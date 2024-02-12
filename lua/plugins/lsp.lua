-- Neuer Code
local python_root_files = {
  "pyproject.toml",
  "setup.py",
  ".project",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
  ".git",
}
local config = function()
  require("neoconf").setup({})
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local lspconfig = require("lspconfig")
  local capabilities = cmp_nvim_lsp.default_capabilities()

  -- lua
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = { -- custom settings for lua
      Lua = {
        -- make the language server recognize "vim" global
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          -- make language server aware of runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    },
  })

  -- json
  lspconfig.jsonls.setup({
    capabilities = capabilities,
    filetypes = { "json", "jsonc" },
  })

  -- python
  lspconfig.pyright.setup({
    capabilities = capabilities,
    settings = {
      pyright = {
        disableOrganizeImports = false,
        analysis = {
          useLibraryCodeForTypes = true,
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          autoImportCompletions = true,
        },
      },
    },
    root_dir = lspconfig.util.root_pattern(python_root_files),
  })

  -- bash
  lspconfig.bashls.setup({
    capabilities = capabilities,
    filetypes = { "sh", "aliasrc" },
  })

  -- solidity
  lspconfig.solidity.setup({
    capabilities = capabilities,
    filetypes = { "solidity" },
  })

  -- docker
  lspconfig.dockerls.setup({
    capabilities = capabilities,
  })

  -- C/C++
  lspconfig.clangd.setup({
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    },
  })

  local luacheck = require("efmls-configs.linters.luacheck")
  local stylua = require("efmls-configs.formatters.stylua")
  local flake8 = require("efmls-configs.linters.flake8")
  local black = require("efmls-configs.formatters.black")
  local eslint = require("efmls-configs.linters.eslint")
  local prettier_d = require("efmls-configs.formatters.prettier_d")
  local fixjson = require("efmls-configs.formatters.fixjson")
  local shellcheck = require("efmls-configs.linters.shellcheck")
  local shfmt = require("efmls-configs.formatters.shfmt")
  local hadolint = require("efmls-configs.linters.hadolint")
  local solhint = require("efmls-configs.linters.solhint")
  local cpplint = require("efmls-configs.linters.cpplint")
  local clangformat = require("efmls-configs.formatters.clang_format")

  -- configure efm server
  lspconfig.efm.setup({
    filetypes = {
      "lua",
      "python",
      "json",
      "jsonc",
      "sh",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "svelte",
      "vue",
      "markdown",
      "docker",
      "solidity",
      "html",
      "css",
      "c",
      "cpp",
    },
    init_options = {
      documentFormatting = true,
      documentRangeFormatting = true,
      hover = true,
      documentSymbol = true,
      codeAction = true,
      completion = true,
    },
    settings = {
      languages = {
        lua = { luacheck, stylua },
        python = { flake8, black },
        typescript = { eslint, prettier_d },
        json = { eslint, fixjson },
        jsonc = { eslint, fixjson },
        sh = { shellcheck, shfmt },
        javascript = { eslint, prettier_d },
        javascriptreact = { eslint, prettier_d },
        typescriptreact = { eslint, prettier_d },
        svelte = { eslint, prettier_d },
        vue = { eslint, prettier_d },
        markdown = { prettier_d },
        docker = { hadolint, prettier_d },
        solidity = { solhint },
        html = { prettier_d },
        css = { prettier_d },
        c = { clangformat, cpplint },
        cpp = { clangformat, cpplint },
      },
    },
  })

  print("config")
end

return {
  "neovim/nvim-lspconfig",

  init = function()
    local keys = {
      { "gt", "Lspsaga finder" }, -- go to definition
      { "gd", "Lspsaga peek_definition" }, -- peak definition
      { "gD", "Lspsaga goto_definition" }, -- go to definition
      { "ca", "Lspsaga code_action" }, -- see available code actions
      { "rn", "Lspsaga rename" }, -- smart rename
      { "D", "Lspsaga show_line_diagnostics" }, -- show  diagnostics for line
      { "d", "Lspsaga show_cursor_diagnostics" }, -- show diagnostics for cursor
      { "pd", "Lspsaga diagnostic_jump_prev" }, -- jump to prev diagnostic in buffer
      { "nd", "Lspsaga diagnostic_jump_next" },
      { "K", "Lspsaga hover_doc" },
    }
  end,
  config = config,
  lazy = false,
  dependencies = {
    "windwp/nvim-autopairs",
    "williamboman/mason.nvim",
    "creativenull/efmls-configs-nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
  },
}
