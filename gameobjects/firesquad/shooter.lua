local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local baton = require "baton"

local Shooter = Gameobject.Gameobject:extend()
local Bullet = require "gameobjects/firesquad/bullet"
local Explosion = require "gameobjects/explosion"
local Speedline = require "gameobjects/speedline"

function Shooter:new(index, target)
    Gameobject.Gameobject.new(self)

    if index == 1 then
        self.input = baton.new {
          controls = {
            a = {'key:z', 'button:a'},
          },
          joystick = love.joystick.getJoysticks()[index],
        }
    else
        self.input = baton.new {
          controls = {
            a = {'key:z', 'button:a'},
          },
          joystick = love.joystick.getJoysticks()[index],
        }
    end

    self.target = target
    self.shots = 5

    self.shape = self:add_component(Component.get('circle')(self, 8, index + 2))
    self.shot_label = self:add_component(Component.get('label')(self, ''))
    self.shot_label.binding = function()
        return tostring(self.shots)..' Bullets'
    end
    self.shot_label.offset_x = 40
    self.shot_label.offset_y = -10
end

function Shooter:update(dt)
    self.input:update()

    if self.input:pressed('a') and Director.current.time > 0 and self.shots > 0 then
        self.shots = math.max(self.shots - 1, 0)

        local dif_x = self.target.x - self.x
        local dif_y = self.target.y - self.y
        local len = (dif_x^2 + dif_y^2)^0.5

        dif_x = dif_x / len * 120
        dif_y = dif_y / len * 120

        local count = love.math.random(3, 8)

        for i=1,count do
            play_sound("sfxs/dash.wav")
            local bullet = Director.current:add_gameobject(Bullet())
            bullet.x = self.x
            bullet.y = self.y
            bullet.target = self.target

            local mid = i-(1+count)/2

            local cos = math.cos(math.pi/12 * mid)
            local sin = math.sin(math.pi/12 * mid)
            bullet.vel_x = (cos * dif_x) - (sin * dif_y)
            bullet.vel_y = (sin * dif_x) + (cos * dif_y)
        end
    end

    Gameobject.Gameobject.update(self, dt)
end

return Shooter
