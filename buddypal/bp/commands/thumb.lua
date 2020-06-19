--------------------------------------------------------------------------------
-- Thumb commands: Handles all commands for adjusting Greem Thumb Moogle shop selection.
--------------------------------------------------------------------------------
local thumb = {}
function thumb.run()
    self = {}
    
    self.execute = function(commands)
        helpers["thumb"].toggle()
    end
    
    return self 

end
return thumb.run()
