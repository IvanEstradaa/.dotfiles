require("grid")
require("hyperkey")
require("scroll")
require("border")
require("directories")

hs.execute("remap original")

hs.hotkey.bind({}, "F19", toggleGrid, nil, startScroll)

hs.hotkey.bind({"cmd", "alt"}, "V", function()
  hs.application.launchOrFocus("Preview")
  -- local app = hs.appfinder.appFromName("Preview")
  -- app:selectMenuItem({"Archivo", "Nuevo a partir del Portapapeles"})
  hs.eventtap.keyStroke({"cmd"}, "N")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "SPACE", function()
  hs.execute("swp 8")
end)

-- Disable Cmd + H
hs.hotkey.bind({"cmd"}, "H", function()
  -- Do nothing instead of hiding the app
end)

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


-- NOTES:

-- Disable window animations
-- hs.window.animationDuration = 0
-- Disable window shadows
-- hs.window.setShadows(false)
