local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "lsp-conf.mason"
require("lsp-conf.handlers").setup()
require "lsp-conf.null-ls"
