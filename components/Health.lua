components.Health = {}

local H = components.Health
H.__index = H
H.__id = 'Health'

function H.new(max, current)
    local self = setmetatable({}, H)

    self.max, self.current = max, current

    return self
end