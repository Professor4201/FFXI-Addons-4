--------------------------------------------------------------------------------
-- Zincore helper: Helper to help with getting fame through Zinc Ore.
--------------------------------------------------------------------------------
local zincore = {}
function zincore.new()
    self = {}
    
    -- Public Variables.
    local injecting = false
    
    self.tradeOre = function()
        local target = windower.ffxi.get_mob_by_id(17743880) or false
        local item   = bpcore:findItemByName("Zinc Ore") or false
        
        if target and item then
            helpers["zincore"].setInjecting(true)
            helpers["actions"].tradeNPC(target, {item, 4})
        end
        
    end
    
    self.handleMenus = function(packets)
        helpers["actions"].injectMenu(packets["NPC"], packets["NPC Index"], packets["Zone"], 0, 91, false, 0, 0)
        helpers["zincore"].setInjecting(false)
        
    end
    
    self.getInjecting = function()
        return injecting
    end
    
    self.setInjecting = function(value)
        injecting = value
    end
    
    return self
    
end
return zincore.new()
