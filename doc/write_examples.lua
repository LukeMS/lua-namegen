local inspect = require("inspect")
local namegen = require("namegen")

local DEST = "examples.rst"
local dest = ""

math.randomseed(1)
math.random()

local sets = namegen.get_sets()
table.sort(sets)
local groups = {
    {"Books"},
    {"Creatures"},
    {"Potions"},
    {"Towns"},
    {"Inns"},
}

for _, set in ipairs(sets) do
    if string.find(set, "books$") then
        Books = groups[1]
        Books[#Books + 1] = set
    elseif string.find(set, "potions$") then
        Potions = groups[3]
        Potions[#Potions + 1] = set
    elseif string.find(set, "towns$") then
        Towns = groups[4]
        Towns[#Towns + 1] = set
    elseif string.find(set, "inns$") then
        Inns = groups[5]
        Inns[#Inns + 1] = set
    else
        Creatures = groups[2]
        Creatures[#Creatures + 1] = set
    end
end


for _, t in ipairs(groups) do
    local group = t[1]
    dest = dest .. ("\n" .. string.format([[%s]], group))
    dest = dest .. ("\n" .. string.gsub(group, ".", "-") .. "---\n")

    for i = 2, #t do
        local set = t[i]
        -- print(group, set)
        dest = dest .. ("\n" .. string.format([["%s"]], set))
        dest = dest .. ("\n" .. string.gsub(set, ".", "*") .. "***\n")
        dest = dest .. ("\n" .. ".. code-block:: lua" .. "\n")

        local names = {}
        local s = 0
        while s < 30 do
            local str = namegen.generate(set)
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
        dest = dest .. ("\n  " .. inspect(names):gsub("[{}]", "") .. "\n\n")
    end
end

local file = io.open(DEST, "w+")
file:write(dest)
file:close()
