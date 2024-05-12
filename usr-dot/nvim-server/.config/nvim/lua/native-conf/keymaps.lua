-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --

-- Save file
keymap("n", "<leader>w", "<cmd>write<CR>", opts)

-- Better window navigation (same keymaps but using christoomey/vim-tmux-navigator plugin)
--[[ keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts) ]]

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<C-S-q>", "<cmd>Bdelete!<CR>", opts)

-- greatest remap ever
keymap("x", "<leader>p", [["_dP]])
keymap({"n", "v"}, "<leader>y", [["+y]])
keymap("n", "<leader>Y", [["+Y]])
keymap({"n", "v"}, "<leader>d", [["_d]])

-- keymap("v", "p", '"_dP', opts)

-- Not allowing delete to write on clipboard
-- keymap("n", "d", '""d', opts)
-- keymap("n", "D", '""D', opts)
-- keymap("n", "dd", '""dd', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files <CR>", opts)
keymap("n", "<leader>ft", ":Telescope current_buffer_fuzzy_find sorting_strategy=ascending<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fa", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
-- Send Telescope list to quickfixlist <C-w>

-- Git
-- This function is declared in toggleterm
keymap("n", "<leader>tg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

--[[
Aditional mapings in 
    lsp-conig.key-maps
    plugins-conf.cmp
    plugins-conf.toggleterm
    plugins-conf.telescope
    plugins-conf.nvim-tree
    plugins-conf.illuminate 
    plugins-conf.vim-visual-multi
]]
