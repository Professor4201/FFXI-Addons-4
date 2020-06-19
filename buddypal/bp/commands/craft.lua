--------------------------------------------------------------------------------
-- Craft Command: Handles executing Craft bot.
--------------------------------------------------------------------------------
local craft = {}
function craft.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local command = command:lower()
            
            if command == "gold" then
                helpers["events"].register("Craft", "Gold")
            
            elseif command == "smithing" then
                helpers["events"].register("Craft", "Smithing")
            
            elseif command == "leathercraft" then
                helpers["events"].register("Craft", "Leathercraft")
            
            elseif command == "clothcraft" then
                helpers["events"].register("Craft", "Clothcraft")
            
            elseif command == "woodworking" then
                helpers["events"].register("Craft", "Woodworking")
            
            elseif command == "alchemy" then
                helpers["events"].register("Craft", "Alchemy")
            
            elseif command == "bonecraft" then
                helpers["events"].register("Craft", "Bonecraft")
            
            elseif command == "cooking" then
                helpers["events"].register("Craft", "Cooking")
            
            end
        
        end
        
        
    end
    
    return self
    
end
return craft.run()