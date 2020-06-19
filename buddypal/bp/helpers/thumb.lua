--------------------------------------------------------------------------------
-- Thumb helper: Controls Green Thumb Moogle shop selections.
--------------------------------------------------------------------------------
local thumb = {}
function thumb.new()
    self = {}
    
    -- Private Variables
    local selection = I{1,2}
    
    self.toggle = function()
        selection:next()
        helpers["popchat"]:pop(string.format("Green Thumb Moogle Shop Selection: %s", selection:current()):upper(), system["Popchat Window"])
    end
    
    self.get = function()
        return tonumber(selection:current())
    end
    
    return self

end
return thumb.new()