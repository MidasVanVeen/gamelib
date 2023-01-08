dofile "firework.lua"

GL_WIDTH = 800
GL_HEIGHT = 800

fireworks = {}

--[[
for i = 1, 10 do
	table.insert(fireworks, Firework:new(math.random(0, GL_WIDTH), GL_HEIGHT, {math.random(0, 255), math.random(0, 255), math.random(0, 255)}, math.random(80, 120)/10))
end
]]--

function mousePressed(button, state, x, y)
	if button ~= 0 then return end
	if state ~= 0 then return end
	table.insert(fireworks, Firework:new(x, y, {math.random(100, 255), math.random(100, 255), math.random(100, 255)}, 0))
	table[#fireworks].exploded = true
	table[#fireworks]:explode()
end

function draw()
	GL_Fill(255,255,255)
	GL_Background(0, 0, 0)
	GL_Text(0.05,0.95, "Gelukkig nieuwjaar!")
	GL_Text(0.05,0.9, "Klik om vuurwerk af te steken")
	for i, firework in ipairs(fireworks) do
		firework:update()
		firework:draw()
		if #firework.particles == 0 and firework.exploded == true then
			table.remove(fireworks, i)
			table.insert(fireworks, Firework:new(math.random(0, GL_WIDTH), GL_HEIGHT, {math.random(100, 255), math.random(100, 255), math.random(100, 255)}, math.random(80, 120)/10))
		end
	end
end

