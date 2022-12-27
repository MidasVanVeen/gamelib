Particle = {}

-- particle with direction
function Particle:new(x, y, direction, speed, color, life)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.x = x
	o.y = y
	o.direction = direction
	o.speed = speed
	o.color = color
	o.life = life
	return o
end

function Particle:update()
	self.x = self.x + math.cos(self.direction) * self.speed
	self.y = self.y + math.sin(self.direction) * self.speed
	-- apply gravity
	self.speed = self.speed * 0.99
	-- decrease life
	self.life = self.life - 1
end

Firework = {}

function Firework:new(x, y, color, speed)
	local firework = {}
	setmetatable(firework, self)
	self.__index = self

	firework.speed = speed
	firework.x = x
	firework.y = y
	firework.color = color
	firework.particles = {}
	firework.exploded = false

	return firework
end

function Firework:update()
	if not self.exploded then
		self.y = self.y - self.speed
		self.speed = self.speed - 0.1
		if self.speed <= 0.2 then
			self.exploded = true
			self:explode()
		end
	else
		for i, particle in ipairs(self.particles) do
			particle:update()
			if particle.life <= 0 then
				table.remove(self.particles, i)
			end
		end
	end
end

function Firework:draw()
	if not self.exploded then
		GL_Fill(self.color[1], self.color[2], self.color[3])
		GL_Rect(self.x/GL_WIDTH, 1-self.y/GL_WIDTH, 5/GL_WIDTH, 5/GL_HEIGHT, self.color)
	else
		for i, particle in ipairs(self.particles) do
			GL_Fill(particle.color[1], particle.color[2], particle.color[3])
			GL_Rect(particle.x/GL_WIDTH, 1-(particle.y/GL_HEIGHT), 5/GL_WIDTH, 5/GL_HEIGHT)
		end
	end
end

function Firework:explode()
	for i = 1, 100 do
		local particle = Particle:new(self.x, self.y, math.random(0, 360), math.random(1, 5), self.color, math.random(100,200))
		table.insert(self.particles, particle)
	end
end
