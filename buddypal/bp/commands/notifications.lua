--------------------------------------------------------------------------------
-- Notifications Command: Handles notification commands.
--------------------------------------------------------------------------------
local notifications = {}
function notifications.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local command = command:lower()
            
            if (command == "on" command == "off" or command == "toggle") then
                helpers["notifications"].toggle()
                
            end
        
        if not command then
            helpers["notifications"].toggle()
        
        end
        
    end
    
    return self
    
end
return notifications.run()