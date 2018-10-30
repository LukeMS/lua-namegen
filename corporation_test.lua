math.randomseed(os.time())
local namegen = require("namegen")

local rules = namegen.exhaust_rules("corporations")
-- local names = namegen.exhaust_set("corporations")
-- for _, v in pairs(names) do
--     print(v)
-- end

for i=1,10 do
	local name = namegen.generate("corporations")  --  Dolin
	print(name)
end