--------------------------------------------------------------------------------
-- Bit helper: Library of functions to help with bit manipulation.
-- Borrowed from: `Seth VanHeulen (Acacia@Odin)`
-- Extract function written by: `Windower Dev Team`.
--------------------------------------------------------------------------------
local bits = {}
function bits.new()
    local self = {}
    
    -- Private Variables
    local math = math
    
    self.tonumber = function(b)
        local num, ex, l, new = 0, ((b):length()-1), 0, ""
        l = ex + 1
        for i = 1, l do
            new = (b):sub(i,i)
            if new == "1" then
                num = num + 2^ex
            end
            ex = ex - 1
        end
        return string.format("%u", num)        
    end
    
    self.tobit = function(n)
        local result = ""
        repeat
            local divres = (n/2)
            local int, frac = math.modf(divres)
            n = int
            result = (math.ceil(frac)..result)
        until n == 0
        return tonumber(string.format(result, "s"))
    end
    
    self.bit = function(p)
        return (2^(p-1))
    end
    
    self.hasbit = function(x, p)
        return (x%(p+p)) >= p
    end
    
    self.setbit = function(x, p)
        return self.hasbit(x, p) and x or (x+p)
    end
    
    self.clearbit = function(x, p)
        return self.hasbit(x, p) and (x-p) or x
    end
    
    self.clearbits = function(s, p, c)
        if c and c > 1 then
            s=self.clearbits(s, (p+1), (c-1))
        end
        local b = math.floor(p/8)
        return (s:sub(1,b) .. string.char(self.clearbit(s:byte(b+1), self.bit(p%8))) .. s:sub(b+2))
    end
    
    self.checkbit = function(s, p)
        return self.hasbit(s:byte(math.floor(p/8)+1), self.bit(p%8))
    end
    
    self.extract = function(d, s, l)
        return d:unpack(("b"..l), (((s/8):floor())+1), ((s%8)+1))
    end    
    
    self.unpack = function(p, s, d)
        local p, s, d, r = p or false, s or false, d or false, ""
        if p and s and d and r == "" then
            for i=1, s, +1 do
                r = (r..d:unpack("b", p+1, i))
            end
        end
        return r
    end
    
    return self
    
end
return bits.new()
