--------------------------------------------------------------------------------
-- Rings Commands: Handles commands to use any of the rings that handle teleportation.
--------------------------------------------------------------------------------
local rings = {}
function rings.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            
            if command == "dem" then
                
                if bpcore:checkTimestamp("Warp Ring", "minute", 10) and (system["BP Allowed"][windower.ffxi.get_info().zone] or not system["BP Allowed"][windower.ffxi.get_info().zone]) then
                    helpers['actions'].equipItem("Warp Ring", 13)
                    helpers['queue'].add(IT["Warp Ring"], "me"):schedule(13)
                    helpers['queue'].handleQueue():schedule(0.2)
                    helpers["popchat"]:pop(("USING TELEPORT-DEM RING!"), system["Popchat Window"])
                    return true
                
                end
                
            end
        
        end
    
    end

    return self
    
end
return rings.run()