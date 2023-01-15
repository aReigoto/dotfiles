DEV = {}

DEV.PRINTKEYS = function(var)
  print('Hello from dev!')
  print(var)
  for k, v in pairs(var) do
    print(k, v)
  end
end

--[[

Execute a file
  :help source
  :help luafile
  
  Exemples 
    :source %
    :source the_path_to_my_lua_or_vimscript_file

    Load a module
      :lua require('dev.dev')
    Execute a function that is inside of table declared in the module
      :lua DEV.FUNC()

Execute vim code in lua
  
  Basic exemple
    vim.cmd("JupyterSendCell")
    vim.cmd "JupyterSendCell"

  Check if the command trow an error
    local run_ok = vim.api.nvim_cmd({cmd='JupyterSendCell'}, {output=true})
    if run_ok == '' then
      print("Nice!")
    else
      vim.api.nvim_err_writeln(run_ok)
    end

options
  :help vim.o
  :help vim.opt

functions
  :help vim.fn
    Call vim built-in functions, user defined functions and even functions of plugins
    Exemples:
      vim.fn.VMInfos()
      vim.fn[VMInfos]()
      vim.fn['fzf#vim#files']('~/projects', false)
      vim.call('fzf#vim#files', '~/projects', false)

    To check if a function exists
      local vm_status_ok, vm = pcall(vim.fn.VMInfos)

    Execute vim comands
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]\]

variables
  :help vim.g
]]

--[[
vim buildin command to explore

getpos
getpos(.) => position of the cursor
charpos
setpos
getmatches
line
line('$') => last line number
search
cursor
prevnonblank({lnum})
nextnonblank({lnum})					
searchpos('# %%', 's', '')
input('Input message: ')

-- Some exemples:

-- Move the cursor to line 10 col 1
vim.fn.setpos('.',  {vim.fn.bufnr(), 10, 1, 0})

-- Append a new line at the end of the file
vim.fn.append(vim.fn.line('$'), "New text")

-- Append a new line below the cursor
vim.fn.append(vim.fn.line('.'), "")

-- Find next empy line
vim.fn.search("^\s*$")

]]


--[[ Open the helpMe File Notes
let help_file = "/HelpMe"
execute "botright vsplit" stdpath('config').help_file
or 
execute "botright vsplit" stdpath('config')."/HelpMe"
https://vi.stackexchange.com/questions/13187/pass-variable-in-vimscript-function-to-split
--]]

-- To explore floating windows
-- https://www.statox.fr/posts/2021/03/breaking_habits_floating_window/


-- NOTE debug data is in this folder called vim-dap.log
-- vim.fn.stdpath('data')

