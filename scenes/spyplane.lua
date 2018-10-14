local Scene = require "scenes/scene"
local pilot = require "gameobjects/plane/pilot"
local Gameobject = require "gameobjects/index"
local Compoonent = require "components/index"
local explosion = require "gameobjects/explosion"
local Spyplane = Scene:extend()

function Spyplane:new()
	Scene.new(self)
	self.players = {}
	self.bullets = {}

	local p1 = pilot(1)
	self:add_gameobject(p1)
	p1.x = 100
	p1.y = 100
	table.insert(self.players,p1)

	--Reassigning "go" to new pilots. Yes it's lazy but w/e
	local p2 = pilot(2)
	self:add_gameobject(p2)
	p2.x = 200
	p2.y = 100
	table.insert(self.players, p2)

	local p3 = pilot(3)
	self:add_gameobject(p3)
	p3.x = 100
	p3.y = 200
	table.insert(self.players, p3)

	local p4 = pilot(4)
	self:add_gameobject(p4)
	p4.x = 200
	p4.y = 200
	table.insert(self.players, p4)

end

function Spyplane:update(dt)
	Scene.update(self, dt)
	--add some speed lines, make them zoom.

	--collision detection, damage

	for i,v in ipairs(self.bullets) do
		print(dist(v.x, v.y, self.players[1].x, self.players[1].y))
		if dist(v.x, v.y, self.players[1].x, self.players[1].y) < 5 and not self.players[1].dead then
			self.players[1]:damage(1)
			v.collided = true
		elseif dist(v.x, v.y, self.players[2].x, self.players[2].y) < 5 and not self.players[2].dead then
			self.players[2]:damage(1)
			v.collided = true
		end
	end


end

function Spyplane:render()
	Scene.render(self)

end

return Spyplane
