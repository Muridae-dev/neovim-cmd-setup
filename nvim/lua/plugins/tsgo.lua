-- Use the project-local tsgo LSP (@typescript/native-preview, e.g. pigello-next)
-- when a repo ships it in node_modules; keep typescript-language-server (ts_ls)
-- for every other project. ts_ls is auto-enabled by mason-lspconfig, so it only
-- needs a guard to stay out of tsgo projects.
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Same root detection as the shipped ts_ls/tsgo configs (nearest package
      -- manager lockfile, falling back to .git).
      local function project_root(bufnr)
        return vim.fs.root(bufnr, {
          { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" },
          { ".git" },
        })
      end

      local function has_local_tsgo(root)
        return root ~= nil
          and vim.fn.executable(vim.fs.joinpath(root, "node_modules", ".bin", "tsgo")) == 1
      end

      -- tsgo: only attach when the project ships the binary. The shipped config
      -- already prefers node_modules/.bin/tsgo for the cmd.
      vim.lsp.config("tsgo", {
        root_dir = function(bufnr, on_dir)
          local root = project_root(bufnr)
          if has_local_tsgo(root) then
            on_dir(root)
          end
        end,
      })

      -- ts_ls: decline in tsgo projects so diagnostics don't double up.
      vim.lsp.config("ts_ls", {
        root_dir = function(bufnr, on_dir)
          local root = project_root(bufnr)
          if has_local_tsgo(root) then
            return
          end
          on_dir(root or vim.fn.getcwd())
        end,
      })

      vim.lsp.enable("tsgo")
      return opts
    end,
  },
}
