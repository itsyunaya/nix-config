{ ... }: {
	environment.variables = let
		# because env vars are evaluated alphabetically, this is needed for cargo and rustup home to resolve correctly
		xdgDataHome = "$HOME/.local/share";
		xdgCacheHome = "$HOME/.cache";
		xdgConfigHome = "$HOME/.config";
	in {
		XDG_CACHE_HOME = xdgCacheHome;
		XDG_CONFIG_HOME = xdgConfigHome;
		XDG_DATA_HOME = xdgDataHome;
		XDG_STATE_HOME = "$HOME/.local/state";
		XDG_BIN_HOME = "$HOME/.local/bin";

		# rust
		CARGO_HOME = "${xdgDataHome}/cargo";
		RUSTUP_HOME = "${xdgDataHome}/rustup";

		# haskell
		# i don't use ghcup on any system besides my macbook, but if i ever do it's good to have this kept in sync
		GHCUP_USE_XDG_DIRS = "1";
		STACK_XDG = "1";

		# idk what these even are but they're in my /home/ so they must go
		CUDA_CACHE_PATH = "${xdgCacheHome}/nv";
		XCOMPOSECACHE = "${xdgCacheHome}/X11/xcompose";

		# jvm
		_JAVA_OPTIONS = ''-Djava.util.prefs.userRoot="${xdgConfigHome}"/java'';
		GRADLE_USER_HOME = "${xdgDataHome}/gradle";
	};
}
