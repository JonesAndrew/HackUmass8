local Scene = require "scenes/scene"
local Gameobject = require "gameobjects/index"
local Component = require "components/index"
local Input = require "generic_input"

local Board = Scene:extend()

local footrace = {
    "Footrace", 
    "A quick hand and sharp eyes will often be your best defense against the capitalists.", 
    "In this humble footrace, you must beat your comrades in a test of wit and agility. Mash the button presented on the screen as fast as possible in order to progress. But beware! Pressing the wrong button will make you regress- much like your generation upon the discovery of western rock music.", 
    "Press the related button on the screen!",
    'footrace'
}

local dontmiss = {
    "Don't Miss", 
    "The mark of a true spy is the ability to seize the moment in an uncertain situation!", 
    "In this challenge, you will be split into teams. One of you will be tasked with maneuvering a reticle to shoot a target. The other one will be attempting to line up the target with your team's reticle! But beware! Both the target and the reticle have a random sway to them. It is impossible to line up a perfect shot! You must make the most of what you are given!", 
    "Use the A button to fire, and use your control stick to adjust!",
    'dontmiss'
}

local fortnite = {
    "Cage Match", 
    "It is a dog eat dog world, comrade.",
    "In this bout, you and your comrades must battle until only one of you is left standing! Navigate the ever shrinking environment, and use any means possible to secure victory. But beware! You all may charge up; this builds up momentum, allowing you to boost forward in a direction you set! Anyone in your way will be knocked aside. May the craftiest comrade win!",
    "Use your control stick to steer, and the hold the A button to charge!",
    'fortnite'
}

local tank = {
    "Math 101", 
    "One man can only do so much. Patience communication with one's partner is the key to success on missions!",
    "In this simulation, you and your partner are tasked with bombarding the enemy tank. One of you will control the angle of the turret, while the other one of you will control the strength of your shot. But beware! It is only through teamwork and synchronization can you hope to survive!",
    "Use the control stick to adjust your angle, and hold A to gauge your shot!",
    'tankgame'
}

local firesquad = {
    "Firing Squad", 
    'There are times when an agent is comprised and the mission is lost- Americans call this "whack".',
    "In this simulation, an agent (the runner) must avoid his teammate's (the gunner) fire. If a runner is shot and killed, the mission is lost. However, if the gunner fails to extinguish their supply of bullets before time runs out, the mission is also lost. But beware! One single connected hit, and you will be, as the capitalists say, toast.",
    "Runners use the control stick to move, and gunners use A to fire.",
    'firesquad'
}

local cave = {
    "The Cave",
    'Plato, the decorated socialist philosopher, once spoke of humanity living in a "cave"',
    "Your exercise today, comrades, is to escape the cave. But beware! Much like the sins of material western society, a single touch from the walls will end your philosophical journey! Make sure not to touch them!",
    "Press A to move up",
    'cavegame'
}

local valkyrie = {
    "Flight of the Valkyries",
    "Escape is the most important part of an agent's mission!",
    "In this exercise, you are pairs of pilots. One pair of pilots, in smaller planes, must escape their pursuers for 30 seconds. The pursuers must eliminate the targets within the time limit. But beware! The pursuers are armed with cannons!",
    "Use the control stick to steer the plane! Pursuers, use A to fire your cannon!",
    'spyplane'
}
function Board:new()
    Scene.new(self)
    self.piecies = {}
    self.targets = {0, 0, 0, 0}
    self.games = {footrace, dontmiss, fortnite, tank, firesquad, cave, valkyrie}

    local go = Gameobject.get("basic")()
    go:add_component(Component.get('circle')(go, 8, 3))
    self:add_gameobject(go)
    go.x = 95
    go.y = 100
    table.insert(self.piecies, go)

    go = Gameobject.get("basic")()
    go:add_component(Component.get('circle')(go, 8, 4))
    self:add_gameobject(go)
    go.x = 95
    go.y = 130
    table.insert(self.piecies, go)

    go = Gameobject.get("basic")()
    go:add_component(Component.get('circle')(go, 8, 5))
    self:add_gameobject(go)
    go.x = 95
    go.y = 160
    table.insert(self.piecies, go)

    go = Gameobject.get("basic")()
    go:add_component(Component.get('circle')(go, 8, 6))
    self:add_gameobject(go)
    go.x = 95
    go.y = 190
    table.insert(self.piecies, go)
end

function Board:win(winner)
    for i=1,4 do
        if winner[i] then
            self.targets[i] = self.targets[i] + 3
        else
            self.targets[i] = self.targets[i] + 1
        end
    end
end

function Board:update(dt)
    Scene.update(self, dt)
    Input.update()

    local fail = false
    for i=1,4 do
        if self.piecies[i].x < 95 + math.min(self.targets[i], 9) * 30 then
            fail = true
            self.piecies[i].x = math.min(95 + self.targets[i] * 30, self.piecies[i].x + 60 * dt)
        end
    end

    if not fail then
        local winners = {}
        local won = false
        for i=1,4 do
            if self.targets[i] >= 9 then
                winners[i] = true
                won = true
            end
        end

        if won then
            play_sound("soviet-anthem.mp3", "stream")
            Director:next_scene(require "scenes/winscreen"(winners))
            return true
        end

        if Input.pressed("a") or Input.pressed("b") or Input.pressed("x") or Input.pressed("y") then
            Director.board = self

            local v = love.math.random(#self.games)
            while v == self.last_index do
                v = love.math.random(#self.games)
            end
            local info = self.games[love.math.random(v)]
            self.last_index = v
            Director:next_scene(require ("scenes/directions")(info[1], info[2], info[3], info[4], info[5]))
            return true
        end
    end
end

function Board:render()
    love.graphics.setColor(colors[3])
    Scene.render(self)

    for i=0,2 do
        love.graphics.line(80, 115 + 30 * i, 380, 115 + 30 * i)
    end

    for i=0,8 do
        love.graphics.line(110 + 30 * i, 90, 110 + 30 * i, 200)
    end
end

return Board