local cmp_dictionary_ok, cmp_dictionary = pcall(require, "cmp_dictionary")
if not cmp_dictionary_ok then
	return
end

cmp_dictionary.setup({
  dic = {
    -- ["*"] = { "/usr/share/dict/words" },
    ["O2"] = { vim.fn.expand("~/.config/nvim/spell/O2.dic") },
    -- ["javascript,typescript"] = { "path/to/js.dic", "path/to/js2.dic" },
    -- filename = {
    --   ["xmake.lua"] = { "path/to/xmake.dic", "path/to/lua.dic" },
    -- },
    -- filepath = {
    --   ["%.tmux.*%.conf"] = "path/to/tmux.dic"
    -- },
    -- spelllang = {
    --   en = "~/.config/nvim/spell/test.dict",
    -- },
  },
  -- The following are default values.
  exact = 1,
  first_case_insensitive = true,
  document = true,
  debug = false,
})

-- For lazy loading
-- cmp_dictionary.update()
