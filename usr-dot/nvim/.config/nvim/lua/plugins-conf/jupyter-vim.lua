--[[ 
if not vim.api.nvim_eval('exists("g:jupyter_mapkeys")') then
	return
end
]]

-- Disable default keymapings
vim.g.jupyter_mapkeys = 0

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true , buffer = true }

local function moveApend()
  local newpos = vim.fn.searchpos("^# %%$", 'sW', '')
  if newpos[1] == 0 then
    local last_line = vim.fn.line('$')
    local last_nonBlank = vim.fn.prevnonblank('$')
    if last_line == last_nonBlank then
      vim.fn.append(vim.fn.line('$'), "")
    end
    vim.fn.append(last_nonBlank+1, "# %%")
    vim.fn.append(last_nonBlank+2, "")
    vim.fn.setpos('.',  {vim.fn.bufnr(), last_nonBlank+3, 1, 0})
  end
end

local function runMoveApend()
  local run_ok = vim.api.nvim_cmd({cmd='JupyterSendCell'}, {output=true})
  -- print (vim.cmd([[JupyterSendCell]]))
  if run_ok == '' then
    moveApend()
  else
    vim.api.nvim_err_writeln(run_ok)
  end
end


keymap("n", "<S-CR>", runMoveApend, opts)
keymap("v", "<S-CR>", '<Plug>JupyterRunVisual', opts)

