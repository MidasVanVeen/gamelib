/*
 * Implementation file for the c functions used by lua
 * These functions are c functions, therefore i use an extern "C"
 * Declaration
 *
 * Author: Midas van Veen
 */

extern "C" {
#include "lua_functions.h"

float fillcolor[3] = { 1, 1, 1};
float clearcolor[3] = { 0, 0, 0};

int _GL_Background(lua_State *L) {
	clearcolor[0] = lua_tonumber(L, 1)/255;
	clearcolor[1] = lua_tonumber(L, 2)/255;
	clearcolor[2] = lua_tonumber(L, 3)/255;
	return 0;
}

int _GL_Fill(lua_State *L) {
	fillcolor[0] = lua_tonumber(L, 1)/255;
	fillcolor[1] = lua_tonumber(L, 2)/255;
	fillcolor[2] = lua_tonumber(L, 3)/255;
	return 0;
}

int _GL_Line(lua_State *L) {
	float x1 = lua_tonumber(L, 1);
	float y1 = lua_tonumber(L, 2);
	float x2 = lua_tonumber(L, 3);
	float y2 = lua_tonumber(L, 4);
	glColor3f(fillcolor[0], fillcolor[1], fillcolor[2]);
	glBegin(GL_LINES);
	glVertex2f(x1, y1);
	glVertex2f(x2, y2);
	glEnd();
	return 0;
}

int _GL_Triangle(lua_State *L) {
	float x1 = lua_tonumber(L, 1);
	float y1 = lua_tonumber(L, 2);
	float x2 = lua_tonumber(L, 3);
	float y2 = lua_tonumber(L, 4);
	float x3 = lua_tonumber(L, 5);
	float y3 = lua_tonumber(L, 6);

	glBegin(GL_TRIANGLES);
	glColor3f(fillcolor[0], fillcolor[1], fillcolor[2]);
	glVertex2f(x1, y1);
	glVertex2f(x2, y2);
	glVertex2f(x3, y3);
	glEnd();
	return 0;
}

int _GL_Rect(lua_State *L) {
	/* Gathering arguments */
	float x = lua_tonumber(L, 1);
	float y = lua_tonumber(L, 2);
	float w = lua_tonumber(L, 3);
	float h = lua_tonumber(L, 4);

	glBegin(GL_POLYGON);
	glColor3f(fillcolor[0], fillcolor[1], fillcolor[2]);
	glVertex2f(x, y);
	glVertex2f(x+w, y);
	glVertex2f(x+w, y+h);
	glVertex2f(x, y+h);
	glEnd();
	return 0;
}

int _GL_Ellipse(lua_State *L) {
	/* Gathering arguments */
	float cx = lua_tonumber(L, 1);
	float cy = lua_tonumber(L, 2);
	float rx = lua_tonumber(L, 3);
	float ry = lua_tonumber(L, 4);
	int num_segments = lua_tonumber(L, 5);

	float theta = 2 * 3.1415926 / float(num_segments);
	float c = cosf(theta);//precalculate the sine and cosine
	float s = sinf(theta);
	float t;

	float x = 1;
	float y = 0;

	for(int ii = 0; ii < num_segments; ii++) {
		glBegin(GL_POLYGON);
		glColor3f(fillcolor[0], fillcolor[1], fillcolor[2]);
		//apply radius and offset
		glVertex2f(x * rx + cx, y * ry + cy);

		//apply the rotation matrix
		t = x;
		x = c * x - s * y;
		y = s * t + c * y;

		glVertex2f(x * rx + cx, y * ry + cy);
		glVertex2f(cx,cy);
		glEnd();
	}
	return 0;
}

int _GL_Text(lua_State *L) {
	/* Gathering arguments */
	float x = lua_tonumber(L, 1);
	float y = lua_tonumber(L, 2);
	const char *text = lua_tostring(L, 3);

	glColor3f(fillcolor[0], fillcolor[1], fillcolor[2]);
	glRasterPos2f(x, y);
	for (const char *p = text; *p; p++)
		glutBitmapCharacter(GLUT_BITMAP_9_BY_15, *p);
	return 0;
}

int _GL_Bezier(lua_State *L) {
	float x1 = lua_tonumber(L, 1);
	float y1 = lua_tonumber(L, 2);
	float x2 = lua_tonumber(L, 3);
	float y2 = lua_tonumber(L, 4);
	float x3 = lua_tonumber(L, 5);
	float y3 = lua_tonumber(L, 6);
	float x4 = lua_tonumber(L, 7);
	float y4 = lua_tonumber(L, 8);
	float ctrlpoints[4][3] = {
		{x1, y1, 0.0}, {x2, y2, 0.0}, {x3, y3, 0.0}, {x4, y4, 0.0}
	};
	float num_segments = lua_tonumber(L, 9);
    glShadeModel(GL_FLAT);
    glMap1f(GL_MAP1_VERTEX_3, 0.0, 1.0, 3, 4,
            &ctrlpoints[0][0]);

    glEnable(GL_MAP1_VERTEX_3);

    // Fill the color
    glColor3f(fillcolor[0], fillcolor[1], fillcolor[2]);
    glBegin(GL_LINE_STRIP);

    // Find the coordinates
    for (int i = 0; i <= num_segments; i++)
        glEvalCoord1f((GLfloat)i / num_segments);

    glEnd();
    glFlush();
	return 0;
}
}
