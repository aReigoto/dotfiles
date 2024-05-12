-- https://github.com/mg979/vim-visual-multi/wiki/Mappings
vim.cmd [[
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-n>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-n>'           " replace visual C-n
let g:VM_maps["Select Cursor Down"] = '<C-S-Down>'      " start selecting down
let g:VM_maps["Select Cursor Up"]   = '<C-S-Up>'        " start selecting up
let g:VM_maps["Add Cursor Down"]    = ''                " add cursor up
let g:VM_maps["Add Cursor Up"]      = ''                " ass cursour down
let g:VM_set_statusline             = 0                 " status line disabled, check lualine
]]

