components.Transform = {}

local T = components.Transform
T.__index = T
T.__id = 'Transform'

function T.new(x, y, rotation, scaleX, scaleY)
    assert(type(x) == 'number' or x == nil)
    assert(type(y) == 'number' or y == nil)
    assert(type(rotation) == 'number' or rotation == nil)
    assert(type(scaleX) == 'number' or scaleX == nil)
    assert(type(scaleY) == 'number' or scaleY == nil)

    local self = setmetatable({}, T)

    self.x, self.y, self.rotation, self.scaleX, self.scaleY = 
    x or 0, y or 0, rotation or 0, scaleX or 1, scaleY or 1

    return self
end