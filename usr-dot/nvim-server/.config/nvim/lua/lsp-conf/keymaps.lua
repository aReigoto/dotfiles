local M = {}

M.setup = function(bufnr)
    -- Diagnostic Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    -- Navegate/inspect errors and warnings
    local opts = { noremap=true, silent=true }
    local keymap = vim.api.nvim_buf_set_keymap
    vim.keymap.set('n', '<leader>lf', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>lp', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<leader>ln', vim.diagnostic.goto_next, opts)
    -- Send info to a quickfixlist window
    vim.keymap.set('n', '<leader>lw', vim.diagnostic.setloclist, opts)
    -- After opening :Telescope diagnostics press <C-w> to send the info to quickfixlist window
    vim.keymap.set('n', '<leader>lt', "<cmd>Telescope diagnostics<cr>", opts)

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    -- All the tree are the same in python but differ for other languages like cpp
    vim.keymap.set('n', '<leader>lg', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<leader>le', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<leader>ld', vim.lsp.buf.type_definition, bufopts)
    -- Show docstring in python
    vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>laf', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>lrf', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>llf', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    -- Rename all symbols across the project!
    vim.keymap.set('n', '<leader>lc', vim.lsp.buf.rename, bufopts)
    -- Auto organize imports and more...
    vim.keymap.set('n', '<leader>lo', vim.lsp.buf.code_action, bufopts)
    -- List all references across the project in split window
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, bufopts)
    -- Format file usig the lsp
    keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)

	-- TODO: rewite the vim.keymap.set to the following form
	-- keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	-- keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	-- keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	-- keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	-- keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
	-- keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	-- keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
	-- keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	-- keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
	-- keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
	-- keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	-- keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts) 
end

return M
