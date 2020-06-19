--------------------------------------------------------------------------------
-- Aeonic Commands: Handles commands for Aeonic KI purchases.
--------------------------------------------------------------------------------
local aeonic = {}
function aeonic.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local target   = windower.ffxi.get_mob_by_target("t") or false
        local commands = commands or false
        
        if commands then
            local command = table.concat(commands, " "):sub(#commands[1]+2)

            if command and target then                
                helpers["aeonic"].setWeapon(windower.convert_auto_trans(command))
                helpers["aeonic"].setInjecting(true)
                helpers["actions"].poke(target)
                
            end
        
        end
    
    end

    return self
    
end
return aeonic.run()