local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local bullet = Gameobject.Gameobject:extend()


function bullet:new(index)
	Gameobject.Gameobject.new(self)
	self.collided = false
	self.shape = self:add_component(Component.get('shape')(self, 2))

	--collision handled in scene, should set collided to true
end

--bullet's only gotta move. if it collides, then it disappears
function bullet:update(dt)
	
	if self.collided then
		return true
	end
	
	self.vel_y = -75	
	Gameobject.Gameobject.update(self, dt)
	
end

return bullet
