local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Window settings
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.84
config.macos_window_background_blur = 30
config.max_fps = 120
config.animation_fps = 120
config.initial_cols = 200
config.initial_rows = 55
config.window_padding = {
  left = 12,
  right = 12,
  top = 10,
  bottom = 10,
}

-- Font settings
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 14.0

-- Color scheme
config.colors = {
  foreground = '#c8c2ba',
  background = '#3a3836',

  cursor_bg = '#9a96b8',
  cursor_fg = '#3a3836',
  cursor_border = '#9a96b8',

  selection_fg = '#c8c2ba',
  selection_bg = '#504c54',

  ansi = {
    '#a8a29c',
    '#c48b8b',
    '#8aab8d',
    '#c4a87a',
    '#8296b0',
    '#ab8ba5',
    '#80a8a0',
    '#a09a94',
  },

  brights = {
    '#b8b2ac',
    '#d4a0a0',
    '#9abb9c',
    '#d4b88a',
    '#96acc4',
    '#bb9bb5',
    '#90b8b0',
    '#c4bdb5',
  },

  split = '#9a96b8',

  tab_bar = {
    background = '#32302e',
    active_tab = {
      bg_color = '#3a3836',
      fg_color = '#c8c2ba',
    },
    inactive_tab = {
      bg_color = '#32302e',
      fg_color = '#7a7570',
    },
    inactive_tab_hover = {
      bg_color = '#454240',
      fg_color = '#c8c2ba',
    },
    new_tab = {
      bg_color = '#32302e',
      fg_color = '#7a7570',
    },
    new_tab_hover = {
      bg_color = '#454240',
      fg_color = '#c8c2ba',
    },
  },
}

-- Dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.6,
}

-- Cursor
config.default_cursor_style = 'BlinkingBlock'
config.cursor_thickness = 1
config.cursor_blink_rate = 100

-- Scrollback
config.scrollback_lines = 10000

-- Selection
config.selection_word_boundary = " \t\n{}[]()\"'`,;:"

-- Mouse
config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = 'Right' } },
    mods = 'NONE',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
}

-- Tab bar
config.enable_scroll_bar = false
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32

-- Key bindings
config.keys = {
  { key = 'v', mods = 'CMD', action = wezterm.action.PasteFrom 'Clipboard' },
  { key = 't', mods = 'CMD', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'n', mods = 'CMD', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentPane { confirm = false } },
  { key = 'Backspace', mods = 'CMD', action = wezterm.action.CloseCurrentPane { confirm = false } },
  { key = 't', mods = 'CMD|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  { key = '[', mods = 'CMD', action = wezterm.action.ActivateTabRelative(-1) },
  { key = ']', mods = 'CMD', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'LeftArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'DownArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'UpArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'RightArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = '1', mods = 'CMD', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'CMD', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'CMD', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'CMD', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'CMD', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'CMD', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'CMD', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'CMD', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'CMD', action = wezterm.action.ActivateTab(8) },
  { key = 'p', mods = 'CMD|SHIFT', action = wezterm.action.ActivateCommandPalette },
}

return config
