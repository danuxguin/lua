
Set = {}

local mt = {}
 

function Set.new(l)

    local set = {}

    -- 为 Set 设置 metatable

    setmetatable(set, mt)

    for _, v in ipairs(l) do set[v] = true end

    return set

end

 

function Set.union(a, b)

    -- 检查 a b 是否都是 Set

    if getmetatable(a) ~= mt or getmetatable(b) ~= mt then

        -- error 的第二个参数为 level

        -- level 指定了如何获取错误的位置

        -- level 值为 1 表示错误的位置为 error 函数被调用的位置

        -- level 值为 2 表示错误的位置为调用 error 的函数被调用的地方

        error("attempt to 'add' a set with a not-set value", 2)

    end

    local res = Set.new{}

    for k in pairs(a) do res[k] = true end

    for k in pairs(b) do res[k] = true end

    return res

end

 

function Set.intersection(a, b)

    local res = Set.new{}

    for k in pairs(a) do

        res[k] = b[k]

    end

    return res

end

 

mt.__add = Set.union

mt.__mul = Set.intersection

 

mt.__tostring = function(s)

    local l = {}

    for e in pairs(s) do

        l[#l + 1] = e

    end

    return '{' .. table.concat(l, ', ') .. '}'

end

 

mt.__le = function(a, b)

    for k in pairs(a) do

        if not b[k] then return false end

    end

    return true

end

 

mt.__lt = function(a, b)

    return a <= b and not (b <= a)

end

 

mt.__eq = function(a, b)

    return a <= b and b <= a

end

 

local s1 = Set.new({1, 2, 3})

local s2 = Set.new({4, 5, 6})

print(s1 + s2)

print(s1 ~= s2)


