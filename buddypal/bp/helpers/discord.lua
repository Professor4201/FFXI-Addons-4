--------------------------------------------------------------------------------
-- Discord Helper: Library of functions for writing bazaar data to a discord bot.
--------------------------------------------------------------------------------
local discord = {}
function discord.new()
    local self = {}
    
    -- Private Variables
    local dir    = ("bp/helpers/discord")
    local player = windower.ffxi.get_player()
    local file   = files.new(string.format("%s/bazaar.lua", dir))
    local update = {trigger=false, time=os.clock()}
    local bazaar = {}
        
    -- Check if bazaar data exist.        
    if file:exists() then
        bazaar = require(string.format("%s/bazaar", dir))
        
    elseif not file:exists() then
        file:write(string.format("return %s", (T(bazaar)):tovstring()))
        
    end
    
    self.add = function(original) -- (I) 0x105
        local target = windower.ffxi.get_mob_by_target("t") or false
        local player = windower.ffxi.get_player() or false
        local item   = res.items[original:unpack("H", 0x0e+1)]
        local price  = original:unpack("I", 0x04+1)
        local count  = original:unpack("I", 0x08+1)
        
        if player and target and item and price and count and type(item) == "table" and player.name == target.name then
            
            if not update.trigger then
                update.trigger = true
                bazaar[player.name:lower()] = {}
                
            end                
            
            if bazaar[player.name:lower()] and item.name ~= bazaar[player.name:lower()].name then
                table.insert(bazaar[player.name:lower()], {id=item.id, name=item.name, price=price, count=count, player=player.name})
            
            else
                bazaar[player.name:lower()] = {}
                table.insert(bazaar[player.name:lower()], {id=item.id, name=item.name, price=price, count=count, player=player.name})
                
            end
            
        end
        helpers["discord"].update()

    end
    
    self.remove = function(original) -- (I) 0x10A
        local player = windower.ffxi.get_player() or false
        local item   = res.items[original:unpack("H", 0x08+1)]
        local count  = original:unpack("I", 0x04+1)
        
        if player and item and count and type(item) == "table" and bazaar[player.name:lower()] then
            local updated = false
            
            for i,v in ipairs(bazaar[player.name:lower()]) do
                
                if v.id == item.id and v.count > count and not updated then
                    bazaar[player.name:lower()][i].count = (bazaar[player.name:lower()][i].count-count)
                    updated = true
                    
                elseif v.id == item.id and v.count == count and not updated then
                    table.remove(bazaar[player.name:lower()], i)
                    updated = true
                    
                end
                
            end
            helpers["discord"].write(bazaar)
            
        end
        
    end
    
    self.update = function()
        update.trigger, update.time = true, os.clock()
    end
    
    self.getUpdate = function()
        return update
    end
    
    self.reset = function()
        helpers["discord"].write(bazaar)
        update = {trigger=false, time=os.clock()}
    end
    
    self.write = function(data)
        local f = files.new(string.format("%s/bazaar.lua", dir))
        
        if f:exists() then
            f:write('return ' .. T(data):tovstring())
        
        elseif not f:exists() then
            f:write('return ' .. T(data):tovstring())
            
        end
        return false
    
    end
    
    return self
    
end
return discord.new()
