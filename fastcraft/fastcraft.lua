_addon.name     = "fastcraft"
_addon.author   = "Elidyr"
_addon.version  = "0.20200421"
_addon.command  = "fast"

local color   = 22
local flags   = {fast=false, finish=false, quality=nil, enabled=false}
local res     = require("resources")
local packets = require("packets")
                require("chat")
                require("logger")
                require("pack")
        
--Commands Handler.
windower.register_event("addon command", function(...)
    
    local a = T{...}
    local c = a[1]:lower() or false
    
    if (c == "on" or c == "off" or c == "toggle") then
        
        if flags.enabled then
            flags.enabled = false
            windower.add_to_chat(22, "Fastcraft is now Disabled!")
            
        else
            flags.enabled = true
            windower.add_to_chat(22, "Fastcraft is now Enabled!")
            
        end
    
    end

end)

--------------------------------------------------------------------------------
-- Player Update.
--------------------------------------------------------------------------------
windower.register_event("incoming chunk", function(id,original,modified,injected,blocked)
    
    if id == 0x037 then
        local p = packets.parse("incoming", original)
        local timestamp = original:unpack("I", 0x40+1)
        
        if flags.fast then
            flags.finish = true
        end
        
    end
    
end)

--------------------------------------------------------------------------------
-- Item Synthesis.
--------------------------------------------------------------------------------
windower.register_event("incoming chunk", function(id,original,modified,injected,blocked)
    
    if id == 0x030  then
        local id        = original:unpack("I", 0x04+1) or false
        local index     = original:unpack("H", 0x08+1) or false
        local effect    = original:unpack("H", 0x0a+1) or false
        local param     = original:unpack("C", 0x0c+1) or false
        local animation = original:unpack("C", 0x0d+1) or false
        local wut       = original:unpack("C", 0x0e+1) or false
        local quality   = {[0] = "NQ Synthesis", [2] = "HQ Synthesis", [1] = "Break"}
        
        if id and index and effect and param and animation and animation == 44 and param ~= 1 and id == windower.ffxi.get_mob_by_target("me").id then
            local packet  = original:sub(1,4)..("I"):pack(id)..("H"):pack(index)..("H"):pack(effect)..("C"):pack(param)..("C"):pack(animation)..("C"):pack(120)
            flags.fast    = true
            flags.quality = param
            windower.add_to_chat(color, string.format("Fastcraft: %s", quality[param]))
            
            return packet
        
        else
            windower.add_to_chat(color, string.format("Fastcraft: %s", quality[param]))
            return original
        
        end

    end
    
end)

--------------------------------------------------------------------------------
-- Synth Result.
--------------------------------------------------------------------------------
windower.register_event("incoming chunk", function(id,original,modified,injected,blocked)
    
    if id == 0x06f then
        local inject  = ("Ibbbbbbbb"):pack(0, 0, 0, 0, 0, 0, 0, 0, 0)
        local result  = original:unpack("C", 0x04+1)
        local count   = original:unpack("C", 0x06+1)
        local _junk1  = original:unpack("C", 0x07+1)
        local item    = original:unpack("H", 0x08+1)
        local crystal = original:unpack("H", 0x22+1)
        local extra   = original:sub(37)
        local lost1,  lost2,  lost3,  lost4  = original:unpack("H", 0x0a+1), original:unpack("H", 0x0c+1), original:unpack("H", 0x0e+1), original:unpack("H", 0x10+1)
        local lost5,  lost6,  lost7,  lost8  = original:unpack("H", 0x12+1), original:unpack("H", 0x14+1), original:unpack("H", 0x16+1), original:unpack("H", 0x18+1)
        local skill1, skill2, skill3, skill4 = original:unpack("C", 0x1a+1), original:unpack("C", 0x1b+1), original:unpack("C", 0x1c+1), original:unpack("C", 0x1d+1)
        local up1,    up2,    up3,    up4    = original:unpack("C", 0x1e+1), original:unpack("C", 0x1f+1), original:unpack("C", 0x20+1), original:unpack("C", 0x21+1)
        local quality
        local success
        
        if flags.quality == 0 then
            quality, success = 0, 0
            
        elseif flags.quality == 2 then
            
            quality, success = 2, 0
            
        else
            quality, success = -1, 1
            
        end
        
        if flags.fast and flags.finish then
            
            if item then
                
                if result == 14 then
                    local packed = ("iCCCCHHHHHHHHHCCCCCCCCH"):pack(0x00006f08, success, quality, count, _junk1, item, lost1, lost2, lost3, lost4, lost5, lost6, lost7, lost8, skill1, skill2, skill3, skill4, up1, up2, up3, up4, crystal):append(extra)
                    
                    windower.packets.inject_incoming(0x6f, packed)
                    flags.finish = false
                    flags.fast   = false
                    
                end 
            
            end
            
        else
            return original
            
        end
        return true
        
    end

end)