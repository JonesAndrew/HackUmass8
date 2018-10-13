local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local bullet = Gameobject.Gameobject:extend()


function bullet:new(index)
	Gameobject.Gameobject.new(self)
	self.collided = false
	self.shape = self:add_component(Component.get('shape')(self, 2))

	--handle collision in object or scene? 
end

function bullet:update(dt)
	self.vel_y = 50	
	if self.collided then
		return true
	end
end
