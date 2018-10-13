-- local Gameobject = require "Gameobjects/index"

-- local Reticle = Gameobject.Gameobject:extend()
-- Gameobject.add("reticle", Reticle)

-- function Reticle:new(gameobject, text)
--     Gameobject.Gameobject.new(self, gameobject)

--     self.input = baton.new {
--       controls = {
--         left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
--         right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
--         up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
--         down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
--         a = {'key:z', 'button:a'},
--         b = {'key:x', 'button:a'},
--         c = {'key:c', 'button:a'},
--         d = {'key:v', 'button:a'},
--       },
--       pairs = {
--         move = {'left', 'right', 'up', 'down'}
--       },
--       joystick = love.joystick.getJoysticks()[index],
--     }

--     self.inner = self:add_component(Component.get('circle')(self, 12))
--     self.outer = self:add_component(Component.get('circle')(self, 48))
-- end

-- function Reticle:fire(gameobject)