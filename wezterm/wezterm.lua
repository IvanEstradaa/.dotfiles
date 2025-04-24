local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 15

local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- To modify title bar, buttons and corners: https://wezterm.org/config/lua/config/window_decorations.html, for squared corners you need to install wezterm@nightly
config.window_decorations = "RESIZE | MACOS_FORCE_SQUARE_CORNERS"

config.window_close_confirmation = 'NeverPrompt'

config.default_cursor_style = 'SteadyBar' -- other options: 'BlinkingBar', 'BlinkingUnderline', 'SteadyUnderline', 'BlinkingBlock', 'SteadyBlock'

-- https://www.youtube.com/watch?v=l5c5ucQvKOA
config.max_fps = 120
config.prefer_egl = true

-- Padding
-- config.window_padding = {
--   left = 0,
--   right = 0,
--   top = 0,
--   bottom = 0,
-- }

-- https://wezterm.org/config/appearance.html#defining-your-own-colors

-- To change color scheme, see: https://wezterm.org/colorschemes/index.html
--   config.color_scheme = 'Dawn (terminal.sexy)'
-- config.color_scheme = 'Unsifted Wheat (terminal.sexy)'
-- config.color_scheme = 'Teva (terminal.sexy)'
-- config.color_scheme = 'Canvased Pastel (terminal.sexy)'
-- config.color_scheme = 'Hybrid (Gogh)'
-- config.color_scheme = 'N0tch2k'
-- config.color_scheme = 'Red Phoenix (terminal.sexy)'
-- config.color_scheme = 'Sundried' -- First favorite
--    config.color_scheme = 'X::Erosion (terminal.sexy)'
-- config.color_scheme = 'Grayscale (dark) (terminal.sexy)' -- Default
  config.color_scheme = 'Black Metal (Immortal) (base16)' -- Second favorite
--    config.color_scheme = 'Black Metal (Khold) (base16)'
-- config.color_scheme = 'Hacktober'
-- config.color_scheme = 'City Streets (terminal.sexy)'
--   config.color_scheme = 'Sequoia Monochrome' -- Third favorite
-- config.color_scheme = 'Mono Theme (terminal.sexy)'


-- config.colors = {}

-- config.window_background_opacity = 0.6
-- config.macos_window_background_blur = 3


-- Function to get the current desktop wallpaper path 
function get_current_wallpaper()
  local handle = io.popen('osascript -e \'tell app "finder" to get posix path of (get desktop picture as alias)\'') -- https://apple.stackexchange.com/questions/332334/macos-determine-current-wallpaper-path#332335
  local wallpaper_path = handle:read("*a"):gsub("\n", "") -- Remove newline at the end
  handle:close()
  return wallpaper_path
end

-- Fetch the current wallpaper path
local wallpaper_path = get_current_wallpaper()

-- Configure the background using the retrieved wallpaper path

config.background = {
  {
    source = {
      File = wallpaper_path,  -- Use the dynamic wallpaper path
    },
    height = 'Cover',
    width = 'Cover',
    horizontal_align = 'Center',
    vertical_align = 'Top',
    -- repeat_x = 'NoRepeat',
    -- repeat_y = 'NoRepeat',
    hsb = { brightness = 0.25 }, -- Adjust the brightness (optional)
    --opacity = 0.7, -- Adjust the opacity (optional)
  },
}

-- local dimmer = { brightness = 0.3 }
-- 
-- -- Background: https://wezterm.org/config/lua/config/background.html
-- -- Background Gradient: https://wezterm.org/config/lua/config/window_background_gradient.html
-- config.background = {
--   {
--     source = {
--       File = os.getenv("HOME") .. "/.dotfiles/wallpaper/Wallpaper1.jpg",
--     },
--     height = 'Cover',
--     width = 'Cover',
--     horizontal_align = 'Center',
--     vertical_align = 'Top',
--     -- repeat_x = 'NoRepeat',
--     -- repeat_y = 'NoRepeat',
--     hsb = dimmer,
--   },
-- }

-- https://wezterm.org/config/lua/wezterm.color/extract_colors_from_image.html

-- Tmux like bindings: https://raw.githubusercontent.com/dragonlobster/wezterm-config/main/wezterm.lua https://www.youtube.com/watch?v=V1X4WQTaxrc 
config.leader = { key = "q", mods = "ALT", timeout_milliseconds = 2000 }
config.keys = {
    {
        mods = "LEADER",
        key = "c",
        action = wezterm.action.SpawnTab "CurrentPaneDomain",
    },
    {
        mods = "LEADER",
        key = "x",
        action = wezterm.action.CloseCurrentPane { confirm = true }
    },
    {
        mods = "LEADER",
        key = "b",
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        mods = "LEADER",
        key = "n",
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        mods = "LEADER",
        key = "º",
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
    },
    {
        mods = "LEADER",
        key = "-",
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
    },
    {
        mods = "LEADER",
        key = "h",
        action = wezterm.action.ActivatePaneDirection "Left"
    },
    {
        mods = "LEADER",
        key = "j",
        action = wezterm.action.ActivatePaneDirection "Down"
    },
    {
        mods = "LEADER",
        key = "k",
        action = wezterm.action.ActivatePaneDirection "Up"
    },
    {
        mods = "LEADER",
        key = "l",
        action = wezterm.action.ActivatePaneDirection "Right"
    },
    {
        mods = "LEADER",
        key = "LeftArrow",
        action = wezterm.action.AdjustPaneSize { "Left", 5 }
    },
    {
        mods = "LEADER",
        key = "RightArrow",
        action = wezterm.action.AdjustPaneSize { "Right", 5 }
    },
    {
        mods = "LEADER",
        key = "DownArrow",
        action = wezterm.action.AdjustPaneSize { "Down", 5 }
    },
    {
        mods = "LEADER",
        key = "UpArrow",
        action = wezterm.action.AdjustPaneSize { "Up", 5 }
    },
}

for i = 0, 9 do
    -- leader + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = wezterm.action.ActivateTab(i),
    })
end

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

-- tmux status
wezterm.on("update-right-status", function(window, _)
    local SOLID_LEFT_ARROW = ""
    local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
    local prefix = ""

    if window:leader_is_active() then
        prefix = " " .. utf8.char(0x1f4a9) -- ocean wave
        SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    end

    if window:active_tab():tab_id() ~= 0 then
        ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
    end -- arrow color based on if tab is first pane

    window:set_left_status(wezterm.format {
        { Background = { Color = "#b7bdf8" } },
        { Text = prefix },
        ARROW_FOREGROUND,
        { Text = SOLID_LEFT_ARROW }
    })
end)

return config
