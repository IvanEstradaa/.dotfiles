-- Recommended: 13x13, Default: 26x26, Maximum: 30x30, Custom: 10x24
local cols = 10
local rows = 24
local col_repetition = 5 -- Number of repetitions for each column
local row_repetition = 3 -- Number of repetitions for each row
local fontSize = 20 -- Default: 20
local labels_offset = { x = -20, y = -10 }
local subLabels_offset = { x = 0, y = 0 }
local background = { red = 0, green = 0, blue = 0, alpha = 0.35 } -- Default: Transparent black (0,0,0,0.35)
local grid_color = { red = 1, green = 1, blue = 1, alpha = 0.20 } -- Default: Transparent white (1,1,1,0.20)
local font_colr = { red = 1, green = 1, blue = 1, alpha = 0.30 } -- Default: Transparent white (1,1,1,0.30)

------------------------------------------------------------------------------------------------------------------------------------------------------

-- {"A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "-"} -- Number of keys: 29
-- {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"} -- 26 (Alphabet)
-- {"Q", "W", "E", "R", "T", "Y" "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "-"} -- 30 (Normal full keyboard)
-- {"A", "S", "D", "F", "G", "H", "J", "K", "L", ";"} -- 10 (Home row)
-- {"A", "S", "D", "F", "G", "H", "J", "K", "L", "ñ"} -- 10 (Home row, Español)
-- {"Q", "W", "E", "R", "U", "I", "O", "P", "A", "S", "D", "F", "J", "K", "L", "ñ", "Z", "X", "C", "V", "M", ",", ".", "-"} -- 24 (No central keyboard part, Español)
-- {"Q", "W", "E", "R", "U", "I", "O", "P", "A", "S", "D", "F", "J", "K", "L", ";", "Z", "X", "C", "V", "M", ",", ".", "-"} -- 24 (No central keyboard part)
-- {"Q", "W", "E", "R", "T", "A", "S", "D", "F", "G", "Z", "X", "C", "V", "B"} -- 15 (Left keyboard part, Español)
-- {"Y", "U", "I", "O", "P", "H", "J", "K", "L", "ñ", "N", "M", ",", ".", "-"} -- 15 (Right keyboard part, Español)
-- {"Q", "A", "Z", "W", "S", "X", "E", "D", "C", "R", "F", "V", "T", "G", "B"} -- 15 (Left keyboard part, Español) Sorted by rows
-- {"Y", "H", "N", "U", "J", "M", "I", "K", ",", "O", "L", ".", "P", "ñ", "-"} -- 15 (Right keyboard part, Español) Sorted by rows
local col_chars = {"A", "S", "D", "F", "G", "H", "J", "K", "L", "ñ"}
local row_chars = {"Q", "W", "E", "R", "U", "I", "O", "P", "A", "S", "D", "F", "J", "K", "L", "ñ", "Z", "X", "C", "V", "M", ",", ".", "-"}
local subGrid_chars = {"Q", "W", "E", "R", "U", "I", "O", "P", "A", "S", "D", "F", "J", "K", "L", "ñ", "Z", "X", "C", "V", "M", ",", ".", "-"}
local labels = {}
local subLabels = {}

-- local screen, grid = getScreen()
-- local cell = cellDimensions()

-- function getScreen()
    local screen = hs.screen.mainScreen():fullFrame()
    local grid = hs.canvas.new({x = 0, y = 0, h = screen.h, w = screen.w})
    -- return screen, grid
-- end

-- function cellDimensions()
    local cell = {}
    cell.w = screen.w / cols
    cell.h = screen.h / rows
    -- return cell
-- end

local function drawGrid()
    local i_element = 1
    -- Draw background color
    grid[i_element] = {
        type = "rectangle",
        fillColor = background,
    } 
    i_element = i_element + 1

    -- Draw horizontal lines
    for i = 0, rows do
        grid[i_element] = { -- Horizontal line
            type = "segments",
            action = "stroke",
            strokeColor = grid_color,
            strokeWidth = 1,
            coordinates = { { x = 0, y = i * cell.h }, { x = screen.w, y = i * cell.h } },
        }
        i_element = i_element + 1
    end

    -- Draw vertical lines
    for i = 0, cols do
        grid[i_element] = { -- Vertical line
            type = "segments",
            action = "stroke",
            strokeColor = grid_color,
            strokeWidth = 1,
            coordinates = { { x = i * cell.w, y = 0 }, { x = i * cell.w, y = screen.h } },
        }
        i_element = i_element + 1
    end

    -- Use cell center to draw text on each cell (like "A A", "B A", etc.)
    local i_count = 1
    local j_count = 1
    for i = 1, cols do
        j_count = 0
        for j = 1, rows do
            grid[i_element] = {
                type = "text",
                text = col_chars[i] .. " " .. row_chars[j],
                textSize = fontSize,
                textColor = font_colr,
                textAlignment = "center",
                frame = { x = ((i-1)*cell.w) + (cell.w/2) + labels_offset.x, y = ((j-1)*cell.h) + (cell.h/2) + labels_offset.y, h = cell.w, w = cell.h},            
            }
            -- Store coordinates for each cell
            labels[col_chars[i] .. row_chars[j]] = { x = ((i-1)*cell.w) + (cell.w/2), y = ((j-1)*cell.h) + (cell.h/2), initialx = (i-1) * cell.w, initialy = (j-1) * cell.h, ID = i_element } -- Save the center of each cell, the initial x and y coordinates and the ID of the text element
            i_element = i_element + 1

            if (j % (row_repetition+1)) == 0 then
                j_count = j_count + 1
            end

            if (j == rows) then
                i_count = 1
                if (i % (col_repetition)) == 0 then
                    i_count = i_count + row_repetition
                end
            end
        end
        if (i == col_repetition) then
            i_count = 1 + row_repetition
        end
        if (i % (row_repetition)) == 0 then
            i_count = i_count + 1
        end
    end

    grid:show()
end

local function drawSubGrid(labels)
    grid:hide()
    subGrid = hs.canvas.new({x = 0, y = 0, h = screen.h, w = screen.w})
    --subGrid = hs.canvas.new({x = labels.initialx, y = labels.initialy, h = cell.h, w = cell.w})
    local subGrid_element = 1
    subGrid[subGrid_element] = {
        type = "rectangle",
        fillColor = background,
        frame = { x = labels.initialx, y = labels.initialy, h = cell.h, w = cell.w},
    }
    subGrid_element = subGrid_element + 1

    -- Draw horizontal lines
    for i = 0, 3 do
        subGrid[subGrid_element] = { -- Horizontal line
            type = "segments",
            action = "stroke",
            strokeColor = grid_color,
            strokeWidth = 1,
            coordinates = { { x = labels.initialx, y = labels.initialy + i*(cell.h/3) }, { x = labels.initialx + cell.w, y = labels.initialy + i*(cell.h/3) } },
        }
        subGrid_element = subGrid_element + 1
    end

    -- Draw vertical lines
    for i = 0, 8 do
        subGrid[subGrid_element] = { -- Vertical line
            type = "segments",
            action = "stroke",
            strokeColor = grid_color,
            strokeWidth = 1,
            coordinates = { { x = labels.initialx + i*(cell.w/8), y = labels.initialy }, { x = labels.initialx + i*(cell.w/8), y = labels.initialy + cell.h } },
        }
        subGrid_element = subGrid_element + 1
    end

    local subGrid_char = 1
    
    for i = 0, 3-1 do
        for j = 0, 8-1 do
            subGrid[subGrid_element] = {
                type = "text",
                text = subGrid_chars[subGrid_char],
                textSize = 10,
                textColor = font_colr,
                textAlignment = "center",
                frame = { x = labels.initialx + (j*cell.w/8) + subLabels_offset.x, y = labels.initialy + (i*cell.h/3) + subLabels_offset.y, h = cell.h/3, w = cell.w/8 },
            }
            subLabels[subGrid_chars[subGrid_char]] = { x = labels.initialx + (j*cell.w/8) + cell.w/(8*2), y = labels.initialy + (i*cell.h/3) + cell.h/(3*2), ID = subGrid_element }
            subGrid_char = subGrid_char + 1
            subGrid_element = subGrid_element + 1
        end
    end
    subGrid:show()
end

local function drawBorder(labels, height)
    border = hs.canvas.new({x = 0, y = 0, h = screen.h, w = screen.w})
    border[1] = {
        type = "rectangle",
        action = "stroke",
        strokeColor = { red = 1, green = 1, blue = 1, alpha = 1 },
        strokeWidth = 1,
        frame = { x = labels.initialx, y = labels.initialy, h = height, w = cell.w },
    }
    border:show()
end

local function mouseMovement(pointA, pointB)

    local event = hs.eventtap.event
    local xdiff = pointB.x - pointA.x
    local ydiff = pointB.y - pointA.y
    local dist = math.sqrt(xdiff * xdiff + ydiff * ydiff)

    -- Reduce the number of steps by increasing the distance per step or reducing total steps
    local steps = math.floor(dist / 50) -- Reduce steps by a factor of 10 for faster dragging

    local xinc = xdiff / steps
    local yinc = ydiff / steps
    local midPoint = {x = pointA.x, y = pointA.y}

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
    event.newMouseEvent(event.types.leftMouseDragged, pointB):post()

end

local function mouseEvent(type, clicks, initial_pos, final_pos)
    local pos = hs.mouse.absolutePosition()

    if type == "left-click" then
        hs.eventtap.event.newMouseEvent(
            hs.eventtap.event.types.leftMouseDown, pos, {}) -- <2>
            :setProperty(hs.eventtap.event.properties.mouseEventClickState, clicks) 
            :post() -- <3>   
        hs.eventtap.event.newMouseEvent( -- <4>
            hs.eventtap.event.types.leftMouseUp, pos, {}):post()
    elseif type == "right-click" then
        hs.eventtap.event.newMouseEvent(
            hs.eventtap.event.types.rightMouseDown, pos, {}) -- <2>
            :setProperty(hs.eventtap.event.properties.mouseEventClickState, clicks) 
            :post() -- <3>   
        hs.eventtap.event.newMouseEvent( -- <4>
            hs.eventtap.event.types.rightMouseUp, pos, {}):post()
    elseif type == "middle-click" then
        hs.eventtap.middleClick(pos)
    elseif type == "click-drag" then
        
        local event = hs.eventtap.event

        -- Post the first mouse down event
        hs.mouse.absolutePosition(initial_pos)
        event.newMouseEvent(event.types.leftMouseDown, initial_pos):post()

        mouseMovement(initial_pos, final_pos)

        -- Post the final mouse up event
        hs.mouse.absolutePosition(final_pos)
        hs.timer.usleep(50000) -- wait 0.05 seconds
        hs.eventtap.event.newMouseEvent(event.types.leftMouseDragged, final_pos):post()
        hs.timer.usleep(250000) -- wait 0.25 seconds
        event.newMouseEvent(event.types.leftMouseUp, final_pos):post()
    end
    
end


local function labelsEvent(action)
    local keys = {}
    local clickCount = 0
    local initial_pos = hs.mouse.absolutePosition()
    local move = true
    local final_pos = hs.mouse.absolutePosition()
    
    listenforLabels = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
        local key = string.upper(hs.keycodes.map[event:getKeyCode()])
        local modifier = hs.eventtap.checkKeyboardModifiers()

        if key == "ESCAPE" or key == "F19" then
            grid:hide()
            listenforLabels:stop()
            if border then
                border:delete()
            end
            if subGrid then
                subGrid:delete()
            end
            return true
        elseif key == "DELETE" then
            if #keys == 0 then
                grid:hide()
                listenforLabels:stop()
                return true 
            end
            if subGrid then
                subGrid:delete()
            end
            if border then
                border:delete()
            end
            table.remove(keys) 
            if #keys == 1 then
                grid:show()
                if labels[keys[1]..row_chars[1]].x then
                    drawBorder(labels[keys[1]..row_chars[1]], screen.h)
                end
            end
        elseif key == "SPACE" then
            if grid then
                grid:hide()
            end

            if subGrid then
                subGrid:delete()
            end

            if border then
                border:delete()
            end

            clickCount = clickCount + 1
            if modifier.shift then 
                mouseEvent("right-click", clickCount, nil, nil)
                clickCount = 0
            elseif modifier.cmd then 
                mouseEvent("middle-click", nil, nil, nil) 
                clickCount = 0
            elseif modifier.alt then 
                if clickCount == 1 then
                    initial_pos = hs.mouse.absolutePosition()
                    keys = {}
                    move = false
                    grid:show()
                else
                    listenforLabels:stop()
                    mouseEvent("click-drag", nil, initial_pos, final_pos)
                    return true
                end
            else
                mouseEvent("left-click", clickCount, nil, nil)
                hs.timer.doAfter(0.3, function()
                    listenforLabels:stop()
                    return true
                end)
            end
            hs.timer.doAfter(0.015, function()
                if clickCount == 0 then
                    listenforLabels:stop() 
                    return true
                end
            end)
        else

            -- Check if the key is in subGrid_chars
            if subLabels[key] and #keys == 2 then
                clickCount = clickCount + 1
                local x = subLabels[key].x
                local y = subLabels[key].y

                if border then
                    border:delete()
                end

                if move then
                    mouseMovement(hs.mouse.absolutePosition(), {x = x, y = y})
                    --hs.mouse.absolutePosition({x = x, y = y})
                else 
                    final_pos = {x = x, y = y}
                end

                subGrid:delete()
                
                if modifier.shift then 
                    mouseEvent("right-click", clickCount, nil, nil)
                    clickCount = 0
                elseif modifier.cmd then 
                    mouseEvent("middle-click", nil, nil, nil) 
                    clickCount = 0
                elseif modifier.alt then
                    if clickCount == 1 then
                        initial_pos = hs.mouse.absolutePosition()
                        keys = {}
                        move = false
                        grid:show()
                    else
                        listenforLabels:stop()
                        mouseEvent("click-drag", nil, initial_pos, final_pos)
                        return true
                    end
                else
                    mouseEvent("left-click", clickCount, nil, nil)
                    hs.timer.doAfter(0.3, function()
                        listenforLabels:stop()
                        return true
                    end)
                end
                hs.timer.doAfter(0.015, function()
                    if clickCount == 0 then
                        listenforLabels:stop() 
                        return true
                    end
                end)
                return true
            end
            
            if #keys < 2 then
                table.insert(keys, key)
            end
            if #keys == 1 and labels[keys[1]..row_chars[1]].x then
                drawBorder(labels[keys[1]..row_chars[1]], screen.h)
            end
            if #keys == 2 and labels[keys[1]..keys[2]].x then
                if border then
                    border:delete()
                end
                local x = labels[keys[1]..keys[2]].x
                local y = labels[keys[1]..keys[2]].y
                if move then
                    mouseMovement(hs.mouse.absolutePosition(), {x = x, y = y})
                    --hs.mouse.absolutePosition({x = x, y = y})
                else 
                    final_pos = {x = x, y = y}
                end
                if subGrid then 
                    subGrid:delete()
                end
                drawSubGrid(labels[keys[1]..keys[2]])
                drawBorder(labels[keys[1]..keys[2]], cell.h)
            end
        end

        -- Modify the keys handler to be able to view the current state of the keys list, and depending on hte amount of clicks, show hide or delete visual elements

        if key then
            return true
        end

        event:stopPropagation()
    end)

    if action then
        listenforLabels:start()
    elseif not action then
        listenforLabels:stop()
    end
end

function startClick()
    drawGrid()
    labelsEvent(true)
end

function stopClick()
    grid:hide()
    labelsEvent(false)
end