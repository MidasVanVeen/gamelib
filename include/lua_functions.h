#ifndef LUA_FUNCTIONS_H
#define LUA_FUNCTIONS_H

/*
 * Header file for the c functions used by lua
 * Author: Midas van Veen
 */

#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>
#include <math.h>

extern float fillcolor[3];
extern float clearcolor[3];

int _GL_Background(lua_State *L);
int _GL_Fill(lua_State *L);
int _GL_Triangle(lua_State *L);
int _GL_Line(lua_State *L);
int _GL_Bezier(lua_State *L);
int _GL_Rect(lua_State *L);
int _GL_Ellipse(lua_State *L);
int _GL_Text(lua_State *L);

#endif // LUA_FUNCTIONS_H

