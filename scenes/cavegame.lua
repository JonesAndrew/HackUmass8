local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"
local Player = require "gameobjects/cavegame/player"

local Tankgame = Scene:extend()

function Tankgame:new()
    Scene.new(self)
--battle music?
    play_sound("gameloop_clean.wav", "stream")
    self.lines = {0,135+40}

    self.height = 90

    local x = 0
    local y = 200

    while x < 50000 do
        local dif = 135 + 40 - y

        x = x + love.math.random(50, 100)
        y = y + love.math.random(dif/2 - 40, dif/2 + 40)
        y = math.min(math.max(100, y), 270)

        self.last_x = x
        table.insert(self.lines, x)
        table.insert(self.lines, y)
    end

    self.index = 1
    self.players = {}

    local p = self:add_gameobject(Player(1))
    p.x = 70
    p.y = self:y_from_x(p.x) - 20
    table.insert(self.players, p)

    local p = self:add_gameobject(Player(2))
    p.x = 90
    p.y = self:y_from_x(p.x) - 20
    table.insert(self.players, p)

    local p = self:add_gameobject(Player(3))
    p.x = 110
    p.y = self:y_from_x(p.x) - 20
    table.insert(self.players, p)

    local p = self:add_gameobject(Player(4))
    p.x = 130
    p.y = self:y_from_x(p.x) - 20
    table.insert(self.players, p)

    self.win_count = 0
end

function Tankgame:y_from_x(x)
    if x < 0 then
        return 200
    elseif x > self.last_x then
        return 200
    end

    local x1 = 0
    local y1 = 0
    local x2 = 0
    local y2 = 0


    for i=1,#self.lines/2 do
        x1 = x2
        y1 = y2

        x2 = self.lines[i * 2 - 1]
        y2 = self.lines[i * 2]

        if x2 >= x then
            break
        end
    end

    x = x - x1
    x2 = x2 - x1

    self.win_timer = 0

    return y1 + (y2 - y1) * (x/x2)
end

function Tankgame:update(dt)
    self.height = self.height - dt
    Scene.update(self, dt)

    while self.players[self.index].dead do
        self.index = self.index + 1
        if self.index > 4 then
            break
        end
    end

    local count = 0
    local winner = 0
    for i=1,4 do
        if not self.players[i].dead then
            winner = i
            count = count + 1
        end
    end

    if count == 1 then
        self.players[winner].stop = true
        self.win_timer = self.win_timer + dt
        if self.win_timer > 2 then
            Director.board:win({[winner]=true})
            return true
        end
        return
    elseif count == 0 then
        self.win_timer = self.win_timer + dt
        if self.win_timer > 2 then
            Director.board:win({})
            return true
        end
        return
    end
end

function Tankgame:render()
    love.graphics.push()
    love.graphics.translate(-(self.players[self.index].x - (self.players[self.index].starting_x or 70)), 0)

    love.graphics.setColor(colors[2])
    love.graphics.line(self.lines)

    love.graphics.push()
    love.graphics.translate(0, -self.height)
    love.graphics.line(self.lines)
    love.graphics.pop()

    Scene.render(self)
    love.graphics.pop()
end

return Tankgame
