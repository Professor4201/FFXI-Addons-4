--------------------------------------------------------------------------------
-- Alias helper: Handles registering and clearing all alias for the addon.
--------------------------------------------------------------------------------
local alias = {}
function alias.new()
    self = {}
    
    -- Private BP Binds.
    local aliases = {
        
        {alias = "wring", command = "bp use_warpring"}
        
    }
    
    self.register = function()
        local aliases = aliases or false
        
        if aliases and type(aliases) == "table" then
            
            for _,v in ipairs(aliases) do
                windower.send_command(string.format("alias %s %s", v.alias, v.command))
            
            end
            
        end        
        
    end
    
    self.unregister = function()        
        local aliases = aliases or false
        
        if aliases and type(aliases) == "table" then
            
            for _,v in ipairs(aliases) do
                windower.send_command(string.format("unalias %s", v.alias))
            
            end
            
        end  
    
    end

    return self
    
end
return alias.new()
