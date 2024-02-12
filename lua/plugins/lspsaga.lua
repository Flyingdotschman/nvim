return {
  "nvimdev/lspsaga.nvim",
  config = function()
    require("lspsaga").setup({})
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons", -- optional
  },
  keys = {
    { "gt", "<cmd>Lspsaga finder<cr>" }, -- go to definition
    { "gd", "<cmd>Lspsaga peek_definition<cr>" }, -- peak definition
    { "gD", "<cmd>Lspsaga goto_definition<cr>" }, -- go to definition
    { "ca", "<cmd>Lspsaga code_action<cr>" }, -- see available code actions
    { "rn", "<cmd>Lspsaga rename<cr>" }, -- smart rename
    { "D", "<cmd>Lspsaga show_line_diagnostics<cr>" }, -- show  diagnostics for line
    { "d", "<cmd>Lspsaga show_cursor_diagnostics<cr>" }, -- show diagnostics for cursor
    { "pd", "<cmd>Lspsaga diagnostic_jump_prev<cr>" }, -- jump to prev diagnostic in buffer
    { "nd", "<cmd>Lspsaga diagnostic_jump_next<cr>" },
    { "K", "<cmd>Lspsaga hover_doc<cr>" },
  },
}
