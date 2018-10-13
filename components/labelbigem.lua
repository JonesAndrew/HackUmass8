local Component = require "components/index"

local LabelBigEm = Component.Component:extend()
Component.add("labelbigem", LabelBigEm)

ptboldem = love.graphics.newFont("fonts/PT_Sans-BoldItalic.ttf", 20)

function LabelBigEm:new(gameobject, text)
    Component.Component.new(self, gameobject)

    self.offset_x = 0
    self.offset_y = 0
    self.text = text
    self.binding = nil
end

function LabelBigEm:render()
    if self.binding then
        self.text = self.binding()
    end

	love.graphics.setColor(colors[4])
	love.graphics.setFont(ptboldem)
    love.graphics.printf(self.text, self.gameobject.x - 200 + self.offset_x, self.gameobject.y + self.offset_y, 400, 'center')
end
