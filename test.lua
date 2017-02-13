math.randomseed(1)
math.random()


local inspect = require("inspect")
local namegen = require("namegen")


local sets = namegen.get_sets()
table.sort(sets)
for _, set in ipairs(sets) do
    -- do break end
    print("\n" .. string.format([["%s"]], set))
    print(string.gsub(set, ".", "-") .. "---")
    print("\n" .. ".. code-block:: lua" .. "\n")
    local names = {}
    for i = 1, 50 do
        names[#names + 1] = namegen.generate(set)
    end
    table.sort(names)
    print("  " .. inspect(names):gsub("[{}]", ""))
end

for i = 1, 10 do
    do break end
    print(inspect({
        namegen.generate("oread female"),
        namegen.generate("oread female"),
        namegen.generate("oread female"),
        namegen.generate("oread female"),
        namegen.generate("oread female"),
        namegen.generate("oread female"),
        namegen.generate("oread female"),
        namegen.generate("oread female"),
        namegen.generate("oread female"),
        namegen.generate("oread female"),
        namegen.generate("oread female"),
        namegen.generate("oread female")
    }))
end
