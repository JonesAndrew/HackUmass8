local Gameobject = require "Gameobjects/index"
local Component = require "components/index"
local baton = require "baton"

local Bullet = Gameobject.Gameobject:extend()
local Explosion = require "gameobjects/explosion"
local Speedline = require "gameobjects/speedline"

function Bullet:new()
    Gameobject.Gameobject.new(self)

    self.shape = self:add_component(Component.get('circle')(self, 3))
    self.shape.style = 'fill'
    self.color = 4
end

function Bullet:update(dt)
    Gameobject.Gameobject.update(self, dt)

    if not self.target.dead and dist(self.target.x, self.target.y, self.x, self.y) < 8 then
        self.target.dead = true
        Director:shake(2.5)
        play_sound("sfxs/explode.wav")
        local o = Director.current:add_gameobject(Explosion(32, 0.5))
        o.x = self.target.x
        o.y = self.target.y
        return true
    end

    return math.abs(self.x - 240) < 3 or self.y > 290
end

return Bullet
