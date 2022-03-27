local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local lspconfig = require("lspconfig")

lspconfig.powershell_es.setup{
  -- Bundle path configured for work computer
  bundle_path = '/Users/zachary.quinn/src/.powershell-editor-services/PowerShellEditorServices'
}

-- JSON setup
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.jsonls.setup{
  capabilities = capabilities,
  settings = {
    json = {
      schemas = {
        description = 'ARM template schema',
        fileMatch = {'azuredeploy-infrastructure.json'},
        url = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"
      }
    }
  }
}

--Bash setup
lspconfig.bashls.setup{}

-- Python setup
lspconfig.pylsp.setup{}

