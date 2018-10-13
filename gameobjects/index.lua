local gameobjects = {}

local function add_gameobject(name, go)
    gameobjects[name] = go
    go.type = name
end

local function gameobject(name)
    return gameobjects[name]
end

local Gameobject = Object:extend()

function Gameobject:new()
    self.components = {}
    self.x = 0
    self.y = 0
    self.del_x = 0
    self.del_y = 0
end

function Gameobject:update(dt)
    for _, comp in ipairs(self.components) do
        comp:update(dt)
    end
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
    local x,y = self.x,self.y
    self.x = math.floor(x + 0.5)
    self.y = math.floor(y + 0.5)
    for _, comp in ipairs(self.components) do
        comp:render()
    end
    self.x,self.y = x,y
end

gameobjects["basic"] = Gameobject

return {
    add = add_gameobject, 
    get = gameobject, 
    Gameobject = Gameobject
}