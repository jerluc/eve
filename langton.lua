local Langton = {
    ant = {
        position = {},
        direction = 1
    },
    size = {0, 0},
    state = {}
}

local directions = {'up', 'right', 'down', 'left'}
local on = {255, 255, 255}
local off = {0, 0, 0}

local function isOn(state)
    return state[1] == on[1]
end

local function isOff(state)
    return state[1] == off[1]
end

function Langton.birth(w, h)
    Langton.size = {w, h}
    Langton.ant.position = {math.floor(w / 2), math.floor(h / 2)}
    Langton.state = {}
    for y = 1, h do
        for x = 1, w do
            table.insert(Langton.state, {x, y, off[1], off[2], off[3]})
        end
    end
end

function Langton.get(x, y)
    local index = (y - 1) * Langton.size[2] + x
    local instance = Langton.state[index]
    if instance == nil then
        return nil
    end
    return {instance[3], instance[4], instance[5]}
end

function Langton.set(x, y, state)
    local index = (y - 1) * Langton.size[2] + x
    Langton.state[index] = {x, y, state[1], state[2], state[3]}
end

function Langton.turnRight()
    local newDirection = Langton.ant.direction + 1
    if newDirection == #directions + 1 then
        newDirection = 1
    end
    Langton.ant.direction = newDirection
end

function Langton.turnLeft()
    local newDirection = Langton.ant.direction - 1
    if newDirection == 0 then
        newDirection = #directions
    end
    Langton.ant.direction = newDirection
end

function Langton.moveForward(x, y)
    local direction = directions[Langton.ant.direction]
    if direction == 'up' then
        Langton.ant.position[2] = y - 1
    elseif direction == 'down' then
        Langton.ant.position[2] = y + 1
    elseif direction == 'left' then
        Langton.ant.position[1] = x - 1
    elseif direction == 'right' then
        Langton.ant.position[1] = x + 1
    end
end

function Langton.progress()
    local x, y = Langton.ant.position[1], Langton.ant.position[2]
    local current = Langton.get(x, y)

    if current == nil then
        return
    end

    if isOn(current) then
        Langton.turnRight()
        Langton.set(x, y, off)
    else
        Langton.turnLeft()
        Langton.set(x, y, on)
    end
    Langton.moveForward(x, y)
end

return Langton
