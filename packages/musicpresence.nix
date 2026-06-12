{ pkgs, xkeyboard_config, stdenv, ... }:

pkgs.stdenv.mkDerivation rec {
	name = "musicpresence";
	version = "2.3.5";

	src = fetchTarball {
		url = "https://github.com/ungive/discord-music-presence/releases/download/v${version}/musicpresence-${version}-linux-x86_64.tar.gz";
		sha256 = "0zvfg7z5gh0735l880ggw0ksknsxg5i52i45hkv2s7nw5vmsfh92";
	};

	nativeBuildInputs = [ pkgs.autoPatchelfHook pkgs.makeWrapper ];

	buildInputs = builtins.attrValues {
		inherit (pkgs)
		e2fsprogs
		fontconfig
		libgcc
		libGL
		libgpg-error
		libxcb
		libx11
		wayland;
		inherit (stdenv.cc.cc) lib;
	};

	installPhase = ''
		runHook preInstall
		mkdir -p $out/bin
		cp -r usr/share $out/
		makeWrapper $out/share/musicpresence/bin/musicpresence $out/bin/musicpresence \
			--set XKB_CONFIG_ROOT "${xkeyboard_config}/share/X11/xkb"
		runHook postInstall
	'';

	# for XKB_CONFIG_ROOT
	# https://stackoverflow.com/questions/56353346/xkbcommon-error-failed-to-add-default-include-path

	meta = {
		description = "The Discord music status that works with any media player";
		homepage = "https://github.com/ungive/discord-music-presence";
		# todo: package the arm version for macOS too
		platforms = [ "x86_64-linux" ];
	};

}
