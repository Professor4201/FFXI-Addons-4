--------------------------------------------------------------------------------
-- FastCRaft helper: This enable instant crafting (Currently doesnt work for skill ups).
--------------------------------------------------------------------------------
local fastcraft = {}
function fastcraft.new()
    local self = {}
    
    -- Private Variables.
    local toggle = I{false,true}
    
    self.toggle = function()
        toggle:next()
        
        local message = string.format("FAST CRAFT: %s", tostring(toggle:current())):upper()
        helpers["popchat"]:pop(message, system["Popchat Window"])
    end
    
    self.getToggle = function()
        return toggle:current()
    end
    
    return self
    
end
return fastcraft.new()