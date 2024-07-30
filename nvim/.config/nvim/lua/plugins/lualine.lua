local function get_linters()
  local linters = require('lint').get_running()
  if #linters == 0 then
    return "󰦕"
  end
  return "󱉶 " .. table.concat(linters, ", ")
end

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = {
    options = {
      theme = 'catppuccin',
      icons_enabled = false,
      component_separators = '|',
      section_separators = '',
      disabled_filetypes = {
        statusline = {'NvimTree'}
      },
    },
    sections = {
      lualine_y = {get_linters},
    },
    inactive_sections = {
      lualine_y = {'progress'},
    },
    extensions = {
      'fzf',
      'lazy',
      'man',
      'mason',
      'nvim-tree',
      'toggleterm',
    },
  },
}

