--------------------------------------------------------------------------------
-- Resourcer Helper: Library of functions to handle resourcing NPC data and writing to appropriate resource file.
--------------------------------------------------------------------------------
local resourcer = {}
function resourcer.new()
    local self = {}
    
    -- Private Variables.
    local enabled = I{true,false}
    
    self.toggle = function()
        enabled:next()
    end
    
    self.isEnabled = function()
        return enabled:current()
    end
    
    return self
    
end
return resourcer.new()