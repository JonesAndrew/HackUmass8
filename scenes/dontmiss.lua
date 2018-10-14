local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"
local Reticle = require "gameobjects/dontmiss/reticle"
local Target = require "gameobjects/dontmiss/target"

local DontMiss = Scene:extend()

function DontMiss:new()
    Scene.new(self)
    self.players = {}
    self.radius = 200
    self.timer = 30

    local go1 = Reticle(1)
    self:add_gameobject(go1)
    go1.color = 3
    go1.x = 240 - 30
    go1.y = 135 - 30

    local go2 = Reticle(3)
    self:add_gameobject(go2)
    go2.color = 2
    go2.x = 240 + 30
    go2.y = 135 + 30

    local go3 = Target(2,4,go1,go2)
    self:add_gameobject(go3)
    go3.color = 4
    go3.x = 240
    go3.y = 135


    self:add_gameobject(self.timer)
    self:add_gameobject(go3.t1score)
    self:add_gameobject(go3.t2score)

    self.timer = Gameobject.get("basic")()
    self.timer:add_component(Component.get("label")(self.timer, "q")).binding = function()
        return self.timer <= 0 and 'Done' or tostring(math.ceil(self.timer))
    end
    self:add_gameobject(self.timer)
    self.timer.x = 240

    self.team1 = Gameobject.get("basic")()
    self.team1:add_component(Component.get("label")(self.team1, "q")).binding = function()
        return ("Team 1 Score: " .. tostring(go3.t1score))
    end

    self:add_gameobject(self.team1)
    self.timer.x = 120

    self.team2 = Gameobject.get("basic")()
    self.team2:add_component(Component.get("label")(self.team2, "q")).binding = function()
        return ("Team 1 Score: " .. tostring(go3.t2score))
    end

    self:add_gameobject(self.team2)
    self.timer.x = 360
end


function DontMiss:update(dt)
    Scene.update(self, dt)
    self.timer = self.timer - dt
end

function DontMiss:render()
    Scene.render(self)

    love.graphics.setColor(colors[3])
end

return DontMiss
