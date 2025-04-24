
myModifierMode = hs.hotkey.modal.new()

function binder(from,to,mods)
	local function f ()
	    myModifierMode.triggered = true
	    hs.eventtap.keyStroke(mods, to, 1000) 
  	end
	myModifierMode:bind({}, from, f,nil,f )
end
	
myModifier = hs.hotkey.bind({}, "a",
  function()
    myModifierMode:enter()
    myModifierMode.triggered = false
  end,
  function()
    myModifierMode:exit()
    if not myModifierMode.triggered then
      myModifier:disable()
      hs.eventtap.keyStroke({}, "a")
      myModifier:enable()
    end 
  end
)
 
binder('b','c')																											
binder('e','t')