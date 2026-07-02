return {
	"startup.nvim",
	-- todo: find actual event name for this
	--event = "VimEnter",
	lazy = false,
	after = function()
		require("startup").setup({
			mappings = {
				execute_command = "<CR>",
				open_file = "o",
				open_file_split = "<c-v>",
				open_section = "<CR>",
				open_help = "?",
			},

			header = {
				type = "text",
				align = "center",
				fold_section = false,
				title = "Header",
				margin = 5,
				highlight = "";
				oldfiles_amount = 0,

				-- todo: find a way to populate required constants from nix
				default_color = "",

				content = {
					"    ___         __    __                 _         ",
					"   /   |  _____/ /_  / /__  __  ___   __(_)___ ___ ",
					"  / /| | / ___/ __ \\/ / _ \\/ / / / | / / / __ `__ \\",
					" / ___ |(__  ) / / / /  __/ /_/ /| |/ / / / / / / /",
					"/_/  |_/____/_/ /_/_/\\___/\\__, / |___/_/_/ /_/ /_/ ",
					"                         /____/                    "
				}
			},

			body = {
				type = "mapping";
				align = "center";
				fold_section = false;
				title = "meow meow meoww meow meoww meow meow";
				margin = 5;
				highlight = "Statement";
				oldfiles_amount = 0;

				content = {
					{ "  Find File", "Telescope find_files", "<leader>ff" },
					{ "  Recent Files", "Telescope oldfiles", "<leader>of" },
					{ "  Find Word", "Telescope live_grep", "<leader>lg" },
					{ "  New File", "lua require'startup'.new_file()", "<leader>nf" }
				},

				-- todo: see above
				default_color = "";
			},

			parts = { "header", "body" }
		})
	end
}