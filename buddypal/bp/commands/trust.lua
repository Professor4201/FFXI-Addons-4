--------------------------------------------------------------------------------
-- Trust Command: Handles all the commands related to trust settings.
--------------------------------------------------------------------------------
local trust = {}
function trust.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local command = command:lower()
                
            if command == "max" then
                local number = commands[3] or false
                
                if number and tonumber(number) ~= nil then
                    local number = tonumber(number)
                    
                    if number > 3 and number < 6 then
                        helpers["popchat"]:pop((string.format("Max trust now set to: %s.", number)):upper(), system["Popchat Window"])
                        
                    else
                        helpers["popchat"]:pop(("Max trust must be a number between 3 and 5."):upper(), system["Popchat Window"])
                        
                    end
                    
                end
            
            elseif command == "set" then
                local slot = commands[3] or false
                local name = {}
                
                for i=4, #commands do
                    table.insert(name, commands[i])
                end
                
                name = table.concat(name, " ")
                
                if slot and name and tonumber(slot) ~= nil and type(name) == "string" and #name > 5 then
                    local slot = tonumber(slot)
                    local name = name:sub(1,#name):lower()
                    local has_spell = false
                    
                    if slot > 0 and slot < 6 then
                        
                        for i,v in pairs(windower.ffxi.get_spells()) do

                            if i and res.spells[i] and v then
                                local found = res.spells[i].en
                                
                                if (found:sub(1, #name):lower() == name and #name < 7 and #found == #name) or (found:sub(1, #name):lower() == name and #name > 6) then  
                                    helpers["trust"].setTrust(slot, found)
                                    helpers["popchat"]:pop((string.format("Slot [%s] is now set to: %s.", slot, found)):upper(), system["Popchat Window"])
                                    has_spell = true
                                    
                                end
                            
                            end
                            
                        end
                        
                        if not has_spell then
                            helpers["popchat"]:pop(("Pleas make sure that you have this trust available."):upper(), system["Popchat Window"])
                        end
                        
                    else
                        helpers["popchat"]:pop(("Please enter a number between 1 and 5."):upper(), system["Popchat Window"])
                        
                    end
                
                else
                    helpers["popchat"]:pop(("Proper command format is: //bp trust set <slot> <trust_name>."):upper(), system["Popchat Window"])
                
                end
            
            end
        
        elseif not command then
            helpers["trust"].toggle()
        
        end
       
    end
    
    return self
    
end
return trust.run()