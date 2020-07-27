--------------------------------------------------------------------------------
-- MagicMaps Command: Handles all the commands for buying magic maps from NPCs.
--------------------------------------------------------------------------------
local magicmaps = {}
function magicmaps.run()
    local self = {}
    
    -- Private Variables
    local vendors = T{"Promurouve"}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local command = command:lower()
                
            if command == "buy" then
                local target = windower.ffxi.get_mob_by_target("t")
                
                if target and vendors:contains(target.name) then
                    helpers["events"].register("Maps", target.name)
                    coroutine.sleep(0.2)
                    helpers["actions"].doAction(target, false, "interact")
                    
                end
            
            end
            
        end
       
    end
    
    return self
    
end
return magicmaps.run()