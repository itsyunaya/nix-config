{ self, ... }: {
	environment = {
		sessionVariables = {
			QT_IM_MODULE = "fcitx";
			XMODIFIERS = "@im=fcitx";
			SDL_IM_MODULE = "fcitx";
			GLFW_IM_MODULE = "ibus";
			QT_QPA_PLATFORM = "wayland";
			NIXOS_OZONE_WL = "1";
			# set to nano by default for some reason
			EDITOR = "nvim";

			# meant to speed up eval speeds, 4GB rn
			GC_INITIAL_HEAP_SIZE = 1024 * 1024 * 1024 * 4;
		};

		# previously managed with hjem, but this is simpler
		etc."wallpapers" = {
			source = "${self}/assets/wallpapers/";
		};
	};
}
