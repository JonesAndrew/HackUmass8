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

    -- local title = Gameobject.get('basic')()
    -- self.button_label = title:add_component(Component.get('label')(title, 'a'))
    -- title.x = 240
    -- self:add_gameobject(title)

    -- self:random_button()
end

function Fortnite:update(dt)
    Scene.update(self, dt)
    self.radius = self.radius - dt

    -- self.countdown = self.countdown - dt
    -- if self.countdown < 0 then
    --     self.countdown = love.math.random() + 2.5
    --     self:random_button()
    -- end
end

function Fortnite:render()
    Scene.render(self)

    love.graphics.setColor(colors[3])
    love.graphics.circle("line", 240, 135, self.radius)
end

return Fortnite
