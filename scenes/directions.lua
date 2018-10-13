local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"

local Directions = Scene:extend()

function Directions:new(title, subtitle, description)
    Scene.new(self)

	local titleLabel = Gameobject.get("basic")()
    titleLabel:add_component(Component.get("labeldisplay")(titleLabel, title))
    self:add_gameobject(titleLabel)

	local subtitleLabel = Gameobject.get("basic")()
    subtitleLabel:add_component(Component.get("labelbigem")(subtitleLabel, subtitle))
    self:add_gameobject(subtitleLabel)

	local descLabel = Gameobject.get("basic")()
    descLabel:add_component(Component.get("labelbig")(descLabel, description))
    self:add_gameobject(descLabel)
	
	local start = Gameobject.get("basic")()
	start:add_component(Component.get("labeldisplaysm")(start, "Press any key to start"))
	self:add_gameobject(start)

    titleLabel.x = 240
    titleLabel.y = 10
	subtitleLabel.x = 240
	subtitleLabel.y = 105
	descLabel.x = 240
	descLabel.y = 130
	start.x = 240
	start.y = 240
end

return Directions