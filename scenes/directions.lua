local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"
local Input = require "generic_input"

local Directions = Scene:extend()

function Directions:new(title, subtitle, description, controls, next_scene)
    Scene.new(self)

	local titleLabel = Gameobject.get("basic")()
    titleLabel:add_component(Component.get("labeldisplay")(titleLabel, title))
    self:add_gameobject(titleLabel)

	local subtitleLabel = Gameobject.get("basic")()
    subtitleLabel:add_component(Component.get("label")(subtitleLabel, subtitle))
    self:add_gameobject(subtitleLabel)

	local descLabel = Gameobject.get("basic")()
    descLabel:add_component(Component.get("label")(descLabel, description))
    self:add_gameobject(descLabel)

    local consLabel = Gameobject.get("basic")()
    consLabel:add_component(Component.get("labelbig")(consLabel, controls))
    self:add_gameobject(consLabel)
	
	local start = Gameobject.get("basic")()
	start:add_component(Component.get("labeldisplaysm")(start, "Press any key to start"))
	self:add_gameobject(start)

    self.next_scene = next_scene

    titleLabel.x = 240
    titleLabel.y = 10
	subtitleLabel.x = 240
	subtitleLabel.y = 60
	descLabel.x = 240
	descLabel.y = 100

    consLabel.x = 240
    consLabel.y = 170

	start.x = 240
	start.y = 240
end

function Directions:update(dt)
    Scene.update(self, dt)

    Input.update()
    if Input.pressed("a") or Input.pressed("b") or Input.pressed("x") or Input.pressed("y") then
        Director:next_scene(require ("scenes/"..self.next_scene)())
        return true
    end
end

return Directions