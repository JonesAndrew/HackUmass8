local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"
local Input = require "generic_input"

local WinScreen = Scene:extend()

function WinScreen:new(winners)
    Scene.new(self)

    local name = Gameobject.get("basic")()
    name:add_component(Component.get("labeldisplay")(name, "Winners"))
    self:add_gameobject(name)
    name.x = 240
    name.y = 10
    name.colors = 3

    local go = Gameobject.get("basic")()
    self.comp = go:add_component(Component.get('circle')(go, 8, 3))
    if winners[1] then
        self:add_gameobject(go)
    end
    go.x = 240 - 60
    go.y = 100
    go.color = 3
    self.final = go

    go = Gameobject.get("basic")()
    go:add_component(Component.get('circle')(go, 10, 4))
    if winners[2] then
        self:add_gameobject(go)
    end
    go.x = 240 - 30
    go.y = 135
    go.color = 3

    go = Gameobject.get("basic")()
    go:add_component(Component.get('circle')(go, 10, 5))
    if winners[3] then
        self:add_gameobject(go)
    end
    go.x = 240 + 30
    go.y = 135
    go.color = 3

    go = Gameobject.get("basic")()
    go:add_component(Component.get('circle')(go, 10, 6))
    if winners[4] then
        self:add_gameobject(go)
    end
    go.x = 240 + 60
    go.y = 135
    go.color = 3
end

function WinScreen:update(dt)
    Scene.update(self, dt)

    print(self.comp.radius, self.comp.gameobject.x)
    print(self.final.x, self.final.y, self.final.colors)
end

return WinScreen