-- command! HelpMe :vs ~/.vimhelp | set filetype=help
vim.api.nvim_create_user_command(
  'HelpMe',
  function()
    -- local base_folder vim.fn.stdpath('config')
    local base_folder = vim.api.nvim_call_function('stdpath', {'config'})
    local f_separator = "/"
    -- local file_name_ = "vimhelp.symlink"
    local file_name_ = "vimhelp.help"
    local full_comand =  ':vs '.. base_folder .. f_separator .. file_name_ .. " | set filetype=help"
    vim.api.nvim_command(full_comand)
  end,
  {bang = false, desc = 'My vim help!'}
)


vim.api.nvim_create_user_command(
  'DevReload',
  function()
    package.loaded.dev = nil
    require('dev.dev')
  end,
  {bang = false, desc = 'Reload dev!'}
)


vim.api.nvim_create_user_command(
  'MyNumberToggle',
  function()
    if vim.o.relativenumber then
      vim.o.number = true
      vim.o.relativenumber = false
    else
      vim.o.number = true
      vim.o.relativenumber = true
    end
  end,
  {bang = false, desc = 'Reload dev!'}
)

vim.api.nvim_create_user_command(
  'Spell',
  function()
    SPELL.WIN()
  end,
  {bang = false, desc = 'Spell helper'}
)
