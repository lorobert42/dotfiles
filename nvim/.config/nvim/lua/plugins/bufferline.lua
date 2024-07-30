return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  opts = {
    options = {
      close_command = function(n) require('mini.bufremove').delete(n, false) end,
      right_mouse_command = function(n) require('mini.bufremove').delete(n, false) end,
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      mode = 'buffers',
      offsets = {
        {filetype = 'NvimTree'}
      },
    },
    highlights = require("catppuccin.groups.integrations.bufferline").get {
      styles = {'bold'},
    },
  },
}
