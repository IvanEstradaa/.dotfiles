local subLayer = {}
local hyperKey = "F20"
local activeSubLayer = ""
local hyperTriggered = false
local size = 2

function singlePressHyper()
    if not hyperTriggered then
        toggleBorder(0, 0, 1, 1, "full")
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
    ["B"] = {app = "'LibreWolf'"},
    ["M"] = {app = "Messages"},
    ["E"] = {app = "FindMy"},
    ["T"] = {app = "WezTerm"},
    ["C"] = {app = "'Visual Studio Code'"},
    ["W"] = {app = "WhatsApp"},
    ["S"] = {app = "Safari"},
    ["F"] = {app = "OnlyOffice"},
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

subLayer["W"] = {
    ["H"] = {window = "left", n = 2},
    ["K"] = {window = "left", n = 4},
    ["L"] = {window = "right", n = 2},
}

subLayer["M"] = {
    ["R"] = {reload = "Reload hammerspoon config"}, 
    ["C"] = {code = "~/.config/hammerspoon"}, 
}

-- subLayer["E"] = {
--     ["Z"] = {mods = {"cmd", "alt"}, key = "V", type = types.keyStroke},
-- }

function mouseLazyCenter()
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
            hs.window.focusedWindow():focusWindowWest(nil, true, false)
        elseif key == "J" then
            hs.window.focusedWindow():focusWindowSouth(nil, true, false)
        elseif key == "K" then
            hs.window.focusedWindow():focusWindowNorth(nil, true, false)
        elseif key == "L" then
            hs.window.focusedWindow():focusWindowEast(nil, true, false)
        end
        mouseLazyCenter()
        hyperTriggered = true
    end

    if key then -- If the key is not nil, then continue the event propagation
        return true
    end
    
    event:stopPropagation()
end)

listenForActions = hs.eventtap.new({hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp}, function(event)
    local key = string.upper(hs.keycodes.map[event:getKeyCode()])  -- Get the key from the key code event and convert to uppercase
    local action = subLayer[activeSubLayer][key]
    local keyUps = event:getType() == hs.eventtap.event.types.keyUp

    -- if activeSubLayer == "" then listenForActions:stop() return false end

    if keyUps then
        if key == hyperKey then 
            activeSubLayer = ""
            listenForActions:stop()
            listenForSubLayers:stop()
        end
        if key == activeSubLayer then
            activeSubLayer = ""
            deleteBar()
            size = 2
            listenForActions:stop()
        end
        return false
    end

    if action then
        if action.app then  
            hs.execute("open -a " .. action.app)
            mouseLazyCenter()
        elseif action.url then
            hs.execute("open " .. action.url)
        elseif action.window then
            -- if not key == past and subLayer[activeSubLayer][past].n < 4 then
            --     hs.alert.show("Not past")
            --     subLayer[activeSubLayer][past].n = 2
            -- end
            -- past = key
            if action.n < 4 then
                action.n = size
            end
            windowManagement(action.window, action.n)
            if size+1 == 4 then
                size = 1
            elseif size < 4 then
                size = size + 1
            end
        elseif action.brightness then
            hs.brightness.set(hs.brightness.get() + action.brightness)
            createBar(hs.brightness.get() / 100)
        elseif action.volume then
            local new = hs.audiodevice.defaultOutputDevice():volume() + action.volume
            if new < 0 then 
                hs.audiodevice.defaultOutputDevice():setMuted(true)
            else
                hs.audiodevice.defaultOutputDevice():setMuted(false)
            end
            hs.audiodevice.defaultOutputDevice():setVolume(new)
            createBar(new / 100)
        elseif action.keys then
            hs.execute("" .. " " .. action.keys)
        elseif action.code then
            hs.execute("${EDITOR:-vi}" .. action.code)
        elseif action.reload then
            hs.reload()
        end
    end

    if key then -- If the key is not nil, then continue the event propagation
        return true 
    end

    event:stopPropagation()
end)

pressedHyper = function() listenForSubLayers:start(); end
releasedHyper = function() listenForSubLayers:stop(); singlePressHyper(); size = 2; deleteBar(); end

hs.hotkey.bind({}, hyperKey, pressedHyper, releasedHyper)