--------------------------------------------------------------------------------
-- Filter helper: Library of functions for filtering incoming text.
--------------------------------------------------------------------------------
local filter = {}
function filter.new()
    local self = {}
    
    -- Private Variables.
    local filters = require("bp/resources/filters")
    
    -- Filter junk strings out of message.
    self.filter = function(message, id)
        local message, id = message or "", id or false
        
        if message ~= "" and id and filters[id] then
            local filter = filters[id]
            
            for i,v in ipairs(filter) do
                message = string.gsub(message, v.match, v.sub)
            end
            
        end
        return message
        
    end
    
    -- Find a specific value in a string.
    self.find = function(message, reg)
        local message, reg = message or "", reg or false
        
        if message ~= "" and reg and reg ~= "" then
            local found = (message):match(reg)
            
            if found ~= nil then
                return found
                
            else
                return ""
                
            end
            
        end
        return ""
        
    end
    
    return self
    
end
return filter.new()
