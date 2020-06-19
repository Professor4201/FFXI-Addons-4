--------------------------------------------------------------------------------
-- Clusters Command: Handles executing Cluster Farming bot in Ru'Aun Gardens.
--------------------------------------------------------------------------------
local clusters = {}
function clusters.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local command = command:lower()
            
            if command == "start" then
                helpers["events"].register("Farm", "Clusters")
                
            elseif command == "end" then
                helpers["events"].finishEvent("Farm")
            
            end
        
        end
        
    end
    
    return self
    
end
return clusters.run()