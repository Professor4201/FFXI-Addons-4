local settings = require('bp/events/sequences/couriers/settings/intense_settings')
local window   = helpers["events"].getWindow()

-- Set Private Tables.
helpers["events"].setEvents(settings)
helpers["events"].setItems(settings)
helpers["events"].setNPCs(settings)

-- Launch Events
local beast = {}
beast["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

beast["prerender"] = function()
    
    if windower.ffxi.get_mob_by_target('me') then
        local midaction = helpers["actions"].getMidaction()
        local clocks    = helpers["events"].getClocks()
        local delays    = helpers["events"].getDelays()
        local zone      = helpers["events"].getZone()
        local npc       = helpers["events"].getNPCs()
        
        -- Handle Cutscene Status.
        helpers['events'].handleCutscene()
        
        if os.clock()-clocks.ping > delays.spam + delays.zone and windower.ffxi.get_mob_by_target('me').status ~= 4 and not midaction then
            local status = helpers["events"].getStatus()
            
            -- Reset the zone delay, and update the event display.
            helpers["events"].setDelays("zone", 0)
            helpers['events'].updateDisplay()
            
            if zone.name == "Mhaura" then
                
                if status == 0 then
                end
            
            elseif zone.name == "Cape Terrigan" then
            
                if status == 1 then
                    
                elseif status == 2 then
                    
                end
            
            elseif zone.name == "Maquette Abdhaljs-LegionA" or zone.name == "Maquette Abdhaljs-LegionB" then
            
                if status == 1 then
                    
                elseif status == 2 then
                    
                end
            
            else            
            
                if status == 0 then
                end
            
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

beast["handle menus"] = function(id,original,modified,injected,blocked)
    local injecting = helpers["events"].getInjecting()
    
    if id == 0x032 or id == 0x034 and injecting then
        local status = helpers["events"].getStatus()
        
        if status == 2 then
            
        elseif status == 3 then
            
        end
    
    end
    
end

beast["entry status"] = function(id,original,modified,injected,blocked)
    
    if id == 0x02a then
        local p      = packets.parse("incoming", original)
        local status = helpers["events"].getStatus()
        local ready  = 40852
        
        if status == 2 and p["Message ID"] = ready then
            helpers["events"].setStatus(3)
            helpers["events"].interact(npc[zone.name][""], 1, 4)
            helpers["events"].setDelays("zone", 15)
        
        end    
    
    end

end

beast["kill mobs"] = function(id,original,modified,injected,blocked)
    
    if id == 0x029 then
        local p      = packets.parse("incoming", original)
        local status = helpers["events"].getStatus()
        local count  = helpers["events"].getCounts().kill
        
        if status == 1 and p["Message"] == 6 and bpcore:isInParty(windower.ffxi.get_mob_by_id(p["Actor"])) and windower.ffxi.get_mob_array()[p["Target Index"]].name == "Greater Manticore" then
            count = (count + 1)
            helpers["events"].setCounts("kill",  count)
            
            if count == "11" then
                helpers["events"].setStatus(2)
            end
            
        end    
    
    end

end

beast["registry"] = {
    
    ["zone change"]   = "zone change",
    ["prerender"]     = "prerender",
    ["handle menus"]  = "incoming chunk",
    ["entry status"]  = "incoming chunk",
    ["kill mobs"]     = "incoming chunk",
    
}
return intense