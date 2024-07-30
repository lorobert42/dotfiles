return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    plugins = { spelling = true },
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.add({
      { 'g', group = '+goto' },
      { 's', group = '+surround' },
      { 'z', group = '+fold' },
      { ']', group = '+next' },
      { '[', group = '+prev' },
      { '<leader><tab>', group = '+tabs' },
      { '<leader>b', group = '+buffer' },
      { '<leader>c', group = '+code' },
      { '<leader>f', group = '+file/find' },
      { '<leader>g', group = '+git' },
      { '<leader>gh', group = '+hunks' },
      { '<leader>q', group = '+quit/session' },
      { '<leader>s', group = '+search' },
      { '<leader>u', group = '+ui' },
      { '<leader>w', group = '+window' },
      { '<leader>x', group = '+diagnostics/quickfix' },
    })
  end,
}
