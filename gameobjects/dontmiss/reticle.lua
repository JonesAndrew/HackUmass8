local Gameobject = require "Gameobjects/index"

local Speedline = Gameobject.Gameobject:extend()
Gameobject.add("speedline", Speedline)

function Speedline:new(gameobject, text)
    Gameobject.Gameobject.new(self, gameobject)

    self.offset_x = 0
    self.offset_y = 0
    self.text = text
    self.binding = nil
end