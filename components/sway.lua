-- local Component = require "components/index"

-- local Sway = Component.Component:extend()
-- Component.add("sway", Sway)

-- function Sway:new(gameobject, position)
--     Component.Component.new(self, gameobject)

--     self.destination = {(gameobject.x + love.math.random(-48,48)), (gameobject.y + love.math.random(-27,27))}
--     self.moveflag = true;
-- end

-- function Sway:checkpoints(vectora, vectorb)
-- 	return ((math.abs(vectora[1] - vectorb[1]) <= 3) and (math.abs(vectora[1] - vectorb[2]) <= 3))
-- end

-- function Sway:update(dt)
-- 	if (checkpoints({gameobject.x, gameobject.y}, destination)) then
-- 		self.destination = {(gameobject.x + love.math.random(-48,48)), (gameobject.y + love.math.random(-27,27))}
-- 	elseif not (moveflag) then
-- 		return
--     end
-- 	local vector = {gameobject.x - destination[1], gameobject.y - destination[2]}
-- 	gameobject.vel_x += -vector[2] * dt --inverted vector
-- 	gameobject.vel_y += vector[1] * dt
-- 	local perp = {-vector[2], vector[1]}
-- 	gameobject.vel_x = gameobject.vel_x + perp[1] * dt
-- 	gameobject.vel_y = gameobject.vel_y + perp[2] * dt
-- 	return
-- end



