local comps = {}

local function add_component(name, comp)
    print(name)
    comps[name] = comp
    comp.type = name
end

local function component(name)
    print("load "..name)
    return comps[name]
end

local Component = Object:extend()

function Component:new(gameobject)
    self.gameobject = gameobject
end

function Component:update(dt)
end

function Component:render()
end

return {add = add_component, get = component, Component = Component}