local inspect = require("inspect")
local namegen = require("namegen")

local DEST = "examples.rst"
local dest = ""

math.randomseed(1)
math.random()

local sets = namegen.get_sets()
table.sort(sets)
local groups = {
    Books = {},
    Potions = {},
    Towns = {},
    Creatures = {}
}

for _, set in ipairs(sets) do
    if string.find(set, "books$") then
        Books = groups["Books"]
        Books[#Books + 1] = set
    elseif string.find(set, "potions$") then
        Potions = groups["Potions"]
        Potions[#Potions + 1] = set
    elseif string.find(set, "towns$") then
        Towns = groups["Towns"]
        Towns[#Towns + 1] = set
    else
        Creatures = groups["Creatures"]
        Creatures[#Creatures + 1] = set
    end
end

for group, t in pairs(groups) do
    dest = dest .. ("\n" .. string.format([["%s"]], group))
    dest = dest .. ("\n" .. string.gsub(group, ".", "-") .. "---\n")

    for _, set in ipairs(t) do
        dest = dest .. ("\n" .. string.format([["%s"]], set))
        dest = dest .. ("\n" .. string.gsub(set, ".", "*") .. "***\n")
        dest = dest .. ("\n" .. ".. code-block:: lua" .. "\n")

        local names = {}
        for i = 1, 50 do
            names[#names + 1] = namegen.generate(set)
        end
        table.sort(names)
        dest = dest .. ("\n  " .. inspect(names):gsub("[{}]", "") .. "\n\n")
    end
end

local file = io.open(DEST, "w+")
file:write(dest)
file:close()
