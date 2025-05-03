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
  local focusedApp = hs.application.frontmostApplication()
  if focusedApp:name() == "Raycast" then
    focusedApp:hide()
    return
  end
  local finder = hs.application.find("Finder")
  if finder then
    finder:kill()
  end
  hs.application.launchOrFocus("Raycast")
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

-- Start apps and close finder, run only once
local uptime_s = hs.execute("uptime | grep -o 'secs' ")
local uptime_m = hs.execute("uptime | grep -o 'min' ")
local uptime_m_amount = hs.execute("uptime | awk '{for (i=1; i<=NF; i++) {if ($i ~ /min/) {print $(i-1);exit;}}}'")
if string.find(uptime_s, "secs") or (string.find(uptime_m, "min") and tonumber(uptime_m_amount) < 5) then 
  hs.application.launchOrFocus("Raycast")
  hs.application.launchOrFocus("WezTerm")

  hs.timer.doUntil(function()
    hs.application.find("Raycast"):hide()
    hs.application.find("Finder"):kill()
  end, function()
    hs.application.find("WezTerm")
  end,
  1)
end

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
  createBorder(1, 0, 0, 1, "dynamic")
  hs.timer.doAfter(0.25, function() quitModal:exit(); deleteBorder() end)
end

local function doQuit()
  deleteBorder()
  hs.application.frontmostApplication():kill()
  quitModal:exit()
end

quitModal:bind("cmd", "Q", doQuit)
--

-- Reload config alert
hs.alert.show("Config loaded")