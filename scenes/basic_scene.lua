local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"

local Basic = Scene:extend()

function Basic:new()
    Scene.new(self)

    local go = Gameobject.get("basic")()
    go:add_component(Component.get("shape")(go, 4, 32))
    go:add_component(Component.get("label")(go, "P1"))
    self:add_gameobject(go)

    go.update = function(go, dt)
        go.x = go.x + dt
    end

    go.x = 100
    go.y = 100
end

return Basic