require("hyperkey")
require("scroll")
require("border")
require("bar")
require("windows")
require("click")
require("nextcloudFile")

hs.execute("/usr/local/bin/remap original")

-- hs.application.launchOrFocus("Finder")
-- hs.application.find("Finder"):kill()

-- function applicationWatcher(appName, eventType, appObject)
--   if (eventType == hs.application.watcher.launched) then
--     if (appName == "Finder") then
--       appObject:kill()
--     end
--   end
-- end
-- 
-- appWatcher = hs.application.watcher.new(applicationWatcher)
-- appWatcher:start()

--local mousePos = hs.mouse.getRelativePosition(frame)
--hs.console.printStyledtext("Mouse position: " .. mousePos.x .. ", " .. mousePos.y)

hs.ipc.cliInstall() -- Install the Hammerspoon CLI tool

hs.hotkey.bind({"cmd"}, "Space", function()
  hs.application.launchOrFocus("Raycast")
  local finder = hs.application.find("Finder")
  if finder then
    finder:kill()
  end
end)

hs.hotkey.bind({}, "F19", startClick, nil, startScroll)

hs.hotkey.bind({"cmd", "alt"}, "V", function()
  hs.application.launchOrFocus("Preview")
  hs.timer.doAfter(0.01, function()
    hs.eventtap.keyStroke({"cmd"}, "N")
  end)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "SPACE", function()
  hs.execute("/usr/local/bin/ourls -y $(ls -t ~/Downloads | head -n 1 | xargs -I {} echo ~/Downloads/{})") -- Get the last downloaded file and pass it as an argument to ourls
end)

-- Disable Cmd + H
-- hs.hotkey.bind({"cmd"}, "H", function()
--   -- Do nothing instead of hiding the app
-- end)

-- Disable Cmd + M
hs.hotkey.bind({"cmd"}, "M", function()
  -- Do nothing instead of minimizing the app
end)

-- Press Cmd+Q twice to quit
local quitModal = hs.hotkey.modal.new("cmd", "Q")

function quitModal:entered()
  hs.timer.doAfter(1, function() quitModal:exit() end)
end

local function doQuit()
  hs.application.frontmostApplication():kill()
end

quitModal:bind("cmd", "Q", doQuit)
--

-- Reload config alert
hs.alert.show("Config loaded")