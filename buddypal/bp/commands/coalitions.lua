--------------------------------------------------------------------------------
-- Coalitions Command: Adjust which coalition you are currently working on..
--------------------------------------------------------------------------------
local coalitions = {}
function coalitions.run()
    local self = {}
    
    self.execute = function(commands)
        local commands = commands or false
        
        if commands then
            local command = commands[2]
            
            if command and command:lower() == "toggle" then
                helpers["coalitions"].toggle()
                
            elseif command and command:lower() == "repeat" then
                helpers["coalitions"].repeating()
                
            elseif command then
                helpers["coalitions"].runCoalition(command)
                
            end            
            
        elseif not commands then
            helpers["coalitions"].toggle()
        
        end
        
    end
    
    return self
    
end
return coalitions.run()