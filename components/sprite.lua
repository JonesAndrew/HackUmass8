local Component = require "components/index"

local Sprite = Component.Component:extend()
Component.add("sprite", Sprite)

local imgs = {}
function load_img(filename)
    local img = imgs[filename]

    if not img then
        img = love.graphics.newImage("imgs/"..filename)
        imgs[filename] = img
    end
    return img
end

function Sprite:new(gameobject, filename, width, height)
    Component.Component.new(self, gameobject)

    self.img = load_img(filename)
    self.width = width
    self.height = height

    self.frames_per_row = self.img:getPixelWidth() / width
    self.frame = 0
end

function Sprite:render()
    if self.frame < 0 then
        return
    end

    quad = love.graphics.newQuad(
        self.width * self.frame % frames_per_row,
        self.height * self.frame % frames_per_row,
        self.width,
        self.height,
        img:getDimensions()
    )
    love.graphics.draw(self.img, quad, self.gameobject.x, self.gameobject.y, 0, 1, 1, -self.width/2, -self.height/2)
    quad:release()
end