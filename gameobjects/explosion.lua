local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local baton = require "baton"

local Explosion = Gameobject.Gameobject:extend()

function Explosion:new(maxsize, len)
    Gameobject.Gameobject.new(self)
    self.shape = self:add_component(Component.get('circle')(self, 2))
    self.shape.style = 'fill'

    self.count_down = len or 0.5
    self.color = 4
    self.maxsize = maxsize or 32
    self.count = 0
end

function Explosion:update(dt)
    Gameobject.Gameobject.update(self, dt)
    self.count_down = self.count_down - dt

    if (self.count == 1) then
        love.timer.sleep(0.05)
    end
    self.count = self.count + 1

    self.shape.radius = (self.count_down*-2+1) * (self.maxsize - 2) + 2

    if self.count_down < 0 then
        return true
    end
end

return Explosion
