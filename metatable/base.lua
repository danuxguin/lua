print(getmetatable('hi'))
print(getmetatable(10))

print("-------------------------")

local mt = {}
function mt.__add(a, b)
	return 'table+'..b
end

local t = {}
setmetatable(t, mt)
print(t + 1)

print("-------------------------")

local mt = {}
mt.__tostring = function(t)
	return '{'..table.concat(t, ',')..'}'
end

local t = {1, 2, 3}
print(t)
setmetatable(t, mt)
print(t)
