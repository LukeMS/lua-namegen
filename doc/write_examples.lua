local inspect = require("inspect")
local namegen = require("namegen")

local DEST = "examples.rst"
local dest = ""

math.randomseed(1)
math.random()

local sets = namegen.get_sets()
table.sort(sets)

for _, set in ipairs(sets) do
    dest = dest .. ("\n" .. string.format([["%s"]], set))
    dest = dest .. ("\n" .. string.gsub(set, ".", "-") .. "---\n")
    dest = dest .. ("\n" .. ".. code-block:: lua" .. "\n")

    local names = {}
    for i = 1, 50 do
        names[#names + 1] = namegen.generate(set)
    end
    table.sort(names)
    dest = dest .. ("\n  " .. inspect(names):gsub("[{}]", "") .. "\n\n")
end

local file = io.open(DEST, "w+")
file:write(dest)
file:close()
