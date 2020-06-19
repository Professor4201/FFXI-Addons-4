--------------------------------------------------------------------------------
-- shops commands: Handles all commands for buying scrolls hidden in NPC shops.
--------------------------------------------------------------------------------
local shops = {}
function shops.run()
    self = {}
    
    self.execute = function(commands)
        local target  = windower.ffxi.get_mob_by_target("t")
            
        if target then
            helpers["shops"].shop(target)                
        end
    
    end
    
    return self 

end
return shops.run()
