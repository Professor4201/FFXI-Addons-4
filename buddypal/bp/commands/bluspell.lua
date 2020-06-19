--------------------------------------------------------------------------------
-- Bluspell Command: Handles executing Bluespell functions.
--------------------------------------------------------------------------------
local bluspell = {}
function bluspell.run()
    self = {}
    
    self.execute = function(commands)
        local command = commands[2] or false

        if command then
            local command = command:lower()
            local arg     = commands[3] or false

            if command == "new" and arg then
                local set_name = arg:lower()
                helpers["bluspell"].new(set_name)
                    
            elseif command== "delete" and arg then
                local set_name = arg:lower()
                helpers["bluspell"].delete(set_name)
            
            elseif command == "set" and arg then
                local set_name = arg:lower()
                helpers["bluspell"].set(set_name)
                
            elseif command == "default" and arg then
                local set_name = arg:lower()
                helpers["bluspell"].default(set_name)
                
            elseif command == "save" and not arg then
                helpers["bluspell"].save()
                
            elseif command == "list" and not arg then
                helpers["bluspell"].list()
                
            end
            
        end
        
    end
    
    return self
    
end
return bluspell.run()