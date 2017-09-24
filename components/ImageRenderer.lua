components.ImageRenderer = {}

local IR = components.ImageRenderer
IR.__index = IR
IR.__id = 'ImageRenderer'

function IR.new(image, originX, originY)
	local self = setmetatable({}, IR)

	self.transform = nil
	self.color = nil --optional

	self.image, self.originX, self.originY = image, originX or 0, originY or 0

	return self
end

function IR:refresh()
	self.transform = self.owner.coms:get(components.Transform)
	assert(self.transform ~= nil)

	--optional
	if components.Color then
		self.color = self.owner.coms:get(components.Color)
	end

	self.owner.coms:registerSubDraw(self.draw, IR.__id, true, self)
end

function IR:centerOrigin()
	self.originX = self.image:getWidth() / 2
	self.originY = self.image:getHeight() / 2
end

function IR:draw()
	local transform = self.transform
	g.push()
	g.translate(transform.x, transform.y)
	if self.color then
		g.setColor(self.color:getRGBA())
	else
		g.setColor(255, 255, 255, 255)
	end
	g.draw(self.image, -self.originX, -self.originY)
	g.pop()
end