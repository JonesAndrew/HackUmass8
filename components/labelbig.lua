local Component = require "components/index"

local LabelBig = Component.Component:extend()
Component.add("labelbig", LabelBig)

ptbold = love.graphics.newFont("fonts/PT_Sans-Bold.ttf", 20)

function LabelBig:new(gameobject, text)
    Component.Component.new(self, gameobject)

    self.offset_x = 0
    self.offset_y = 0
    self.text = text
    self.binding = nil
end

function LabelBig:render()
    if self.binding then
        self.text = self.binding()
    end

	love.graphics.setColor(colors[4])
	love.graphics.setFont(ptbold)
    love.graphics.printf(self.text, self.gameobject.x - 200 + self.offset_x, self.gameobject.y + self.offset_y, 400, 'center')
end
