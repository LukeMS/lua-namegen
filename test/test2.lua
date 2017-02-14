local inspect = require("inspect")
local namegen = require("namegen")

local rules = namegen.exhaust_rules("books")
print(inspect(rules))
local names = namegen.exhaust_set("books")
for _, v in pairs(names) do
    print(v)
end
