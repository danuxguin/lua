#include <stdio.h>
#include <lua.h>
#include <lauxlib.h>

double func (lua_State *L, double x, double y) {
	
	double z;

	lua_getglobal(L, "func");
	lua_pushnumber(L, x);
	lua_pushnumber(L, y);

	if (lua_pcall(L, 2, 1, 0) != 0) {
		error(L, "error running function 'func': %s", lua_tostring(L, -1));
	}
	
	if (!lua_isnumber(L, -1)) {
		error(L, "function 'func' must return a number");
	}
	z = lua_tonumber(L, -1);
	lua_pop(L, 1);

	return z;
}

int main()
{
	lua_State *L = lua_open();
	luaL_openlibs(L);

	luaL_loadfile(L, "function.lua");

	printf("func return value = %lf\n", func(L, 2.0, 3.0));

	lua_close(L);

	return 0;
}
