FILES=src/main.cpp src/lua_functions.cpp
INCLUDES=-Iinclude/
OUTNAME=gamelib
OUTDIR=build/
GLUTFLAGS=-lGL -lGLU -lglut
LUAFLAGS=-llua5.4
EXTRAFLAGS=-lm -g

.SILENT: all

all:
	g++ $(FILES) -o $(OUTDIR)$(OUTNAME) $(INCLUDES) $(GLUTFLAGS) $(LUAFLAGS) $(EXTRAFLAGS)
	echo "Build complete."
