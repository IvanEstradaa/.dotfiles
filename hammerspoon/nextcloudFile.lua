

function nextcloudFile(action)
    hs.application.launchOrFocus("Finder")

    local screen = hs.screen.mainScreen():fullFrame()
    hs.window.focusedWindow():move(hs.geometry.rect(0, 0, screen.w, screen.h),nil,true,0)

    hs.eventtap.rightClick({x = 1664.43359375, y = 56.79296875})
    hs.eventtap.keyStroke({}, "N")
    hs.eventtap.keyStroke({}, "E")
    hs.eventtap.keyStroke({}, "right")

    if action == "offload" then
        hs.eventtap.keyStroke({}, "L") -- "L" Liberar espacio local | "F" Free up local space
    elseif action == "download" then
        hs.eventtap.keyStroke({}, "H") -- "H" Hacer que esté siempre localmente disponible | "M" Make available offline
    end
    hs.eventtap.keyStroke({}, "return")

    -- kill the Finder app
    hs.application.find("Finder"):kill()
end