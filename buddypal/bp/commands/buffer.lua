--------------------------------------------------------------------------------
-- Buffer Commands: Handles all commands in regards to auto-buffing functionality on target party members.
--------------------------------------------------------------------------------
local buffer = {}
function buffer.run()
    local self = {}
    
    self.execute = function(commands)
        local target = windower.ffxi.get_mob_by_target("t") or false
        local spell  = commands[2] or false
        local delay  = commands[3] or false
        
        if target and spell then
            helpers["buffer"].commands(target, spell:lower(), delay)
        end
        
        
    end
    
    return self
    
end
return buffer.run()