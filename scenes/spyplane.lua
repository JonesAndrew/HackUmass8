local Scene = require "scenes/scene"
local pilot = require "gameobjects/plane/pilot"
local runner = require "gameobjects/plane/runner"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"
local explosion = require "gameobjects/explosion"
local Spyplane = Scene:extend()

function Spyplane:new()
	Scene.new(self)
	self.players = {}
	self.bullets = {}

	local p1 = runner(1)
	self:add_gameobject(p1)
	p1.color = 4
	p1.x = 175
	p1.y = 100
	table.insert(self.players,p1)

	local p2 = runner(2)
	self:add_gameobject(p2)
	p2.color = 4
	p2.x = 300
	p2.y = 100
	table.insert(self.players, p2)

	local p3 = pilot(3)
	self:add_gameobject(p3)
	p3.x = 175
	p3.y = 200

	local p4 = pilot(4)
	self:add_gameobject(p4)
	p4.x = 300
	p4.y = 200

	self.timer = 30
	self.timerlabel = Gameobject.get("basic")()
	self.labelComp = self.timerlabel:add_component(Component.get("label")(self.timerlabel, "q"))
	self.labelComp.binding = function()
		return self.timer <= 0 and 'Done' or tostring(math.ceil(self.timer))
	end
	self.timerlabel.x = 240
	self.timerlabel.y = 10
	self:add_gameobject(self.timerlabel)
end

function Spyplane:update(dt)
	Scene.update(self, dt)
	self.timer = self.timer - dt

--Win conditions
	if #self.players == 0 then
		self.timer = math.min(self.timer, 0)
		self.labelComp.binding = nil
		self.labelComp.text = "Scummy Americans Win!"
		if self.timer <= -2 then
			Director.board:win({[3]=true, [4]=true})
			return true
		end
		return
	end

	if self.timer <= 0 then
		self.labelComp.binding = nil
		self.labelComp.text = "Glory to Russia! Soviets Win!"
		if self.timer <= -2 then
			Director.board:win({[1]=true,[2]=true})
			return true
		end
		return
	end

	local count = 0

	for i,v in ipairs(self.bullets) do

		count = count + 1
		
--Collision detection
		if dist(v.x, v.y, self.players[1].x, self.players[1].y) < 5 and not self.players[1].dead then
			self.players[1]:damage(1)
			v.collided = true
			table.remove(self.bullets, count)
			play_sound("sfxs/hit.wav")
			if self.players[1].dead then
				table.remove(Director.current.players, count)
			end

			break

		elseif dist(v.x, v.y, self.players[2].x, self.players[2].y) < 5 and not self.players[2].dead then
			self.players[2]:damage(1)
			v.collided = true
			table.remove(self.bullets, count)
			play_sound("sfxs/hit.wav")
			if self.players[2].dead then
				table.remove(Director.current.players, count)
			end

		end
	end
end

function Spyplane:render()
	Scene.render(self)

end

return Spyplane
