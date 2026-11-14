{ pkgs, ... }: {
	environment.systemPackages = builtins.attrValues {
		inherit
			(pkgs.kdePackages)
			dolphin
			kio
			kio-extras
			kio-fuse
			;
	};

	/*
	there's two separate issues here:
		-	dolphin does not respect system file associations by default and therefore
			*needs* this stupid file
		-	the file it needs normally requires all of plasma-workspace to be pulled
			if you don't want to specify it manually like this

	none of this would be needed if kde fixed their apps :sob:
	related issue: https://github.com/NixOS/nixpkgs/issues/409986
	*/
	environment.etc."xdg/menus/applications.menu".source = ./plasma-applications.menu;
}
