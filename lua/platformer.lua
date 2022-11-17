GL_WIDTH=800
GL_HEIGHT=800

player = {
	x=100/GL_WIDTH,
	y=1 - 600/GL_HEIGHT,
	w=50/GL_HEIGHT,
	h=50/GL_HEIGHT,
	vel={x=0,y=0},
	grounded=false,
	color={255,0,0}
}

ground = {
	x=0,
	y=0,
	w=1,
	h=200/GL_HEIGHT,
	color={0,255,0}
}

function mousePressed(b,s,x,y)
	if s == 1 then return end
	player.x=x/GL_WIDTH
	player.y=1-y/GL_HEIGHT
end

function keyboardPressed(key, state)
	if key == 97 and state == 1 then
		player.vel.x = -0.003
	end
	if key == 100 and state == 1 then
		player.vel.x = 0.003
	end
	if key == 119 and state == 1 and player.grounded then
		player.vel.y = 0.006
		player.grounded = false
	end
end

function draw()

	player.x = player.x + player.vel.x
	player.y = player.y + player.vel.y
	player.vel.y = player.vel.y - 0.0001
	player.vel.x = player.vel.x * 0.99
	player.vel.y = player.vel.y * 0.99

	if player.y < ground.h then
		player.y = ground.h
		player.grounded = true
		player.vel.y = 0
	end

	GL_Background(150,200,255)
	GL_Fill(player.color[1],player.color[2],player.color[3])
	GL_Rect(player.x,player.y,player.w,player.h)
	GL_Fill(ground.color[1],ground.color[2],ground.color[3])
	GL_Rect(ground.x,ground.y,ground.w,ground.h)
end
