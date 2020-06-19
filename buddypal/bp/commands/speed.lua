--------------------------------------------------------------------------------
-- Speed Command: Set your characters base speed of movement.
--------------------------------------------------------------------------------
local speed = {}
function speed.run()
    self = {}
    
    self.execute = function(commands)
        local command = commands[2] or false
    
        if command then
            local command = command:lower()
            
            if (command == "on" or command == "off" or command == "toggle") then
                helpers["speed"].toggle()
            
            elseif ("rate"):match(command) then
                local value = tonumber(commands[3]) or false
                
                if value and value <= 800 then
                    helpers["speed"].setSpeed(value)
                    
                else    
                    helpers["popchat"]:pop(("PLEASE ENTER A VALUE BETWEEN 1-800"):upper(), system["Popchat Window"])
                
                end
                
            end
        
        elseif not command then
            helpers["speed"].toggle()
        
        end
    
    end
    
    return self    
    
end
return speed.run()