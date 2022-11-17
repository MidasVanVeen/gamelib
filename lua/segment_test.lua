--[[
-- Filename: main.lua
-- Author: Midas van Veen
-- Description: simple test program for the gamelib ellipse func
--]]

GL_WIDTH=400
GL_HEIGHT=400

local n = 3

function mousePressed(x,y)
	n = n + 1
	print("Number of segments: " .. n)
end

function draw()
	GL_Fill(255,0,0)
	GL_Ellipse(0.5,0.5, 0.2, 0.2, n)
end
