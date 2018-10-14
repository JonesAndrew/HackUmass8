local Component = require "components/index"

local Sway = Component.Component:extend()
Component.add("sway", Sway)

function Sway:new(gameobject, w, rx, ry)
    Component.Component.new(self, gameobject)

    self.radx = 12 * rx
    self.rady = 9 * ry
    self.destination = {math.abs((gameobject.x + love.math.random(-self.radx,self.radx))) % 480, 
    math.abs(gameobject.y + love.math.random(-self.rady,self.rady)) % 270}
    self.timer = 0
    self.weight = w
end

function Sway:checkpoints(vectora, vectorb)
	return ((math.abs(vectora[1] - vectorb[1]) <= 3) and (math.abs(vectora[2] - vectorb[2]) <= 3))
end

function Sway:update(dt)
	if (self:checkpoints({self.gameobject.x, self.gameobject.y}, self.destination) or (self.timer >= 1.5)) then
		local x = self.gameobject.x + love.math.random(-self.radx,self.radx)
		local y = self.gameobject.y + love.math.random(-self.rady,self.rady)
		x = math.abs(x) % 480
		y = math.abs(y) % 270
		self.destination = {x, y}
		self.timer = 0
    end

    self.timer = self.timer + dt

	local vector = {self.destination[1] - self.gameobject.x, self.destination[2] - self.gameobject.y}
	local value = (vector[1]^2 + vector[2]^2)^0.5
	self.gameobject.vel_x = self.gameobject.vel_x + (self.weight * 100) * vector[1]/value * dt --inverted vector
	self.gameobject.vel_y = self.gameobject.vel_y + (self.weight * 100) * vector[2]/value * dt
	return
end



