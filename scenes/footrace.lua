local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"
local RacePlayer = require "gameobjects/footrace/race_player"

local Footrace = Scene:extend()

function Footrace:new()
    Scene.new(self)
    play_sound("gameloop_clean.wav", "stream")
    self.players = {}

    self.countdown = love.math.random() + 2.5

    local go = RacePlayer(1)
    self:add_gameobject(go)
    go.x = 100
    go.y = 100
    table.insert(self.players, go)

    go = RacePlayer(2)
    self:add_gameobject(go)
    go.x = 100
    go.y = 140
    table.insert(self.players, go)

    go = RacePlayer(3)
    self:add_gameobject(go)
    go.x = 100
    go.y = 180
    table.insert(self.players, go)

    go = RacePlayer(4)
    self:add_gameobject(go)
    go.x = 100
    go.y = 220
    table.insert(self.players, go)

    local title = Gameobject.get('basic')()
    self.button_label = title:add_component(Component.get('labeldisplay')(title, 'a'))
    title.x = 240
	title.y = 20
    self:add_gameobject(title)

    self:random_button()
    self.win_timer = 0
end

function Footrace:random_button()
   local buttons = {'a', 'b', 'x', 'y', 'STOP'}
   self.button = buttons[love.math.random(5)]
   self.button_label:updateText(self.button)
end

function Footrace:update(dt)
    Scene.update(self, dt)

    self.countdown = self.countdown - dt
    if self.countdown < 0 then
        self.countdown = love.math.random()*2 + 1.5
        self:random_button()
    end

    local winner = nil
    for i,p in ipairs(self.players) do
        if 460 - self.players[i].x <= 8 then
            winner = i
            break
        end
    end

    if winner then
        for i,p in ipairs(self.players) do
            p.stop = true
        end
        self.win_timer = self.win_timer + dt
        self.countdown = 10
        self.button_label:updateText("Winner")
        if self.win_timer > 3 then
            Director.board:win({[winner]=true})
            return true
        end
    end
end

function Footrace:render()
    Scene.render(self)

    love.graphics.setColor(colors[3])
    love.graphics.line(460, 60, 460, 250)
end

return Footrace