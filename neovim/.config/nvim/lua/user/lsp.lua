local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local lspconfig = require("lspconfig")

lspconfig.powershell_es.setup{
  -- Bundle path configured for work computer
  bundle_path = '/Users/zachary.quinn/src/.powershell-editor-services/PowerShellEditorServices'
}
