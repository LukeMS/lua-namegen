math.randomseed(os.time())

local namegen = require("namegen")

-- This function adds the 'rd','nth','st' onto
-- numbers passed to it. NOTE: It MUST be a number
-- and NOT a string. It will convert it to string
-- afterwards...
function ordinal_numbers(n)
	local ordinal, digit = {"st", "nd", "rd"}, string.sub(n, -1)
	if tonumber(digit) > 0 and tonumber(digit) <= 3 and string.sub(n,-2) ~= '11' and string.sub(n,-2) ~= '12' and string.sub(n,-2) ~= '13' then
		return n .. ordinal[tonumber(digit)]
	else
		return n .. "th"
	end
end

 -- A split string function 
function splitstring(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function post_process(name)
	local result = ""
	-- If name contains the "|" then
	-- do the stuff to add a random 
	-- number assignment to unit/regiment
	if string.match(name, "|") then
		result = ""
		local splitName = splitstring(name,"|")
		result = splitName[1]
		result = result..ordinal_numbers(math.random(1,999))..splitName[2]
	else
		result=name
	end
	return result
end

for i=1,10 do
	local name = namegen.generate("military_units") 
	print(post_process(name))
end
