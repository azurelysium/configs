local function osExecute(cmd)
    local fileHandle     = assert(io.popen(cmd, 'r'))
    local commandOutput  = assert(fileHandle:read('*a'))
    local returnTable    = {fileHandle:close()}
    return commandOutput,returnTable[3]
end

hs.hotkey.bind({'ctrl', 'alt'}, '0', function() hs.caffeinate.lockScreen() end)

-- Toggle a window between its normal size, and being maximized
local frameCache = {}
hs.window.animationDuration = 0
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


hs.hotkey.bind({'ctrl', 'alt'}, '4', function() hs.eventtap.keyStroke({"ctrl", "shift"}, "tab") end)
hs.hotkey.bind({'ctrl', 'alt'}, '5', function() toggle_window_maximized() end)
hs.hotkey.bind({'ctrl', 'alt'}, '6', function() hs.eventtap.keyStroke({"ctrl"}, "tab") end)

-- Volume Control
local function sendSystemKey(key)
    hs.eventtap.event.newSystemKeyEvent(key, true):post()
    hs.eventtap.event.newSystemKeyEvent(key, false):post()
end

local volume = {
    up   = function() sendSystemKey("SOUND_UP") end,
    down = function() sendSystemKey("SOUND_DOWN") end,
    mute = function() sendSystemKey("MUTE") end,
}

hs.hotkey.bind({}, "pad5", volume.mute)
hs.hotkey.bind({}, "pad8", volume.up, nil, volume.up)
hs.hotkey.bind({}, "pad2", volume.down, nil, volume.down)

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
