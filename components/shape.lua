local Component = require "components/index"

local Shape = Component.Component:extend()
Component.add("shape", Shape)

function Shape:new(gameobject, radius)
    Component.Component.new(self, gameobject)

    self.radius = radius
end

function Shape:render()
    love.graphics.rectangle("line", self.gameobject.x-self.radius, self.gameobject.y-self.radius, self.radius*2, self.radius*2)
end
