local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"
local RacePlayer = require "gameobjects/footrace/race_player"

local Footrace = Scene:extend()

function Footrace:new()
    Scene.new(self)

    self.countdown = love.math.random() + 2.5

    local go = RacePlayer(1)
    self:add_gameobject(go)
    go.x = 100
    go.y = 100

    go = RacePlayer(2)
    self:add_gameobject(go)
    go.x = 100
    go.y = 140

    go = RacePlayer(3)
    self:add_gameobject(go)
    go.x = 100
    go.y = 180

    go = RacePlayer(4)
    self:add_gameobject(go)
    go.x = 100
    go.y = 220

    local title = Gameobject.get('basic')()
    self.button_label = title:add_component(Component.get('labelbig')(title, 'a'))
    title.x = 240
    self:add_gameobject(title)

    self:random_button()
end

function Footrace:random_button()
   local buttons = {'a', 'b', 'x', 'y', 'STOP'}
   self.button = buttons[love.math.random(5)]
   self.button_label.text = string.upper(self.button)
end

function Footrace:update(dt)
    Scene.update(self, dt)

    self.countdown = self.countdown - dt
    if self.countdown < 0 then
        self.countdown = love.math.random()*2 + 1.5
        self:random_button()
    end
end

return Footrace