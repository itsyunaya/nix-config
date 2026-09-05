{ pkgs, ... }: let
	vscodePackage = pkgs.vscode-with-extensions.override {
		vscode = pkgs.vscodium;
		vscodeExtensions = with pkgs.vscode-extensions; [ mvllow.rose-pine ];
	};
in {
	#packages = [ vscodePackage ];
	xdg.config.files."Code/User/settings.json" = {
		enable = false;
		generator = (pkgs.formats.json {}).generate "settings.json";
		value = {
			"chat.disableAIFeatures" = true;
			"workbench.colorTheme" = "Rosé Pine";
			"editor.tabSize" = 4;
		};
	};
}
