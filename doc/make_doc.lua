local inspect = require("inspect")
local SRC = "README.rst"
local DEST = "../README.rst"

require("write_examples")

local function literalinclude(block_args)
    local file = io.input(block_args["fn_arg"])
    local s = file:read("*a")
    file:close()
    return s
end

local parsers = {literalinclude = literalinclude}

local function parse_block(block_args)
    -- print(inspect(block_args))
    local fn = parsers[block_args["fn"]]
    return fn(block_args)
end

local function parse_lines()
    local dest = ""

    local inside_block = false
    local block_args
    for line in io.lines(SRC) do
        if inside_block then
            if line == nil or line == "" or line:sub(1) ~= " " then
                inside_block = false
                dest = dest .. parse_block(block_args) .. "\n"
            else
                local field, value = line:match("^ +:([%a-]+): *(.+)$")
                -- print("inside_block", field, value)
                block_args[field] = value
            end
        else
            local field, arg = line:match("^%.%. *(.+):: *(.+)$")
            if field and parsers[field] then
                block_args = {}
                block_args["fn"] = field
                block_args["fn_arg"] = arg
                inside_block = true
                -- print("inside_block", field, parsers[field])
            else
                dest = dest .. line .. "\n"
            end
        end
    end
    local file = io.open(DEST, "w+")
    file:write(dest)
    file:close()
end

parse_lines()
