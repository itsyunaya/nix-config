{ pkgs, ... }: let
	# tests explode on macos for some reason
	tack = pkgs.tack.overrideAttrs (old: {
			doCheck =
				if pkgs.stdenv.isDarwin
				then false
				else true;
		});

	vesktop = pkgs.vesktop.override {
		withTTS = false;
		withMiddleClickScroll = true;
	};
in {
	environment = {
		systemPackages = builtins.attrValues {
			inherit
				tack
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
				ripgrep
				statix
				;
		};

		variables = {
			XDG_CACHE_HOME = "$HOME/.cache";
			XDG_CONFIG_HOME = "$HOME/.config";
			XDG_DATA_HOME = "$HOME/.local/share";
			XDG_STATE_HOME = "$HOME/.local/state";
			XDG_BIN_HOME = "$HOME/.local/bin";

			# rust slop
			CARGO_HOME = "$XDG_DATA_HOME/cargo";
			RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
		};
	};

	nix.settings = {
		# does what `nix store --optimise` does but automatically
		auto-optimise-store = true;

		experimental-features = [
			"nix-command"
			"flakes"
		];

		# disables git tree dirty warning because it's kinda useless for me
		warn-dirty = false;
	};

	nixpkgs.config.allowUnfree = true;
}
