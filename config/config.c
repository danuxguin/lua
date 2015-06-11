#include <stdio.h>
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

#define MAX_COLOR		255

int get_field( lua_State *L, const char *key) {
	
	int result;
	lua_pushstring(L, key);
	lua_gettable(L, -2);

	if (!lua_isnumber(L, -1)) {
		error(L, "invalid component in background color\n");
	}

	result = (int) lua_tonumber(L, -1) * MAX_COLOR;
	lua_pop(L, 1);

	return result;
}

void load (char *filename, int *width, int *height) {

	lua_State *L = lua_open();
	luaL_openlibs(L);

	if (luaL_loadfile(L, filename) || lua_pcall(L, 0, 0, 0)) {
		error(L, "cannot run configuration file: %s\n", lua_tostring(L, -1));
	}	

	lua_getglobal(L, "width");
	lua_getglobal(L, "height");
	lua_getglobal(L, "background");

	if (!lua_isnumber(L, -3)) {
		error(L, "width should be a number\n");
	}
	if (!lua_isnumber(L, -2)) {
		error(L, "height should be a number\n");
	}
	if (!lua_istable(L, -1)) {
		error(L, "background is not a valid color table\n");
	}

	*width = (int) lua_tonumber(L, -3);
	*height = (int) lua_tonumber(L, -2);	

	int red = get_field(L, "r");
	int green = get_field(L, "g");
	int blue = get_field(L, "b");

	printf("red = %d\tgreen = %d\tblue = %d\n", red, green, blue);

	lua_close(L);
}

int main() 
{
	int width, height;
	load("config.lua", &width, &height);

	printf("width = %d\theight = %d\n", width, height);

	return 0;
}
