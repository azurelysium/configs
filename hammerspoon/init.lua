local function osExecute(cmd)
    local fileHandle     = assert(io.popen(cmd, 'r'))
    local commandOutput  = assert(fileHandle:read('*a'))
    local returnTable    = {fileHandle:close()}
    return commandOutput,returnTable[3]
end

hs.hotkey.bind({'ctrl', 'alt'}, '0', function() hs.caffeinate.lockScreen() end)

-- Toggle a window between its normal size, and being maximized
local frameCache = {}
function toggle_window_maximized()
   local win = hs.window.focusedWindow()
   if frameCache[win:id()] then
      win:setFrame(frameCache[win:id()])
      frameCache[win:id()] = nil
   else
      frameCache[win:id()] = win:frame()
      win:maximize()
   end
end

hs.hotkey.bind({'ctrl', 'alt'}, '3', function() toggle_window_maximized() end)

-- SkyRocket
local SkyRocket = hs.loadSpoon("SkyRocket")

sky = SkyRocket:new({
  -- Opacity of resize canvas
  opacity = 0.3,

  -- Which modifiers to hold to move a window?
  moveModifiers = {'cmd'},

  -- Which mouse button to hold to move a window?
  moveMouseButton = 'left',

  -- Which modifiers to hold to resize a window?
  resizeModifiers = {'cmd'},

  -- Which mouse button to hold to resize a window?
  resizeMouseButton = 'right',
})