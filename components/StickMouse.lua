components.StickMouse = {}

local SM = components.StickMouse
SM.__index = SM
SM.__id = 'StickMouse'

function SM.new()
    local self = setmetatable({}, SM)

    return self
end

function SM:refresh()
	self.transform = self.owner.coms:get(components.Transform)
	assert(self.transform ~= nil)
end

function SM:always()
	self.transform.x, self.transform.y = love.mouse.getPosition()
end