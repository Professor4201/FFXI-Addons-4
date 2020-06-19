--------------------------------------------------------------------------------
-- FastCraft Command: Handles executing FastCraft helper.
--------------------------------------------------------------------------------
local fastcraft = {}
function fastcraft.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function()
        helpers["fastcraft"].toggle()        
    end
    return self
    
end
return fastcraft.run()