local subLayer = {}
local hyperKey = "F20"
local activeSubLayer = ""
local hyperTriggered = false

function singlePressHyper()
    if not hyperTriggered then
        toggleBorder(0, 0, 1, 1)
        hs.execute("/usr/local/bin/remap")
    end
    hyperTriggered = false
end

subLayer["B"] = {
    ["H"] = {url = "https://brew.sh/"},
    ["T"] = {url = "https://experiencia21.tec.mx/"},
    ["D"] = {url = "https://doc.new/"},
    ["C"] = {url = "https://chatgpt.com/"},
    ["W"] = {url = "https://web.whatsapp.com/"},
}

subLayer["O"] = {
    ["B"] = {app = "Safari"},
    ["M"] = {app = "Messages"},
    ["E"] = {app = "FindMy"},
    ["T"] = {app = "Warp"},
    ["C"] = {app = "'Visual Studio Code'"},
}

subLayer["R"] = {
    ["C"] = {url = "raycast://extensions/thomas/color-picker/pick-color"},
    ["E"] = {url = "raycast://extensions/raycast/emoji-symbols/search-emoji-symbols"},
    ["H"] = {url = "raycast://extensions/ivanestradaa/mitec/horario"},
    ["V"] = {url = "raycast://extensions/benekuehn/openvpn/toggle-last-profile"},
    ["L"] = {url = "raycast://extensions/lardissone/raindrop-io/search"},
    ["A"] = {url = "raycast://extensions/lardissone/raindrop-io/add"},
}

subLayer["S"] = {
    ["H"] = {url = "raycast://extensions/mattisssa/spotify-player/previous"},
    ["J"] = {url = "raycast://extensions/mattisssa/spotify-player/volumeDown"},
    ["K"] = {url = "raycast://extensions/mattisssa/spotify-player/volumeUp"},
    ["L"] = {url = "raycast://extensions/mattisssa/spotify-player/next"},
    ["B"] = {url = "raycast://extensions/mattisssa/spotify-player/yourLibrary"},
    ["D"] = {url = "raycast://extensions/mattisssa/spotify-player/devices"},
    ["F"] = {url = "raycast://extensions/mattisssa/spotify-player/search"},
    ["A"] = {url = "raycast://extensions/mattisssa/spotify-player/toggleShuffle"},
    ["R"] = {url = "raycast://extensions/mattisssa/spotify-player/replay"},
    ["M"] = {url = "raycast://extensions/mattisssa/spotify-player/like"},
    ["Q"] = {url = "raycast://extensions/mattisssa/spotify-player/queue"},
    ["SPACE"] = {url = "raycast://extensions/mattisssa/spotify-player/togglePlayPause"},
    ["N"] = {url = "raycast://extensions/mattisssa/spotify-player/nowPlaying"},
}

subLayer["C"] = {
    ["U"] = {brightness = 6}, -- Brightness increment 
    ["J"] = {brightness = -6}, -- Brightness decrement
    ["I"] = {volume = 6}, -- Volume increment
    ["K"] = {volume = -6}, -- Volume decrement
    ["B"] = {url = "x-apple.systempreferences:com.apple.preference.battery"},
    ["L"] = {url = "x-apple.systempreferences:com.apple.Lock-Screen-Settings.extension"},
    ["A"] = {url = "x-apple.systempreferences:com.apple.settings.Storage"},
}

subLayer["M"] = {
    ["R"] = {reload = "Reload hammerspoon config"}, 
    ["C"] = {code = "~/.config/hammerspoon"}, 
}

-- subLayer["E"] = {
--     ["Z"] = {mods = {"cmd", "alt"}, key = "V", type = types.keyStroke},
-- }

local function mouseLazyCenter()
    local frame = hs.window.focusedWindow():frame()
    -- Calculate the center of the window
    local centerX = frame.x + frame.w / 2
    local centerY = frame.y + frame.h / 2
    -- Move the mouse to the center of the window
    hs.mouse.setRelativePosition({x = centerX, y = centerY})
end


listenForSubLayers = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, function(event)
    local key = string.upper(hs.keycodes.map[event:getKeyCode()])  -- Get the key from the key code event and convert to uppercase
    local keyUp = event:getType() == hs.eventtap.event.types.keyUp

    if keyUp then
        if key == hyperKey then
            activeSubLayer = ""
            listenForActions:stop()
            return false
        else return true end
    end

    if subLayer[key] and activeSubLayer == "" then
        activeSubLayer = key
        listenForActions:start()
        hyperTriggered = true
    end

    if activeSubLayer == "" then 
        if key == "H" then
            hs.window.focusedWindow():focusWindowWest()
        elseif key == "J" then
            hs.window.focusedWindow():focusWindowSouth()
        elseif key == "K" then
            hs.window.focusedWindow():focusWindowNorth()
        elseif key == "L" then
            hs.window.focusedWindow():focusWindowEast()
        end
        mouseLazyCenter()
        hyperTriggered = true
    end
    event:stopPropagation()
end)

listenForActions = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, function(event)
    local key = string.upper(hs.keycodes.map[event:getKeyCode()])  -- Get the key from the key code event and convert to uppercase
    local action = subLayer[activeSubLayer][key]
    local keyUps = event:getType() == hs.eventtap.event.types.keyUp

    if keyUps then
        if key == hyperKey or key == activeSubLayer then 
            activeSubLayer = ""
            listenForActions:stop()
            return false
        else return true end
    end

    if action then
        if action.app then
            hs.execute("open -a " .. action.app)
        elseif action.url then
            hs.execute("open " .. action.url)
        elseif action.brightness then
            hs.brightness.set(hs.brightness.get() + action.brightness)
        elseif action.volume then
            local new = hs.audiodevice.defaultOutputDevice():volume() + action.volume
            if new < 0 then 
                hs.audiodevice.defaultOutputDevice():setMuted(true)
            else
                hs.audiodevice.defaultOutputDevice():setMuted(false)
            end
            hs.audiodevice.defaultOutputDevice():setVolume(new)
            createBar(new / 100)
            hs.timer.doAfter(1.2, deleteBar)
        elseif action.keys then
            hs.execute("" .. " " .. action.keys)
        elseif action.code then
            hs.execute("code " .. action.code)
        elseif action.reload then
            hs.reload()
        end
    end

    event:stopPropagation()
end)

pressedHyper = function() listenForSubLayers:start(); end
releasedHyper = function() listenForSubLayers:stop(); singlePressHyper(); end

hs.hotkey.bind({}, hyperKey, pressedHyper, releasedHyper)