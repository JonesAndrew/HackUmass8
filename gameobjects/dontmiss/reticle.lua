local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local baton = require "baton"

local Reticle = Gameobject.Gameobject:extend()
Gameobject.add("reticle", Reticle)

function Reticle:new(index)
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
    self.index = index
    self.inner = self:add_component(Component.get('circle')(self, 6))
    self.outer = self:add_component(Component.get('circle')(self, 18))
    self.sway = self:add_component(Component.get('sway')(self, 4, 4, 3))
    self.primed = false
    self.timer = 2.50
    self.shot = false
    self.position = nil
end


function Reticle:update(dt)
	self.input:update()
	local x, y = self.input:get('move')
	self.vel_x = approach(self.vel_x, x * 60, dt * 400)
	self.vel_y = approach(self.vel_y, y * 60, dt * 400)
	Gameobject.Gameobject.update(self, dt)
	if (self.input:down('a') and not self.primed) then self.primed = true
	elseif self.primed then self:fire(dt) end
end


function Reticle:fire(x) 
	self.timer = self.timer - x
	self.inner.style = "fill"
	self.inner.radius = math.floor(self.timer/2.50 * self.inner.radius)
	self.outer.radius = math.floor(self.timer/2.50 * self.outer.radius)
	if (self.timer <= 2 and not self.position) then 
		self.shot = true --shooters gonna shoot
		self.position = {self.x, self.y}
    elseif self.timer <= 0 then
        self:reset()
	end
end

function Reticle:reset() 
	self.timer = 2.50
	self.inner.style = "line"
	self.inner.radius = 6
	self.outer.radius = 18
	self.x = 240 + ((-1)^(self.index) * 20)
	self.y = 135
	self.primed = false
	self.shot = false
    self.position = nil
end



return Reticle