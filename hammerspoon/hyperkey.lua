local subLayer = {}
local hyperKey = "F20"
local activeSubLayer = ""
local hyperTriggered = false

function singlePressHyper()
    if not hyperTriggered then
        toggleBorder(0, 0, 1, 1)
        hs.execute("remap")
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
    ["B"] = {app = "Arc"},
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

subLayer["H"] = {
    ["R"] = {reload = "Reload hammerspoon config"}, 
    ["C"] = {code = "~/.config/hammerspoon"}, 
}

-- subLayer["E"] = {
--     ["Z"] = {mods = {"cmd", "alt"}, key = "V", type = types.keyStroke},
-- }


listenForSubLayers = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, function(event)
    local key = string.upper(hs.keycodes.map[event:getKeyCode()])  -- Get the key from the key code event and convert to uppercase
    local keyUp = event:getType() == hs.eventtap.event.types.keyUp

    if keyUp and key == hyperKey then
        listenForActions:stop()
        activeSubLayer = ""
        return false
    end

    if subLayer[key] and activeSubLayer == "" then
        listenForActions:start()
        activeSubLayer = key
        hyperTriggered = true
    end

    event:stopPropagation()
end)

listenForActions = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, function(event)
    local key = string.upper(hs.keycodes.map[event:getKeyCode()])  -- Get the key from the key code event and convert to uppercase
    local action = subLayer[activeSubLayer][key]
    local keyUps = event:getType() == hs.eventtap.event.types.keyUp

    if keyUps then
        if key == hyperKey then
            listenForActions:stop()
            listenForSubLayers:stop()
            activeSubLayer = ""
            return false
        elseif key == activeSubLayer then listenForActions:stop() activeSubLayer = "" 
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
            if new > 0 then 
                hs.audiodevice.defaultOutputDevice():setMuted(false)
            else
                hs.audiodevice.defaultOutputDevice():setMuted(true)
            end
            hs.audiodevice.defaultOutputDevice():setVolume(new)
        elseif action.keys then
            hs.execute("" .. " " .. action.keys)
        elseif action.code then
            hs.execute("code " .. action.code)
            listenForActions:stop()
            listenForSubLayers:stop()
            activeSubLayer = ""
        elseif action.reload then
            hs.reload()
        end
        return
    end

    event:stopPropagation()
end)

pressedHyper = function() listenForSubLayers:start(); end
releasedHyper = function() listenForSubLayers:stop(); singlePressHyper(); end

hs.hotkey.bind({}, hyperKey, pressedHyper, releasedHyper)