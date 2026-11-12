{ lib, options, ... }: let
	inherit (lib) mkMerge optionalAttrs;

	# stupid hack because using pkgs here infrecs
	isLinux = options.system.tools ? nixos-enter;
in {
	config = mkMerge [
		{
			documentation = {
				enable = false;
				info.enable = false;
			};
		}

		(optionalAttrs isLinux {
			documentation.nixos.enable = false;

			environment = {
				# perl, rsync, strace
				defaultPackages = [];

				# error message when trying to run dynamically linked exes
				stub-ld.enable = false;
			};

			programs = {
				command-not-found.enable = false;
				nano.enable = false;
			};

			services.speechd.enable = false;

			system.tools = {
				nixos-enter.enable = false;
				nixos-generate-config.enable = false;
				nixos-install.enable = false;
			};
		})

		# operating systems: linux, macOS; mental illnesses: everything else
		(optionalAttrs (!isLinux) {
			system.tools = {
				darwin-option.enable = false;
				darwin-version.enable = false;
				darwin-uninstaller.enable = false;
			};
		})
	];
}
