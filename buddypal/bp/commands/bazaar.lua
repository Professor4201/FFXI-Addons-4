--------------------------------------------------------------------------------
-- Bazaar Command: Handles executing Bazaar helper.
--------------------------------------------------------------------------------
local bazaar = {}
function bazaar.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local command = command:lower()
            
            if command == "list" then
                
            elseif command == "remove" then
                
            end
            
        end
        
        
    end
    
    return self
    
end
return bazaar.run()