local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local baton = require "baton"

local Player = Gameobject.Gameobject:extend()
local Explosion = require "gameobjects/explosion"
local Speedline = require "gameobjects/speedline"

function Player:new(index)
    Gameobject.Gameobject.new(self)

    if index == 1 then
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
    else
        self.input = baton.new {
          controls = {
            left = {'axis:leftx-', 'button:dpleft'},
            right = {'axis:leftx+', 'button:dpright'},
            up = {'axis:lefty-', 'button:dpup'},
            down = {'axis:lefty+', 'button:dpdown'},
            a = {'button:a'},
          },
          pairs = {
            move = {'left', 'right', 'up', 'down'}
          },
          joystick = love.joystick.getJoysticks()[index],
        }
    end

    self.shape = self:add_component(Component.get('circle')(self, 12, index + 2))

    self.line_cool = 0
    self.charge = 0
    self.stun = 0
    self.dash = false
    self.color = 3

    self.last_x = 1
    self.last_y = 0
end

function Player:update(dt)
    if self.stop then
        return
    end

    self.input:update()
    self.line_cool = self.line_cool - dt
    self.stun = self.stun - dt

    local x, y = self.input:get('move')
    if (x ~= 0 or y ~= 0) then
        self.last_x = x
        self.last_y = y
    end

    if self.stun > 0 then
        self.charge = 0
    elseif self.input:down('a') then
        self.vel_x = approach(self.vel_x, 0, dt * 240)
        self.vel_y = approach(self.vel_y, 0, dt * 240)

        self.charge = math.max(math.min(self.charge + dt, 1), 0.4)
    elseif self.input:released('a') then
        if x == 0 and y == 0 then
            x = self.last_x
            y = self.last_y
        end
        
        local len = (x^2 + y^2)^0.5
        x = x / len
        y = y / len
        self.vel_x = (self.charge) * 320 * x
        self.vel_y = (self.charge) * 320 * y
        self.dash = true
        self.charge = 0
    else
        self.vel_x = approach(self.vel_x, x * 60, dt * 360)
        self.vel_y = approach(self.vel_y, y * 60, dt * 360)
    end

    Gameobject.Gameobject.update(self, dt)

    local speed = (self.vel_x^2 + self.vel_y^2)^0.5
    if speed > 60 then
        if speed > 120 then
            local obj = Director.current:add_gameobject(Speedline(-speed, math.atan2(self.vel_y, self.vel_x)))
            local dir = math.atan2(-self.vel_x, self.vel_y)
            local amt = love.math.random(-8,8)
            obj.x = self.x + math.cos(dir) * amt + math.sin(dir) * 8
            obj.y = self.y + math.sin(dir) * amt - math.cos(dir) * 8
        end

        if self.dash then
            for _, other in ipairs(Director.current.players) do
                if other ~= self and not other.dead then
                    if ((self.x - other.x)^2 + (self.y - other.y)^2)^0.5 < 17 then
                        Director:shake(1.5)
                        local o = Director.current:add_gameobject(Explosion(8, 0.1))
                        o.x = (self.x + other.x)/2
                        o.y = (self.y + other.y)/2
                        if other.dash then
                            local temp_x = other.vel_x
                            local temp_y = other.vel_y
                            other.vel_x = self.vel_x
                            other.vel_y = self.vel_y
                            self.vel_x = temp_x
                            self.vel_x = temp_y
                            other.dash = false
                            self.dash = false
                            break
                        else
                            other.vel_x = self.vel_x
                            other.vel_y = self.vel_y
                            other.stun = 0.25
                            other.dash = true
                            self.vel_x = self.vel_x / 4
                            self.vel_y = self.vel_y / 4
                            self.dash = false
                            break
                        end
                    end
                end
            end
        end
    else
        self.dash = false
    end

    if dist(self.x, self.y, 240, 135) > Director.current.radius then
        self.dead = true
        Director:shake(2.5)
        local o = Director.current:add_gameobject(Explosion())
        o.x = self.x
        o.y = self.y
        return true
    end

    self.shape.radius = 8 - (self.charge) * 4
end

return Player
