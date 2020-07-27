--------------------------------------------------------------------------------
-- Farmer Command: Handles all farmer helper commands.
--------------------------------------------------------------------------------
local farmer = {}
function farmer.run()
    local self = {}

    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local command = command:lower()
            
            if command == "new" then
                local ext = commands[3] or false
                
                if ext then
                    local ext = ext:lower()
                    helpers["farmer"].new(ext)
                    
                end
            
            elseif command == "delete" then
                local ext = commands[3] or false
                
                if ext then
                    local ext = ext:lower()
                    helpers["farmer"].delete(ext)
                    
                end
                
            elseif command == "load" then
                local ext = commands[3] or false
                
                if ext then
                    local ext = ext:lower()
                    helpers["farmer"].load(ext)
                    
                end
                
            elseif command == "add" then
                local target = windower.ffxi.get_mob_by_target("t") or false
                
                if target then
                    helpers["farmer"].addToList(target)
                
                end
            
            elseif command == "mode" then
                helpers["farmer"].mode()
                
            elseif (command == "on" or command == "toggle" or command == "off") then
                helpers["farmer"].toggle()
                
            end
        
        elseif not command then
            helpers["farmer"].toggle()
            
        end
       
    end
    
    return self
    
end
return farmer.run()