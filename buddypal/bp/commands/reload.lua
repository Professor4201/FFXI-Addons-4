--------------------------------------------------------------------------------
-- Reload Command: Reload functionality of the addon.
--------------------------------------------------------------------------------
local reload = {}
function reload.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function()
        windower.send_command("lua reload " .. _addon.name)
        
    end
    
    return self
    
end
return reload.run()