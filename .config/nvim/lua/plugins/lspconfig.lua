local Plugin = {'neovim/nvim-lspconfig'}
local user = {}

Plugin.dependencies =  {
	{'hrsh7th/cmp-nvim-lsp'},
	{'williamboman/mason-lspconfig.nvim'},
}

Plugin.cmd = {'LspInfo', 'LspInstall', 'LspUnInstall'}

Plugin.event = {'BufReadPre', 'BufNewFile'}

function Plugin.init()
	local sign = function(opts)
		-- See :help sign_define()
		vim.fn.sign_define(opts.name, {
			texthl = opts.name,
			text = opts.text,
			numhl = ''
		})
	end

	sign({name = 'DiagnosticSignError', text = ''})
	sign({name = 'DiagnosticSignWarn', text = ''})
	sign({name = 'DiagnosticSignHint', text = ''})
	sign({name = 'DiagnosticSignInfo', text = ''})

	-- See :help vim.diagnostic.config()
	vim.diagnostic.config({
		virtual_text = false,
		severity_sort = true,
		float = {
			border = 'rounded',
			source = 'always',
		},
	})

	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
	vim.lsp.handlers.hover,
	{border = 'rounded'}
	)

	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
	vim.lsp.handlers.signature_help,
	{border = 'rounded'}
	)
end

function Plugin.config()
	local lspconfig = require('lspconfig')
	local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

	local group = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})

	vim.api.nvim_create_autocmd('LspAttach', {
		group = group,
		desc = 'LSP actions',
		callback = user.on_attach
	})

	-- See :help mason-lspconfig-settings
	require('mason-lspconfig').setup({
		ensure_installed = {
			'bashls',
			'clangd',
			'autotools_ls',
			'tsserver',
			'eslint',
			'html',
			'cssls',
			'somesass_ls',
			'basedpyright',
			'rust_analyzer',
		},
		handlers = {
			-- See :help mason-lspconfig-dynamic-server-setup
			function(server)
				-- See :help lspconfig-setup
				lspconfig[server].setup({
					capabilities = lsp_capabilities,
				})
			end,
			['tsserver'] = function()
				lspconfig.tsserver.setup({
					capabilities = lsp_capabilities,
					settings = {
						completions = {
							completeFunctionCalls = true
						}
					}
				})
			end,
			['lua_ls'] = function()
				require('plugins.lsp.lua_ls')
			end
		}
	})
end

function user.on_attach()
	local bufmap = function(mode, lhs, rhs, desc)
		local opts = { buffer = true, desc = desc }
		vim.keymap.set(mode, lhs, rhs, opts)
	end

	-- You can search each function in the help page.
	-- For example :help vim.lsp.buf.hover()

	bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', 'Code help')
	bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', 'Go to definition')
	bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Got to declaration')
	bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Go to implementation')
	bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Go to type definition')
	bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', 'See references')
	bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Signature help')
	bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename symbol')
	bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code action')
	bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', 'See diagnostics')
	bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Previous diagnostic')
	bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Next diagnostic')
end

return Plugin
