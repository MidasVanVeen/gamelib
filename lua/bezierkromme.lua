GL_WIDTH = 800
GL_HEIGHT = 800

curves = {{}}

mousePressed = function(button, state, mx, my)
	if state == 0 then
		return
	end
	if #curves[#curves] == 4 then
		curves[#curves+1] = {}
	end
	table.insert(curves[#curves], {mx/GL_WIDTH, 1-my/GL_HEIGHT})
end

keyboardPressed = function(key, state)
	if key == 99 and state == 1 then
		curves = {{}}
	end
end

function draw()
	GL_Background(255,255,255)
	for i=1,#curves do
		if #curves[i] >= 2 then
			GL_Fill(255,0,0)
			GL_Line(curves[i][1][1], curves[i][1][2], curves[i][2][1], curves[i][2][2])
		end
		if #curves[i] == 4 then
			GL_Line(curves[i][3][1], curves[i][3][2], curves[i][4][1], curves[i][4][2])
			GL_Fill(0,0,0)
			GL_Bezier(curves[i][1][1], curves[i][1][2], curves[i][2][1], curves[i][2][2], curves[i][3][1], curves[i][3][2], curves[i][4][1], curves[i][4][2], 32)
		end
	end
end
