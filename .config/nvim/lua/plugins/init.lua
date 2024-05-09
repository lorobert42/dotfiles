local Plugins = {
	{'tpope/vim-repeat'},
	{'kyazdani42/nvim-web-devicons', lazy = true},

	-- Themes
	{
		'catppuccin/nvim',
		lazy = true,
		name = 'catppuccin',
		opts = {
			integrations = {
				gitsigns = true,
				mason = true,
				mini = {
					enabled = true,
					indentscope_color = '',
				},
				cmp = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { 'undercurl' },
						hints = { 'undercurl' },
						warnings = { 'undercurl' },
						information = { 'undercurl' },
					},
				},
				nvimtree = true,
				treesitter = true,
				telescope = {
					enabled = true,
				},
			},
		},
	},
}

return Plugins
