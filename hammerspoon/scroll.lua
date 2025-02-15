local c = require("hs.canvas")

-- Get screen size and create canvas
local screen = hs.screen.mainScreen():fullFrame()
local canvas = c.new({x = 0, y = 0, h = screen.h, w = screen.w})
local border = c.new({x = 0, y = 0, h = screen.h, w = screen.w})
local canvas_element = 1
local labels = { "Q", "W", "E", "R", "U", "I", "O", "P" }
local coords = {}
local lock = false

-- Draw 7 columns
for i = 1, 7 do
    canvas[canvas_element] = {
        type = "segments",
        action = "stroke",
        strokeColor = { red = 1, green = 1, blue = 1, alpha = 0.50 },
        strokeWidth = 1,
        coordinates = { { x = (i / 8) * screen.w, y = 0 }, { x = (i / 8) * screen.w, y = screen.h } },
    }
    canvas_element = canvas_element + 1
end

-- Draw labels for each column (Q, W, E, R, U, I, O, P)
local label_index = 1
for i = 1, 7*2+2, 2 do
    canvas[canvas_element] = {
        type = "text",
        text = labels[label_index],
        textSize = 20,
        textColor = { red = 1, green = 1, blue = 1, alpha = 1 },
        textAlignment = "center",
        frame = { x = ((i / 8) * screen.w - 30)/2, y = screen.h/2-100, h = 20, w = 40 },
    }
    coords[labels[label_index]] = { x = ((i / 8) * screen.w)/2, y = screen.h/2}
    canvas_element = canvas_element + 1
    label_index = label_index + 1
end

-- Draw a border around the screen
border[1] = {
    type = "rectangle",
    action = "stroke",
    strokeColor = { red = 0, green = 1, blue = 0, alpha = 1 },
    strokeWidth = 5,
    frame = { x = 0, y = 0, h = screen.h, w = screen.w },
}

-- Function to listen for key presses
keyListenerScroll = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    local keyCode = event:getKeyCode()  -- Get the key code of the key pressed
    local key = string.upper(hs.keycodes.map[keyCode])  -- Get the key from the key code and convert to uppercase
    local arrowKeys = {}
    arrowKeys["H"] = { a = {3, 0}, b = {}, c = "line", d = {1000, 0}, e = "left"}
    arrowKeys["J"] = { a = {0, -3}, b = {}, c = "line", d = {0, -1000}, e = "down"}
    arrowKeys["K"] = { a = {0, 3}, b = {}, c = "line", d = {0, 1000}, e = "up"}
    arrowKeys["L"] = { a = {-3, 0}, b = {}, c = "line", d = {-1000, 0}, e = "right"}
    
    if arrowKeys[key] then
        lock = false
        local modifiers = hs.eventtap.checkKeyboardModifiers()
        canvas:hide()
        if modifiers.cmd then
            hs.eventtap.scrollWheel(arrowKeys[key].d, arrowKeys[key].b, arrowKeys[key].c)
            -- hs.eventtap.keyStroke({"cmd"}, arrowKeys[key].e)
        else
            hs.eventtap.scrollWheel(arrowKeys[key].a, arrowKeys[key].b, arrowKeys[key].c)
        end
    end

    if coords[key] then
        local mousePos = { x = coords[key].x + 5, y = coords[key].y - 90 }
        hs.mouse.setAbsolutePosition(mousePos)
        canvas:hide()
    end

    if key == "ESCAPE" or (key == "F19" and lock == false) then
        canvas:hide()
        border:hide()
        keyListenerScroll:stop()
        lock = false
    end

    -- Only stop propagation for non-command key events (so cmd + arrow keys still work)
    -- if not (key == "DOWN" or key == "UP" or key == "LEFT" or key == "RIGHT") then
    --     event:stopPropagation()  -- Stop propagation for non-command key presses
    -- end

    event:stopPropagation()
end)

-- Toggle the grid visibility
function startScroll()
    lock = true
    stopGrid()
    canvas:show()
    border:show()
    keyListenerScroll:start()
end