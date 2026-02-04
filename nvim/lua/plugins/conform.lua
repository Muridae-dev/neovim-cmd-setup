return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        oxfmt = {
          command = "oxfmt",
          stdin = true,
        },
      },

      formatters_by_ft = {
        javascript = { "oxfmt", "prettier", stop_after_first = true },
        typescript = { "oxfmt", stop_after_first = true },
        javascriptreact = { "oxfmt", stop_after_first = true },
        typescriptreact = { "oxfmt", stop_after_first = true },
        vue = { "oxfmt", stop_after_first = true },
        svelte = { "oxfmt", stop_after_first = true },
        astro = { "oxfmt", stop_after_first = true },
      },
    },
  },
}
