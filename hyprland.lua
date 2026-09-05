-- Porcelain — window manager look'n'feel.
--
-- Omarchy loads this instead of generating one from colors.toml, so the border
-- colours are set here explicitly alongside the geometry. Anything in
-- ~/.config/hypr/looknfeel.lua is sourced afterwards and still wins.
--
-- The wallpapers have no hard edges and no hard shadows: forms are separated
-- by soft value falloff and sit in a lot of empty space. Windows follow that —
-- generously rounded, a little more air between them, and a shadow that is
-- barely there. On a near-white desktop a heavy shadow reads as dirt, not as
-- depth, so the shadow is wide and faint rather than tight and dark.

-- The bounce light sweeping into the slate shadow, on the diagonal the
-- sculpted forms run in every one of the three backgrounds.
local active_border_color = { colors = { "rgba(9e5462ff)", "rgba(6d7f93ff)" }, angle = 45 }
local inactive_border_color = "rgba(d2d7deff)"

hl.config({
  general = {
    gaps_in = 6,
    gaps_out = 12,
    border_size = 2,

    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  decoration = {
    rounding = 12,
    rounding_power = 2.6,

    shadow = {
      enabled = true,
      -- Wide and faint: a bloom under the window rather than a drop shadow.
      range = 30,
      render_power = 2,
      offset = "0 8",
      -- Cool graphite at ~15%, the same ink as the text, so the shadow reads
      -- as the wallpaper's ambient shade instead of as grey haze.
      color = "rgba(2a303a26)",
      color_inactive = "rgba(2a303a12)",
    },

    blur = {
      enabled = true,
      size = 6,
      passes = 3,
      new_optimizations = true,
      ignore_opacity = false,
      xray = false,
      popups = true,
      -- Light theme: glass should stay bright. Lifting brightness and pulling
      -- contrast down keeps a translucent launcher legible over the dark
      -- wallpaper without letting it grey out over the light ones.
      noise = 0.006,
      contrast = 0.9,
      brightness = 1.05,
      vibrancy = 0.08,
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },

    groupbar = {
      indicator_height = 2,
      text_color = "rgb(1d2229)",
      text_color_inactive = "rgba(68717daa)",
      col = {
        active = "rgba(9e546226)",
        inactive = "rgba(d4d8df66)",
      },
    },
  },
})
