local Component = require "components/index"

local Sway = Component.Component:extend()
Component.add("sway", Sway)

function Sway:new(gameobject, position)
    Component.Component.new(self, gameobject)

    self.position = {gameobject.x, gameobject.y}
    self.destination = {(gameobject.x + love.math.random(-48,48)), (gameobject.y + love.math.random(-27,27))}
    self.jitter = {-position[2] * random(-1,1), position[1] * random(-1,1)}
end

function Sway:update(dt)
	

