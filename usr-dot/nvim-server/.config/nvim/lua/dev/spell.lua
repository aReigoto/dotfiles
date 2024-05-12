SPELL = {}

SPELL.WIN = function()
  local width = 50
  local height = 11

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Get current ui settings
  local ui = vim.api.nvim_list_uis()[1]

  -- Create exit keymaps for current buffer
  local closingKeys = {'<Esc>', '<CR>', '<Leader>'}
  for _, closingKey in ipairs(closingKeys) do
      vim.api.nvim_buf_set_keymap(buf, 'n',
                                  closingKey, ':close<CR>',
                                  { silent = true,
                                    nowait = true,
                                    noremap = true
                                  }
      )
  end

  -- vim.o.spelllang=pt
  -- vim.o.spell=true
  -- bufdo to apply to all tabs
  -- tabdo apply to all tabs
  -- windo apply to all windows
  -- check :set dictionary?
  -- toggle :set spell!
  -- https://www.vimfromscratch.com/articles/spell-and-grammar-vim

  -- This will enable in all windows buffers and tabs, not cool...
  -- vim.api.nvim_buf_set_keymap(buf, 'n', '1', ':tabdo windo set spell spelllang=en<CR>', {silent=true})
  -- vim.api.nvim_buf_set_keymap(buf, 'n', '2', ':tabdo windo set spell spelllang=pt<CR>', {silent=true})
  -- vim.api.nvim_buf_set_keymap(buf, 'n', '0', ':tabdo windo set nospell<CR>', {silent=true})

  -- Close the following window and then activate spelling correction
  vim.api.nvim_buf_set_keymap(buf, 'n', '1', ':close | set spell spelllang=en<CR>', {silent=true})
  vim.api.nvim_buf_set_keymap(buf, 'n', '2', ':close | set spell spelllang=pt<CR>', {silent=true})
  vim.api.nvim_buf_set_keymap(buf, 'n', '0', ':close | set nospell<CR>', {silent=true})

  -- Write a message in to the buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    "Spell check helper, use the following shortcuts",
    "",
    "契1 en",
    "契2 pt",
    "契0 off",
    "",
    "In normal mode use the following key bindings:",
    "z= to see sell suggestions in new window",
    "<C-X>s to show completion in a floating window",
    "[s go to previous error",
    "]s go to next error",
    }
  )


  -- Window options 
  local opts = {relative =  'editor',
                 width =  width,
                 height =  height,
                 col =  (ui.width/2) - (width/2),
                 row =  (ui.height/2) - (height/2),
                 anchor =  'NW',
                 style =  'minimal',
                 border = 'single'
                 }

  local win = vim.api.nvim_open_win(buf, 1, opts)
end

