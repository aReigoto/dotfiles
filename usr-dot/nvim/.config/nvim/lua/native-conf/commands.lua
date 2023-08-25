local function open_win()
    local buf = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")

    local win_height = math.ceil(height * 0.8 - 4)
    local win_width = math.ceil(width * 0.8)

    local row = math.ceil((height - win_height) / 2 - 1)
    local col = math.ceil((width - win_width) / 2)

    local opts = {
        style = "minimal",
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col,
        border = "rounded",
    }

    win = vim.api.nvim_open_win(buf, true, opts)
    vim.api.nvim_win_set_option(win, "cursorline", true)
end

-- command! HelpMe :vs ~/.vimhelp | set filetype=help
vim.api.nvim_create_user_command(
  'HelpMe',
  function()
    local base_folder = vim.api.nvim_call_function('stdpath', {'config'})
    local f_separator = "/"
    local file_name_ = "vimhelp.help"
    local file_path = base_folder .. f_separator .. file_name_

    -- Old way open on vertical split
    -- local full_comand =  ':vs '.. file_path .. " | set filetype=help"
    -- vim.api.nvim_command(full_comand)

    local file_path_tst = vim.api.nvim_get_runtime_file(file_path, false)[1]

		open_win()
    vim.api.nvim_command("$read" .. file_path .. " | set filetype=help")
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
