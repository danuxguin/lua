t = {}
t.a = 1

print(t.a) --1
print(t.b) --nil

setmetatable(t, {__index = function(x) return "test" end})

print(t.b) --test