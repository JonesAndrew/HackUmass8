local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"
local Player = require "gameobjects/firesquad/player"
local Shooter = require "gameobjects/firesquad/shooter"

local Firesquad = Scene:extend()

function Firesquad:new()
    Scene.new(self)
    play_sound("gameloop_clean.wav", "stream")
    self.players = {}
    self.shooters = {}
    self.bullets = {}
    self.radius = 200
    self.time = 10
    self.round = 1

    local go = Player(1)
    self:add_gameobject(go)
    go.color = 3
    go.x = 240 - 120
    go.y = 135 + 80
    table.insert(self.players, go)

    go = Shooter(3, go)
    self:add_gameobject(go)
    go.color = 3
    go.x = 240 - 120
    go.y = 135 - 110
    table.insert(self.shooters, go)

    go = Player(2)
    self:add_gameobject(go)
    go.color = 3
    go.x = 240 + 120
    go.y = 135 + 80
    table.insert(self.players, go)

    go = Shooter(4, go)
    self:add_gameobject(go)
    go.color = 3
    go.x = 240 + 120
    go.y = 135 - 110
    table.insert(self.shooters, go)

    self.title = Gameobject.get("basic")()
    self.title:add_component(Component.get("label")(self.title, "5")).binding = function()
        return self.time <= 0 and 'Done' or tostring(math.ceil(self.time))
    end

    self:add_gameobject(self.title)
    self.title.x = 240
    self.title.y = 0
end

function Firesquad:update(dt)
    Scene.update(self, dt)

    self.time = self.time - dt
    if self.time < -3 then
        if (self.players[1].dead or self.players[2].dead or self.shooters[1].shots > 0 or self.shooters[2].shots > 0) then
            local win = {
                [1] = not (self.players[1].dead or self.shooters[1].shots > 0),
                [2] = not (self.players[2].dead or self.shooters[2].shots > 0),
                [3] = not (self.players[1].dead or self.shooters[1].shots > 0),
                [4] = not (self.players[2].dead or self.shooters[2].shots > 0),
            }
            Director.board:win(win)
            return true
        end

        self.round = self.round + 1
        self.time = 10
        self.shooters[1].shots = self.round * 5
        self.shooters[2].shots = self.round * 5
    end

end

function Firesquad:render()
    Scene.render(self)

    love.graphics.setColor(colors[3])
    love.graphics.line(240, 20, 240, 270)
end

return Firesquad
