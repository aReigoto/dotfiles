require("neo-zoom").setup{
  width_ratio = 0.68,
  left_ratio = 0.25,
}


local NOREF_NOERR_TRUNC = { silent = true, nowait = true }
vim.keymap.set('n', '<leader>z', require("neo-zoom").neo_zoom, NOREF_NOERR_TRUNC)

  -- My setup (This requires NeoNoName.lua, and optionally NeoWell.lua)
local cur_buf = nil
local cur_cur = nil
vim.keymap.set('n', '<leader>z', function ()
  -- Pop-up Effect
  if vim.api.nvim_win_get_config(0).relative == '' then
    cur_buf = vim.fn.bufnr()
    cur_cur = vim.api.nvim_win_get_cursor(0)
    -- if vim.fn.bufname() ~= '' then
    --   vim.cmd('NeoNoName')
    -- end
    vim.cmd('NeoZoomToggle')
    vim.api.nvim_set_current_buf(cur_buf)
    vim.api.nvim_win_set_cursor(0, cur_cur)
    vim.cmd("normal! zt")
    vim.cmd("normal! 7k7j")
    return
  end
  vim.cmd('NeoZoomToggle')
  vim.api.nvim_set_current_buf(cur_buf)
  cur_buf = nil
  cur_cur = nil
  -- vim.cmd('NeoWellJump') -- you can safely remove this line.
  end, 
NOREF_NOERR_TRUNC)


