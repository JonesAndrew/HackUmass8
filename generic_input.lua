local baton = require "baton"
local inputs = {}

for i=1,4 do
  inputs[i] = baton.new {
    controls = {
      left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
      right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
      up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
      down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
      a = {'key:a', 'button:a'},
      b = {'key:b', 'button:b'},
      x = {'key:x', 'button:x'},
      y = {'key:y', 'button:y'},
    },
    joystick = love.joystick.getJoysticks()[index],
  }
end

function update()
  for i=1,4 do
    inputs[i]:update()
  end
end

function pressed(button)
  for i=1,4 do
    if inputs[i]:released(button) then
      return true
    end
  end

  return false
end

return {update=update, pressed=pressed}