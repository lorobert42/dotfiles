local Plugin = {'kyazdani42/nvim-tree.lua'}

Plugin.cmd = {'NvimTreeToggle'}

-- See :help nvim-tree-setup
Plugin.opts = {
	hijack_cursor = false,
	on_attach = function(bufnr)
		local bufmap = function(lhs, rhs, desc)
			vim.keymap.set('n', lhs, rhs, {buffer = bufnr, desc = desc})
		end

		-- :help nvim-tree.api
		local api = require('nvim-tree.api')

		-- default mappings
		api.config.mappings.default_on_attach(bufnr)
	end
}

function Plugin.init()
	vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
end

return Plugin
