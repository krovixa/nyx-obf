-- [[ dev: krovixa | hw: SM-T225 ]] --
-- basic cff + vm implementation (ref: prometheus/moonsec)

local z = {}

-- op mapping
local _OP = {
	i_ld = 0x11, -- loadk
	g_gt = 0x22, -- getgenv/getglb
	f_cl = 0x33, -- call
	s_jp = 0x44, -- jump
	s_if = 0x55, -- cond_jump
	m_th = 0x66, -- math
	h_lt = 0x00  -- halt
}

function z.execute(b, k)
	local s = {} -- reg stack
	local p = 1  -- pointer
	
	-- main dispatcher loop
	while p > 0 do
		local i = b[p]
		if not i then break end
		
		local op = i[1]
		
		-- load immediate / constant
		if op == 0x11 then
			s[i[2]] = k[i[3]]
			p = p + 1
			
		-- get global
		elseif op == 0x22 then
			s[i[2]] = _G[k[i[3]]]
			p = p + 1
			
		-- function call logic
		elseif op == 0x33 then
			local f = s[i[2]]
			local args = {}
			for x = 1, i[3] do
				args[x] = s[i[2] + x]
			end
			f(unpack(args))
			p = p + 1
			
		-- prometheus style flattening (state jumps)
		elseif op == 0x44 then
			p = i[2] 
			
		-- conditional flattening (the 'if' killer)
		elseif op == 0x55 then
			if s[i[2]] then
				p = i[3]
			else
				p = i[4]
			end
			
		-- math logic ((0 * 5 = 5 + 0))
		elseif op == 0x66 then
			local mode = i[2]
			local v1, v2 = s[i[3]], s[i[4]]
			
			if mode == 1 then -- add
				s[i[3]] = v1 + v2
			elseif mode == 3 then -- mul
				s[i[3]] = v1 * v2
			end
			p = p + 1
			
		-- kill process
		elseif op == 0x00 then
			p = 0
		else
			p = p + 1
		end
	end
end

return z
