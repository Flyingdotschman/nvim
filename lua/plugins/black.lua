return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      ["python"] = { "autopep8" },
    },
    formatters = {
      black = {
        prepend_args = { "--skip-magic-trailing-comma=true" },
      },
    },
  },
}
