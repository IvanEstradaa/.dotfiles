local c = require("hs.canvas")

-- Get screen size and create canvas
local screen = hs.screen.mainScreen():fullFrame()
local canvas = c.new({x = 0, y = 0, h = screen.h, w = screen.w})
local border = c.new({x = 0, y = 0, h = screen.h, w = screen.w})
local canvas_element = 1
local labels = { "Q", "W", "E", "R", "U", "I", "O", "P" }
local coords = {}
local lock = false
local gCount = 0

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


local function moveMouse(pos)
    local initial_pos = hs.mouse.absolutePosition()

    local event = hs.eventtap.event
    local xdiff = pos.x - initial_pos.x
    local ydiff = pos.y - initial_pos.y
    local dist = math.sqrt(xdiff * xdiff + ydiff * ydiff)

    -- Reduce the number of steps by increasing the distance per step or reducing total steps
    local steps = math.floor(dist / 10) -- Reduce steps by a factor of 10 for faster dragging

    local xinc = xdiff / steps
    local yinc = ydiff / steps
    local midPoint = {x = initial_pos.x, y = initial_pos.y}

    -- Perform faster dragging
    for i = 1, steps do
        midPoint.x = midPoint.x + xinc
        midPoint.y = midPoint.y + yinc
        hs.mouse.absolutePosition(midPoint)

        -- Optionally, post fewer mouse drag events by skipping iterations if needed
        if i % 2 == 0 then -- Only post events every 2nd iteration (or adjust this)
            event.newMouseEvent(event.types.leftMouseDragged, midPoint):post()
        end
    end

end

-- Function to listen for key presses
keyListenerScroll = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    local keyCode = event:getKeyCode()  -- Get the key code of the key pressed
    local key = string.upper(hs.keycodes.map[keyCode])  -- Get the key from the key code and convert to uppercase
    local arrowKeys = {}
    arrowKeys["H"] = { a = {3, 0}, b = {}, c = "line", d = {20000, 0}, e = "left"}
    arrowKeys["J"] = { a = {0, -3}, b = {}, c = "line", d = {0, -20000}, e = "down"}
    arrowKeys["K"] = { a = {0, 3}, b = {}, c = "line", d = {0, 20000}, e = "up"}
    arrowKeys["L"] = { a = {-3, 0}, b = {}, c = "line", d = {-20000, 0}, e = "right"}
    
    if arrowKeys[key] then
        lock = false
        local modifiers = hs.eventtap.checkKeyboardModifiers()
        canvas:hide()
        if modifiers.cmd then
            hs.eventtap.scrollWheel(arrowKeys[key].d, arrowKeys[key].b, arrowKeys[key].c)
        else
            hs.eventtap.scrollWheel(arrowKeys[key].a, arrowKeys[key].b, arrowKeys[key].c)
        end
    end

    if key == "G" then 
        local modifiers = hs.eventtap.checkKeyboardModifiers()
        canvas:hide()        
        if modifiers.shift then
            hs.eventtap.scrollWheel({0, -20000}, {}, "line")
        else
            gCount = gCount + 1
            if gCount == 2 then
                hs.eventtap.scrollWheel({0, 20000}, {}, "line")
            end
            hs.timer.doAfter(0.2, function()
                gCount = 0
                return true
            end)
        end
    end

    if coords[key] then
        local mousePos = { x = coords[key].x + 5, y = coords[key].y - 90 }
        moveMouse(mousePos)
        --hs.mouse.absolutePosition(mousePos)
        canvas:hide()
    end

    if key == "ESCAPE" or (key == "F19" and lock == false) then
        canvas:hide()
        border:hide()
        keyListenerScroll:stop()
        lock = false
    end

    if key  then
        return true
    end

    event:stopPropagation()
end)

-- Toggle the grid visibility
function startScroll()
    gCount = 0
    lock = true
    stopClick()
    canvas:show()
    border:show()
    keyListenerScroll:start()
end