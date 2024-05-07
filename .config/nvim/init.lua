-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30

-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --

-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set({'n', 'x', 'o'}, '<leader>h', '^', {desc = 'Go to line start'})
vim.keymap.set({'n', 'x', 'o'}, '<leader>l', 'g_', {desc = 'Go to line end'})
vim.keymap.set('n', '<C-a>', ':keepjumps normal! ggVG<cr>', {desc = 'Select all'})

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, '<C-c>', '"+y', {desc = 'Copy to clipboard'})
vim.keymap.set({'n', 'x'}, '<C-v>', '"+p', {desc = 'Paste from clipboard'})

-- Delete text
vim.keymap.set({'n', 'x'}, 'x', '"_x', {desc = 'Delete without altering register'})
vim.keymap.set({'n', 'x'}, 'X', '"_d', {desc = 'Delete without altering register'})

-- Commands
vim.keymap.set({'n', 'v', 'i'}, '<C-s>', '<esc><cmd>update<cr>', {desc = 'Save'})
vim.keymap.set('n', '<leader>bq', '<cmd>bdelete<cr>', {desc = 'Close current buffer'})
vim.keymap.set('n', '<leader>bl', '<cmd>buffer #<cr>', {desc = 'Go to buffer #'})
vim.keymap.set('n', '<leader>bc', '<cmd>bdelete<CR>', {desc = 'Close buffer'})

-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {desc = 'Reload config'})

local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('FileType', {
	pattern = {'help', 'man'},
	group = group,
	desc = 'Use q to close the window',
	command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd('TextYankPost', {
	group = group,
	desc = 'Highlight on yank',
	callback = function(event)
		vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
	end
})

-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

local lazy = {}

function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print('Installing lazy.nvim....')
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/folke/lazy.nvim.git',
			'--branch=stable', -- latest stable release
			path,
		})
	end
end

function lazy.setup(plugins)
	if vim.g.plugins_ready then
		return
	end

	-- You can "comment out" the line below after lazy.nvim is installed
	lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)

	require('lazy').setup(plugins, lazy.opts)
	vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
	{'catppuccin/nvim', name = 'catppuccin', priority = 1000},
	{'nvim-lualine/lualine.nvim'},
	{'akinsho/bufferline.nvim'},
	{'echasnovski/mini.indentscope'},
	{'nvim-treesitter/nvim-treesitter'},
	{'nvim-treesitter/nvim-treesitter-textobjects'},
	{'echasnovski/mini.ai'},
	{'echasnovski/mini.comment'},
	{'echasnovski/mini.surround'},
	{'echasnovski/mini.pairs'},
	{'echasnovski/mini.bufremove'},
	{'kyazdani42/nvim-tree.lua'},
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }
  },
	{'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
	{'akinsho/toggleterm.nvim'},
	{
		'kdheepak/lazygit.nvim',
		dependencies = {
			'nvim-telescope/telescope.nvim',
			'nvim-lua/plenary.nvim',
		},
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{'lewis6991/gitsigns.nvim'},
	{'tpope/vim-repeat'},
})

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme
---
vim.opt.termguicolors = true
vim.cmd.colorscheme('catppuccin')

require('catppuccin').setup({
	integrations = {
		nvimtree = true,
		treesitter = true,
		mini = {
			enabled = true,
			indentscope_color = '',
		},
		telescope = {
			enabled = true,
		},
	}
})

---
-- lualine.nvim (statusline)
---
require('lualine').setup({
	options = {
		icons_enabled = false,
		theme = 'catppuccin',
		component_separators = '|',
		section_separators = '',
		disabled_filetypes = {
			statusline = {'NvimTree'}
		}
	}
})

---
-- bufferline.nvim (tabs for buffers)
---
require('bufferline').setup({
	options = {
		mode = 'buffers',
		offsets = {
			{filetype = 'NvimTree'}
		},
	},
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
})

---
-- nvim-tree (file explorer)
---
require('nvim-tree').setup({
	hijack_cursor = false,
	on_attach = function(bufnr)
		local bufmap = function(lhs, rhs, desc)
			vim.keymap.set('n', lhs, rhs, {buffer = bufnr, desc = desc})
		end

		-- See :help nvim-tree.api
		local api = require('nvim-tree.api')

		bufmap('L', api.node.open.edit, 'Expand folder or go to file')
		bufmap('H', api.node.navigate.parent_close, 'Close parent folder')
		bufmap('gh', api.tree.toggle_hidden_filter, 'Toggle hidden files')
	end
})

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')

---
-- Telescope
---
-- See :help telescope.builtin
vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')

require('telescope').load_extension('fzf')
require('telescope').load_extension('lazygit')

---
-- Gitsigns (show git modifications in side bar)
---
require('gitsigns').setup({
	signs = {
		add = {text = '▎'},
		change = {text = '▎'},
		delete = {text = '➤'},
		topdelete = {text = '➤'},
		changedelete = {text = '▎'},
	}
})

---
-- toggleterm
---
-- See :help toggleterm-roadmap
require('toggleterm').setup({
	open_mapping = '<C-t>',
	direction = 'horizontal',
	shade_terminals = true
})

---
-- mini.indentscope (show scopes)
---
require('mini.indentscope').setup({
	draw = {
		delay = 0,
		animation = require('mini.indentscope').gen_animation.none(),
	},
})
---
-- mini.ai (navigate around more elements)
---
require('mini.ai').setup()
---
-- mini.comment (add comments)
---
require('mini.comment').setup()
---
-- mini.surround (add characters around text)
---
require('mini.surround').setup()
---
-- mini.pairs (close scopes)
---
require('mini.pairs').setup()
---
-- mini.bufremove (close buffers)
---
require('mini.bufremove').setup()

---
-- treesitter (syntax highlighting)
---
require('nvim-treesitter.configs').setup({
	highlight = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
			}
		},
	},
	ensure_installed = {
		'javascript',
		'typescript',
		'tsx',
		'html',
		'css',
		'scss',
		'json',
		'lua',
		'c',
		'cpp',
		'make',
		'dockerfile',
		'python',
		'rust',
	},
})

