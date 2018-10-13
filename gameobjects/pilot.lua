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
        shoot = {'key: x', 'button:a'}
      },
      pairs = {
        move = {'left', 'right', 'up', 'down'}
      },
      joystick = love.joystick.getJoysticks()[index],
    }

    self.health = 5
    player.active = true
	self.circle = self:add_component(Component.get('circle')(self, 5, 3))

end

--Calculates damage. Returns false when the pilot is destroyed
function Player:damage(damage)
	health = health - damage
	if health <= 0 then
		return false
	end

	return true
end 

function Player:shoot()
	--[[Send out a bullet at a set velocity.
		Any way to space time out between shots?
	]]
	


function Player:update(dt)
	self.input:update()
	local button = self.input:pressed()
	
	if button == 'left' then
		self.vel_x = -40
	elseif button == 'right' then
		self.vel_x =  40
	elseif button == 'up' then
		self.vel_y = -40
	elseif button == 'down' then
		self.vel_y = 40
	elseif button == 'shoot' then
		Player:shoot()
		--shoot function

--change shape into plane?
-- add array of bullets and check each bullet with position of soviets
end

