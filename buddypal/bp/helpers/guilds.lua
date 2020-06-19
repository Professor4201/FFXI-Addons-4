--------------------------------------------------------------------------------
-- Guilds helper: Functions for unlocking all the guild items from Guild Vendors.
--------------------------------------------------------------------------------
local shops = {}
function shops.new()
    self = {}
    
    -- Private Variables
    local packed = {}
    local raw    = ""
    local guilds = {
        
        ["Woodworking"]  = dofile(windower.addon_path.."bp/helpers/guilds/woodworking.lua"),
        ["Smithing"]     = dofile(windower.addon_path.."bp/helpers/guilds/smithing.lua"),
        ["Bonecraft"]    = dofile(windower.addon_path.."bp/helpers/guilds/bonecraft.lua"),
        ["Alchemy"]      = dofile(windower.addon_path.."bp/helpers/guilds/alchemy.lua"),
        ["Goldsmithing"] = dofile(windower.addon_path.."bp/helpers/guilds/goldsmithing.lua"),
        ["Leathercraft"] = dofile(windower.addon_path.."bp/helpers/guilds/leathercraft.lua"),
        ["Clothcraft"]   = dofile(windower.addon_path.."bp/helpers/guilds/clothcraft.lua"),
        ["Cooking"]      = dofile(windower.addon_path.."bp/helpers/guilds/cooking.lua"),
        
    }
    
    self.unlockWoodworking = function(data)
        local count  = data:sub(5,6):unpack('H')
        local data   = data or false
        local packed = {}
        
        if count == 0 then
            
            for i,v in pairs(helpers["guilds"].getShop("Woodworking")[1]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            
        elseif count == 28 then
        
            for i,v in pairs(helpers["guilds"].getShop("Woodworking")[2]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            commands["guilds"].setStatus("")
            
        end
        return table.concat(packed, "")
        
    end
    
    self.unlockSmithing = function(data)
        local count  = data:sub(5,6):unpack('H')
        local data   = data or false
        local packed = {}
        if count == 0 then
            
            for i,v in pairs(helpers["guilds"].getShop("Smithing")[1]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            
        elseif count == 24 then
        
            for i,v in pairs(helpers["guilds"].getShop("Smithing")[2]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            commands["guilds"].setStatus("")
            
        end
        return table.concat(packed, "")
        
    end
    
    self.unlockBonecraft = function(data)
        local count  = data:sub(5,6):unpack('H')
        local data   = data or false
        local packed = {}
        if count == 0 then
            
            for i,v in pairs(helpers["guilds"].getShop("Bonecraft")[1]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            
        elseif count == 19 then
        
            for i,v in pairs(helpers["guilds"].getShop("Bonecraft")[2]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            commands["guilds"].setStatus("")
            
        end
        return table.concat(packed, "")
        
    end
    
    self.unlockAlchemy = function(data)
        local count  = data:sub(5,6):unpack('H')
        local data   = data or false
        packed = {}        
        
        if count == 0 then
            
            for _,v in pairs(helpers["guilds"].getShop("Alchemy")[1]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            
        elseif count == 19 then

            for _,v in pairs(helpers["guilds"].getShop("Alchemy")[2]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            commands["guilds"].setStatus("")
            
        end
        return table.concat(packed, "")
        
    end
    
    self.unlockGoldsmithing = function(data)
        local count  = data:sub(5,6):unpack('H')
        local data   = data or false
        local packed = {}
        
        if count == 0 then
            
            for i,v in pairs(helpers["guilds"].getShop("Goldsmithing")[1]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            
        elseif count == 19 then
        
            for i,v in pairs(helpers["guilds"].getShop("Goldsmithing")[2]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
        
        elseif count == 38 then
            
            for i,v in pairs(helpers["guilds"].getShop("Goldsmithing")[3]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            commands["guilds"].setStatus("")
            
        end
        return table.concat(packed, "")
        
    end
    
    self.unlockLeathercraft = function(data)
        local count  = data:sub(5,6):unpack('H')
        local data   = data or false
        local packed = {}
        if count == 0 then
            
            for i,v in pairs(helpers["guilds"].getShop("Leathercraft")[1]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            
        elseif count == 19 then
        
            for i,v in pairs(helpers["guilds"].getShop("Leathercraft")[2]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            commands["guilds"].setStatus("")
            
        end
        return table.concat(packed, "")
        
    end
    
    self.unlockClothcraft = function(data)
        local count  = data:sub(5,6):unpack('H')
        local data   = data or false
        local packed = {}
        
        if count == 0 then
            
            for i,v in pairs(helpers["guilds"].getShop("Clothcraft")[1]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            
        elseif count == 19 then
        
            for i,v in pairs(helpers["guilds"].getShop("Clothcraft")[2]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            commands["guilds"].setStatus("")
            
        end
        return table.concat(packed, "")
        
    end
    
    self.unlockCooking = function(data)
        local count  = data:sub(5,6):unpack('H')
        local data   = data or false
        local packed = {}
        if count == 0 then
            
            for i,v in pairs(helpers["guilds"].getShop("Cooking")[1]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            
        elseif count == 19 then
        
            for i,v in pairs(helpers["guilds"].getShop("Cooking")[2]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
        
        elseif count == 38 then
            
            for i,v in pairs(helpers["guilds"].getShop("Cooking")[3]) do
                
                if raw == "" then
                    raw = ("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0)
                    table.insert(packed, raw)
                else
                    raw = raw:append(("I"):pack(v.cost)..("H"):pack(v.id)..("H"):pack(v.slot)..("H"):pack(0)..("H"):pack(0))
                    table.insert(packed, raw)
                end
                
            end
            commands["guilds"].setStatus("")
            
        end
        return table.concat(packed, "")
        
    end
    
    self.getShop = function(craft)
        
        if guilds[craft] then
            return guilds[craft]
        end
        return false
    
    end

    return self

end
return shops.new()