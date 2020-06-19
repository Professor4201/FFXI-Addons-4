--------------------------------------------------------------------------------
-- PartyUI Commands: Handles commands to use any of the rings that handle teleportation.
--------------------------------------------------------------------------------
local partyui = {}
function partyui.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        local target  = windower.ffxi.get_mob_by_target("t") or false
        
        if command and target then
            local scan = windower.convert_auto_trans(command):sub(1, #command):lower()

            if ("acheron shield"):match(scan) then
            end
        
        end
    
    end

    return self
    
end
return partyui.run()