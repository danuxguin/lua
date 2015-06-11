--metatable
a = {5, 6}
b = {7, 8}
c = {}

c.__add = function(op1, op2)
	for _, item in ipairs(op2) do
		table.insert(op1, item)
	end	
	return op1
end

setmetatable(a, c)
d = a + b

for _, item in ipairs(d) do
	print(item)
end
