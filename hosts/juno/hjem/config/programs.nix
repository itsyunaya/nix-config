{ pkgs, ... }: {
	services.nextcloud-client.enable = true;

	programs = {
		anyrun.enable = true;
		hyprlock.enable = true;

		vscode = {
			enable = true;
			extensions = with pkgs.vscode-extensions; [ mvllow.rose-pine james-yu.latex-workshop jnoortheen.nix-ide ];
			settings = {
				"chat.disableAIFeatures" = true;
				"workbench.colorTheme" = "Rosé Pine";
				"editor.tabSize" = 4;
			};
		};
	};
}
