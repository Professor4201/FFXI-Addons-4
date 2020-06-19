--------------------------------------------------------------------------------
-- Sparks helper: Handles registering and clearing all keybinds for the addon..
--------------------------------------------------------------------------------
local sparks = {}
function sparks.new()
    self = {}
    
    -- Private Variables
    local sparks_injection = false
    local item             = ""
    local quantity         = 0
    local items = dofile(windower.addon_path.."bp/helpers/sparks/items.lua")
    
    self.purchaseItem = function(packets)
        local packets = packets or false
        local target  = windower.ffxi.get_mob_by_id(packets["NPC"]) or false
        local item    = helpers["sparks"].getItem() or false
        local count   = helpers["sparks"].getQuantity()
        local space   = (windower.ffxi.get_bag_info(0).max - windower.ffxi.get_bag_info(0).count)
        
        
        -- Protect from over-purchasing items.
        if bpcore:hasSpace(0) and (count < space and count ~= 0) then
            count = count
        
        elseif bpcore:hasSpace(0) and (count > space or count == 0) then
            count = space
            
        end
        
        if packets and target and item and bpcore:hasSpace(0) then
            local message = string.format("Now Purchasing: %s - %s.", count, item):upper()
            local item    = item:lower()
            
            if count > 0 then
                
                for i,v in pairs(items) do
                    
                    if i == item then
                
                        for i=1, count do
                            helpers["actions"].injectMenu(packets["NPC"], packets["NPC Index"], packets["Zone"], v.option, packets["Menu ID"], true, v._u1, v._u2)
                            
                            if i == count then
                                helpers['popchat']:pop((message), system["Popchat Window"])
                                helpers["actions"].doExitMenu(packets, target)
                            end
                        
                        end
                        
                    end
                
                end
            
            else
                helpers['popchat']:pop(("Make sure you have enough inventory space!!"), system["Popchat Window"])
                helpers["actions"].doExitMenu(packets, target)
            
            end
            
        else
            helpers["actions"].doExitMenu(packets, target)
            
        end
    
    end
    
    self.setInjecting = function(value)
        sparks_injection = value
    end
    
    self.getInjecting = function()
        return sparks_injection
    end
    
    self.setItem = function(name)
        item = name or ""
    end
    
    self.getItem = function()
        return item
    end
    
    self.setQuantity = function(count)
        quantity = count or 0
    end
    
    self.getQuantity = function()
        return quantity
    end
    
    return self
    
end
return sparks.new()
