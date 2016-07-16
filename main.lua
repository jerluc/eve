local Conway = require('conway')
local Langton = require('langton')

local universe = Langton

local paused = false

local function resetUniverse()
    universe.birth(300, 300)
end

function love.load()
    love.mouse.setVisible(false)
    resetUniverse()
end

function love.keypressed(key)
    if key == 'l' then
        universe = Langton
        resetUniverse()
    elseif key == 'c' then
        universe = Conway
        resetUniverse()
    elseif key == 'return' then
        resetUniverse()
    elseif key == 'space' then
        paused = not paused
    elseif key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    if not paused then
        universe.progress()
    end
end

function love.draw()
    love.graphics.push()
    love.graphics.setPointSize(3)
    love.graphics.scale(3, 3)
    love.graphics.points(universe.state)
    love.graphics.pop()
end
