--------------------------------------------------------------------------------
-- Kits helper: Library of functions to handle kit purchases from guild NPCs
--------------------------------------------------------------------------------
local kits = {}
function kits.new()
    local self = {}
    
    -- Private Variables.
    local injecting = false
    local kit = 0
    local quantity = 0
    local kits = {
        [17723848] = {[25]=2, [45]=258, [65]=514, [71]=770, [74]=1026, [81]=1282, [84]=1538, [90]=1794, [94]=2050}
    }
    
    self.purchase = function(packets, npc, kit, quantity)
        local packets, npc, kit, quantity = packets or false, npc or false, kit or false, quantity or false
        
        if packets and npc and kit and quantity and kits[npc.id] and kits[npc.id][kit] then
            helpers["popchat"]:pop(string.format("Purchasing %s of %s Kit.", quantity, kit), system["Popchat Window"])
            helpers["actions"].injectMenu(npc.id, npc.index, packets["Zone"], kits[npc.id][kit], packets["Menu ID"], true, quantity, 0)
            helpers["actions"].injectMenu(npc.id, npc.index, packets["Zone"], 1, packets["Menu ID"], true, 0, 0)
            helpers["actions"].doExitMenu(packets, npc)
            
        else
            helpers["popchat"]:pop(string.format("Unable to purchase Kit %s", kit), system["Popchat Window"])
            helpers["actions"].doExitMenu(packets, npc)
            
        end
        
    end
    
    self.verify = function(npc, kit)
        local npc, kit = npc or false, kit or false
        
        if npc and kit and type(npc) == "table" and tonumber(kit) ~= nil and kits[npc.id] and kits[npc.id][kit] then
            return true
        end
        return false
        
    end
    
    self.setKit = function(value)
        local value = value or 0
        
        if value and tonumber(value) ~= nil then
            kit = value
        end
        
    end
    
    self.getKit = function()
        return kit
    end
    
    self.setQuantity = function(value)
        local value = value or 0
        
        if value and tonumber(value) ~= nil and value >= 0 and value <= 12 then
            quantity = value
        end
        
    end
    
    self.getQuantity = function()
        return quantity
    end
    
    self.setInjecting = function(value)
        local value = value or false
        
        if value and type(value) == "boolean" then
            injecting = value
        else
            injecting = false
        end
        
    end
    
    self.getInjecting = function()
        return injecting
    end
    
    return self
    
end
return kits.new()
