components.Damage = {}

local D = components.Damage
D.__index = D
D.__id = 'Damage'

function D.new(destTag, min, max, autoDestroy)
    local self = setmetatable({}, D)

    self.transform = nil
    self.shape = nil

    self.destTag = destTag or 'default'
    self.min, self.max, self.autoDestroy = min or 0, max or 0, autoDestroy or false

    self.prev = {}

    return self
end

function D:refresh()
	self.transform = self.owner.coms:get(components.Transform)
	assert(self.transform ~= nil)
	self.shape = self.owner.coms:get(components.Shape)
	assert(self.shape ~= nil)
end

function D:always()
	local all = flatmoon.engine.Thing.getAll(self.destTag)
	local haveOne = false
	for _, o in pairs(all) do
		local h = o.coms:get(components.Health)
		local s = o.coms:get(components.Shape)
		local ic = self.shape:isCollideWith(s)
		if h and s and ic and not self.prev[h] then
			haveOne = true
			self.prev[h] = true
			h.current = h.current - math.random(self.min, self.max)
		end
		if h and s and not ic then
			self.prev[h] = nil
		end
	end

	if self.autoDestroy and haveOne then self.owner:destroy() end
end