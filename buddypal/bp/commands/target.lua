--------------------------------------------------------------------------------
-- Target Commands: Handles all commands related to setting the targets for the player.
--------------------------------------------------------------------------------
local target = {}
function target.run()
    self = {}
    
    -- Private Variables
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        local target  = windower.ffxi.get_mob_by_target("t") or false
        
        if command then
            local mode = helpers["target"].getTargetMode()
            
            if command == "player" or command == "me" and target then
                helpers['target'].setPlayerTarget(target)
                
            elseif command == "party" or command == "pt" and target then
                helpers['target'].setPartyTarget(target)
                windower.send_command(("bp > R bp target send_id " .. tostring(target.id)))
                
            elseif command == "gtarget" and target and system["Player"].main_job == "GEO" then
                helpers['target'].setLuopanTarget(target)
                
            elseif command == "etarget" and target and system["Player"].main_job == "GEO" and bpcore:isInParty(target) then
                helpers['target'].setEntrustTarget(target)
                
            elseif command == "send_id" then
                local id = commands[3] or false

                if id then
                    local sent_target = windower.ffxi.get_mob_by_id(tonumber(id)) or false
                    
                    if target then
                        helpers['target'].setPartyTarget(sent_target.id)
                    end
                
                end
                
            elseif command == "mode" then
                helpers["target"].setTargetMode()
                
            end
            
        end
    
    end

    return self
    
end
return target.run()