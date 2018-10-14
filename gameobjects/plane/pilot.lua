local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local baton = require "baton"
local circle = require "components/circle"
local shape = require "components/shape"
local bullet = require "Gameobjects/plane/bullet"
local Player = Gameobject.Gameobject:extend()
local Explosion = require "Gameobjects/explosion"

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
    self.dead = false
	self.circle = self:add_component(Component.get('circle')(self, 5, 3))
	self.bullet_count = 0

end

--Calculates damage. Returns false when the pilot is destroyed
function Player:damage(damage)
	self.health = self.health - damage
	if self.health <= 0 then
		self.dead = true
	end 
end

function Player:shoot()
	--[[Send out a bullet at a set velocity.
		Any way to space time out between shots?
	]]
	b = bullet(self.bullet_count)
	b.x = self.x
	b.y = self.y - 20
	self.bullet_count = self.bullet_count + 1

	--Add to array of bullets the scene will look at
	table.insert(Director.current.bullets, b)
	Director.current:add_gameobject(b)
end

function Player:update(dt)
	self.input:update()
	
	if self.dead then
		play_sound("sfxs/explode.wav")
		local o = Director.current:add_gameobject(Explosion())
		o.x = self.x
		o.y = self.y
		return true 
	end

	local x, y = self.input:get('move')
	self.vel_x = x * 200
	self.vel_y = y * 200

	if self.input:pressed('shoot') then
		self:shoot()
		--shoot function
	end--]]
	-- movement handled by superclass
	Gameobject.Gameobject.update(self, dt)

	if self.x < 0 then
		self.x = 0
	end
	if self.y < 0 then
		self. y = 0
	end

	if self.x > gw then
		self. x = gw
	end
	if self.y > gh then
		self.y = gh
	end
end

return Player
