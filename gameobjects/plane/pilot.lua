local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local baton = require "baton"
local circle = require "components/circle"
local shape = require "components/shape"
local Player = Gameobject.Gameobject:extend()

function Player:new(index)
    Gameobject.Gameobject.new(self)

--Buttons and such
    self.input = baton.new {
      controls = {
        left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
        right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
        up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
        down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
        shoot = {'key:x', 'button:a'},
      },
      pairs = {
        move = {'left', 'right', 'up', 'down'}
      },
      joystick = love.joystick.getJoysticks()[index],
    }

    self.health = 5
    self.active = true
	self.circle = self:add_component(Component.get('circle')(self, 5, 3))
	self.bullet_count = 0

end

--Calculates damage. Returns false when the pilot is destroyed
function Player:damage(damage)
	health = health - damage
	if health <= 0 then
		active = false
	end 
end

function Player:shoot()
	--[[Send out a bullet at a set velocity.
		Any way to space time out between shots?
	]]
	local b = bullet:new(bullet_count)
	b.x = self.x
	b.y = self.y + 2
	bullet_count = bullet_count + 1

	--Add to array of bullets the scene will look at
	table.insert(Director.current.bullets, b)
end

function Player:update(dt)
	self.input:update()
	
	if self.active == false then
		local o = Direcor.current:add_gameobject(Explosion())
		o.x = self.x
		o.y = self.y
		return true
	end

	local x, y = self.input:get('move')
	self.vel_x = x * 600
	self.vel_y = y * 600

	if input:get('shoot') then
		Player:shoot()
		--shoot function
	end
	-- movement handled by superclass
	Gameobject.Gameobject.update(self, dt)
end

return Player
