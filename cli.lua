local function get_device_info()
    local handle = io.popen("getprop ro.product.model")
    local result = handle:read("*a")
    handle:close()
    return result:gsub("%s+", "") or "GENERIC_HOST"
end

local SYSTEM = {
    ADMIN = "krovixa",
    DEVICE = get_device_info(),
    VERSION = "1.0.4"
}

local function run()
    local args = {...}
    if not args[1] then return end

    print(string.format("[*] NYX_SESSION: %s @ %s", SYSTEM.ADMIN, SYSTEM.DEVICE))
    
    -- Calling the VM (z.lua)
    local z = require("z")
    z.execute()
end

run()
