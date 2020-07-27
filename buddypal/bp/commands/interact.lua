--------------------------------------------------------------------------------
-- Interact Commands: Handles all commands for all npc interactions.
--------------------------------------------------------------------------------
local interact = {}
function interact.run()
    local self = {}
    
    self.execute = function(commands)
        local name = commands[2] or false
        
        if name then
            helpers["interact"].find(name)
        
        elseif not name then
            helpers["interact"].clearAll()
            
        end    
    
    end
    
    return self 

end
return interact.run()