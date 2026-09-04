_: {
	options = {
		settingsFile.default = ./yazi.toml;
		initLuaFile.default = ./init.lua;

		plugins.defaultFunc = { inputs }: import ./plugins.nix { inherit inputs; };
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
