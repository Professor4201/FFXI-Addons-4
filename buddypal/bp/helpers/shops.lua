--------------------------------------------------------------------------------
-- Shops helper: Functions for unlocking all the scrolls at specific NPC Vendors..
--------------------------------------------------------------------------------
local shops = {}
function shops.new()
    local self = {}
    
    -- Private Variables
    local packed    = {}
    local raw       = ""
    local count     = nil
    local shop_name = false
    local shops     = dofile(windower.addon_path.."bp/helpers/shops/shops.lua")
    
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
                helpers["shops"].setCount(data:sub(5,6):unpack("H"))
                return table.concat(packed, "")
            
            end
    
        end
    
    end

    self.build = function(data, size, mog)
        local mog      = mog or false
        local packed   = {}
        local page     = 1
        
        if data and size and shops[shop_name] then
            local padding = data:sub(7,8):unpack("H")
            local shop
            
            if mog then
                shop = shops[shop_name][helpers["thumb"].get()]

            elseif not mog then
                shop = shops[shop_name]
                
            end
            
            if shop then
            
                for i=1,#shop do
                    
                    if not packed[page] then
                        packed[page] = {}
                    end
                    
                    if i == 1 then
                        table.insert(packed[page], ("iHHIHHHH"):pack(0x00003c00, 0, 0, shop[i].cost, shop[i].id, i, 0, 0))
                    
                    elseif (i % size) == 0 then
                        table.insert(packed[page], ("iHHIHHHH"):pack(0x00003c00, i, 0, shop[i].cost, shop[i].id, i, 0, 0))
                        
                    elseif (i % size) == (size - 1) then
                        table.insert(packed[page], ("IHHHH"):pack(shop[i].cost, shop[i].id, i, 0, 0))
                        page = (page + 1)
                        
                    else
                        table.insert(packed[page], ("IHHHH"):pack(shop[i].cost, shop[i].id, i, 0, 0))
                    
                    end
                    
                end
            
            end
            
            for i,v in ipairs(packed) do
                windower.packets.inject_incoming(0x03c, table.concat(v,""))
            end
            
        else
            helpers["shops"].reset()
            return data
        
        end
        helpers["shops"].reset()
        
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
    
    self.stock = function(shop, size, sub)
        local sub    = sub or false
        local packed = {}
        local page   = 1
        
        if shop and size and not sub and shops[shop] then
            local padding = 273
            
            for i=1, #shops[shop] do
                
                if not packed[page] then
                    packed[page] = {}
                end
                
                if i == 1 then
                    table.insert(packed[page], ("iHHIHHHH"):pack(0x00003c00, 0, 0, shops[shop][i].cost, shops[shop][i].id, shops[shop][i].slot, 0, 0))
                
                elseif (i % size) == 0 then
                    table.insert(packed[page], ("iHHIHHHH"):pack(0x00003c00, i, 0, shops[shop][i].cost, shops[shop][i].id, shops[shop][i].slot, 0, 0))
                    
                elseif (i % size) == (size - 1) then
                    table.insert(packed[page], ("IHHHH"):pack(shops[shop][i].cost, shops[shop][i].id, shops[shop][i].slot, 0, 0))
                    page = (page + 1)
                    
                else
                    table.insert(packed[page], ("IHHHH"):pack(shops[shop][i].cost, shops[shop][i].id, shops[shop][i].slot, 0, 0))
                
                end
                
            end
            
            for i,v in ipairs(packed) do
                windower.packets.inject_incoming(0x03c, table.concat(v,""))
            end
            
        elseif shop and size and sub and shops[shop][sub] then
            local padding = 273
            
            for i=1, #shops[shop][sub] do
                
                if not packed[page] then
                    packed[page] = {}
                end
                
                if i == 1 then
                    table.insert(packed[page], ("iHHIHHHH"):pack(0x00003c00, 0, 0, shops[shop][sub][i].cost, shops[shop][sub][i].id, shops[shop][sub][i].slot, 0, 0))
                
                elseif (i % size) == 0 then
                    table.insert(packed[page], ("iHHIHHHH"):pack(0x00003c00, i, 0, shops[shop][sub][i].cost, shops[shop][sub][i].id, shops[shop][sub][i].slot, 0, 0))
                    
                elseif (i % size) == (size - 1) then
                    table.insert(packed[page], ("IHHHH"):pack(shops[shop][sub][i].cost, shops[shop][sub][i].id, shops[shop][sub][i].slot, 0, 0))
                    page = (page + 1)
                    
                else
                    table.insert(packed[page], ("IHHHH"):pack(shops[shop][sub][i].cost, shops[shop][sub][i].id, shops[shop][sub][i].slot, 0, 0))
                
                end
                
            end
            
            for i,v in ipairs(packed) do
                windower.packets.inject_incoming(0x03c, table.concat(v,""))
            end
            
        end
        
    end
    
    self.GreenThumb = function(rank)
        helpers["actions"].openShop(6)
        
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
return shops.new()