local telekasten_status_ok, telekasten = pcall(require, "telekasten")
if not telekasten_status_ok then
  return
end

local home = vim.fn.expand("~/notes")
local opts = { noremap = true, silent = true }

require('telekasten').setup({
  home = home,
  take_over_my_home = true,
  auto_set_filetype = true,
  dailies = home .. '/' .. 'daily',
  weeklies = home .. '/' .. 'weekly',
  templates = home .. '/' .. 'templates',
  extension = ".md",
  follow_creates_nonexisting = true,
  dailies_create_nonexisting = true,
  weeklies_create_nonexisting = false,
  image_link_style = "markdown",
  plug_into_calendar = false,
  close_after_yanking = false,
  insert_after_inserting = true,
  tag_notation = "yaml-bare",
  command_pallete_theme = "dropdown",
  subdirs_in_links = true,
  new_note_location = "smart",
  rename_update_links = true,
})

-- Keymaps
vim.api.nvim_set_keymap('n', '<Leader>zf', ':lua require("telekasten").find_notes()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>zd', ':lua require("telekasten").find_daily_notes()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>zg', ':lua require("telekasten").search_notes()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>zz', ':lua require("telekasten").follow_link()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>z', ':lua require("telekasten").panel()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>zT', ':lua require("telekasten").goto_today()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>#', ':lua require("telekasten").show_tags()<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>zr', ':lua require("telekasten").rename_note()<CR>', opts)
vim.api.nvim_set_keymap('i', '<Leader>[[[', '<cmd>:lua require("telekasten").insert_link({ i = true })<CR>', opts)
vim.api.nvim_set_keymap('i', '<Leader>zt', '<cmd>:lua require("telekasten").toggle_todo({ i = true })<CR>', opts)
