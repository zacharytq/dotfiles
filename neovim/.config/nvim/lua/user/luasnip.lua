if vim.g.snippets == 'luasnip' then
  return
end

local ls = require('luasnip')
local types = require('luasnip.util.types')
local keymap = vim.api.nvim_set_keymap
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local node = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local snip = ls.snippet
local date = function() return {os.date('%Y-%m-%d')} end

ls.config.set_config {
  history = true,
  
  updateevents = "TextChanged,TextChangedI",
}

-- Keymaps
keymap("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/user/luasnip.lua<CR>", { noremap = true, silent = true })

-- snippets
ls.snippets = {
  all = {
    snip({
      trig = 'meta',
      namr = "Metadata",
      dscr = "Yaml metadata format for markdown"
    },
    {
      text({"---",
      "title: "}), insert(1, "note_title"), text({"", 
      "date: "}), func(date, {}), text({"",
      "lastmod: "}), func(date, {}), text({"",
      "tags: ["}), insert(2), text({"]",
      "comments: true",
      "---", ""}), text({"",
      "# ",}), rep(1), text({"",
      ""}),
      insert(0)
    })
  }
}
