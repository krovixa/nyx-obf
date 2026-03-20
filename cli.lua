local z = require("z")

-- Constants for the math test
local _c = { "print", 0, 5 }

local _b = {
    {0xC3, 1, 1}, -- Reg 1 = print
    {0xB1, 2, 2}, -- Reg 2 = 0
    {0xB1, 3, 3}, -- Reg 3 = 5
    
    -- PART 1: 0 * 5 (Mode 3 is Multiply)
    {0xE5, 3, 2, 3, "var_mul"}, -- result in Reg 2
    
    -- PART 2: 5 + 0 (Mode 1 is Add)
    {0xB1, 4, 3}, -- Reg 4 = 5
    {0xB1, 5, 2}, -- Reg 5 = 0
    {0xE5, 1, 4, 5, "var_add"}, -- result in Reg 4
    
    -- Final Output (Calling print with the results)
    {0xD4, 1, 1}, 
    {0xF6, 0, 0}
}

z.execute(_b, _c)
