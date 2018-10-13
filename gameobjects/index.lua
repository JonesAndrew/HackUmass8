local gos = {}

local function add(name, go)
    gos[name] = go
    print 'add'
    for k,v in pairs(gos) do
        print(k, v)
    end
    go.type = name
end

local function get(name)
    for k,v in pairs(gos) do
        print(k, v)
    end
    return gos[name]
end

local Gameobject = Object:extend()

function Gameobject:new()
    self.components = {}
    self.x = 0
    self.y = 0
    self.vel_x = 0
    self.vel_y = 0
end

function Gameobject:update(dt)
    for _, comp in ipairs(self.components) do
        comp:update(dt)
    end
    self.x = self.x + self.vel_x * dt
    self.y = self.y + self.vel_y * dt
end

function Gameobject:add_component(comp)
    table.insert(self.components, comp)
    return comp
end

function Gameobject:get_component(comp_type)
    for _, comp in ipairs(self.components) do
        if comp.type == comp_type then
            return comp
        end
    end
end

function Gameobject:render()
    if self.color then
        love.graphics.push()
        local c = colors[self.color]
        love.graphics.setColor(c[1], c[2], c[3])
    end

    local x,y = self.x,self.y
    self.x = math.floor(x + 0.5)
    self.y = math.floor(y + 0.5)
    for _, comp in ipairs(self.components) do
        comp:render()
    end
    self.x,self.y = x,y

    if self.color then
        love.graphics.pop()
    end
end

gos["basic"] = Gameobject

return {
    add = add, 
    get = get, 
    Gameobject = Gameobject
}