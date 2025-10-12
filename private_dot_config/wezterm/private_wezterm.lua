-- WezTerm configuration converted from Alacritty
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Font configuration
config.font = wezterm.font('Monaspace Neon NF')
config.font_size = 10.0

-- Window dimensions
config.initial_cols = 152
config.initial_rows = 40

-- Shell configuration
config.default_prog = { '/bin/fish', '--login' }

-- Custom color scheme (converted from Alacritty)
config.colors = {
  -- Primary colors
  foreground = '#d5d5d5',
  background = '#090300',

  -- Cursor colors
  cursor_bg = '#a5a2a2',
  cursor_fg = '#090300',
  cursor_border = '#a5a2a2',

  -- Selection colors (using cursor colors as base)
  selection_fg = '#090300',
  selection_bg = '#a5a2a2',

  -- ANSI colors (normal)
  ansi = {
    '#3b3b3b', -- black
    '#db2d20', -- red
    '#19cb00', -- green
    '#f9af4f', -- yellow
    '#01a0e4', -- blue
    '#ad2bee', -- magenta
    '#0066ff', -- cyan
    '#fafafa', -- white
  },

  -- ANSI colors (bright)
  brights = {
    '#5c5855', -- black
    '#db2d20', -- red
    '#a2e655', -- green
    '#ffb454', -- yellow
    '#01a0e4', -- blue
    '#cc00ff', -- magenta
    '#0066ff', -- cyan
    '#ffffff', -- white
  },
}

-- Keyboard bindings
config.keys = {
  -- Increase font size (Ctrl+Equals)
  {
    key = '=',
    mods = 'CTRL',
    action = wezterm.action.IncreaseFontSize,
  },
  -- Decrease font size (Ctrl+Minus)
  {
    key = '-',
    mods = 'CTRL',
    action = wezterm.action.DecreaseFontSize,
  },
  -- Terminal integration for Claude (Shift+Enter)
  {
    key = "Enter",
    mods = "SHIFT",
    action = wezterm.action { SendString = "\x1b\r" },
  },
}

return config
