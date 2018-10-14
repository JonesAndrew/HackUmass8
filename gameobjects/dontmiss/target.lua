local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local baton = require "baton"

local Target = Gameobject.Gameobject:extend()
Gameobject.add("target", Target)

function Target:new(index1, index2, reticle1, reticle2)
    Gameobject.Gameobject.new(self)

    self.r1 = reticle1
    self.r2 = reticle2
    self.input1 = baton.new {
      controls = {
        left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
        right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
        up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
        down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
        a = {'key:z', 'button:a'}, 
        b = {'key:x', 'button:b'},
        x = {'key:c', 'button:x'},
        y = {'key:v', 'button:y'},
      },
      pairs = {
        move = {'left', 'right', 'up', 'down'}
      },
      joystick = love.joystick.getJoysticks()[index1],
    }

    self.input2 = baton.new {
      controls = {
        left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
        right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
        up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
        down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
        a = {'key:z', 'button:a'}, 
        b = {'key:x', 'button:b'},
        x = {'key:c', 'button:x'},
        y = {'key:v', 'button:y'},
      },
      pairs = {
        move = {'left', 'right', 'up', 'down'}
      },
      joystick = love.joystick.getJoysticks()[index2],
    }

    self.inner = self:add_component(Component.get('circle')(self, 12))
    self.middle = self:add_component(Component.get('circle')(self, 36))
    self.outer = self:add_component(Component.get('circle')(self, 108))
    self.sway = self:add_component(Component.get('sway')(self, 5, 3, 2))
    self.t1score = 0
    self.t2score = 0

end


function Target:update(dt)
	self.input1:update()
	self.input2:update()
	local x1, y1 = self.input1:get('move')
	local x2, y2 = self.input2:get('move')
	local x = x1 + x2
	local y = y1 + y2
	self.vel_x = approach(self.vel_x, x * 60, dt * 500)
	self.vel_y = approach(self.vel_y, y * 60, dt * 500)
	Gameobject.Gameobject.update(self, dt)
	if (self.r1.shot) then
		self.t1score = self.t1score + self:calcscore(self.r1.position)
		self.r1:reset()
  end
	if (self.r2.shot) then
		self.t2score = self.t2score + self:calcscore(self.r2.position)
		self.r2:reset()
	end
end
	
function Target:calcscore(pos)
	dist = ((pos[1] - self.x)^2 + (pos[2] - self.y)^2)^0.5
	if (dist <= 12) then
		return 3
	elseif (dist <= 36) then 
		return 2
	elseif (dist <= 108) then
		return 1
	else return 0 end
end


return Target