-- define function to toggle window between minimized and unminimized
-- store window id to /tmp/hs_window_id
--

function toggleMinimized()
  local isMinimized = 1

  local file = io.open("/tmp/hs_minimized", "r")
  if file ~= nil then
    isMinimized = file:read()
    isMinimized = tonumber(isMinimized)
    file:close()
  end

  isMinimized = 1 - isMinimized
  file = io.open("/tmp/hs_minimized", "w")
  file:write(isMinimized)
  file:close()

  return isMinimized
end

hs.hotkey.bind({"ctrl"}, "\\", function()

  -- read window id from /tmp/hs_window_id
  local id = nil
  local file = io.open("/tmp/hs_window_id", "r")
  if file ~= nil then
    id = file:read()
    id = tonumber(id)
    file:close()
  end

  print("id", id)

  -- if window id is not nil, focus window
  local win = nil
  if id ~= nil then
    win = hs.window.get(id)
  end

  print("win", win)

  if win == nil then
    win = hs.window.focusedWindow()
    if win == nil then
      return
    end

    -- store window id to /tmp/hs_window_id
    local file = io.open("/tmp/hs_window_id", "w")
    file:write(win:id())
    file:close()
  end

  local isMinimized = toggleMinimized()
  print("isMinimized", isMinimized)

  local winFocused = hs.window.focusedWindow()
  if isMinimized == 1 then
    local screen = winFocused:screen()
    win:moveToScreen(screen)
    win:unminimize()
    win:centerOnScreen()
    win:focus()
  else
    if winFocused == win then
      hs.eventtap.keyStroke({"cmd"}, "h")
    else
      win:focus()
    end
  end

end)

-- Create an event tap to listen for middle mouse button clicks
local MOUSE_BUTTON_MIDDLE = 2
local MOUSE_BUTTON_PREV = 3
local MOUSE_BUTTON_NEXT = 4

middleButtonTap = hs.eventtap.new({hs.eventtap.event.types.otherMouseDown}, function(event)
    local buttonPressed = event:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber)
    print("buttonPressed", buttonPressed)

    if buttonPressed == MOUSE_BUTTON_MIDDLE then
        -- Toggle Mission Control
        hs.osascript.applescript([[
            tell application "System Events"
                key code 160 -- Mission Control
            end tell
        ]])
        return true -- Prevent the event from propagating
    elseif buttonPressed == MOUSE_BUTTON_PREV then
        return true
    elseif buttonPressed == MOUSE_BUTTON_NEXT then
        return true
    end

    return false
end)

-- Start the event tap
--middleButtonTap:start()

-- WE USE the 3rd-party app Mac Mouse Fix for custom mouse button mapping
