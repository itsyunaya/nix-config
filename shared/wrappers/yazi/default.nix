_: {
	options = {
		settingsFile.default = ./yazi.toml;
		initLuaFile.default = ./init.lua;

		plugins.defaultFunc = { inputs }: let
			inherit (inputs.nixpkgs.pkgs) yaziPlugins;
		in {
			"git.yazi" = yaziPlugins.git;
		};
	};

	mutations."/fish".interactiveShellInit = _: ''
		function y
			set tmp (mktemp -t "yazi-cwd.XXXXXX")
			command yazi $argv --cwd-file="$tmp"
			if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
				builtin cd -- "$cwd"
			end
			command rm -f -- "$tmp"
		end
	'';
}
