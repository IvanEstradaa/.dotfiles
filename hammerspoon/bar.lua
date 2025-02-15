local c = require("hs.canvas")
local screen = hs.screen.mainScreen():fullFrame()
local bar = c.new({x = 0, y = 0, h = 2.1, w = screen.w}) -- Only displays at the top of the screen

function createBar(length)
  bar[1] = {
    type = "rectangle",
    action = "fill",
    fillColor = { red = 1, green = 1, blue = 1, alpha = 1 },
    frame = { x = 0, y = 0, h = 2.1, w = screen.w * length },
  }
  bar:show()
end

function deleteBar()
  bar:delete()
end