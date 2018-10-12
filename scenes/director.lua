local Director = Object:extend()

function Director:new()
    self.current = nil
    self.next = nil
end

function Director:start_with_scene(scene)
    self.current = scene
    self.current:enter()
end

function Director:next_scene(scene)
    self.next = scene
end

function Director:update(dt)
    if self.current:update(dt) then
        if self.next == nil then
            return true
        end

        self.current = self.next
        self.next = nil
        self.current:enter()
    end
end

function Director:render()
    self.current:render()
end

local dir = Director()
return dir
