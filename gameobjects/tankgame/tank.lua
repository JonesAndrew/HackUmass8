local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local baton = require "baton"

local Player = Gameobject.Gameobject:extend()
local Bullet = require "gameobjects/tankgame/bullet"
local Explosion = require "gameobjects/explosion"
local Speedline = require "gameobjects/speedline"

function Player:new(index, index2)
    Gameobject.Gameobject.new(self)

    self.input = baton.new {
      controls = {
        left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
        right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
        up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
        down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
        a = {'key:z', 'button:a'},
      },
      pairs = {
        move = {'left', 'right', 'up', 'down'}
      },
      joystick = love.joystick.getJoysticks()[index],
    }

    self.input2 = baton.new {
      controls = {
        left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
        right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
        up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
        down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
        a = {'key:z', 'button:a'},
      },
      pairs = {
        move = {'left', 'right', 'up', 'down'}
      },
      joystick = love.joystick.getJoysticks()[index2],
    }

    self.shape = self:add_component(Component.get('shape')(self, 6))

    self.line_cool = 0
    self.color = 3

    self.last_x = 1
    self.last_y = 0

    self.angle = -math.pi/4
    self.charge = 0.2
    self.cooldown = 0
end

function Player:update(dt)
    self.input:update()
    self.input2:update()

    local up = self.input2:get("up") - self.input2:get("down")

    self.angle = math.min(math.max(-math.pi/2, self.angle - up/2 * dt), math.pi/6)

    if self.cooldown > 0 then
        self.cooldown = self.cooldown - dt
    elseif self.input:down('a') then
        self.charge = math.max(0.2, math.min(self.charge + dt, 1))
    elseif self.input:released('a') then
        local bullet = Bullet()
        bullet.x = self.x
        bullet.y = self.y
        Director.current:add_gameobject(bullet)

        local dir = self.x < 240 and 1 or -1
        bullet.vel_x = math.cos(self.angle) * 400 * dir * self.charge
        bullet.vel_y = math.sin(self.angle) * 400 * self.charge
        bullet.target = self.target
        play_sound("sfxs/tank_shoot.wav")

        self.cooldown = 2
        self.charge = 0.2
    end

    return self.dead
end

function Player:render()
    Gameobject.Gameobject.render(self)

    if self.cooldown > 0 then
        return
    end

    local dir = self.x < 240 and 1 or -1
    local x = math.cos(self.angle) * 100 * dir * self.charge
    local y = math.sin(self.angle) * 100 * self.charge

    love.graphics.line(self.x, self.y, self.x+x, self.y+y)
end

return Player
