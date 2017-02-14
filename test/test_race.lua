local inspect = require("inspect")
local namegen = require("namegen")

math.randomseed(1)
math.random()

local names = {}
local s = 0
while s < 80 do
    local str = namegen.generate("sylph female")
    if names[str] == nil then
        names[str] = str
        s = s + 1
    end
end

local names, old = {}, names
for _, v in pairs(old) do
    names[#names + 1] = v
end
table.sort(names)

print(inspect(names))

