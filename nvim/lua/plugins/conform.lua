return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        oxfmt = {
          command = "oxfmt",
          stdin = true,
        },
        biome = {
          command = "biome",
          stdin = true,
        },
      },

      formatters_by_ft = {
        javascript = { "oxfmt", "biome", "prettier", stop_after_first = true },
        typescript = { "oxfmt", "biome", stop_after_first = true },
        javascriptreact = { "oxfmt", "biome", stop_after_first = true },
        typescriptreact = { "oxfmt", "biome", stop_after_first = true },
        vue = { "oxfmt", "biome", stop_after_first = true },
        svelte = { "oxfmt", "biome", stop_after_first = true },
        astro = { "oxfmt", "biome", stop_after_first = true },
      },
    },
  },
}
