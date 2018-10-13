local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"
local Tank = require "gameobjects/tankgame/tank"

local Tankgame = Scene:extend()

function Tankgame:new()
    Scene.new(self)

    self.lines = {0,200}

    local x = 0
    local y = 200

    while x < 420 do
        local dif = 135 - y

        x = x + love.math.random(20, 60)
        y = y + love.math.random(dif/2 - 50, dif/2 + 50)
        y = math.min(math.max(40, y), 230)

        table.insert(self.lines, x)
        table.insert(self.lines, y)
    end

    table.insert(self.lines, 480)
    table.insert(self.lines, 200)

    local go = self:add_gameobject(Tank(1, 2))
    go.x = love.math.random(10, 80)
    go.y = self:y_from_x(go.x) - 2

    local go2 = self:add_gameobject(Tank(3, 4))
    go2.x = love.math.random(400, 470)
    go2.y = self:y_from_x(go2.x) - 2

    go.target = go2
    go2.target = go
end

function Tankgame:y_from_x(x)
    if x < 0 then
        return 200
    elseif x > 480 then
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

    return y1 + (y2 - y1) * (x/x2)
end

function Tankgame:update(dt)
    Scene.update(self, dt)
end

function Tankgame:render()
    love.graphics.setColor(colors[2])
    love.graphics.line(self.lines)

    Scene.render(self)
end

return Tankgame
