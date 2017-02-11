math.randomseed(1)
math.random()


local inspect = require("inspect")
local namegen = require("namegen")


local sets = namegen.get_sets()
table.sort(sets)
for _, set in ipairs(sets) do
    print("\n\n" .. "* " .. string.format([["%s"]], set) .. "\n")
    local names = {}
    for i = 1, 50 do
        names[#names + 1] = namegen.generate(set)
    end
    table.sort(names)
    print("  " .. inspect(names):gsub("[{}]", ""))
end

