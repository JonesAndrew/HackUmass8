local Scene = Object:extend()

function Scene:new()
    self.gameobjects = {}
end

function Scene:add_gameobject(go)
    table.insert(self.gameobjects, go)
    return go
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
    local i = 1
    while i<=#self.gameobjects do
        if self.gameobjects[i]:update(dt) then
            table.remove(self.gameobjects, i)
        else
            i = i + 1
        end
    end
end

function Scene:render()
    for i=1,#self.gameobjects do
        self.gameobjects[i]:render()
    end
end

return Scene
