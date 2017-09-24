components.ShapeRenderer = {}

local SR = components.ShapeRenderer
SR.__index = SR
SR.__id = 'ShapeRenderer'

function SR.new(kind, lineWidth, fillStyle)
	local self = setmetatable({}, SR)

	self.transform = nil
	self.shape = nil
	self.color = nil --optional

	self.kind, self.lineWidth, self.fillStyle = kind or 'line', lineWidth or 1, fillStyle or 'soild'

	return self
end

function SR:refresh()
	self.transform = self.owner.coms:get(components.Transform)
	assert(self.transform ~= nil)
	self.shape = self.owner.coms:get(components.Shape)
	assert(self.shape ~= nil)

	--optional
	if components.Color then
		self.color = self.owner.coms:get(components.Color)
	end

	self.owner.coms:registerSubDraw(self.draw, SR.__id, true, self)
end

function SR:draw()
	local transform = self.transform
	local list = self.shape.list
	g.push()
	g.translate(transform.x, transform.y)
	if self.color then
		g.setColor(self.color:getRGBA())
	else
		g.setColor(255, 255, 255, 255)
	end
	g.setLineWidth(self.lineWidth)
	for _, s in pairs(list) do
		if s.kind == 'rectangle' then
			g.rectangle(self.kind, s.x, s.y, s.w, s.h)
		elseif s.kind == 'circle' then
			g.circle(self.kind, s.x, s.y, s.r)
		end
	end
	g.pop()
end