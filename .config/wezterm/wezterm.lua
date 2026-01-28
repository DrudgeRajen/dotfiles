local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local action = wezterm.action

config.initial_cols = 100
config.initial_rows = 35

config.font = wezterm.font {
  family = 'JetBrainsMonoNL Nerd Font',
  weight = 'Medium',
}
config.font_size = 16.0
config.line_height = 1.3
config.freetype_load_flags = 'NO_HINTING'
config.freetype_interpreter_version = 35
config.freetype_load_target = 'Light'
config.cell_width = 0.9

config.default_cursor_style = 'BlinkingBar'


-- Theme
-- config.color_scheme = 'Catppuccin Macchiato' -- Good one
--config.color_scheme = 'Galaxy'  -- Good one
config.color_scheme = 'Snazzy (base16)' -- Good one
--config.color_scheme = 'Sandcastle (base16)'  -- Good one
--config.color_scheme = 'seoulbones_dark'  -- Good one

-- Tab settings
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 999

-- Window settings
config.pane_focus_follows_mouse = true
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.window_frame = {
  font = wezterm.font { family = 'Roboto', weight = 'Bold' },
  font_size = 17.0,
  active_titlebar_bg = '#333333',
  inactive_titlebar_bg = '#333333',
}

-- Similar to iTerm compact mode, use CTRL + Window click and drag
-- Hold Command Button to Drag the Wezterm window around
config.window_decorations = "RESIZE"

-- Infinite scroll similar to iTerm
config.scrollback_lines = 99999

config.colors = {
  tab_bar = {
    background = '#0b0022',

    active_tab = {
      bg_color = '#2b2042',
      fg_color = '#c0c0c0',

      intensity = 'Normal',
      underline = 'None',
      italic = false,
      strikethrough = false,
    },
    inactive_tab = {
      bg_color = '#1b1032',
      fg_color = '#808080',
    },
    -- The color of the inactive tab bar edge/divider
    inactive_tab_edge = '#575757',
  }
}

config.keys = {
  { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
  {
    key = '[',
    mods = 'CMD',
    action = action.ActivatePaneDirection 'Left'
  },

  {
    key = ']',
    mods = 'CMD',
    action = action.ActivatePaneDirection 'Right'
  },

  {
    key = 'UpArrow',
    mods = 'CMD',
    action = action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'CMD',
    action = action.ActivatePaneDirection 'Down',
  },

  -- iTerm like Split panes
  {
    key = 'd',
    mods = 'CMD',
    action = action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = 'CMD|SHIFT',
    action = action.SplitVertical { domain = 'CurrentPaneDomain' },
  },

  { key = 'k', mods = 'CMD',  action = action.ClearScrollback 'ScrollbackAndViewport' },
  { key = 'w', mods = 'CMD',  action = action.CloseCurrentPane { confirm = false } },

  -- Pass Ctrl+Tab to tmux
  {
    key = 'Tab',
    mods = 'CTRL',
    action = wezterm.action.SendKey {
      key = 'Tab',
      mods = 'CTRL',
    },
  },
  -- Pass Ctrl+Shift+Tab to tmux
  {
    key = 'Tab',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SendKey {
      key = 'Tab',
      mods = 'CTRL|SHIFT',
    },
  },
  { key = "Enter", mods = "SHIFT", action = wezterm.action { SendString = "\x1b\r" } },
}

-- Open Hyperlinks with Ctrl + Mouse click
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = action.OpenLinkAtMouseCursor,
  },
  -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = action.Nop,
  },
}

-- Position new Wezterm window at the center of the screen
wezterm.on("gui-startup", function(cmd)
  local screen            = wezterm.gui.screens().active
  local ratio             = 0.7
  local width, height     = screen.width * ratio, screen.height * ratio
  local tab, pane, window = wezterm.mux.spawn_window {
    position = {
      x = (screen.width - width) / 2,
      y = (screen.height - height) / 2,
      origin = 'ActiveScreen' }
  }
  window:gui_window():maximize()
  window:gui_window():set_inner_size(width, height)
end)


-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)

    if tab.is_active then
      return wezterm.format({
        { Background = { Color = '008900' } },
        { Foreground = { Color = 'ffffff' } },
        { Attribute = { Intensity = 'Bold' } },
        { Text = ' ' .. title .. ' ' },
      })
    end

    if tab.is_last_active then
      -- Green color and append '*' to previously active tab.
      return wezterm.format({
        { Background = { Color = 'green' } },
        { Text = ' ' .. title .. '*' },
      })
    end

    return title
  end
)

return config
