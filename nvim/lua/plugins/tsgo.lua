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
      -- (now an alias for tsc) prefers node_modules/.bin/tsc over tsgo, and
      -- plain tsc exits 1 on --lsp --stdio, so force the local tsgo binary.
      vim.lsp.config("tsgo", {
        cmd = function(dispatchers, config)
          local bin = vim.fs.joinpath(config.root_dir, "node_modules", ".bin", "tsgo")
          return vim.lsp.rpc.start({ bin, "--lsp", "--stdio" }, dispatchers)
        end,
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

      -- LazyVim enables inlay hints for every capable server; tsgo emits type
      -- hints by default, which shows greyed-out inferred types inline.
      opts.inlay_hints = { enabled = false }
      return opts
    end,
  },
}
