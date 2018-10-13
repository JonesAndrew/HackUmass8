local Component = require "components/index"

local Circle = Component.Component:extend()
Component.add("circle", Circle)

function Circle:new(gameobject, radius, segments)
    Component.Component.new(self, gameobject)

    self.radius = radius
    self.segments = segments
end

function Circle:render()
    love.graphics.circle("line", self.gameobject.x, self.gameobject.y, self.radius, self.segments)
end
