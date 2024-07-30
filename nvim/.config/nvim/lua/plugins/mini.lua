return {
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'echasnovski/mini.bufremove',
    keys = {
      {
        '<leader>bd',
        function()
          local bd = require('mini.bufremove').delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = 'Delete Buffer',
      },
      { '<leader>bD', function() require('mini.bufremove').delete(0, true) end, desc = 'Delete Buffer (Force)' },
    },
  },
  {
    'echasnovski/mini.indentscope',
    opts = {
      draw = {
        delay = 0,
        -- animation = require('mini.indentscope').gen_animation.none(),
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'dashboard',
          'lazy',
          'mason',
          'toggleterm',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
