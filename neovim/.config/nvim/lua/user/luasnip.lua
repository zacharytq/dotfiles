if vim.g.snippets == 'luasnip' then
  return
end

local keymap = vim.api.nvim_set_keymap

local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  ext_base_prio = 300,
  ext_prio_increase = 1,
  enable_autosnippets = true
}

-- Keymaps
keymap("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/user/luasnip.lua<CR>", { noremap = true, silent = true })

-- Functions
local date = function() return {os.date("%Y-%m-%d")} end

local function bash(_, _, command)
  local file = io.popen(command, "r")
  local res = {}
  for line in file:lines() do
    table.insert(res, line)
  end
  return res
end

local date_input = function(args, snip, old_state, fmt)
	local fmt = fmt or "%Y-%m-%d"
	return sn(nil, i(1, os.date(fmt)))
end

-- 'recursive' dynamic snippet. Expands to some text followed by itself.
local rec_ls
rec_ls = function()
	return sn(
		nil,
		c(1, {
			-- Order is important, sn(...) first would cause infinite loop of expansion.
			t(""),
			sn(nil, { t({ "", "\t- " }), i(1), d(2, rec_ls, {}) }),
		})
	)
end

-- snippets
ls.snippets = {
  all = {
    s("bash", f(bash, {}, { user_args = { "ls /" } })),
    s("basic_note", {
      t("---"),
      t({"", "title: "}),
      i(1),
      t({"", "date_created: "}),
      f(date, {}),
      t({"", "date_modified: "}),
      d(2, date_input, {}),
      t({"", "tags: [ "}),
      i(3), t({" ]"}),
      t({"", "---", "", ""}),
      t({"# "}), rep(1), t({"", "", ""}),
      t({"- ***TODO***", "", ""}),
      t({"## Notes", "", ""}),
      t({"## Logs", "", ""}),
      i(0)
    })
  }
}


