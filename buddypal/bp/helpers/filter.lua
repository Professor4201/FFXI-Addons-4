--------------------------------------------------------------------------------
-- Filter helper: Library of functions for filtering incoming text.
--------------------------------------------------------------------------------
local filter = {}
function filter.new()
    self = {}
    
    -- Private Variables.
    local filters = require("bp/resources/filters")
    
    self.filter = function(message, id)
        local message, id = message or "", id or false
        
        if message ~= "" and id and filters[id] then
            local filter = filters[id]
            
            for i,v in ipairs(filter) do
                message = string.gsub(message, v.match, v.sub)
            end
            return message
            
        end
        return false
        
    end

    return self
    
end
return filter.new()
