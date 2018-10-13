require "require"
Object = require "classic"

require.tree("components")
require.tree("gameobjects")

Director = require "scenes/director"
Basic = require "scenes/basic_scene"

local main_canvas

function resize(s)
    love.window.setMode(s*gw, s*gh) 
    sx, sy = s, s
end

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.graphics.setLineStyle('rough')

    resize(2)

    Director:start_with_scene(require "scenes/footrace"())

    main_canvas = love.graphics.newCanvas(gw, gh)
end

function love.update(dt)
    if Director:update(dt) then
        love.event.quit()
    end
end

function love.draw()
    love.graphics.setCanvas(main_canvas)
    love.graphics.clear()

    Director:render()

    love.graphics.setCanvas()

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setBlendMode('alpha', 'premultiplied')
    love.graphics.draw(main_canvas, 0, 0, 0, sx, sy)
    love.graphics.setBlendMode('alpha')
end