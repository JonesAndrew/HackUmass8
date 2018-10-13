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
	subtitle:add_component(Component.get("labelbig")(subtitle, "The Soviet Spy Training Programme"))
	self:add_gameobject(subtitle)
	
	local warning = Gameobject.get("basic")()
	warning:add_component(Component.get("labelbigem")(warning, "Confidential Material"))
	self:add_gameobject(warning)
	
	local disclaimer = Gameobject.get("basic")()
	disclaimer:add_component(Component.get("label")(disclaimer, "If you are not authorized to view this programme,\nyou must report to your superior immediately"))
	self:add_gameobject(disclaimer)
	
	local start = Gameobject.get("basic")()
	start:add_component(Component.get("labeldisplaysm")(start, "Press any key to start"))
	self:add_gameobject(start)

    name.x = 240
    name.y = 10
	subtitle.x = 240
	subtitle.y = 120
	warning.x = 240
	warning.y = 150
	disclaimer.x = 240
	disclaimer.y = 200
	start.x = 240
	start.y = 240
end

return Title