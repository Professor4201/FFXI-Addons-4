--------------------------------------------------------------------------------
-- Moghouse commands: This controls all commands relating to alliance adjustments.
--------------------------------------------------------------------------------
local moghouse = {}
function moghouse.run()
    self = {}
    
    -- Private variables.
    local player = windower.ffxi.get_mob_by_target("me")
    
    self.execute = function()
        local inject = 'ibbb':pack(0x00002e00, 0x02, 0x00, 0x00)
        windower.packets.inject_incoming(0x2e, inject)
        
    end
    
    return self 

end
return moghouse.run()
