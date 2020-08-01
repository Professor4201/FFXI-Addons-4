_addon.name     = "craftstats"
_addon.author   = "Elidyr"
_addon.version  = "1.20200801"
_addon.command  = "stats"

local helpers = require("helpers")
local files   = require("files")
                require("chat")
                require("logger")
                require("pack")
                require("lists")
                require("tables")
                
local stats, f, hash = {}, files.new(string.format("stats/%s.lua", windower.ffxi.get_player().name)), 0
local display = helpers.display(true)

if not f:exists() then
    f:write("return " .. T({}):tovstring())
    stats = require(string.format("stats/%s", windower.ffxi.get_player().name))
    helpers.setStats(stats)
else
    stats = require(string.format("stats/%s", windower.ffxi.get_player().name))
    helpers.setStats(stats)
end

windower.register_event("addon command", function(...)
    
    local a = T{...}
    local c = a[1] or false
    
    if c then
        local c = c:lower()
        
        if c == "find" then
            local item  = a[2] or false
            
            if item and stats and item ~= "" then
                helpers.clear()
                helpers.find(item, stats, display)
                
            end
            
        end
    
    end
    
end)

windower.register_event("outgoing chunk", function(id,original,modified,injected,blocked)
    
    if id == 0x096 then
        local ingredients = {original:unpack("H8", 0x0a+1)} or false
        local crystal     = original:unpack("H", 0x06+1) or false
        
        if ingredients and crystal then
            hash = helpers.createId(ingredients, crystal)
        end
        
    end

end)

windower.register_event("incoming chunk", function(id,original,modified,injected,blocked)
    
    if id == 0x06f then
        local result  = original:unpack("C", 0x04+1)
        local quality = original:unpack("c", 0x05+1)
        local skill   = helpers.tonumber(helpers.unpack(0x01a, 6, original))
        local item    = original:unpack("H", 0x08+1)
        
        if result and hash and quality and item then
            
            if (result == 0 or result == 12) then
                stats = helpers.add(stats, skill, hash, result, quality, item)
                helpers.update(display, stats, skill, hash)
                    
            elseif (result == 1 or result == 5) then
                stats = helpers.add(stats, skill, hash, result, quality, item)
                helpers.update(display, stats, skill, hash)
                
            end
            
        end
        
    end

end)

windower.register_event("mouse", function(type, x, y, delta, blocked)
    local player = windower.ffxi.get_player() or false
    
    if player then
        
        if type == 1 then
            local menus = helpers.getMenus()
            
            if menus[0]:hover(x, y) then
                helpers.up()
                return true
                
            elseif menus[#menus] and menus[#menus]:hover(x, y) then
                helpers.down()
                return true
                
            elseif menus[6] and menus[6]:hover(x, y) then
                helpers.down()
                return true
                
            end
            
        elseif type == 2 then
            local menus = helpers.getMenus()
            
            if menus[0]:hover(x, y) then
                return true
                
            elseif menus[#menus] and menus[#menus]:hover(x, y) then
                return true
                
            elseif menus[6] and menus[6]:hover(x, y) then
                return true
                
            end
            
        end
        
    end
    
end)
