_addon.name     = "craftstats"
_addon.author   = "Elidyr"
_addon.version  = "1.20200513"
_addon.command  = "stats"

local helpers = require("helpers")
local files   = require("files")
                require("chat")
                require("logger")
                require("pack")
                require("lists")
                require("tables")
                
local stats, f, hash = {}, files.new(string.format("stats/%s.lua", windower.ffxi.get_player().name)), 0
local display = helpers.display()

if not f:exists() then
    f:write("return " .. T({}):tovstring())
    stats = require(string.format("stats/%s", windower.ffxi.get_player().name))
else
    stats = require(string.format("stats/%s", windower.ffxi.get_player().name))
end

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
        local skill   = original:unpack("H", 0x1a+1)
        local item    = original:unpack("H", 0x08+1)
        
        if result and hash and quality and item then
            
            if result == 0 then
                stats = helpers.add(stats, skill, hash, result, quality, item)
                    
            elseif result == 1 then
                stats = helpers.add(stats, skill, hash, result, quality, item)
                
            end
            helpers.update(display, stats, skill, hash)
            
        end
        
    end

end)

