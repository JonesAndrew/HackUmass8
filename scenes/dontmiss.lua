local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"
local Reticle = require "gameobjects/dontmiss/reticle"

local DontMiss = Scene:extend()

function DontMiss:new()
    Scene.new(self)
    self.players = {}
    self.radius = 200

    local go = Reticle(1)
    self:add_gameobject(go)
    go.color = 3
    go.x = 240 - 70
    go.y = 135 - 70


    -- local title = Gameobject.get('basic')()
    -- self.button_label = title:add_component(Component.get('label')(title, 'a'))
    -- title.x = 240
    -- self:add_gameobject(title)

    -- self:random_button()
end

function DontMiss:update(dt)
    Scene.update(self, dt)
end

function DontMiss:render()
    Scene.render(self)

    love.graphics.setColor(colors[3])
end

return DontMiss
