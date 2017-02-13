local namegen = {
    _VERSION     = 'LuaNameGen - Lua Name Generator v1.0.0',
    _DESCRIPTION = 'A name generator written in Lua',
    _URL         = 'https://github.com/LukeMS/lua-namegen',
    _LICENSE     = [[
MIT LICENSE

Copyright (c) 2017 Lucas Siqueira

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]
}

local function loadrequire(module)
    local loaded
    local function requiref(module)
        loaded = require(module)
    end
    pcall(requiref, module)
    return loaded
end

local RangedTable = require("rangedtable")

local inspect = loadrequire('inspect') or function(t)
    s = "{"
    for k, v in t do
        s = s .. string.format("%s: %s;", k, v)
    end
    s = s .. "}"
    return s
end


-- ======================
--  CONSTANTS
-- ======================

-- set this to true for a debug/verbose mode
-- requires 'inspect' (https://github.com/kikito/inspect.lua)
local DEBUG = false


-- ======================
--  VARIABLES
-- ======================

-- the table containing the generators
local namegen_generators_list = {}


-- ======================
--  UTILITIES
-- ======================

local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

local function get_path(filename)
    if filename:find("%.cfg$") then
        return filename
    else
        return filename .. ".cfg"
    end
end

local function split(str)
    local t = {}
    for v in string.gmatch(str:gsub(",", ""), "%S+") do
        t[#t + 1] = v
    end
    return t
end

local function ng_debug(str, ...)
    if DEBUG == true then
        if ... then
            print(string.format(str, ...))
        else
            print(str)
        end
    end
end


-- ======================
--  PARSERS
-- ======================

local function parse_rules(rules)
    local rules_weight = {}
    local rule_pattern = [[^%%*(%d*)(%S+)]]
    for _, v in pairs(rules) do
        local chance, rule = string.match(v, rule_pattern)
        ng_debug([[chance: "%s", rule: "%s"]], chance, rule)
        chance = chance == "" and 100 or tonumber(chance)
        rules_weight[#rules_weight + 1] = {chance, rule}
    end
    ng_debug(inspect(rules), inspect(rules_weight))
    return RangedTable(rules_weight)
end

local function parse_property(name, value, parser_data)
    local v = name == "name" and value or split(value)
        if name == "name" then
        ng_debug([[parse_property: "%s"]], value)
        parser_data["name"] = v
    elseif name == "syllablesStart" then
        parser_data["start"] = v
    elseif name == "syllablesMiddle" then
        parser_data["middle"] = v
    elseif name == "syllablesEnd" then
        parser_data["end"] = v
    elseif name =="syllablesPre" then
        parser_data["pre"] = v
    elseif name =="syllablesPost" then
        parser_data["post"] = v
    elseif name == "phonemesVocals" then
        parser_data["vocals"] = v
    elseif name =="phonemesConsonants" then
        parser_data.consonants = v
    elseif name == "rules" then
        parser_data["rules"] = parse_rules(v)
    elseif name == "illegal" then
        -- /* illegal strings are converted to lowercase */
        parser_data.illegal = split(string.lower(value))
    else
        local cg = string.match(name, "^customGroup(%a)")
        if cg then
            parser_data["cg" .. cg:lower()] = v
        else
            ng_debug("parse_property else")
            return false
        end
    end
    return true
end

local function parse_lines(path, data)
    ng_debug("starting `parse_lines`", path)
    local data
    local name_pattern = [[name ?"(.+)" ?{]]
    local property_pattern = [[ +(.+) = "(.+)"]]
    local end_body_pattern = [[}]]

    local body = false
    for line in io.lines(path) do
        local name = string.match(line, name_pattern)
        if name ~= nil then
            namegen_generators_list[name] = {}
            data = namegen_generators_list[name]
            parse_property("name", name, data)
            body = true
        elseif body == true then
            if string.match(line, end_body_pattern) then
                body = false
            else
                local name, value = string.match(line, property_pattern)
                if name and value then
                    parse_property(name, value, data)
                end
            end
        end
    end
    ng_debug("ending `parse_lines`")
end

local function parse_file(filename)
    ng_debug("starting `parse_file`")
    local path = get_path(filename)
    if not file_exists(path) then
        error(string.format("File \"%s\" not found!\n",path))
    end
    parse_lines(get_path(filename))
    ng_debug("ending `parse_file`")
end

local function parse_index()
    ng_debug("starting `parse_index`")

    for line in io.lines("namegen.index") do
        parse_file(line)
    end
    ng_debug("ending `parse_index`")
end


-- ======================
--  WORD VALIDATION
-- ======================

-- check for occurrences of triple characters (case-insensitive)
local function word_has_triples(str)
    local str = str:lower()
    for i = 1, #str - 2 do
        local a = str:sub(i, i)
        local b = str:sub(i+1, i+1)
        local c = str:sub(i+2, i+2)
        if a == b and a == c then
            return true
        end
    end
    return false
end

-- check for occurrences of illegal strings (case-insensitive)
local function word_has_illegal(data, str)
    local str = str:lower()

    if not data.illegal then return false end

    for i  = 1, #data.illegal do
        if str:find(data.illegal[i]) then
            return true
        end
    end
    return false
end

-- check for repeated syllables (case-insensitive)
local function word_repeated_syllables(str)
    local word = str:lower()

    for step = 2, math.min(5, math.floor(#str / 2)) do
        for i = 1, #word - step + 1 do
            local search = word:sub(i, i + step - 1)
            local sub = word:sub(i + step, (i + step) + step - 1)
            if search == sub then
                return true
            end
            ng_debug("not repeatted", str, step, search, sub)
        end
    end
    return false
end

-- verify if the word passes the above checks
local function word_is_ok(data, str)
    return ((#str > 0) and
            not word_has_triples(str) and
            not word_has_illegal(data, str) and
            not word_repeated_syllables(str))
end

-- removes double, leading and ending spaces
local function word_prune_spaces(str)
    str = str:gsub(" +$", "")
    str = str:gsub("^ +", "")
    str = str:gsub(" +", " ")
    return str
end

local function generate_custom(name, rule)
    local random = math.random

    local data = namegen_generators_list[name]
    if data == nil then
        error(string.format("The name \"%s\" has not been found.\n",name))
    end

    -- start name generation
    local buf, i, it
    repeat
        buf = ""
        i = 1
        while i <= #rule do
            it = rule:sub(i, i)
            -- append normal character
            if ((it >= 'a' and it <= 'z') or
                (it >= 'A' and it <= 'Z') or
                it == '\'' or it == '-')
            then
                ng_debug("buf case 1")
                buf = buf .. it
            elseif it == '/' then
                -- special character
                i = i + 1
                ng_debug("buf case 2")
                buf = buf .. it
            elseif it == '_' then
                -- convert underscore to space
                ng_debug("buf case 3")
                buf = buf .. " "
            -- interpret a wildcard
            elseif it == '$' then
                local chance = 100;
                i = i + 1
                local it = rule:sub(i, i)
                ng_debug("buf case 4, it: %s", it)
                -- food for the randomiser
                if it >= '0' and it <= '9' then
                    ng_debug("buf case 4.1")
                    chance = 0
                    while it >= '0' and it <= '9' do
                        chance = chance * 10
                        chance = chance + tonumber(it)
                        i = i + 1
                        it = rule:sub(i, i);
                    end
                end
                -- evaluate the wildcard according to its chance
                if chance >= random(100) then
                    ng_debug("buf case 4.2")
                    local lst
                    if it == 'P' then
                        ng_debug("buf case 4.2.1")
                        lst = data["pre"]
                    elseif it == 's' then
                        ng_debug("buf case 4.2.2")
                        lst = data["start"]
                    elseif it == 'm' then
                        ng_debug("buf case 4.2.3")
                        lst = data["middle"]
                    elseif it == 'e' then
                        ng_debug("buf case 4.2.4")
                        lst = data["end"]
                    elseif it == 'p' then
                        ng_debug("buf case 4.2.5")
                        lst = data["post"]
                    elseif it == 'v' then
                        ng_debug("buf case 4.2.6")
                        lst = data["vocals"]
                    elseif it == 'c' then
                        ng_debug("buf case 4.2.7")
                        lst = data["consonants"]
                    elseif it == '?' then
                        ng_debug("buf case 4.2.8")
                        lst = ((random(1, 2) == 1) and data.vocals or
                               data.consonants)
                    elseif it >= "A" and it < "P" then
                        ng_debug("buf case 4.2.9")
                        lst = data["cg" .. it:lower()]
                    elseif it == "'" then
                        ng_debug("buf case 4.2.10")
                        lst = {"'"}
                    else
                        error(string.format(
                            [[Wrong rules syntax(it:"%s", rule:"%s")]],
                            it, rule))
                    end
                    -- got the list, now choose something on it
                    if #lst == 0 then
                        error(string.format(
                            "No data found in the requested string (wildcard %s). Check your name generation rule %s.",
                            it,rule
                        ))
                    else
                        buf = buf .. (lst[random(1, #lst)]:gsub('_', ' '))
                    end
                end
            end
            ng_debug([[i: %d, buf: %s, it: %s, rule: %s]],
                     i, buf, it, rule)
            i = i + 1
        end
    until word_is_ok(data, buf)
    ng_debug([[ending "generate_custom 'repeat ... until'"]])

    -- prune undesired spaces and return the name
    return word_prune_spaces(buf)
end

-- generate a new name with one of the rules from set
local function generate(name)
    ng_debug([[starting "generate(%s)"]], name)
    local data = namegen_generators_list[name]
    if data == nil then
        error(string.format("The name \"%s\" has not been found.\n",name))
    end
    -- check if the rules list is present */
    if data.rules:size() == 0 then
        error("The rules list is empty!")
    end

    -- choose the rule */
    local res = generate_custom(name, data.rules:choice())
    ng_debug([[starting "generate(%s)"]], name)
    return res
end

local function get_sets()
    local t = {}
    for k, _ in pairs(namegen_generators_list) do
        if namegen_generators_list[k].rules then
            t[#t + 1] = k
        end
    end
    return t
end


-- ------------------------------
--  load default sets (as specified on `namegen.index`)
-- ------------------------------
parse_index()


-- ------------------------------
--  publicly available functions
-- ------------------------------

namegen.get_sets = get_sets
namegen.parse_file = parse_file
namegen.generate = generate
namegen.generate_custom = generate_custom

return namegen
