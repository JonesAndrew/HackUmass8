local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local baton = require "baton"

local Player = Gameobject.Gameobject:extend()
local Speedline = require "gameobjects/speedline"

function Player:new(index)
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
    }

    self.shape = self:add_component(Component.get('shape')(self, 8))

    self.line_cool = 0
    self.color = 3
end

function Player:update(dt)
    self.input:update()
    self.line_cool = self.line_cool - dt

    local button = nil
    if self.input:pressed('a') then
        button = 'a'
    elseif self.input:pressed('b') then
        button = 'b'
    elseif self.input:pressed('x') then
        button = 'x'
    elseif self.input:pressed('y') then
        button = 'y'
    end

    if button == Director.current.button then
        self.vel_x = 40
    elseif button ~= nil then
        self.vel_x = -30
    end

    local delta = 360 * dt
    if self.vel_x >= 0 then
        if self.vel_x < delta then
            self.vel_x = 0
        else
            self.vel_x = self.vel_x - delta
        end
    else
        if self.vel_x > -delta then
            self.vel_x = 0
        else
            self.vel_x = self.vel_x + delta
        end
    end

    if self.vel_x ~= 0 then
        self.shape.radius = 7
        if self.line_cool <= 0 then
            self.line_cool = 0.025
            local dir = 1
            if self.vel_x > 0 then
                dir = -1
            end

            local line = Director.current:add_gameobject(Speedline(math.abs(self.vel_x) * 2 + 30, (-1 + dir)/2 * math.pi))
            line.x = self.x + 9 * dir
            line.y = self.y + love.math.random(-8, 8)
        end
    else
        self.shape.radius = 8
    end

    Gameobject.Gameobject.update(self, dt)
end

return Player
