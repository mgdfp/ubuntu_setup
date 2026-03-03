return {
	-- Python (Built-in extra)
	{ import = "lazyvim.plugins.extras.lang.python" },

	-- Shell/Bash (Manual setup)
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				bashls = {},
			},
		},
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"bash-language-server",
				"shfmt",
				"shellcheck",
			},
		},
	},
}
