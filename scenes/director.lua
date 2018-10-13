local Director = Object:extend()
-- colors = {
--     {30, 0, 0},
--     {158, 0, 0},
--     {247, 142/255, 80},
--     {206, 247, 247}
-- }

colors = {
    {8, 24, 32},
    {52, 104, 86},
    {136, 192, 112},
    {224, 248, 208}
}

for _, c in ipairs(colors) do
    c[1] = c[1]/255
    c[2] = c[2]/255
    c[3] = c[3]/255
end

function Director:new()
    self.current = nil
    self.next = nil
    self.s = 0
end

function Director:start_with_scene(scene)
    self.current = scene
    self.current:enter()
end

function Director:next_scene(scene)
    self.next = scene
end

function Director:shake(s)
    self.s = math.max(s, self.s)
end

function Director:update(dt)
    self.s = self.s - 4*dt

    if self.current:update(dt) then
        if self.next == nil then
            self.next = self.board
            self.board = nil
            if self.next == nil then
                return true
            end
        end

        self.current = self.next
        self.next = nil
        self.current:enter()
    end
end

function Director:render()
    if self.s > 0 then
        love.graphics.push()
        local dir = love.math.random() * math.pi * 4
        love.graphics.translate(math.cos(dir) * self.s, math.sin(dir) * self.s)
    end

    self.current:render()

    if self.s > 0 then
        love.graphics.pop()
    end
end

local dir = Director()
return dir
