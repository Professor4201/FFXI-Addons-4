--------------------------------------------------------------------------------
-- Nav Commands: Handles all commands related to the Nav Helper.
--------------------------------------------------------------------------------
local nav = {}
function nav.run()
    local self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local command = command:lower()
            
            if command == "record" then
                helpers["nav"].record()
            end
            
        elseif not command then
            helpers["nav"].record()
        end
        
    end
    
    return self
    
end
return nav.run()