local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"

local Title = Scene:extend()

function Title:new()
    Scene.new(self)

    local name = Gameobject.get("basic")()
    name:add_component(Component.get("labeldisplay")(name, "Russian Bullshit"))
    self:add_gameobject(name)
	
	local subtitle = Gameobject.get("basic")()
	subtitle:add_component(Component.get("label")(subtitle, "The Soviet Spy Training Programme"))
	self:add_gameobject(subtitle)

    name.x = 240
    name.y = 10
	subtitle.x = 240
	subtitle.y = 120
end

return Title