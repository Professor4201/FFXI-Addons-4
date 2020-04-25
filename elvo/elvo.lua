_addon.name     = "elvo"
_addon.author   = "Elidyr"
_addon.version  = "0.20200422"
_addon.command  = "elvo"

local color   = 25
local f       = false
local packets = require("packets")
                require("strings")
                require("lists")
                require("tables")
                require("chat")
                require("logger")
                require("pack")

--Commands Handler.
windower.register_event("addon command", function(...)
    
    local a = T{...}
    local c = a[1]:lower() or false
    
    if c == "get" or c == "ki" or c == "di" then
        local target = windower.ffxi.get_mob_by_target("t") or false
        
        if target then
            f = true
            poke(target)
            
        end
    
    elseif c == "help" then
        windower.add_to_chat(color, "To get an Elvorseal, just target the NPC and use [//elvo get || ki || di ] to obtain a Key Item and warp.")
    
    end
    
end)

windower.register_event("incoming chunk", function(id,original,modified,injected,blocked)
    
    if id == 0x032 or id == 0x034 and f then
        local pack  = packets.parse("incoming", original)
        local npc   = original:unpack("I", 0x04+1)
        local entry = {
            [17957448]={id=17957448, index=584, spawn={x=-15.743389129639, y=40.585868835449, z=0.77015554904938}},
            [17961710]={id=17961710, index=750, spawn={x=-209.02131652832, y=-43.599998474121, z=8.2033805847168}},
            [17969974]={id=17969974, index=822, spawn={x=640, y=-921.00006103516, z=-372.00003051758}}}
        
        if entry[npc] then
            local seal = original:sub(9,9):unpack("C")
            
            -- Elvorseal is not active.
            if (seal % 8) == 0 then
                exit(entry[npc], pack)
                windower.add_to_chat(color, "Elvorseal is not ready!")
                f = false
                return true
                
            -- 10 Minutes until adds spawn.
            elseif (seal % 8) == 1 then
                elvorseal(entry[npc], entry[npc]["spawn"].x, entry[npc]["spawn"].y, entry[npc]["spawn"].z, pack)
                windower.add_to_chat(color, "Getting Elvorseal!")
                f = false
                return true
            
            -- Domain Invasion adds have spawned.
            elseif (seal % 8) == 2 then
                elvorseal(entry[npc], entry[npc]["spawn"].x, entry[npc]["spawn"].y, entry[npc]["spawn"].z, pack)
                windower.add_to_chat(color, "Getting Elvorseal!")
                f = false
                return true
            
            else
                f = false
                windower.add_to_chat(color, "Error getting Elvorseal!")
                return original
                
            end
            
        else
            f = false
            windower.add_to_chat(color, "Please check your target!")
            return original
        
        end
    
    end
    
end)

inject = function(id, index, zone, option, menuid, automated, _u1, _u2)
    local _u1, _u2 = _u1 or false, _u2 or false
    
    if id and index and option and zone and menuid and (automated or not automated) then
        local inject = 'iIHHHBCHH':pack(0x00005b00, id, option, _u1, index, automated, _u2, zone, menuid)
        windower.packets.inject_outgoing(0x05b, inject)
    end
    
end

elvorseal = function(target, x, y, z, packets)
    local target, x, y, z, packets = target or false, x or false, y or false, z or false, packets or false

    if target and x and y and z and packets then
        local warp = 'ifffIIHHHCC':pack(0x00005c00, x, z, y, target.id, 12, packets['Zone'], packets['Menu ID'], target.index, 1, 0)
        local update = 'iHH':pack(0x00001600, target.index, 0)
        
        inject(target.id, target.index, packets['Zone'], 14, packets['Menu ID'], true, 0, 0)
        inject(target.id, target.index, packets['Zone'], 08, packets['Menu ID'], true, 0, 0)
        inject(target.id, target.index, packets['Zone'], 09, packets['Menu ID'], true, 0, 0)
        inject(target.id, target.index, packets['Zone'], 09, packets['Menu ID'], true, 0, 0)
        inject(target.id, target.index, packets['Zone'], 10, packets['Menu ID'], true, 0, 0)
        inject(target.id, target.index, packets['Zone'], 11, packets['Menu ID'], true, 0, 0)
        windower.packets.inject_outgoing(0x05c, warp)
        inject(target.id, target.index, packets['Zone'], 12, packets['Menu ID'], false, 0, 0)
        windower.packets.inject_outgoing(0x016, update)
        
    end
    
end

exit = function(target, packets)
    local target, packets = target or false, packets or false
    
    if target and packets then
        inject(target.id, target.index, packets['Zone'], 0, packets['Menu ID'], false, 16384, 0)        
    end
    
end

poke = function(target)
    local target = target or false
    
    if target then
        local poke = packets.new('outgoing', 0x1a, {
            ['Target'] = target.id,
            ['Target Index'] = target.index,
        })
        packets.inject(poke)
    
    end
    
end