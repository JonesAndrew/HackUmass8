local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local baton = require "baton"

local Player = Gameobject.Gameobject:extend()
local Explosion = require "gameobjects/explosion"
local Speedline = require "gameobjects/speedline"

function Player:new(index)
    Gameobject.Gameobject.new(self)

    if index == 1 then
        self.input = baton.new {
          controls = {
            left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
            right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
            up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
            down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
            a = {'key:z', 'button:a'},
          },
          pairs = {
            move = {'left', 'right', 'up', 'down'}
          },
          joystick = love.joystick.getJoysticks()[index],
        }
    else
        self.input = baton.new {
          controls = {
            left = {'axis:leftx-', 'button:dpleft'},
            right = {'axis:leftx+', 'button:dpright'},
            up = {'axis:lefty-', 'button:dpup'},
            down = {'axis:lefty+', 'button:dpdown'},
            a = {'button:a'},
          },
          pairs = {
            move = {'left', 'right', 'up', 'down'}
          },
          joystick = love.joystick.getJoysticks()[index],
        }
    end

    self.shape = self:add_component(Component.get('circle')(self, 8, index + 2))

    self.last_x = 1
    self.last_y = 0
end

function Player:update(dt)
    self.input:update()

    local x, y = self.input:get('move')
    if (x ~= 0 or y ~= 0) then
        self.last_x = x
        self.last_y = y
    end

    self.vel_x = approach(self.vel_x, x * 60, dt * 1000)
    self.vel_y = approach(self.vel_y, y * 60, dt * 1000)

    local left = self.x < 240
    Gameobject.Gameobject.update(self, dt)

    if left then
      self.x = math.min(math.max(self.x, 0 + 8), 240 - 8)
    else
      self.x = math.min(math.max(self.x, 240 + 8), 480 - 8)
    end

    return self.dead
end

return Player
