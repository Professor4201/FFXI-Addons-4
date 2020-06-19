--------------------------------------------------------------------------------
-- Scrolls helper: Functions for unlocking all the scrolls at specific NPC Vendors..
--------------------------------------------------------------------------------
local scrolls = {}
function scrolls.new()
    self = {}
    
    -- Private Variables
    local packed    = {}
    local raw       = ""
    local count     = nil
    local shop_name = false
    local shops     = dofile(windower.addon_path.."bp/helpers/scrolls/shops.lua")
    
    self.unlock = function(data)
        local data   = data or false
        
        if data and shops[shop_name] then
            local shop = shops[shop_name]

            if data:sub(5,6):unpack("H") ~= count then
                
                for i,v in pairs(shop) do
                    
                    if raw == "" then
                        raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                        table.insert(packed, raw)
                    else
                        raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                        table.insert(packed, raw)
                    end
                    
                end
                helpers["scrolls"].setCount(data:sub(5,6):unpack("H"))
                return table.concat(packed, "")
            
            end
    
        end
    
    end
    
    self.shop = function(target)
        local target = target or false
        local shop = false
        
        if target then
            shop      = target
            shop_name = (shop.name):gsub("%s+", ""):lower()
            
            if shops[shop_name] then
                helpers["actions"].doAction(shop, 0, "interact")
            else
                shop_name = false
            end
            
            
        end
        
    end
    
    self.getCount = function()
        return count
    end
    
    self.setCount = function(value)
        local value = value or false
        
        if value and tonumber(value) ~= nil then
            count = tonumber(value)
        end
        
    end
    
    self.getShopName = function()
        return shop_name
    end
    
    self.setShopName = function(name)
        local name = name or false
        
        if name and type(name) == "string" then
            shop_name = name
        end
        
    end
    
    self.reset = function()
        packed    = {}
        raw       = ""
        count     = nil
        shop_name = false
        
    end
    
    return self

end
return scrolls.new()