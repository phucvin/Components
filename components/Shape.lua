components.Shape = {}

local S = components.Shape
S.__index = S
S.__id = 'Shape'

function S.new(...)
    local self = setmetatable({}, S)

    self.transform = nil

    self.list = {}

    self:add(...)

    return self
end

function S:refresh()
	self.transform = self.owner.coms:get(components.Transform)
	assert(self.transform ~= nil)
end

local function addRectangle(self, x, y, w, h)
	table.insert(self.list, {kind = 'rectangle', x = x, y = y, w = w, h = h})
end

local function addCircle(self, x, y, r)
	table.insert(self.list, {kind = 'circle', x = x, y = y, r = r})
end

function S:add(kind, ...)
	if kind == 'rectangle' then
		addRectangle(self, ...)
	elseif kind == 'circle' then
		addCircle(self, ...)
	end
end

local function isCollide(at, as, bt, bs)
	if as.kind == 'circle' and bs.kind == 'circle' then
		if math.pow(at.x - bt.x, 2) + math.pow(at.y - bt.y, 2) <= math.pow(as.r + bs.r, 2) then
			return true
		end
	end
end

function S:isCollideWith(other)
	for _, s in pairs(self.list) do
		for _, o in pairs(other.list) do
			if isCollide(self.transform, s, other.transform, o) then return true end
		end
	end
	return false
end