--------------------------------------------------------------------------------
-- Craft Command: Handles executing Craft bot.
--------------------------------------------------------------------------------
local craft = {}
function craft.run()
    local self = {}
    
    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local command = command:lower()
            
            if command == "gold" then
                helpers["events"].register("craft", "gold")
            
            elseif command == "smithing" then
                helpers["events"].register("craft", "smithing")
            
            elseif command == "leathercraft" then
                helpers["events"].register("craft", "leathercraft")
            
            elseif command == "clothcraft" then
                helpers["events"].register("craft", "clothcraft")
            
            elseif command == "woodworking" then
                helpers["events"].register("craft", "woodworking")
            
            elseif command == "alchemy" then
                helpers["events"].register("craft", "alchemy")
            
            elseif command == "bonecraft" then
                helpers["events"].register("craft", "bonecraft")
            
            elseif command == "cooking" then
                helpers["events"].register("craft", "cooking")
            
            end
        
        end
        
        
    end
    
    return self
    
end
return craft.run()