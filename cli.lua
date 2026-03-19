-- [[ NYX_CORE: cli.lua ]] --
local args = {...}
if #args < 1 then return end

local function read(path)
    local f = io.open(path, "rb")
    if not f then return nil end
    local src = f:read("*all")
    f:close()
    return src
end

local function write(path, data)
    local f = io.open(path, "wb")
    if f then
        f:write(data)
        f:close()
    end
end

local function run()
    local source = read(args[1])
    if not source then return end

    -- NYX_PIPELINE: Virtualization Logic
    -- This is where the Moonsec/Prometheus modules hook in.
    local output = "-- [[ NYX_V1 ]]\n" .. source:reverse() 

    write("nyx_out.lua", output)
    print("NYX: COMPLETED")
end

run()
