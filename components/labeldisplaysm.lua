local utf8 = require "utf8"
local Component = require "components/index"

local LabelDisplaySm = Component.Component:extend()
Component.add("labeldisplaysm", LabelDisplaySm)

rubikmonosm = love.graphics.newFont("fonts/RubikMonoOne.ttf", 20)

function Cyrillify(text)
	mod = string.upper(text)
	mod = string.gsub(mod, "D", utf8.char(1044))
	mod = string.gsub(mod, "H", utf8.char(1034))
	mod = string.gsub(mod, "K", utf8.char(1050))
	-- mod = string.gsub(mod, "L", utf8.char(1043))
	mod = string.gsub(mod, "N", utf8.char(1048))
	mod = string.gsub(mod, "O", utf8.char(1060))
	mod = string.gsub(mod, "R", utf8.char(1071))
	-- mod = string.gsub(mod, "T", utf8.char(1035))
	mod = string.gsub(mod, "U", utf8.char(1062))
	mod = string.gsub(mod, "W", utf8.char(1065))
	mod = string.gsub(mod, "X", utf8.char(1046))
	mod = string.gsub(mod, "Y", utf8.char(1059))
	return mod
end

function LabelDisplaySm:new(gameobject, text)
    Component.Component.new(self, gameobject)

    self.offset_x = 0
    self.offset_y = 0
    self.text = Cyrillify(text)
    self.binding = nil
end

function LabelDisplaySm:render()
    if self.binding then
        self.text = self.binding()
    end
	
	love.graphics.setFont(rubikmonosm)
	love.graphics.setColor(colors[3])
    love.graphics.printf(self.text, self.gameobject.x - 200 + self.offset_x, self.gameobject.y + self.offset_y, 400, 'center')
end
