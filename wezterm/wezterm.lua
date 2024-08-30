-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.audible_bell = 'Disabled'
config.automatically_reload_config = true
config.color_scheme = 'AdventureTime'
-- config.disable_default_key_bindings = true
config.quit_when_all_windows_are_closed = false

-- copied from https://wezfurlong.org/wezterm/config/lua/PaneInformation.html
wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    if tab.is_active then
      return {
        { Background = { Color = 'blue' } },
        { Text = ' ' .. tab.active_pane.title .. ' ' },
      }
    end
    local has_unseen_output = false
    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output then
        has_unseen_output = true
        break
      end
    end
    if has_unseen_output then
      return {
        { Background = { Color = 'Orange' } },
        { Text = ' ' .. tab.active_pane.title .. ' ' },
      }
    end
    return tab.active_pane.title
  end
)

-- and finally, return the configuration to wezterm
return config
