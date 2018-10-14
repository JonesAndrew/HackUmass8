local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local baton = require "baton"

local Player = Gameobject.Gameobject:extend()
local Speedline = require "gameobjects/speedline"
local Explosion = require "gameobjects/explosion"

function Player:new(index)
    Gameobject.Gameobject.new(self)

    self.input = baton.new {
      controls = {
        left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
        right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
        up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
        down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
        a = {'key:a', 'button:a'},
        b = {'key:b', 'button:b'},
        x = {'key:x', 'button:x'},
        y = {'key:y', 'button:y'},
      },
      joystick = love.joystick.getJoysticks()[index],
    }

    self.shape = self:add_component(Component.get('circle')(self, 8, index + 2))

    self.line_cool = 0
    self.color = 3
    self.started = false
end

function Player:update(dt)
    if self.stop then
        return
    end

    self.input:update()
    if self.input:pressed('a') then
        if not self.started then
            self.starting_x = self.x
            self.started = true
        end
        self.vel_y = -120
        self.vel_x = 60
    end

    if self.started then
        self.vel_y = self.vel_y + 240 * dt
    end

    Gameobject.Gameobject.update(self, dt)

    local y = Director.current:y_from_x(self.x)
    if self.y >= y - 2 or self.y <= y - (Director.current.height - 2) then
        self.dead = true
        Director:shake(2.5)
        play_sound("sfxs/explode.wav")
        local o = Director.current:add_gameobject(Explosion(32, 0.5))
        o.x = self.x
        o.y = self.y
        return true
    end
end

return Player
