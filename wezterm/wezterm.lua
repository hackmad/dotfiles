-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux
local action = wezterm.action

-- This table will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Colour scheme
config.color_scheme = 'Dark Pastel'

-- Fonts
config.font = wezterm.font_with_fallback {
    { family = 'JetBrainsMono Nerd Font', weight = 'Light' },
    { family = 'FiraCode Nerd Font',      weight = 'Light' },
}
config.font_size = 10

-- Tab bar
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- Filled in variant of the < and > symbols.
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This function returns the suggested title for a tab. It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the title of the active pane in that tab.
function tab_title(tab_info)
    local title = tab_info.tab_title
    local index = tab_info.tab_index + 1

    -- If the tab title is explicitly set, take that
    if title and #title > 0 then
        return index .. ': ' .. title
    end

    -- Otherwise, use the title from the active pane in that tab
    return index .. ': ' .. tab_info.active_pane.title
end

wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
        local edge_background = '#0b0022'
        local background = '#2b2042'
        local foreground = '#909090'

        if tab.is_active then
            background = '#5b5072'
            foreground = 'fc0f0f0'
        elseif hover then
            background = '#3b3052'
            foreground = '#c0c0c0'
        end

        local edge_foreground = background

        local title = tab_title(tab)

        -- Ensure that the titles fit in the available space, and that we have room for the edges.
        title = wezterm.truncate_right(title, max_width - 2)

        return {
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_LEFT_ARROW },
            { Background = { Color = background } },
            { Foreground = { Color = foreground } },
            { Text = title },
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_RIGHT_ARROW },
        }
    end
)

-- Key bindings (from tmux)
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    -- Panes
    { key = '\\', mods = 'LEADER', action = action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '-',  mods = 'LEADER', action = action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'h',  mods = 'LEADER', action = action.ActivatePaneDirection('Prev') },
    { key = 'l',  mods = 'LEADER', action = action.ActivatePaneDirection('Next') },
    { key = 'k',  mods = 'LEADER', action = action.ActivatePaneDirection('Prev') },
    { key = 'j',  mods = 'LEADER', action = action.ActivatePaneDirection('Next') },

    -- Tabs
    { key = 'c',  mods = 'LEADER', action = action.SpawnTab('CurrentPaneDomain') },
    { key = 'n',  mods = 'LEADER', action = action.ActivateTabRelative(1) },
    { key = 'p',  mods = 'LEADER', action = action.ActivateTabRelative(-1) },
}
for i = 1, 9 do
    table.insert(config.keys, { key = tostring(i), mods = 'LEADER', action = action.ActivateTab(i - 1) })
end

-- Workspaces
function coding_workspace(args)
    -- Top pane is for the editor/running, bottom pane is for the build tool
    local tab, pane, window = mux.spawn_window {
        workspace = 'coding',
        args = args,
    }
    -- window:gui_window():maximize()

    -- local right_pane = pane:split {
    --     direction = 'Left',
    --     size = 0.5,
    -- }

    -- window:spawn_tab {}

    -- tab:activate()
end

wezterm.on('gui-startup', function(cmd)
    -- Allow `wezterm start -- something` to affect what we spawn in our initial window.
    local args = {}
    if cmd then
        args = cmd.args
    end

    -- Set a workspaces
    coding_workspace(args)

    -- We want to startup in the coding workspace.
    mux.set_active_workspace 'coding'
end)

-- And finally, return the configuration to wezterm.
return config
