math.randomseed(os.time())
local namegen = require("namegen")

local rules = namegen.exhaust_rules("empires")

-- local names = namegen.exhaust_set("empires")
-- for _, v in pairs(names) do
--     print(v)
-- end

for i=1,10 do
	local name = namegen.generate("empires") 
	print(name)
end

