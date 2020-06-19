--------------------------------------------------------------------------------
-- Party commands: This controls all commands relating to party invites and party adjustments.
--------------------------------------------------------------------------------
local party = {}
function party.run()
    self = {}
    
    -- Private variables.
    local player = windower.ffxi.get_mob_by_target("me")
    
    self.execute = function(commands)
        local command = commands[2] or false

        if command then
            
            if command == "invite" then
                local invite    = {}
                local delay     = system["Orders Delay"] + 1.5
                local structure = commands[3] or false
                local command   = command:lower()

                if structure and structure == "+" and system["Party Structures"][player.name] then

                    for _,v in ipairs(system["Party Structures"][structure]) do
                        
                        if v and v ~= player.name then
                            table.insert(invite, ("pcmd add " .. v .. "; wait " .. delay .. ";"))
                        end
                        
                    end
                    windower.send_command(table.concat(invite[player.name], " "))
                    
                else
                    
                    for _,v in ipairs(system["Characters"]) do
                        
                        if v and v ~= player.name then
                            table.insert(invite, ("pcmd add " .. v .. "; wait " .. delay .. ";"))
                        end
                        
                    end
                    windower.send_command(table.concat(invite, " "))
                    
                end
            
            elseif command == "leader" then
            
                if (system["Party"]["Parties"].leader1 ~= player.id or system["Party"]["Parties"].leader2 ~= player.id or system["Party"]["Parties"].leader3 ~= player.id) then
                    windower.send_command("bp > @ bp party transfer_leadership " .. player.name)
                
                end
            
            elseif command == "break" then
                if (system["Party"]["Parties"].leader1 == player.id or system["Party"]["Parties"].leader2 == player.id or system["Party"]["Parties"].leader3 == player.id) then
                    windower.send_command("pcmd breakup")
                
                end
                   
                   
            elseif command == "transfer_leadership" then
                local transfer = commands[3] or false
                
                if transfer and (system["Party"]["Parties"].leader1 == player.id or system["Party"]["Parties"].leader2 == player.id or system["Party"]["Parties"].leader3 == player.id) then
                    windower.send_command("pcmd leader " .. transfer)
                
                end
                
            end            
        
        elseif not command then
            windower.send_command("bp party invite")
        
        end
        
    end
    
    --------------------------------------------------------------------------------------
    -- Handle the return of all current settings.
    --------------------------------------------------------------------------------------
    self.settings = function()
        
        return {
            
        }
    
    end
    
    return self 

end
return party.run()
