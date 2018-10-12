local Scene = Object:extend()

function Scene:new()
    self.gameobjects = {}
end

function Scene:add_gameobject(go)
    table.insert(self.gameobjects, go)
end

function Scene:exit()
end

function Scene:enter()
end

function Scene:remove_gameobject(go)
    for i=1,#self.gameobjects do
        if (self.gameobjects[i] == go) then
            table.remove(self.gameobjects, i)
            return
        end
    end
end

function Scene:update(dt)
    for i=1,#self.gameobjects do
        self.gameobjects[i]:update(dt)
    end
end

function Scene:render()
    for i=1,#self.gameobjects do
        self.gameobjects[i]:render()
    end
end

return Scene
