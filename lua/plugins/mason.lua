local opts = {
  ensure_installed = {
    "pyright",
    "efm",
  },
}
return {
  "williamboman/mason-lspconfig.nvim",
  opts = opts,
  event = "BufReadPre",
  dependencies = "williamboman/mason.nvim",
}
