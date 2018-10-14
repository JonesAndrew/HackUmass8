local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"

local Board = Scene:extend()

function Board:new()
    Scene.new(self)
    self.piecies = {}
    self.targets = {0, 0, 0, 0}
    self.games = {'footrace','firesquad','fortnite','tankgame'}

    local go = Gameobject.get("basic")()
    go:add_component(Component.get('circle')(go, 8, 3))
    self:add_gameobject(go)
    go.x = 95
    go.y = 100
    table.insert(self.piecies, go)

    go = Gameobject.get("basic")()
    go:add_component(Component.get('circle')(go, 8, 4))
    self:add_gameobject(go)
    go.x = 95
    go.y = 130
    table.insert(self.piecies, go)

    go = Gameobject.get("basic")()
    go:add_component(Component.get('circle')(go, 8, 5))
    self:add_gameobject(go)
    go.x = 95
    go.y = 160
    table.insert(self.piecies, go)

    go = Gameobject.get("basic")()
    go:add_component(Component.get('circle')(go, 8, 6))
    self:add_gameobject(go)
    go.x = 95
    go.y = 190
    table.insert(self.piecies, go)
end

function Board:win(winner)
    for i=1,4 do
        if winner[i] then
            self.targets[i] = self.targets[i] + 3
        else
            self.targets[i] = self.targets[i] + 1
        end
    end
end

function Board:update(dt)
    Scene.update(self, dt)

    local fail = false
    for i=1,4 do
        if self.piecies[i].x < 95 + self.targets[i] * 30 then
            fail = true
            self.piecies[i].x = math.min(95 + self.targets[i] * 30, self.piecies[i].x + 60 * dt)
        end
    end

    if not fail then
        if love.keyboard.isDown("space") then
            Director.board = self
            Director:next_scene(require ("scenes/"..self.games[love.math.random(#self.games)])())
            return true
        end
    end
end

function Board:render()
    love.graphics.setColor(colors[3])
    Scene.render(self)

    for i=0,2 do
        love.graphics.line(80, 115 + 30 * i, 380, 115 + 30 * i)
    end

    for i=0,8 do
        love.graphics.line(110 + 30 * i, 90, 110 + 30 * i, 200)
    end
end

return Board