{ inputs }: let
	inherit (inputs.nixpkgs.pkgs) yaziPlugins;
in {
	"git.yazi" = yaziPlugins.git;
	"full-border.yazi" = yaziPlugins.full-border;
}
