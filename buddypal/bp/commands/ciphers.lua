--------------------------------------------------------------------------------
-- Ciphers Commands: Handles commands for Cipher trades to NPC.
--------------------------------------------------------------------------------
local ciphers = {}
function ciphers.run()
    local self = {}

    self.execute = function(commands)
        local target   = windower.ffxi.get_mob_by_target("t") or false
        local item     = bpcore:findItemByName("cipher") or false
        local commands = commands or false
        
        if commands and target and item then
            helpers["ciphers"].trade(target, {item, 1})
        
        end
    
    end

    return self
    
end
return ciphers.run()