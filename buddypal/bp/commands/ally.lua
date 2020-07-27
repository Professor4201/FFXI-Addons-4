--------------------------------------------------------------------------------
-- Alliance commands: This controls all commands relating to alliance adjustments.
--------------------------------------------------------------------------------
local ally = {}
function ally.run()
    local self = {}
    
    -- Private variables.
    local player = windower.ffxi.get_mob_by_target("me")
    
    self.execute = function(commands)
        local command = commands[2] or false

        if command then
            
            if command == "leader" then
            
                if (system["Party"]["Parties"].leader1 == player.id or system["Party"]["Parties"].leader2 == player.id or system["Party"]["Parties"].leader3 == player.id) then
                    windower.send_command("bp > @ bp ally transfer_leadership " .. player.name)
                
                end
            
            elseif command == "break" then
                if system["Party"]["Alliance"].leader == player.id then
                    windower.send_command("acmd breakup")
                
                end
                   
                   
            elseif command == "transfer_leadership" then
                local transfer = commands[3] or false
                
                if transfer and system["Party"]["Alliance"].leader == player.id then
                    windower.send_command("acmd leader " .. transfer)
                
                end
                
            end
        
        end
        
    end
    
    return self 

end
return ally.run()
