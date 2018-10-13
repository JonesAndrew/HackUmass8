local Component = require "components/index"

local Line = Component.Component:extend()
Component.add("line", Line)

function Line:new(gameobject, length)
    Component.Component.new(self, gameobject)

    self.length = length
    self.rotation = 0
end

function Line:render()
    local offx = math.cos(self.rotation)
    local offy = math.sin(self.rotation)
    local length = self.length
    love.graphics.line(
        self.gameobject.x - offx*length/2, 
        self.gameobject.y - offy*length/2,
        self.gameobject.x + offx*length/2,
        self.gameobject.y + offy*length/2
    )
end
