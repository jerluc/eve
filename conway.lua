local Conway = {
    size = {0, 0},
    state = {}
}

local alive = {255, 255, 255}
local dying = {150, 50, 50}
local dead = {0, 0, 0}

function Conway.birth(w, h)
    math.randomseed(os.time())
    Conway.size = {w, h}
    Conway.state = {}
    for y = 1, h do
        for x = 1, w do
            local state = (math.random(0, 1) == 0) and dead or alive
            table.insert(Conway.state, {x, y, state[1], state[2], state[3]})
        end
    end
end

function Conway.get(x, y)
    local index = (y - 1) * Conway.size[2] + x
    local instance = Conway.state[index]
    if instance == nil then
        return dead
    end
    return {instance[3], instance[4], instance[5]}
end

function Conway.set(x, y, state)
    local index = (y - 1) * Conway.size[2] + x
    Conway.state[index] = {x, y, state[1], state[2], state[3]}
end

function Conway.above(x, y)
    return Conway.get(x, y - 1)
end

function Conway.below(x, y)
    return Conway.get(x, y + 1)
end

function Conway.left(x, y)
    return Conway.get(x - 1, y)
end

function Conway.right(x, y)
    return Conway.get(x + 1, y)
end

function Conway.aboveLeft(x, y)
    return Conway.get(x - 1, y - 1)
end

function Conway.aboveRight(x, y)
    return Conway.get(x + 1, y - 1)
end

function Conway.belowLeft(x, y)
    return Conway.get(x - 1, y + 1)
end

function Conway.belowRight(x, y)
    return Conway.get(x + 1, y + 1)
end

local function isAlive(state)
    return state[3] == 255
end

local function isDead(state)
    return state[3] == 0
end

function Conway.aliveCount(x, y)
    local count = 0
    count = count + (isAlive(Conway.left(x, y)) and 1 or 0)
    count = count + (isAlive(Conway.right(x, y)) and 1 or 0)
    count = count + (isAlive(Conway.above(x, y)) and 1 or 0)
    count = count + (isAlive(Conway.below(x, y)) and 1 or 0)
    count = count + (isAlive(Conway.aboveLeft(x, y)) and 1 or 0)
    count = count + (isAlive(Conway.aboveRight(x, y)) and 1 or 0)
    count = count + (isAlive(Conway.belowLeft(x, y)) and 1 or 0)
    count = count + (isAlive(Conway.belowRight(x, y)) and 1 or 0)
    return count
end

function Conway.progressInstance(x, y)
    local instance = Conway.get(x, y)
    local nextState = instance
    local livingNeighbors = Conway.aliveCount(x, y)

    -- The rules followed by all life herein
    if isAlive(instance) and livingNeighbors < 2 then
        nextState = dying
    elseif isAlive(instance) and livingNeighbors > 3 then
        nextState = dying
    elseif not isDead(instance) and not isAlive(instance) then
        nextState = dead
    elseif isDead(instance) and livingNeighbors == 3 then
        nextState = alive
    end

    return nextState
end

function Conway.progress()
    for x = 1, Conway.size[1] do
        for y = 1, Conway.size[2] do
            Conway.set(x, y, Conway.progressInstance(x, y))
        end
    end
end

return Conway
