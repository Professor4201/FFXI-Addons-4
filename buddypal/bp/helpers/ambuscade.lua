--------------------------------------------------------------------------------
-- Ambuscade Helper: Library of functions to handle Ambuscade Event Bot.
--------------------------------------------------------------------------------
local ambuscade = {}
function ambuscade.new()
    local self = {}
    
    -- Private Variables
    local seals = I{true,false}
    local loop  = I{true,false}
    local limit = I{false,true}
    
    self.start = function(name)
        local name = name or false
        
        if name and name ~= "" and not limit:current() then
            helpers["schedule"].scheduleEvent("ambuscade", name)
            
        elseif name and name ~= "" and limit:current() then
            helpers["schedule"].scheduleEvent("ambuscade", name)
        end
        
    end
    
    self.reset = function(name)
        local name = name or false
        
        if name and name ~= "" and not limit:current() then
            
            if loop:current() then
                helpers["events"].finishEvent("ambuscade", "ambuscade", name)
            else
                helpers["events"].finishEvent("ambuscade")
            end
            
        end
        
    end
        
    self.loop = function(value)
        local value = value or false
        
        if value and type(value) == "boolean" then
            loop:setTo(value)            
        elseif not value then
            loop:next()
        end
        
    end
    
    self.limit = function(value)
        local value = value or false
        
        if value and type(value) == "boolean" then
            loop:setTo(value)            
        elseif not value then
            loop:next()
        end
        
    end
    
    self.getLooping = function()
        return loop:current()
    end
    
    self.limit = function()
        return limit:current()
    end
    
    return self
    
end
return ambuscade.new()
