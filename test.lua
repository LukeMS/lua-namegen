local namegen = require("namegen")

math.randomseed(os.time())
math.random()

local sets = namegen.get_sets()

local gen = {}
for _, set in ipairs(sets) do
    gen[set] = gen[set] or {}
    for i = 1, 100 do
        local str = namegen.generate(set)
        gen[set][str] = (gen[set][str] or 0) +1
    end
end

for set, t in pairs(gen) do
    for k, v in pairs(t) do
        print(set, k, v)
    end
end
