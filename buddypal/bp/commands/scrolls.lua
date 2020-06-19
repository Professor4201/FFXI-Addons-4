--------------------------------------------------------------------------------
-- Scrolls commands: Handles all commands for buying scrolls hidden in NPC shops.
--------------------------------------------------------------------------------
local scrolls = {}
function scrolls.run()
    self = {}
    
    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local command = command:lower()
            
            if command == "buy" then
                local target = windower.ffxi.get_mob_by_target("t")
                
                if target then
                    helpers["scrolls"].shop(target)
                end
                
            end
            
        end
    
    end
    
    return self 

end
return scrolls.run()
