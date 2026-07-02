{ pkgs, ... }: {
	programs.mnw = {
		enable = true;

		appName = "ashleyvim";
		aliases = [ "vi" "nvm" ];
		desktopEntry = false;

		initLua = ''require("init")'';

		plugins = {
			dev.conf = {
				pure = ./.;
				impure = "/home/ashley/Documents/Development/nvim";
			};

			start = builtins.attrValues {
				inherit
					(pkgs.vimPlugins)
					# cmp stuff
					nvim-cmp
					cmp-buffer
					cmp_luasnip
					cmp-nvim-lsp
					cmp-path
					cmp-vimtex

					# langs
					nvim-lspconfig
					luasnip
					vimtex

					# theming
					lualine-nvim
					startup-nvim
					transparent-nvim

					# etc
					lz-n
					;
			};
		};
	};
}
