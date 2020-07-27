--------------------------------------------------------------------------------
-- Ciphers helper: Handles all Cipher Menu functions for turning in trust ciphers.
--------------------------------------------------------------------------------
local ciphers = {}
function ciphers.new()
    local self = {}
    
    -- Private BP Binds.
    local npc       = {17744187}
    local id        = false
    local injecting = false
    
    self.trade = function(target, item)
        local target = target or false
        local item   = item or false
        
        if target and item and item[1] and type(item) == "table" and helpers["ciphers"].checkNPC(target.id) then
            local id = helpers["ciphers"].convert(item[1]) or false
            
            if id and helpers["ciphers"].isTrust(id) then
                helpers["ciphers"].setInjecting(true)
                helpers["ciphers"].setId(id)
                helpers["actions"].tradeNPC(target, item)
                
            end
            
        end
        
    end
    
    self.setId = function(value)
        local value = value or false
        
        if value then
            id = value
            
        else
            id = false
            
        end
        
    end
    
    self.getId = function()
        return id
    end
    
    self.checkNPC = function(id)
        local id = id or false
        
        if id then
            
            for _,v in ipairs(npc) do

                if v == id then
                    return true
                end
                
            end
            
        end
        return false
        
    end
    
    self.isTrust = function(id)
        local id = id or false
        
        if id then
            local allowed = res.spells:type("Trust")
        
            for i,_ in pairs(allowed) do

                if i == id then
                    return true
                end
                
            end
            
        end
        return false
        
    end
    
    self.convert = function(item)
        local item = item or false
        
        if item then
            local allowed = res.spells:type("Trust")
            
            for _,v in pairs(allowed) do
                
                if v and v.en and (item.en:sub(8):match(v.en)) then
                    return v.id
                end
                
            end
            
        end
        return false
        
    end
    
    self.setInjecting = function(value)
        injecting = value        
    end
    
    self.getInjecting = function()
        return injecting
    end
    
    return self
    
end
return ciphers.new()
