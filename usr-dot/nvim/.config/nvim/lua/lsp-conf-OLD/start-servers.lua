local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local M = {}
M.setup = function(servers)
    local opts = {}

    for _, server in pairs(servers) do
    opts = {
        on_attach = require("lsp-conf.on_attach").on_attach,
        capabilities = require("lsp-conf.capabilities").capabilities,
    }

    -- Merge server specific config with opts
    if server == "sumneko_lua" then
        local sumneko_opts = require "lsp-conf.server-settings.sumneko_lua"
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server == "pyright" then
        local pyright_opts = require "lsp-conf.server-settings.pyright"
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    lspconfig[server].setup(opts)
    end
end

return M