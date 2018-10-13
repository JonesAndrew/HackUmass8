local Gameobject = require "Gameobjects/index"

local Reticle = Gameobject.Gameobject:extend()
Gameobject.add("reticle", Reticle)

function Reticle:new()
    Gameobject.Gameobject.new(self)

    self.input = baton.new {
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
      joystick = love.joystick.getJoysticks()[index],
    }

    self.inner = self:add_component(Component.get('circle')(self, 12))
    self.outer = self:add_component(Component.get('circle')(self, 48))
    self.sway = self.add_component(Component.get('sway')(self))
    self.primed = false;
    self.timer = 1.00;
end
function Reticle:update(dt)
	self.input:update()
	Gameobject.Gameobject.update(self, dt)
	if (self.input:down('a') and not self.primed) then self.primed = true
	elseif self.primed then self.fire(dt) end
end



function Reticle:fire(gameobject, dt) 
	self.timer = self.timer - dt
	self.inner.radius = math.floor(self.timer * self.inner.radius + 0.5)
	self.outer.radius = math.floor(self.timer * self.outer.radius + 0.5)
	if (self.timer =< 0)
		self.inner.radius = 1;
end