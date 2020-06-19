--------------------------------------------------------------------------------
-- Sparks Commands: Handles all sparks related commands.
--------------------------------------------------------------------------------
local sparks = {}
function sparks.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local target   = windower.ffxi.get_mob_by_target("t") or false
        local commands = commands or false
        local command  = {}
        local quantity
        
        for i=2, #commands do

            if tonumber(commands[i]) ~= nil then
                quantity = tonumber(commands[i])
                
            elseif tonumber(commands[i]) == nil then
                table.insert(command, commands[i])
            
            end
            
        end

        if command and target and quantity then
            local command = table.concat(command, " ")
            local scan    = windower.convert_auto_trans(command):sub(1, #command):lower()
            
            if scan then 
                helpers["sparks"].setItem(scan)
                helpers["sparks"].setQuantity(tonumber(quantity))
                helpers["sparks"].setInjecting(true)
                helpers["actions"].poke(target)
                
            end
        
        end
    
    end

    return self
    
end
return sparks.run()