--------------------------------------------------------------------------------
-- Crystals helper: Handle Ephemeral Moogle functions.
--------------------------------------------------------------------------------
local crystals = {}
function crystals.new()
    local self = {}
    
    --Private Variables.
    local moogles  = {17764827,17736015,17764826,17723846,17723847,17719925,11740167,17752529,17740211}
    local crystal  = nil
    local quantity = nil
    local flag     = false
    
    self.getCrystals = function(target, crystal, quantity)
        local target, crystal, quantity = target or false, crystal or false, quantity or false
        
        if target and crystal and quantity and type(target) == "table" then
            local mog = false
            
            for _,v in ipairs(moogles) do
                
                if target.id == v then
                    mog = true
                end
                
            end
            
            if mog then
                helpers["actions"].getCrystals(target, quantity, crystal)                
            end
            
        end
        
    end
    
    self.getCrystal = function()
        return crystal
    end
    
    self.setCrystal = function(value)
        local value = value or false
        
        if value and type(value) == "string" then
            crystal = value
        end
    
    end
    
    self.getQuantity = function()
        return quantity
    end
    
    self.setQuantity = function(value)
        local value = value or false
        
        if value and tonumber(value) ~= nil then
            quantity = value
        end
    
    end
    
    self.getFlag = function()
        return flag
    end
    
    self.setFlag = function(value)
        flag = value
    end
    
    return self
    
end
return crystals.new()