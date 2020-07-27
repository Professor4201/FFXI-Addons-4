--------------------------------------------------------------------------------
-- FastCraft Command: Handles executing FastCraft helper.
--------------------------------------------------------------------------------
local fastcraft = {}
function fastcraft.run()
    local self = {}

    self.execute = function()
        helpers["fastcraft"].toggle()        
    end
    return self
    
end
return fastcraft.run()