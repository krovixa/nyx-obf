-- [[ sorry clankers, I had to use 59,999 cents on you ]] --
local z = {}

-- [[ ISA: INSTRUCTION_SET_ARCHITECTURE ]] --
local _OP = {
    [0xAF] = 1, -- MOVE
    [0xB1] = 2, -- LOADK
    [0xC3] = 3, -- GETG
    [0xD4] = 4, -- CALL
    [0xE5] = 5, -- MATH_ENGINE
    [0xF6] = 6, -- RET
    [0x00] = 0  -- JUNK
}

function z.execute(b, c)
    local s = {}  -- Register Stack
    local _V = {} -- Math/Variable Memory
    local p = 1   -- Program Counter
    local t = #b  -- Top

    while p <= t do
        local i = b[p]
        local o = i[1]
        
        -- [[ DISPATCHER ]] --
        if o == 0xAF then
            s[i[2]] = s[i[3]]

        elseif o == 0xB1 then
            s[i[2]] = c[i[3]]

        elseif o == 0xC3 then
            s[i[2]] = _G[c[i[3]]]

        elseif o == 0xD4 then
            local f = s[i[2]]
            local a = {}
            for x = 1, i[3] do table.insert(a, s[i[2]+x]) end
            f(unpack(a))

        elseif o == 0xE5 then -- MATH ENGINE
            local mode = i[2] -- 1: Add, 2: Sub, 3: Mul, 4: Div
            local v1 = s[i[3]]
            local v2 = s[i[4]]
            local reg_out = i[5]
            
            if mode == 1 then _V[reg_out] = v1 + v2
            elseif mode == 2 then _V[reg_out] = v1 - v2
            elseif mode == 3 then _V[reg_out] = v1 * v2
            elseif mode == 4 then _V[reg_out] = v1 / v2
            end
            
            -- Push result back to active stack
            s[i[3]] = _V[reg_out]

        elseif o == 0xF6 then
            break
        end
        p = p + 1
    end
end

return z
