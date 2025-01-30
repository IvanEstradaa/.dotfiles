local c = require("hs.canvas")
local screen = hs.screen.mainScreen():fullFrame()
local temp = c.new({x = 0, y = 0, h = screen.h, w = screen.w})
local tempMode = false

function createBorder(red, green, blue, alpha)
  temp[1] = {
    type = "rectangle",
    action = "stroke",
    strokeColor = { red = red, green = green, blue = blue, alpha = alpha },
    strokeWidth = 5,
    frame = { x = 0, y = 0, h = screen.h, w = screen.w },
  }
  temp:show()
end

function deleteBorder()
  temp:delete()
end

function toggleBorder(red, green, blue, alpha)
  if tempMode then
      deleteBorder()
      tempMode = false
  else
      createBorder(red, green, blue, alpha)
      tempMode = true
  end
end
