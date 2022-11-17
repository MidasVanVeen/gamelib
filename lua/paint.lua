GL_WIDTH = 800
GL_HEIGHT = 800

curves = {{}}
lines = {{}}
tool="freehand"

mousex=0
mousey=0
mousestate=0

function bezierPressed(button, state, mx, my)
	if state == 0 then
		return
	end
	if #curves[#curves] == 4 then
		curves[#curves+1] = {}
	end
	table.insert(curves[#curves], {mx/GL_WIDTH, 1-my/GL_HEIGHT})
end

function linePressed(button, state, mx, my)
	if state == 0 then
		return
	end
	if #lines[#lines] == 2 then
		lines[#lines+1] = {}
	end
	table.insert(lines[#lines], {mx/GL_WIDTH, 1-my/GL_HEIGHT})
end

function mousePressed(button, state, mx, my)
	mousestate = state
	mousex=mx/GL_WIDTH
	mousey=1-my/GL_HEIGHT
	if tool == "bezier" then
		bezierPressed(button, state, mx, my)
	elseif tool == "line" then
		linePressed(button, state, mx, my)
	elseif tool == "freehand" then
		if #lines[#lines] == 1 and state == 1 then
			lines[#lines] = {}
		end
	end
end

function mouseMoved(mx, my)
	mousex=mx/GL_WIDTH
	mousey=1-my/GL_HEIGHT

	if mousestate == 0 then
		if tool == "freehand" then
			if #lines[#lines] == 2 then
				lines[#lines+1] = {}
			end
			table.insert(lines[#lines], {mx/GL_WIDTH, 1-my/GL_HEIGHT})
		end
	end
end

function keyboardPressed(key, state)
	if key == 99 and state == 1 then
		curves = {{}}
		lines = {{}}
	elseif key == 98 and state == 1 then
		tool = "bezier"
	elseif key == 108 and state == 1 then
		tool = "line"
	elseif key == 102 and state == 1 then
		tool = "freehand"
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
	for i=1,#lines do
		if #lines[i] == 1 then
			GL_Fill(0,0,0)
			GL_Line(lines[i][1][1], lines[i][1][2], mousex, mousey)
		end
		if #lines[i] == 2 then
			GL_Fill(0,0,0)
			GL_Line(lines[i][1][1], lines[i][1][2], lines[i][2][1], lines[i][2][2])
		end
	end
end
