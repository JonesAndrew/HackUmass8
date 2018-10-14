local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"
local Input = require "generic_input"

local Title = Scene:extend()

function Title:new()
    Scene.new(self)

    local name = Gameobject.get("basic")()
    name:add_component(Component.get("labeldisplay")(name, "Praktika"))
    self:add_gameobject(name)
	
	local subtitle = Gameobject.get("basic")()
	subtitle:add_component(Component.get("labelbig")(subtitle, "Spycraft Training Bouts And Espionage Games 1987 - 1988"))
	self:add_gameobject(subtitle)
	
	-- local warning = Gameobject.get("basic")()
	-- warning:add_component(Component.get("labelbigem")(warning, "Confidential Material"))
	-- self:add_gameobject(warning)
	
	local disclaimer = Gameobject.get("basic")()
	disclaimer:add_component(Component.get("label")(disclaimer, "MEANT FOR TRAINING PURPOSES\nCONFIDENTIAL"))
	self:add_gameobject(disclaimer)
	
	local start = Gameobject.get("basic")()
	start:add_component(Component.get("labeldisplaysm")(start, "Press any key to start"))
	self:add_gameobject(start)

    name.x = 240
    name.y = 30
	subtitle.x = 240
	subtitle.y = 110
	-- warning.x = 240
	-- warning.y = 150
	disclaimer.x = 240
	disclaimer.y = 190
	start.x = 240
	start.y = 240
end

function Title:update(dt)
	Scene.update(self, dt)

	Input.update()
	if Input.pressed("a") or Input.pressed("b") or Input.pressed("x") or Input.pressed("y") then
		Director:next_scene(require "scenes/board"())
		return true
	end
end

return Title