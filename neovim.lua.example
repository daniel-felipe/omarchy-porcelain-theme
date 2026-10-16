-- Porcelain — Neovim.
--
-- Omarchy would generate this file from colors.toml through its aether
-- template. It is written out by hand instead because aether's defaults are
-- built for dark themes in three places, and each one is wrong on a near-white
-- ground: the cursorline is derived as 20% of the foreground (a grey bar), the
-- search wash is derived as 40% blue (too dark to read ink on), and the
-- lualine mode block puts `darker_background` on the mode colour — which is a
-- *light* grey here, so it would be light-on-light.
--
-- Everything else comes straight from colors.toml, unchanged.

local palette = {
  bg = "#f4f5f7",
  dark_bg = "#e7e9ed",
  darker_bg = "#d4d8df",
  lighter_bg = "#eaecf0",

  fg = "#3b424c",
  dark_fg = "#68717d",
  light_fg = "#525a65",
  bright_fg = "#1d2229",
  muted = "#848e9b",

  -- Two families only. red/magenta are the rose, green/blue/cyan are the blue,
  -- yellow is neutral ink. See colors.toml for why.
  red = "#a8394b",
  yellow = "#68717d",
  orange = "#9e5462",
  green = "#5a7290",
  cyan = "#3f6597",
  blue = "#4a6c94",
  magenta = "#9e5462",
  brown = "#68717d",

  bright_red = "#8e2a3c",
  bright_yellow = "#525a65",
  bright_green = "#4a6383",
  bright_cyan = "#35558c",
  bright_blue = "#3a587c",
  bright_magenta = "#7d4250",

  accent = "#9e5462",
  cursor = "#1d2229",
  foreground = "#3b424c",
  background = "#f4f5f7",
  selection = "#ebd9de",
  selection_foreground = "#1d2229",
  selection_background = "#ebd9de",
}

return {
  {
    "bjarneo/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = {
      colors = palette,

      on_colors = function(c)
        -- Cursorline: the theme's highlight band, not a 20%-foreground grey.
        c.cursorline_bg = palette.lighter_bg
        c.subtle_bg = palette.lighter_bg
        -- Search: a pale slate wash so full-strength ink still sits on it.
        c.bg_search = "#ccd5e0"
      end,

      on_highlights = function(hl, c)
        -- Splits are a hairline on this theme, not a bold rule.
        hl.WinSeparator = { fg = "#d2d7de" }
        hl.VertSplit = { fg = "#d2d7de" }
        -- The cursor is the one place the accent appears inside a buffer.
        hl.Cursor = { fg = palette.bg, bg = palette.accent }
        hl.CursorLineNr = { fg = c.accent, bold = true }
        -- Every "this row is chosen" surface is the selection wash.
        --
        -- aether derives these from `muted`, which is correct on a dark theme
        -- (there `muted` is a *dark* grey, so it reads as a subtle wash) and
        -- wrong here: on a light ground `muted` is a *mid* grey — too dark to
        -- be a wash, too light to be an inverse. Measured on a live selected
        -- row it lands at 2.96:1, below the 4.5:1 floor.
        --
        -- `muted` cannot be retuned to fix this. To stay readable as dim text
        -- on `background` it needs L <= 0.29; to carry body ink as a fill it
        -- needs L >= 0.44. The two constraints do not overlap, so the fill
        -- role has to move off the token entirely.
        --
        -- The selection wash is the answer, and it is the same value ghostty
        -- uses for terminal selection — so a selected row in the editor and a
        -- selected range in the shell are finally the same color.
        local selected = { bg = palette.selection, fg = palette.bright_fg }

        hl.Visual = { bg = palette.selection }
        hl.VisualNOS = { bg = palette.selection }
        hl.PmenuSel = { bg = palette.selection }
        hl.PmenuMatchSel = { bg = palette.selection, fg = palette.blue, bold = true }
        hl.BlinkCmpMenuSelection = { bg = palette.selection }
        hl.WildMenu = selected
        hl.QuickFixLine = { bg = palette.selection }
        hl.SnacksPickerListCursorLine = selected
        hl.NeoTreeCursorLine = { bg = palette.selection }
        hl.TelescopeSelection = selected
        hl.FzfLuaCursorLine = selected

        -- TabLineSel is deliberately NOT in this list. The active tab already
        -- renders as a solid accent block, which is the correct treatment —
        -- it is the same gesture as lualine's mode block, and it is the only
        -- accent in that row. A wash there would be a downgrade.

        -- ------------------------------------------------------------------
        -- Syntax, collapsed to two hues.
        --
        -- With only rose and blue available, hue can no longer label eight
        -- different token types. So it labels four *categories* instead, and
        -- weight carries the rest:
        --
        --   rose      grammar   — keywords, control flow, imports
        --   blue      data      — strings, numbers, booleans, regex
        --   ink bold  names     — functions and types you defined
        --   ink       subjects  — variables, properties, parameters
        --   grey      noise     — comments, punctuation, operators
        --
        -- Reading code becomes "grammar / data / names / everything else",
        -- which is a coarser cut than eight hues but a consistent one, and it
        -- survives being looked at next to the rest of the desktop.
        -- ------------------------------------------------------------------
        local rose, data = palette.accent, palette.blue
        local names = { fg = palette.bright_fg, bold = true }
        local subject = { fg = palette.fg }
        local noise = { fg = palette.dark_fg }

        for _, g in ipairs({
          "Statement", "Keyword", "Conditional", "Repeat", "Exception",
          "PreProc", "Include", "Define", "Macro",
          "@keyword", "@keyword.function", "@keyword.operator", "@keyword.return",
          "@keyword.import", "@keyword.repeat", "@keyword.conditional",
          "@keyword.exception", "@conditional", "@repeat", "@exception", "@include",
        }) do
          hl[g] = { fg = rose }
        end

        for _, g in ipairs({
          "String", "Character", "@string", "@string.documentation",
          "@string.escape", "@string.special", "@character",
        }) do
          hl[g] = { fg = data }
        end

        for _, g in ipairs({
          "Number", "Float", "Boolean", "Constant",
          "@number", "@number.float", "@boolean", "@constant",
          "@constant.builtin", "@string.regexp",
        }) do
          hl[g] = { fg = palette.cyan }
        end

        for _, g in ipairs({
          "Function", "@function", "@function.call", "@function.method",
          "@function.builtin", "@method", "@method.call", "@constructor",
        }) do
          hl[g] = names
        end

        for _, g in ipairs({
          "Type", "StorageClass", "Structure", "Typedef",
          "@type", "@type.builtin", "@type.definition", "@module",
        }) do
          hl[g] = { fg = palette.bright_fg }
        end

        for _, g in ipairs({
          "Identifier", "@variable", "@variable.member", "@variable.parameter",
          "@property", "@field", "@parameter", "@attribute",
        }) do
          hl[g] = subject
        end

        for _, g in ipairs({
          "Delimiter", "Operator", "Special", "SpecialChar",
          "@punctuation.bracket", "@punctuation.delimiter", "@punctuation.special",
          "@operator",
        }) do
          hl[g] = noise
        end

        hl.Comment = { fg = palette.muted, italic = true }
        hl["@comment"] = { fg = palette.muted, italic = true }

        -- Diagnostics stay inside the rose family and separate by urgency:
        -- an error is the high-chroma rose, a warning is the plain accent.
        -- Info and hint are the blue, because they are not problems.
        hl.DiagnosticError = { fg = palette.red }
        hl.DiagnosticWarn = { fg = palette.accent }
        hl.DiagnosticInfo = { fg = palette.blue }
        hl.DiagnosticHint = { fg = palette.green }
        hl.DiagnosticOk = { fg = palette.blue }

        -- Git: added is the blue, removed is the alarm rose, changed is the
        -- plain accent. Red/green is the one convention this theme gives up.
        hl.GitSignsAdd = { fg = palette.blue }
        hl.GitSignsChange = { fg = palette.accent }
        hl.GitSignsDelete = { fg = palette.red }
        hl.DiffAdd = { bg = "#dde3ec" }
        hl.DiffDelete = { bg = "#f0dde1" }
        hl.DiffChange = { bg = "#e6e9ee" }
        hl.DiffText = { bg = "#c9d5e4" }
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Same hierarchy as the rest of the desktop: the mode block is the one
      -- saturated element, the plate behind it is dark_background, and the
      -- accent marks normal mode the way it marks the focused window.
      --
      -- Section b stays ink. Lualine's convention is to tint it with the mode
      -- colour, but b and the undefined sections that fall back to it (branch,
      -- position, progress) then put the accent in three places at once, which
      -- is three more than "the brightest thing on screen is what you are
      -- acting on" allows. a and z bookend it; everything between is neutral.
      local function mode(color)
        return {
          a = { bg = color, fg = palette.bg, gui = "bold" },
          b = { bg = palette.dark_bg, fg = palette.foreground },
          c = { bg = palette.dark_bg, fg = palette.dark_fg },
        }
      end

      opts.options = opts.options or {}
      opts.options.theme = {
        -- Six modes, two families. `magenta` is now the accent itself, so the
        -- old normal/visual pair would have been the same block. They separate
        -- by chroma and depth within rose and blue instead.
        normal = mode(palette.accent),      -- rose
        insert = mode(palette.blue),        -- blue
        visual = mode(palette.bright_magenta), -- rose, deeper
        replace = mode(palette.red),        -- rose, alarm
        command = mode(palette.light_fg),   -- neutral ink
        terminal = mode(palette.bright_blue), -- blue, deeper
        inactive = {
          a = { bg = palette.dark_bg, fg = palette.muted },
          b = { bg = palette.bg, fg = palette.muted },
          c = { bg = palette.bg, fg = palette.muted },
        },
      }

      return opts
    end,
  },
}
