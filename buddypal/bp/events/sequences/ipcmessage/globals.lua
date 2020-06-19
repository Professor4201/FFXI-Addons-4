local globals = {}
    
--------------------------------------------------------------------------------
-- Windower IPC Message Event
--------------------------------------------------------------------------------
globals[1] = function(message)
    local player  = windower.ffxi.get_player()
    local message = message or false
    
    if player and message then
        local commands = message:split(" ")
        
        if commands and player.name then
            local command = {}
            local current = ""
            local built   = false
            local name    = (player.name):lower()
            
            for i,v in ipairs(commands) do
                
                if v:sub(1,1) == "+" and built then
                    break
                end
                
                if v and v:sub(1,1) == "+" and v:sub(2) == name then
                    current = v:sub(2)
                    command[current] = {}
                    built = true
                
                end
                
                if v and v ~= "" and command[current] and current == name and v:sub(1,1) ~= "+" then
                    table.insert(command[current], v)
                end
                
            end

            if command[name] then
                windower.send_command(table.concat(command[name], " "))
            end
            
        end
    
    end
    
end

return globals