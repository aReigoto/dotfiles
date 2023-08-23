local M = {}

local info = function(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

local function error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

local function warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

local api = vim.api

M.highlight = true

function M.toggle()
  M.highlight = not M.highlight
  if M.highlight then
    info("Enabled document highlight", "Document Highlight")
  else
    warn("Disabled document highlight", "Document Highlight")
  end
end

function M.highlight(client, bufnr)
  if M.highlight then
    if client.server_capabilities.documentHighlightProvider then

      local present, illuminate = pcall(require, "illuminate")
      if present then
        illuminate.on_attach(client)

      else
        local lsp_highlight_grp = api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
        api.nvim_create_autocmd("CursorHold", {
          callback = function()
            vim.schedule(vim.lsp.buf.document_highlight)
          end,
          group = lsp_highlight_grp,
          buffer = bufnr,
        })
        api.nvim_create_autocmd("CursorMoved", {
          callback = function()
            vim.schedule(vim.lsp.buf.clear_references)
          end,
          group = lsp_highlight_grp,
          buffer = bufnr,
        })
      end
    end
  end
end

function M.setup(client, bufnr)
  M.highlight(client, bufnr)
end

return M
