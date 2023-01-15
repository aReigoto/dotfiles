local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- require "lsp-conf.lsp-installer"
-- require("lsp-conf.handlers").setup()
-- require "lsp-conf.null-ls"

-- require("nvim-lsp-installer").setup{}

local servers = {
  "sumneko_lua",
  "cssls",
  "html",
  "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
}

require('lsp-conf.start-servers').setup(servers)
require('lsp-conf.diagnostics').setup()
