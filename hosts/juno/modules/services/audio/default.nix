# a lot of this is adapted from https://github.com/PartlyAwesome/nixos/tree/master/hosts/common/audio
{ lib, pkgs, ... }: let
	loudmax_plugin_name = "la_LoudMax64.so";
	loudmax_plugin = pkgs.runCommand "loudmax" {
		nativeBuildInputs = [ pkgs.autoPatchelfHook ];
		buildInputs = builtins.attrValues { inherit (pkgs.stdenv.cc) cc libc; };
	} "mkdir -p $out/lib/ladspa && cp ${./loudmax/${loudmax_plugin_name}} $out/lib/ladspa/${loudmax_plugin_name} && chmod -R +w $out && autoPatchelf $out";

	mkFilterChain = { name, plugin, label, control ? null, captureProps ? {}, playbackProps ? {} }: {
		"context.modules" = [
			{
				name = "libpipewire-module-filter-chain";
				args = {
					"node.description" = name;
					"media.name" = name;
					"filter.graph" = {
						nodes = [
							{
								type = "ladspa";
								inherit name plugin label;
								control = lib.mkIf (control != null) control;
							}
						];
					};
					"capture.props" = {
						"node.name" = "${name} Input";
						"node.passive" = true;
					}
					// captureProps;
					"playback.props" = {
						"node.name" = "${name} Output";
						"media.class" = "Audio/Source";
					}
					// playbackProps;
				};
			}
		];
	};
in {
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;

		extraConfig.pipewire = {
			dfn = mkFilterChain {
				name = "DeepFilterNet";
				plugin = "${pkgs.deepfilternet}/lib/ladspa/libdeep_filter_ladspa.so";
				label = "deep_filter_mono";
				control = {
					"Attenuation Limit (dB)" = 100;
				};
			};

			compressor = mkFilterChain {
				name = "Compressor";
				plugin = "${loudmax_plugin}/lib/ladspa/${loudmax_plugin_name}";
				label = "ldmx_stereo";
				control = {
					"Threshold (dB)" = -25.0;
					"Output (dB)" = 0;
				};
				captureProps = {
					"node.autoconnect" = "false";
				};
			};
		};

		wireplumber = {
			extraConfig = {
				"99-auto-connect" = {
					"wireplumber.components" = [
						{
							name = "startup/auto-connect-ports.lua";
							type = "script/lua";
							provides = "custom.auto-connect-ports";
						}
					];
					"wireplumber.profiles" = {
						main = {
							"custom.auto-connect-ports" = "required";
						};
					};
				};
			};
			extraScripts = {
				"startup/auto-connect-ports.lua" = builtins.readFile ./auto-connect-ports.lua;
			};
		};
	};
}
