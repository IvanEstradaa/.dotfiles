local screen = hs.screen.mainScreen():fullFrame()
local orientation = {}
orientation["left"]= {x = 0, y = 0}
orientation["right"]= {x = screen.w, y = 0}

function windowManagement(type, n)

    hs.window.focusedWindow():move(hs.geometry.rect(orientation[type].x, orientation[type].y, screen.w * (n / 4), screen.h),nil,true,0) -- If usin percentages instead of clicks
    -- hs.window.focusedWindow():move(hs.geometry.rect(orientation[type].x, orientation[type].y, screen.w * (size/100), screen.h),nil,true,0) -- If usin percentages instead of clicks

end