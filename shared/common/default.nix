{ pkgs, wrappers, ... }: let
	vesktop = pkgs.vesktop.override {
		withTTS = false;
		withMiddleClickScroll = true;
	};
in {
	environment = {
		systemPackages = builtins.attrValues {
			inherit
				vesktop
				;

			inherit
				(pkgs)
				alejandra
				musicpresence
				nh
				nil
				nodejs-slim
				pnpm
				statix
				tack
				;

		} ++ ( with wrappers; [
			bat.drv
			less.drv
			ripgrep.drv
		]);

		etc."pulse/client.conf" = {
			enable = pkgs.stdenv.hostPlatform.isLinux;
			text = ''
				cookie/file = $XDG_CONFIG_HOME/pulse/cookie
			'';
		};

		variables = let
			# because env vars are evaluated alphabetically, this is needed for cargo and rustup home to resolve correctly
			xdgDataHome = "$HOME/.local/share";
			xdgCacheHome = "$HOME/.cache";
		in {
			XDG_CACHE_HOME = xdgCacheHome;
			XDG_CONFIG_HOME = "$HOME/.config";
			XDG_DATA_HOME = xdgDataHome;
			XDG_STATE_HOME = "$HOME/.local/state";
			XDG_BIN_HOME = "$HOME/.local/bin";

			# rust slop
			CARGO_HOME = "${xdgDataHome}/cargo";
			RUSTUP_HOME = "${xdgDataHome}/rustup";

			# i don't use ghcup on any system besides my macbook, but if i ever do it's good to have this kept in sync
			GHCUP_USE_XDG_DIRS = "1";

			CUDA_CACHE_PATH="${xdgCacheHome}/nv";
		};
	};

	nix = {
		channel.enable = false;
		settings = {
			# does what `nix store --optimise` does but automatically
			auto-optimise-store = true;

			# for more info see
			# https://nix.dev/manual/nix/2.35/language/import-from-derivation
			allow-import-from-derivation = false;

			experimental-features = [
				"nix-command"
				"flakes"
			];

			use-xdg-base-directories = true;

			# disables git tree dirty warning because it's kinda useless for me
			warn-dirty = false;
		};
	};

	nixpkgs.config.allowUnfree = true;
}
