#include <GL/glut.h>
#include <math.h>

extern "C" {
#include "lua_functions.h"
}

static lua_State *L;

static int width;
static int height;

static void keyDown(unsigned char key, int x, int y) {
	lua_getglobal(L, "keyboardPressed");
	lua_pushnumber(L, key);
	// 1 is for down
	lua_pushnumber(L, 1);
	lua_pcall(L, 2, 1, 0);
}
static void keyUp(unsigned char key, int x, int y) {
	lua_getglobal(L, "keyboardPressed");
	lua_pushnumber(L, key);
	// 0 is for up
	lua_pushnumber(L, 0);
	lua_pcall(L, 2, 1, 0);
}

static void pre_display(void) {
	glViewport(0, 0, width, height);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluOrtho2D(0.0, 1.0, 0.0, 1.0);
	glClearColor(clearcolor[0], clearcolor[1], clearcolor[2], 1); // set background color
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

static void post_display(void) {
	glFlush();
	glutSwapBuffers();
}

static void display(void) {
	pre_display();
	lua_getglobal(L, "draw");
	lua_pcall(L,0,1,0);
	post_display();
}

static void idle(void) {
	glutPostRedisplay();
}

static void motion(int x, int y) {
	lua_getglobal(L, "mouseMoved");
	lua_pushnumber(L, x);
	lua_pushnumber(L, y);
	lua_pcall(L,2,1,0);
}

static void mouse(int button, int state, int x, int y) {
	lua_getglobal(L, "mousePressed");
	lua_pushnumber(L, button);
	lua_pushnumber(L, state);
	lua_pushnumber(L, x);
	lua_pushnumber(L, y);
	lua_pcall(L,4,1,0);
}

int main(int argc, char** argv) {

	// initializing lua and reading main file
	L = luaL_newstate();
	luaL_openlibs(L);
	luaL_dofile(L, argv[1]);

	// registering functions
	lua_register(L, "GL_Rect", _GL_Rect);
	lua_register(L, "GL_Ellipse", _GL_Ellipse);
	lua_register(L, "GL_Triangle", _GL_Triangle);
	lua_register(L, "GL_Line", _GL_Line);
	lua_register(L, "GL_Bezier", _GL_Bezier);
	lua_register(L, "GL_Fill", _GL_Fill);
	lua_register(L, "GL_Background", _GL_Background);

	// setting width & height
	lua_getglobal(L, "GL_WIDTH");
	width = lua_tonumber(L, -1);

	lua_getglobal(L, "GL_HEIGHT");
	height = lua_tonumber(L, -1);

	// initializing glut
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
	glutInitWindowSize(width, height);
	glutInitWindowPosition(100, 100);
	glutCreateWindow("Gamelib");

	glutDisplayFunc(display);
	//glutReshapeFunc(reshape);
	glutKeyboardUpFunc(keyUp);
	glutKeyboardFunc(keyDown);
	glutMouseFunc(mouse);
	glutMotionFunc(motion);
	glutIdleFunc(idle);

	glutMainLoop();

	return 0;
}
