-- Cmd + Alt + H: Open Home folder
hs.hotkey.bind({"cmd", "alt"}, "H", function()
    hs.execute("open ~")    
end)

-- Cmd + Alt + L: Open Downloads folder
hs.hotkey.bind({"cmd", "alt"}, "L", function()
    hs.execute("open ~/Downloads")    
end)

-- Cmd + Alt + P: Open Trash folder
hs.hotkey.bind({"cmd", "alt"}, "P", function()
    hs.execute("open ~/.Trash")    
end)

-- Cmd + Alt + O: Open Nextcloud folder
hs.hotkey.bind({"cmd", "alt"}, "O", function()
    hs.execute("open ~/Nextcloud")    
end)