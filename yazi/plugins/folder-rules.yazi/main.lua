local function setup()
  ps.sub("cd", function()
    local cwd = cx.active.current.cwd
    if cwd:ends_with(".Trash") then
      ya.mgr_emit("sort", { "mtime", reverse = true, dir_first = false })
    elseif cwd:ends_with("Downloads") then
      ya.mgr_emit("sort", { "mtime", reverse = true, dir_first = false })
    else
      ya.mgr_emit("sort", { "alphabetical", reverse = false, dir_first = true })
    end
  end)
end

return { setup = setup} 
