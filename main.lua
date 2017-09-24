--
require 'flatmoon.engine'
--require 'flatmoon.director'
require 'flatmoon.tweener'

--make some usually stuff global
Thing = flatmoon.engine.Thing
yield = flatmoon.engine.yield
wait = flatmoon.engine.wait
listener = flatmoon.listener
stween = flatmoon.tweener.stween
ptween = flatmoon.tweener.ptween
--director = flatmoon.director

--
require 'components.init'
require 'components.Transform'
require 'components.Color'
require 'components.Shape'
require 'components.ImageRenderer'
require 'components.ShapeRenderer'
require 'components.StickMouse'
require 'components.Health'
require 'components.Damage'

Transform = components.Transform
Color = components.Color
Shape = components.Shape
ImageRenderer = components.ImageRenderer
ShapeRenderer = components.ShapeRenderer
StickMouse = components.StickMouse
Health = components.Health
Damage = components.Damage

--game's first function
function gmain()
	local bg = Thing.new({'background'})
	bg.image = love.graphics.newImage('content/background.png')
	bg.draw = function (self)
		g.setColor(255, 255, 255)
		g.draw(self.image, 0, 0)
	end

	local puck = Thing.new({'puck'})
	puck.coms:add(Transform.new(200, 400))
	puck.coms:add(Color.new(100, 255, 100, 200))
	puck.coms:add(Shape.new('circle', 0, 0, 50))
	puck.coms:add(ImageRenderer.new(love.graphics.newImage('content/puck.png'), 0, 0))
	puck.coms:get(ImageRenderer):centerOrigin()
	puck.coms:add(ShapeRenderer.new('fill'))
	puck.coms:add(StickMouse.new())
	puck.coms:refresh()
	listener.add('mousepressed', '', function ()
		local bullet = Thing.new({'bullet'})
		local pt = puck.coms:get(Transform)
		bullet.coms:add(Transform.new(pt.x, pt.y))
		bullet.coms:add(Shape.new('circle', 0, 0, 10))
		bullet.coms:add(Color.new(0, 255, 0, 255))
		bullet.coms:add(ShapeRenderer.new('fill'))
		bullet.coms:add(Damage.new('enemy', 10, 10, true))
		bullet.coms:refresh()
		ptween(bullet.coms:get(Transform), 1, {x = 960/2, y = 640/2}, nil, nil, nil, 
			function () bullet:destroy() end)
	end)

	for i = 1, 10, 1 do
		local enemy = Thing.new({'enemy'})
		enemy.coms:add(Transform.new(math.random(0, 960), math.random(0, 640)))
		enemy.coms:add(Color.new(255, 0, 0, 200))
		enemy.coms:add(Shape.new('circle', 0, 0, 30))
		enemy.coms:add(ShapeRenderer.new('fill'))
		enemy.coms:add(Health.new(30, 30))
		enemy.coms:refresh()
		enemy.always = function (self)
			if self.coms:get(Health).current <= 0 then self:destroy() end
		end
	end
end