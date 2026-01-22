return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa"
    },
  },
  {
    "tiagovla/tokyodark.nvim",
    "Mofiqul/dracula.nvim",
    "olimorris/onedarkpro.nvim",
    "scottmckendry/cyberdream.nvim",

    opts = {
      -- custom options here
    },
    {
      "rebelot/kanagawa.nvim",
      priority = 1000,
      lazy = false,
      init = function()
        vim.cmd.colorscheme("kanagawa-dragon")
      end,
  
      opts = {
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
        overrides =
          ---@param colors KanagawaColors
          function(colors)
            local theme = colors.theme
  
            colors.theme.ui.bg_gutter = theme.ui.bg
  
            local makeDiagnosticColor = function(color)
              local c = require("kanagawa.lib.color")
              return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
            end
  
            return {
              NormalFloat = { bg = "none" },
              FloatBorder = { bg = "none" },
              FloatTitle = { bg = "none" },
  
              -- Save an hlgroup with dark background and dimmed foreground
              -- so that you can use it where your still want darker windows.
              -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
              NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
  
              -- Popular plugins that open floats will link to NormalFloat by default;
              -- set their background accordingly if you wish to keep them dark and borderless
              LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
              MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
  
              -- TelescopeTitle = { fg = theme.ui.special, bold = true },
              -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
              TelescopePromptBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },
              -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
              TelescopeResultsBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },
              -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
              TelescopePreviewBorder = { fg = theme.ui.bg_p2, bg = theme.ui.bg },
  
              Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
              PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
              PmenuSbar = { bg = theme.ui.bg_m1 },
              PmenuThumb = { bg = theme.ui.bg_p2 },
  
              DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
              DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
              DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
              DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
  
              NoiceCmdlineIcon = {
                bg = theme.ui.bg,
                fg = theme.ui.special,
              },
  
              NoiceCmdlineIconSearch = {
                bg = theme.ui.bg,
                fg = theme.ui.special,
              },
  
              NoiceCmdlinePopup = {
                bg = theme.ui.bg,
                fg = theme.ui.fg,
              },
              NoiceCmdlinePopupBorder = {
                bg = theme.ui.bg,
                fg = theme.ui.bg_p2,
              },
  
              NoicePopupBorder = {
                bg = theme.ui.bg,
                fg = colors.palette.roninYellow,
              },
  
              NoiceCmdlinePopupBorderSearch = {
                bg = theme.ui.bg,
                fg = colors.palette.roninYellow,
              },
  
              NoiceCmdlinePrompt = {
                bg = theme.ui.bg,
                fg = colors.palette.roninYellow,
              },
  
              LazyGitFloat = {
                bg = theme.ui.bg,
                fg = colors.palette.fujiWhite,
              },
              LazyGitBorder = {
                bg = theme.ui.bg,
                fg = theme.ui.bg_p2,
              },
            }
          end,
      },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd([[colorscheme kanagawa]])
    end,
  }
  
}
