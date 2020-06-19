--------------------------------------------------------------------------------
-- Orders helper: This helper handles IPC messages to other accounts currently running.
--------------------------------------------------------------------------------
local orders = {}
function orders.new()
    self = {}
    
    self.buildCommand = function(commands, start)
        local start = start or 4
        return table.concat(commands, " ", start)
        
    end
    
    --------------------------------------------------------------------------------
    -- Send an order to all currently active accounts.
    --------------------------------------------------------------------------------
    self.orderAll = function(command, delay)
        
        if delay then
            delay = system["Orders Delay"]
        end
        
        if command then
            local commands = command:split(" ")
            local delay    = delay or 0
            
            if commands then
                
                if commands[1]:sub(1,1) == "!" and windower.ffxi.get_mob_by_target("me") then
                    local name      = windower.ffxi.get_mob_by_target("me").name
                    local blacklist = commands[1]:sub(2):lower()
                    local build     = table.concat( { helpers["orders"].buildCommand(command:split(" "), 2) }, " ")
                    local deliver   = ""
                    local passed    = false
                    
                    for _,v in ipairs(system["Characters"]) do
                        
                        if v and v ~= "" then
                            
                            if name:lower() == v:lower() and not (name:lower():sub(1, #blacklist)):match(blacklist) then
                                passed = true
                                
                            elseif not (v:lower():sub(1, #blacklist)):match(blacklist) then
                                deliver = (deliver .. table.concat({ ("+"..v:lower()), commands[1], ("wait "..delay..";"), (helpers["orders"].buildCommand(command:split(" "), 2)..";"), "" }, " "))
                                
                                if delay ~= 0 then
                                    delay = (delay + 0.8)
                                end
                                
                            end
                            
                        end
                        
                    end
                    windower.send_ipc_message(deliver)
                    
                    if passed then
                        windower.send_command(build)
                    end
                
                else
                    
                    if windower.ffxi.get_mob_by_target("me") then
                    
                        local name      = windower.ffxi.get_mob_by_target("me").name
                        local build     = table.concat( { helpers["orders"].buildCommand(command:split(" "), 1) }, " ")
                        local deliver   = ""
                        
                        for _,v in ipairs(system["Characters"]) do
                            
                            if v and v ~= "" then
                                deliver = (deliver .. table.concat({ ("+"..v:lower()), ("wait "..delay..";"), (helpers["orders"].buildCommand(command:split(" "), 1)..";"), "" }, " "))
                                
                                if delay ~= 0 then
                                    delay = (delay + 0.8)
                                end
                                
                            end
                            
                        end
                        windower.send_ipc_message(deliver)
                        windower.send_command(build)
                    
                    end
                    
                end
                
            end
        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Have a specific account send out an order to all other accounts.
    --------------------------------------------------------------------------------
    self.orderOthers = function(command, delay)
        
        if delay then
            delay = system["Orders Delay"]
        end
        
        if command then
            local commands = command:split(" ")
            local delay    = delay or 0
            
            if commands then
                
                if commands[1]:sub(1,1) == "!" and windower.ffxi.get_mob_by_target("me") then
                    local name      = windower.ffxi.get_mob_by_target("me").name
                    local blacklist = commands[1]:sub(2):lower()
                    local build     = table.concat( { helpers["orders"].buildCommand(command:split(" "), 2) }, " ")
                    local deliver   = ""
                    
                    for _,v in ipairs(system["Characters"]) do
                        
                        if v and v ~= "" and v ~= name:lower() then
                                
                            if not (v:lower():sub(1, #blacklist)):match(blacklist) then
                                deliver = (deliver .. table.concat({ ("+"..v:lower()), commands[1], ("wait "..delay..";"), (helpers["orders"].buildCommand(command:split(" "), 2)..";"), "" }, " "))
                                
                                if delay ~= 0 then
                                    delay = (delay + 0.8)
                                end
                                
                            end
                            
                        end
                        
                    end
                    windower.send_ipc_message(deliver)
                
                else
                    
                    if windower.ffxi.get_mob_by_target("me") then
                    
                        local name      = windower.ffxi.get_mob_by_target("me").name
                        local build     = table.concat( { helpers["orders"].buildCommand(command:split(" "), 1) }, " ")
                        local deliver   = ""
                        
                        
                        for _,v in ipairs(system["Characters"]) do
                            
                            if v and v ~= "" and v ~= name:lower() then
                                deliver = (deliver .. table.concat({ ("+"..v:lower()), ("wait "..delay..";"), (helpers["orders"].buildCommand(command:split(" "), 1)..";"), "" }, " "))
                                
                                if delay ~= 0 then
                                    delay = (delay + 0.8)
                                end
                                
                            end
                            
                        end
                        windower.send_ipc_message(deliver)
                    
                    end
                    
                end
                
            end
        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Order other accounts in range of a player to perform specific commands.
    --------------------------------------------------------------------------------
    self.orderInRange = function(command, delay)
        
        if delay then
            delay = system["Orders Delay"]
        end
        
        if command then
            local commands = command:split(" ")
            local delay    = delay or 0
            local distance = system["Orders Range"]
            
            if commands then
                
                if commands[1]:sub(1,1) == "!" and windower.ffxi.get_mob_by_target("me") then
                    local name      = windower.ffxi.get_mob_by_target("me").name
                    local blacklist = commands[1]:sub(2):lower()
                    local build     = table.concat( { helpers["orders"].buildCommand(command:split(" "), 2) }, " ")
                    local deliver   = ""
                    
                    for _,v in ipairs(system["Characters"]) do
                        
                        if v and v ~= "" and v ~= name:lower() and windower.ffxi.get_mob_by_name(v) and math.sqrt(windower.ffxi.get_mob_by_name(v).distance) < distance then
                            
                            if not (v:lower():sub(1, #blacklist)):match(blacklist) then
                                deliver = (deliver .. table.concat({ ("+"..v:lower()), commands[1], ("wait "..delay..";"), (helpers["orders"].buildCommand(command:split(" "), 2)..";"), "" }, " "))
                                
                                if delay ~= 0 then
                                    delay = (delay + 0.8)
                                end
                                
                            end
                            
                        end
                        
                    end
                    windower.send_ipc_message(deliver)
                
                else
                    
                    if windower.ffxi.get_mob_by_target("me") then
                    
                        local name      = windower.ffxi.get_mob_by_target("me").name
                        local build     = table.concat( { helpers["orders"].buildCommand(command:split(" "), 1) }, " ")
                        local deliver   = ""
                        
                        for _,v in ipairs(system["Characters"]) do
                            
                            if v and v ~= "" and v ~= name:lower() and windower.ffxi.get_mob_by_name(v) and math.sqrt(windower.ffxi.get_mob_by_name(v).distance) < distance then
                                deliver = (deliver .. table.concat({ ("+"..v:lower()), ("wait "..delay..";"), (helpers["orders"].buildCommand(command:split(" "), 1)..";"), "" }, " "))
                                
                                if delay ~= 0 then
                                    delay = (delay + 0.8)
                                end
                                
                            end
                            
                        end
                        windower.send_ipc_message(deliver)
                    
                    end
                    
                end
                
            end
        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Order all accounts in range of a player to perform specific commands.
    --------------------------------------------------------------------------------
    self.orderAllInRange = function(command, delay)
        
        if delay then
            delay = system["Orders Delay"]
        end
        
        if command then
            local commands = command:split(" ")
            local delay    = delay or 0
            local distance = system["Orders Range"]
            
            if commands then
                
                if commands[1]:sub(1,1) == "!" and windower.ffxi.get_mob_by_target("me") then
                    local name      = windower.ffxi.get_mob_by_target("me").name
                    local blacklist = commands[1]:sub(2):lower()
                    local build     = table.concat( { helpers["orders"].buildCommand(command:split(" "), 2) }, " ")
                    local deliver   = ""
                    local passed    = false
                    
                    for _,v in ipairs(system["Characters"]) do
                        delay = delay + delay
                        
                        if v and v ~= "" and v ~= name:lower() and windower.ffxi.get_mob_by_name(v) and math.sqrt(windower.ffxi.get_mob_by_name(v).distance) < distance then
                            
                            if name:lower() == v:lower() and not (name:lower():sub(1, #blacklist)):match(blacklist) then
                                passed = true
                            
                            elseif not (v:lower():sub(1, #blacklist)):match(blacklist) then
                                deliver = (deliver .. table.concat({ ("+"..v:lower()), commands[1], ("wait "..delay..";"), (helpers["orders"].buildCommand(command:split(" "), 2)..";"), "" }, " "))
                                
                                if delay ~= 0 then
                                    delay = (delay + 0.8)
                                end
                                
                            end
                            
                        end
                        
                    end
                    windower.send_ipc_message(deliver)
                    
                    if passed then
                        windower.send_command(build)
                    end
                
                else
                    
                    if windower.ffxi.get_mob_by_target("me") then
                    
                        local name      = windower.ffxi.get_mob_by_target("me").name
                        local build     = table.concat( { helpers["orders"].buildCommand(command:split(" "), 1) }, " ")
                        local deliver   = ""
                        
                        
                        for _,v in ipairs(system["Characters"]) do
                            
                            if v and v ~= "" and v ~= name:lower() and windower.ffxi.get_mob_by_name(v) and math.sqrt(windower.ffxi.get_mob_by_name(v).distance) < distance then
                                deliver = (deliver .. table.concat({ ("+"..v:lower()), ("wait "..delay..";"), (helpers["orders"].buildCommand(command:split(" "), 1)..";"), "" }, " "))
                                
                                if delay ~= 0 then
                                    delay = (delay + 0.8)
                                end
                                
                            end
                            
                        end
                        windower.send_ipc_message(deliver)
                        windower.send_command(build)
                    
                    end
                    
                end
                
            end
        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Order all accounts in party of a player to perform specific commands.
    --------------------------------------------------------------------------------
    self.orderInParty = function(command, delay)
        
        if delay then
            delay = 0.5
        end
        
        if command then
            local commands = command:split(" ")
            local delay    = delay or 0
            
            if commands then
                
                if commands[1]:sub(1,1) == "!" and windower.ffxi.get_mob_by_target("me") then
                    local name      = windower.ffxi.get_mob_by_target("me").name
                    local blacklist = commands[1]:sub(2):lower()
                    local build     = table.concat( { helpers["orders"].buildCommand(command:split(" "), 2) }, " ")
                    local deliver   = ""
                    local passed    = false
                    
                    for _,v in ipairs(system["Characters"]) do
                        
                        if v and v ~= "" and system["Party"]["Players"][v] then

                            if name:lower() == v:lower() and not (name:lower():sub(1, #blacklist)):match(blacklist) then
                                passed = true
                            
                            elseif not (v:lower():sub(1, #blacklist)):match(blacklist) then
                                deliver = (deliver .. table.concat({ ("+"..v:lower()), commands[1], ("wait "..delay..";"), (helpers["orders"].buildCommand(command:split(" "), 2)..";"), "" }, " "))
                                
                                if delay ~= 0 then
                                    delay = (delay + 0.8)
                                end
                                
                            end
                            
                        end
                        
                    end
                    windower.send_ipc_message(deliver)
                    
                    if passed then
                        windower.send_command(build)
                    end
                
                else
                    
                    if windower.ffxi.get_mob_by_target("me") then
                    
                        local name      = windower.ffxi.get_mob_by_target("me").name
                        local build     = table.concat( { helpers["orders"].buildCommand(command:split(" "), 1) }, " ")
                        local deliver   = ""
                        
                        
                        for _,v in ipairs(system["Characters"]) do
                            
                            if v and v ~= "" and system["Party"]["Players"][v] then
                                deliver = (deliver .. table.concat({ ("+"..v:lower()), ("wait "..delay..";"), (helpers["orders"].buildCommand(command:split(" "), 1)..";"), "" }, " "))
                                
                                if delay ~= 0 then
                                    delay = (delay + 0.8)
                                end
                                
                            end
                            
                        end
                        windower.send_ipc_message(deliver)
                        windower.send_command(build)
                    
                    end
                    
                end
                
            end
        
        end
        
    end
    
    return self

end
return orders.new()