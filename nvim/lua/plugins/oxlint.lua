return {
  -- Run the oxlint language server without `--type-aware`, so it never spawns
  -- tsgolint (the heavy, tsc-equivalent type-checker). Plain syntax linting
  -- stays on and is cheap. Full type-aware checks remain available via
  -- `pnpm lint --type-aware` / CI.
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      oxlint = {
        cmd = { "oxlint", "--lsp" },
      },
    },
  },
}
