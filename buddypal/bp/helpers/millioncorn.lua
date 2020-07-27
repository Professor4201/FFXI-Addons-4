--------------------------------------------------------------------------------
-- Miliicorn helper: Helper to help with getting fame through millicorn.
--------------------------------------------------------------------------------
local millioncorn = {}
function millioncorn.new()
    local self = {}
    
    -- Public Variables.
    local injecting = false
    
    self.tradeCorn = function()
        local target = windower.ffxi.get_mob_by_id(17793049) or false
        local item   = bpcore:findItemByName("Millioncorn") or false
        
        if target and item then
            helpers["millioncorn"].setInjecting(true)
            helpers["actions"].tradeNPC(target, {item, 3})
        end
        
    end
    
    self.handleMenus = function(packets)
        helpers["actions"].injectMenu(packets["NPC"], packets["NPC Index"], packets["Zone"], 12, 63, false, 0, 0)
        helpers["millioncorn"].setInjecting(false)
        
    end
    
    self.getInjecting = function()
        return injecting
    end
    
    self.setInjecting = function(value)
        injecting = value
    end
    
    return self
    
end
return millioncorn.new()
