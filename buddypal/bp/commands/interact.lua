--------------------------------------------------------------------------------
-- Interact Command: Handles commands for Interact helper.
--------------------------------------------------------------------------------
local interact = {}
function interact.run()
    self = {}
    
    self.execute = function(commands)
        local command = commands[2] or false
        local target  = windower.ffxi.get_mob_by_target("t") or false
        
        if not command and target then
            helpers["interact"].interact(target.id)
            
        elseif command and not target and tonumber(command) ~= nil then
            local id = tonumber(command) or false
            
            if id and npcs[id] then
                helpers["interact"].interact(id)
            end
        
        elseif command and target and command == "all" then
            local id = target.id or false
            
            if id then
                local message = string.format("bp > P- bp interact %s", target.id)
                
                if npcs[id] then
                    windower.send_command(message)
                    helpers["interact"].interact(npcs[id].id, 0.4)
                end
                
            end
        
        end
        
    end
    
    return self
    
end
return interact.run()