local Component = require "components/index"

local Circle = Component.Component:extend()
Component.add("circle", Circle)

function Circle:new(gameobject, radius, segments)
    Component.Component.new(self, gameobject)

    self.radius = radius
    self.segments = segments
    self.style = "line"

    if self.segments == 5 then
        self.segments = nil
    end
end

function Circle:render()
    if self.segments then
        if self.segments == 6 then
            love.graphics.circle(self.style, self.gameobject.x, self.gameobject.y, self.radius, 4)
            return
        end

        love.graphics.push()
        love.graphics.translate(self.gameobject.x, self.gameobject.y)
        if self.segments == 4 then
            love.graphics.rotate(math.pi/4)
        elseif self.segments == 3 then
            love.graphics.rotate(math.pi/6)
        elseif self.segments == 5 then
            love.graphics.rotate(math.pi/10+math.pi)
        end
        love.graphics.translate(-self.gameobject.x, -self.gameobject.y)
    end

    love.graphics.circle(self.style, self.gameobject.x, self.gameobject.y, self.radius, self.segments)

    if self.segments then
        love.graphics.pop()
    end
end
