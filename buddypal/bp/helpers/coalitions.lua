--------------------------------------------------------------------------------
-- Coalitions helper: Handle Coalition Bot functions.
--------------------------------------------------------------------------------
local coalitions = {}
function coalitions.new()
    local self = {}
    
    --Private Variables.
    local coalition = I{"Couriers","Pioneers","Mummers","Inventors","Peacekeepers","Scouts"}
    local repeating = I{false,true}
    
    self.toggle = function()
        coalition:next()
        helpers["popchat"]:pop((string.format("Current Coalition: %s", coalition:current()):upper()), system["Popchat Window"])
    end
    
    self.repeating = function()
        repeating:next()
        helpers["popchat"]:pop((string.format("Coalition Repeating is now: %s", tostring(repeating:current())):upper()), system["Popchat Window"])
    end
    
    self.getCoalition = function()
        return coalition:current()
    end
    
    self.getRepeating = function()
        return repeating:current()
    end
    
    self.isCoalition = function(name)
        local name = name or false
        local list = {"Couriers","Pioneers","Mummers","Inventors","Peacekeepers","Scouts"}
        
        if name and type(name) == "string" then
            
            for _,v in ipairs(list) do
                
                if (name:lower()):match(v:lower()) then
                    return true                    
                end
                
            end
            
        end
        
    end
        
    self.runCoalition = function(name)
        local name = name or false

        if name and type(name) == "string" and helpers["coalitions"].isCoalition(name) then
            helpers["events"].register(name:lower(), "Legend")
            
        end
        
    end
    
    return self
    
end
return coalitions.new()