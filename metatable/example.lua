Set = {}

local mt = {}

function Set.new(l)
	local set = {}

	setmetatable(set, mt)
	for _, v in ipairs(l) do set[v] = true end
	return set
end

function Set.union(a, b)
	if getmetatable(a) ~= mt or getmetatable(b) ~= mt then
		error("attemp to 'add' a set with a not-set value", 2)
	end

	local res = Set.new{}







   
