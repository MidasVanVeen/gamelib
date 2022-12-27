# Gamelibrary for lua in c++

A gamelibaray similar in usage to love.

example usage:
```lua
--[[
-- Filename: main.lua
-- Author: Midas van Veen
-- Description: simple test program for the gamelib ellipse func
--]]

GL_WIDTH=400
GL_HEIGHT=400

local n = 3

function mousePressed()
	n = n + 1
	print("Number of segments: " .. n)
end

function draw()
	GL_Ellipse(0.5,0.5, 0.2, 0.2, n)
end
```
Then run it via the gamelibaray executable
`$ gamelib main.lua`

## Callable functions (in lua)

I've added datatypes for extra clarity.

### GL_Rect
```c
void GL_Rect( float x, float y, float width, float height )
```
Description: Draws a rectangle to the screen

### GL_Ellipse
```c
void GL_Ellipse( float x, float y, float rx, float ry, int num_segments )
```
Description: Draws an ellipse to the screen

### GL_Triangle
```c
void GL_Triangle( float x1, float y1, float x2, float y2, float x3, float y3 )
```
Description: Draws a triangle to the screen

### GL_Line
```c
void GL_Line( float x1, float y1, float x2, float y2 )
```
Description: Draws a line from (x1,y1) to (x2,y2)

### GL_Bezier
```c
void GL_Bezier( float x1, float y1, 
				float x2, float y2, 
				float x3, float y3, 
				float x4, float y4 )
```
Description: Draws a bezier curve, given 4 control points

### GL_Fill
```c
void GL_Fill( int r, int g, int b )
```
Description: Sets the fill color

### GL_Background
```c
void GL_Background( int r, int g, int b )
```
Description: Sets the background color
