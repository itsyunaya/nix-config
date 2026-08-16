{
	environment.variables = {
		XDG_CACHE_HOME = "$HOME/.cache";
		XDG_CONFIG_HOME = "$HOME/.config";
		XDG_DATA_HOME = "$HOME/.local/share";
		XDG_STATE_HOME = "$HOME/.local/state";
		XDG_BIN_HOME = "$HOME/.local/bin";

		# rust slop
		CARGO_HOME = "$XDG_DATA_HOME/cargo";
		RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
	};
}
