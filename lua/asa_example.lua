
GL_WIDTH=800
GL_HEIGHT=800

function draw()
	GL_Background(255,255,255)
	GL_Fill(0,255,0)
	GL_Ellipse(0.6,0.5, 0.05, 0.2, 32)
	GL_Ellipse(0.4,0.5, 0.05, 0.2, 32)
	GL_Rect(0.4,0.4,0.2,0.2)
	GL_Ellipse(0.5,0.6,0.1,0.05,32)
	GL_Ellipse(0.5,0.4,0.2,0.05,32)

	GL_Fill(0,0,0)
	GL_Ellipse(0.4,0.65, 0.01, 0.01, 32)
	GL_Ellipse(0.6,0.65, 0.01, 0.01, 32)
end
