return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        oxfmt = {
          command = "oxfmt",
          args = { "--stdin" },
          stdin = true,
        },
      },

      formatters_by_ft = {
        javascript = { "oxfmt" },
        typescript = { "oxfmt" },
        javascriptreact = { "oxfmt" },
        typescriptreact = { "oxfmt" },
        vue = { "oxfmt" },
        svelte = { "oxfmt" },
        astro = { "oxfmt" },
      },
    },
  },
}
