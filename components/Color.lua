components.Color = {}

local C = components.Color
C.__index = C
C.__id = 'Color'

function C.new(r, g, b, a)
    assert(type(r) == 'number' or r == nil)
    assert(type(g) == 'number' or g == nil)
    assert(type(b) == 'number' or b == nil)
    assert(type(a) == 'number' or a == nil)

    local self = setmetatable({}, C)

    self.r, self.g, self.b, self.a =
    r or 0, g or 0, b or 0, a or 255

    return self
end

function C:getRGBA()
	return self.r, self.g, self.b, self.a
end