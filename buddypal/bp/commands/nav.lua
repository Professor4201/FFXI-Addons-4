--------------------------------------------------------------------------------
-- Nav Command: Handles all the commands sent for the navigation.
--------------------------------------------------------------------------------
local nav = {}
function nav.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        local ext     = commands[3] or false
        
        if command and ext then
            local command = command:lower()
            local ext     = ext:lower()
                
            if command == "load" then
                helpers["nav"].loadPath(ext)
            
            elseif command == "new" then
                helpers["nav"].new(ext)
            
            elseif command == "delete" then
                helpers["nav"].delete(ext)
            
            end
        
        elseif command and not ext then
            local command = command:lower()
            
            if command == "record" then
                helpers["nav"].record()
                
            elseif (command == "run" or command == "start" or command == "stop" or command == "toggle") then
                helpers["nav"].toggle()
                
            elseif command == "mode" then
                helpers["nav"].mode()
                
            elseif command == "list" then
                helpers["nav"].list()
                
            end
        
        elseif not command then
            helpers["nav"].toggle()
            
        end
       
    end
    
    return self
    
end
return nav.run()