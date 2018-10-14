local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"
local FortnitePlayer = require "gameobjects/fortnite/fortnite_player"

local Fortnite = Scene:extend()

function Fortnite:new()
    Scene.new(self)
    self.players = {}
    self.radius = 200

    local go = FortnitePlayer(1)
    self:add_gameobject(go)
    go.color = 3
    go.x = 240 - 70
    go.y = 135 - 70
    table.insert(self.players, go)

    go = FortnitePlayer(2)
    self:add_gameobject(go)
    go.color = 3
    go.x = 240 + 70
    go.y = 135 - 70
    table.insert(self.players, go)

    go = FortnitePlayer(3)
    self:add_gameobject(go)
    go.color = 3
    go.x = 240 - 70
    go.y = 135 + 70
    table.insert(self.players, go)

    go = FortnitePlayer(4)
    self:add_gameobject(go)
    go.color = 3
    go.x = 240 + 70
    go.y = 135 + 70
    table.insert(self.players, go)

    self.win_timer = 0
end

function Fortnite:update(dt)
    Scene.update(self, dt)

    local count = 0
    local winner = 0
    for i=1,4 do
        if not self.players[i].dead then
            winner = i
            count = count + 1
        end
    end

    if count == 1 then
        self.players[winner].stop = true
        self.win_timer = self.win_timer + dt
        if self.win_timer > 2 then
            print(winner)
            Director.board:win({[winner]=true})
            return true
        end
        return
    end

    self.radius = self.radius - dt * 1.5
end

function Fortnite:render()
    Scene.render(self)

    love.graphics.setColor(colors[3])
    love.graphics.circle("line", 240, 135, self.radius)
end

return Fortnite
