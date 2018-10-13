local Component = require "components/index"

local Sway = Component.Component:extend()
Component.add("sway", Sway)

function Sway:new(gameobject, position)
    Component.Component.new(self, gameobject)

    self.destination = {(gameobject.x + love.math.random(-48,48)), (gameobject.y + love.math.random(-27,27))}
end

function Sway:checkpoints(vectora, vectorb)
	local epsilon = 3
	if ((math.abs(vectora[1] - vectorb[1]) =< 3) and (math.abs(vectora[1] - vectorb[2]))

function Sway:update(dt)
	if (self.destination[1] = gameobject.x gameobject.y})
	local vector = {gameobject.x - destination[1], gameobject.y - destnation[2]}
	local 



