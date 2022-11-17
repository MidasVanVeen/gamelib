GL_WIDTH = 800
GL_HEIGHT = 800

local x, y = 0.5, 0.5
local alpha = 0
local radius = 0.0

local turnspeed = 0.05

function mouseMoved(mx, my)
	x = mx/GL_WIDTH
	y = 1 - my/GL_HEIGHT
end

mousePressed = function (x,y) end

function draw()
	alpha = alpha + turnspeed
	-- radius = radius + 0.01
	local nx = x + math.cos(alpha) * radius
	local ny = y + math.sin(alpha) * radius
	GL_Background(60,130,220)
	GL_Fill(255,255,0)
	GL_Ellipse(nx,ny, 0.05, 0.05, 32)
	GL_Fill(50,140,40)
	GL_Rect(0,0,1,0.2)
	GL_Fill(0,0,255)
	GL_Triangle(0,0,0.1,0,0,0.1)
end
