local wezterm = require 'wezterm'

local config =  {

  color_scheme = 'GruvboxDarkHard',

  font_size = 15,
  font = 
    -- wezterm.font('CaskaydiaCove Nerd Font Mono', {
    --   weight = "Regular", 
    --   stretch = 'Normal',
    --   style = "Normal"
    -- }),
    wezterm.font('FiraCode Nerd Font', {
      weight = "Regular", 
      stretch = 'Normal',
      style = "Normal"
    }),
    -- wezterm.font('Maple Mono NF', {
    --   weight = "Regular",
    --   stretch = 'Normal',
    --   style = "Normal"
    -- }),
  -- use_cap_height_to_scale_fallback_fonts = true

  adjust_window_size_when_changing_font_size = false,
  hide_mouse_cursor_when_typing = false,
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "RESIZE",

  front_end = "WebGpu",
  -- enable_wayland = false,

  initial_cols = 92,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },


--  window_frame = {
--    border_left_width = '0cell',
--    border_right_width = '0cell',
--    border_bottom_height = '0cell',
--    border_top_height = '0cell',
--  }
}

return config
