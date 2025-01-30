c = require("hs.canvas")

-- Global variables
state = false
gridsize = 26  -- 13x13 grid also can be 26x26 due to the alphabet
font_size = 20 -- Default font size: 20
grid_element = 1
chars = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
sub_chars = {"Q", "W", "E", "R", "U", "I", "O", "P", "A", "S", "D", "F", "J", "K", "L", ";", "Z", "X", "C", "V", "M", ",", ".", "-"}
grid_cells = {}
subgrid_cells = {}
background_color = { red = 0, green = 0, blue = 0, alpha = 0.35 }
line_color = { red = 1, green = 1, blue = 1, alpha = 0.20 } 
font_color = { red = 1, green = 1, blue = 1, alpha = 0.30 }
submode = false

-- Get screen size
screen = hs.screen.mainScreen():fullFrame()

-- Create canvas
grid = c.new({x = 0, y = 0, h = screen.h, w = screen.w})

-- Set background color (transparent black)
grid[grid_element] = {
    type = "rectangle",
    fillColor = background_color,
}
grid_element = grid_element + 1

-- Draw grid lines
for i = 1, gridsize do
  grid[grid_element] = {
    type = "segments",
    action = "stroke",
    strokeColor = line_color,
    strokeWidth = 1,
    coordinates = { { x = 0, y = (i / gridsize) * screen.h }, { x = screen.w, y = (i / gridsize) * screen.h } },
  }
  grid_element = grid_element + 1
  grid[grid_element] = {
    type = "segments",
    action = "stroke",
    strokeColor = line_color,
    strokeWidth = 1,
    coordinates = { { x = (i / gridsize) * screen.w, y = 0 }, { x = (i / gridsize) * screen.w, y = screen.h } },
  }
  grid_element = grid_element + 1
end

-- Display cell pairs (like "A A", "B A", etc.)
for i = 1, (gridsize*2), 2 do
  for j = 1, (gridsize*2)-1, 2 do
    grid[grid_element] = {
      type = "text",
      text = chars[(i+1)/2] .. " " .. chars[(j+1)/2],
      textSize = font_size,
      textColor = font_color,
      textAlignment = "center",
      frame = { x = (i / (gridsize*2)) * screen.w - 40 , y = (j / (gridsize*2)) * screen.h - 13, h = 40, w = 80 },
    }
    grid_element = grid_element + 1

    -- Store coordinates for each cell
    grid_cells[chars[(i+1)/2] .. chars[(j+1)/2]] = { x = (i / (gridsize*2)) * screen.w, y = (j / (gridsize*2)) * screen.h, ID = grid_element }
    -- hs.alert.show("Cell: " .. chars[(i+1)/2] .. chars[(j+1)/2] .. " at " .. grid_cells[chars[(i+1)/2] .. chars[(j+1)/2]].x .. ", " .. grid_cells[chars[(i+1)/2] .. chars[(j+1)/2]].y)
  end
end

-- Function to draw a subgrid inside a cell with 8x3 cells
function drawSubGrid(cell)
  local col = 2
  local row = 7
  local subgrid_element = 1
  subgrid = c.new({x = grid_cells[cell].x - 27, y = grid_cells[cell].y - 16, h =  screen.h/gridsize - 2, w = screen.w/gridsize - 2})

  -- Set background color (transparent black)
  subgrid[subgrid_element] = {
      type = "rectangle",
      fillColor = background_color,
  }
  subgrid_element = subgrid_element + 1

  -- Draw grid lines, first horizontal, then vertical
  for i = 1, col do
    subgrid[subgrid_element] = {
      type = "segments",
      action = "stroke",
      strokeColor = line_color,
      strokeWidth = 1,
      coordinates = { { x = 0, y = (i / col) * 22 }, { x = 55, y = (i / col) * 22 } },
    }
    subgrid_element = subgrid_element + 1
  end

  for i = 1, row do
    subgrid[subgrid_element] = {
      type = "segments",
      action = "stroke",
      strokeColor = line_color,
      strokeWidth = 1,
      coordinates = { { x = (i / row) * 48, y = 0 }, { x = (i / row) * 48, y = 35 } },
    }
    subgrid_element = subgrid_element + 1
  end

  -- Display each cell in the subgrid with the corresponding character from sub_chars array, like this:
  -- "Q", "W", "E", "R", "U", "I", "O", "P",
  -- "A", "S", "D", "F", "J", "K", "L", ";",
  -- "Z", "X", "C", "V", "M", ",", ".", "/"
  local sub_char_index = 1
  for i = 1, col+1 do
    for j = 1, row+1 do
      subgrid[subgrid_element] = {
        type = "text",
        text = sub_chars[sub_char_index],
        textSize = 7,
        textColor = font_color,
        textAlignment = "center",
        frame = { x = (j / row) * 48 - 28 , y = (i / col) * 22 - 10, h = 50, w = 50 },
      }
      subgrid_cells[sub_chars[sub_char_index]] = { x = (j / row), y = (i / col) * 22, ID = subgrid_element }
      subgrid_element = subgrid_element + 1
      sub_char_index = sub_char_index + 1
    end
  end

  subgrid:show()
end

-- Function to hide the subgrid
function hideSubGrid()
  subgrid:hide()
  subgrid_cells = {} 
end

-- Toggle the grid visibility
function toggleGrid()
  if state then
    grid:hide()
    subgrid:hide()
    submode = false
    state = false
    stopListeningForKeys()  -- Stop listening when grid is hidden
  else
    grid:show()
    state = true
    startListeningForKeys()  -- Start listening when grid is visible
  end
end

-- Start listening for key presses
function startListeningForKeys()
  local keys = {}  -- Reset keys on each listening start

  -- Create the eventtap to intercept keyDown events
  keyListener = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    local key = event:getCharacters(true)  -- Get the character of the key pressed
    local keyCode = event:getKeyCode()  -- Get the key code of the key pressed


    -- If Escape is pressed, toggle the grid and stop listening for keys (if grid is visible), or if f19 is pressed, toggle the grid
    if keyCode == 53 or keyCode == 80 then
      if submode then
        submode = false
        hideSubGrid()
      else
        toggleGrid()
        event:stopPropagation()
        return
      end
    end

    -- If space is pressed, simulate a click based on modifier keys (Shift for right-click, Cmd for middle-click) or if return is pressed
    if keyCode == 49 or keyCode == 36 then
      local modifiers = hs.eventtap.checkKeyboardModifiers()
      if modifiers.shift then
        hs.eventtap.rightClick(hs.mouse.getAbsolutePosition())
      elseif modifiers.cmd then
        hs.eventtap.middleClick(hs.mouse.getAbsolutePosition())
      else
        hs.eventtap.leftClick(hs.mouse.getAbsolutePosition())
      end

      -- wait until the click is done before resetting the keys
      hs.timer.doAfter(0.01, function()
        keys = {}  -- Reset after clicking
        toggleGrid()  -- Hide the grid after clicking
      end)
    end

    if not submode then
      -- If the key pressed is a letter, add it to the keys table
      if key:match("%a") then
        if #keys <= 1 then
          -- make key uppercase
          key = string.upper(key)
          -- hs.alert.show("Key pressed: " .. key)  -- Show the key that was pressed
          table.insert(keys, key)
          -- hs.alert.show("Keys: " .. table.concat(keys, " "))
        end
        
        -- When two keys are pressed (e.g., "A B"), move the mouse to the corresponding position
        if #keys == 2 then
          -- hs.alert.show("Moving mouse to: " .. keys[1] .. keys[2])
          local mousePos = { x = grid_cells[keys[1] .. keys[2]].x, y = grid_cells[keys[1] .. keys[2]].y }
          hs.mouse.setAbsolutePosition(mousePos)
  
          -- If the second key is pressed, show the subgrid
          drawSubGrid(keys[1] .. keys[2])
          submode = true
  
          -- hs.alert.show("Mouse moved to: " .. keys[1] .. keys[2])
          keys = {}  -- Reset after moving mouse
        end
      end
      else
        if #keys == 0 then
          -- make key uppercase
          key = string.upper(key)
          -- hs.alert.show("Key pressed: " .. key)  -- Show the key that was pressed
          table.insert(keys, key)
          -- hs.alert.show("Keys: " .. table.concat(keys, " "))
        end
        
        -- When two keys are pressed (e.g., "A B"), move the mouse to the corresponding position
        if #keys == 1 then
          -- hs.alert.show("Moving mouse to: " .. keys[1] .. keys[2])
          -- Get current mouse position
          local actualMousePos = hs.mouse.getAbsolutePosition()
          local mousePos = { x = subgrid_cells[keys[1]].x * actualMousePos.x, y = subgrid_cells[keys[1]].y * actualMousePos.y}
          hs.mouse.setAbsolutePosition(mousePos)
          
          -- hs.alert.show("Mouse moved to: " .. keys[1] .. keys[2])
          keys = {}  -- Reset after moving mouse
        end
    
    end

    event:stopPropagation()  -- This stops the key event from being passed to the focused app
  end)

  keyListener:start()  -- Start the listener when the grid is shown
end

-- Stop listening for key events when the grid is hidden
function stopListeningForKeys()
  keyListener:stop()
end


function stopGrid()
  grid:hide()
  subgrid:hide()
  submode = false
  state = false
  stopListeningForKeys()  -- Stop listening when grid is hidden  
end


function test()
  hs.alert.show("Test")
end