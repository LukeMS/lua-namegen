-- RangedTable - table with range or group entries
-- Author: Lucas Siqueira
-- License: Public Domain / CC0.

local RangedTable = {}
RangedTable.__index = RangedTable

setmetatable(RangedTable, {
    __call = function(class, ...)
        local instance = setmetatable({}, class)
        if instance.initialize then
            instance:initialize(...)
        end
    return instance
    end
})

local function cmp_number(k, t)
    for i = 1, #t do
        local entry = t[i]
        local range, v = entry[1], entry[2]
        if k >= range[1] and k <= range[2] then
            return v
        end
    end
end

local function cmp_group(k, t)
    for i = 1, #t do
        local entry = t[i]
        local group, v = entry[1], entry[2]
        for i = 1, #group do
            if k == group[i] then
                return v
            end
        end
    end
end

function RangedTable:get(k)
    local cmp = type(k) == "number" and cmp_number or cmp_group
    return cmp(k, self.ranges)
end

function RangedTable:keys()
    local i = 0
    return function()
        i = i + 1
        return self.ranges[i] and self.ranges[i][1] or nil
    end
end

function RangedTable:items()
    local i = 0
    return function()
        i = i + 1
        return self.ranges[i] and self.ranges[i][1] or nil,
               self.ranges[i] and self.ranges[i][2] or nil
    end
end

function RangedTable:values()
    local i = 0
    return function()
        i = i + 1
        return self.ranges[i] and self.ranges[i][2] or nil
    end
end

function RangedTable:choice()
    return self:get(math.random(1, self.max))
end

function RangedTable:initialize(t)
    self.ranges = {}
    for i = 1, #t do
        self.ranges[#self.ranges + 1] = t[i]
    end
    self:normalize()
    return self
end

function RangedTable:size()
    return #self.ranges
end

function RangedTable:normalize()
    local normalized = {}
    local sum = 1
    local range
    for i = 1, #self.ranges do
        local entry = self.ranges[i]
        local chance = entry[1]
        local content = entry[2]
        if type(chance) == "number" then
            range = chance
        elseif #chance == 1 then
            range = chance[1]
        elseif type(chance[1]) == "string" then
            return
        else
            range = chance[2] - chance[1] + 1
        end
        normalized[#normalized + 1] = {{sum, sum + range - 1}, content}
        sum = sum + range
    end
    self.ranges = normalized
    self.max = sum - 1
end


return RangedTable
