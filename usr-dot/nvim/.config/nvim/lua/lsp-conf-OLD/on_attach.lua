local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local M = {}

M.on_attach = function(client, bufnr)

    require('lsp-conf.key-maps').setup(bufnr)

    local status_ok, illuminate = pcall(require, "illuminate")
    if status_ok then
        illuminate.on_attach(client)
    end
end

return M