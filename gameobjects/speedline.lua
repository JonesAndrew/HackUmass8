local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local baton = require "baton"

local Speedline = Gameobject.Gameobject:extend()

function Speedline:new(vel, rotation)
    Gameobject.Gameobject.new(self)
    self.shape = self:add_component(Component.get('line')(self, love.math.random(4, 6)))
    self.shape.rotation = rotation
    self.vel_x = vel * math.cos(rotation)
    self.vel_y = vel * math.sin(rotation)

    self.count_down = 0.2
    self.color = 3
end

function Speedline:update(dt)
    Gameobject.Gameobject.update(self, dt)
    self.count_down = self.count_down - dt
    if self.count_down < 0 then
        return true
    end
end

return Speedline
