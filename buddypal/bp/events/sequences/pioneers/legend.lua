-- Global Event Variables.
local settings
local window
local found    = false
local attempts = 0

-- Launch Events
local legend = {}
legend["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

legend["prerender"] = function()
    local player = windower.ffxi.get_mob_by_target("me") or false
    
    if player then
        
        if helpers["events"].getReset() then
            settings    = dofile(windower.addon_path.."bp/events/sequences/mummers/settings/legend_settings.lua")
            window      = helpers["events"].getWindow()
            
            -- Set Private Tables.
            helpers["events"].setEvents(settings)
            helpers["events"].setItems(settings)
            helpers["events"].setNPCs(settings)
            helpers["events"].setReset(false)
            attempts = 0
            found    = false
        
        end
        
        local midaction = helpers["actions"].getMidaction()
        local clocks    = helpers["events"].getClocks()
        local delays    = helpers["events"].getDelays()
        local zone      = helpers["events"].getZone()
        local npc       = helpers["events"].getNPCs()
        
        -- Handle Cutscene Status.
        helpers["events"].handleCutscene()
        
        if os.clock()-clocks.ping > delays.spam + delays.zone and player.status ~= 4 and not midaction then
            local status = helpers["events"].getStatus()
            
            -- Reset the zone delay, and update the event display.
            helpers["events"].setDelays("zone", 0)
            helpers["events"].updateDisplay()
            
            if zone.name == "Western Adoulin" then
                
                if status == 0 then
                    helpers["events"].setInjecting(true)
                    helpers["events"].interact(npc[zone.name]["Task Delegator"], 1, false)
                    
                elseif status == 1 then
                    helpers["events"].setDelays("zone", 10)
                    windower.send_command("bp mw wp Kamihr Drifts 1")
                    
                elseif status == 3 then
                    helpers["events"].setInjecting(true)
                    helpers["events"].interact(npc[zone.name]["Task Delegator"], 1, false)
                    
                elseif status == 4 then
                    local imps = helpers["currencies"].getCurrency("Imps")
                    
                    if imps >= 3 and helpers["coalitions"].getRepeating() then
                        helpers["events"].finishEvent("Mummers", helpers["coalitions"].getCoalition(), "Legend")
                        
                    else
                        helpers["events"].finishEvent("Mummers")
                        
                    end
                    
                end
                
            elseif zone.name == "Kamihr Drifts" then
                
                if status == 1 then
                    
                    if not found then
                        windower.packets.inject_outgoing(0x016, ("iHH"):pack(0x00001600, 345, 0))
                        helpers["events"].setDelays("zone", 5)
                        
                    elseif found then
                        local article = windower.ffxi.get_mob_by_name("Lost Article") or false
                        
                        if article then
                            helpers["events"].interact(article, 1, 3)                        
                        end
                        
                    end
                
                elseif status == 2 then
                    helpers["events"].setDelays("zone", 10)
                    windower.send_command("bp mw wp Marjami Ravine 4")
                
                elseif status == 3 then
                    helpers["events"].setDelays("zone", 10)
                    windower.send_command("bp mw wp Western Adoulin 3")
                    
                end
                
            elseif zone.name == "Woh Gates" then
                
                if status == 2 then
                    
                    if not found then
                        windower.packets.inject_outgoing(0x016, ("iHH"):pack(0x00001600, 442, 0))
                        helpers["events"].setDelays("zone", 5)
                        
                    elseif found then
                        local article = windower.ffxi.get_mob_by_name("Lost Article") or false
                        
                        if article then
                            helpers["events"].interact(article, 1, 3)                        
                        end
                        
                    end
                
                elseif status == 3 then
                    local warp     = helpers["actions"].rangeCheck(npc[zone.name]["Warp"].x, npc[zone.name]["Warp"].y, 3)
                    local waypoint = windower.ffxi.get_mob_by_name("Waypoint") or false
                    
                    if waypoint and waypoint.distance:sqrt() < 6 and not warp then
                        helpers["actions"].reposition(npc[zone.name]["Warp"].x, npc[zone.name]["Warp"].y, npc[zone.name]["Warp"].z)
                        helpers["events"].setDelays("zone", 2)
                        
                    elseif not waypoint or (waypoint and waypoint.distance:sqrt() > 6 and warp) then
                        helpers["actions"].moveToPosition(npc[zone.name]["Entrance"].x, npc[zone.name]["Entrance"].y)
                        helpers["events"].setDelays("zone", 15)
                        
                    end
                    
                end
                
            elseif zone.name == "Marjami Ravine" then
                local me = windower.ffxi.get_mob_by_target("me")
                
                if status == 2 then
                    local warp     = helpers["actions"].rangeCheck(npc[zone.name]["Warp"].x, npc[zone.name]["Warp"].y, 3)
                    local waypoint = windower.ffxi.get_mob_by_name("Waypoint") or false
                    
                    if waypoint and waypoint.distance:sqrt() < 6 and not warp then
                        helpers["actions"].reposition(npc[zone.name]["Warp"].x, npc[zone.name]["Warp"].y, npc[zone.name]["Warp"].z)
                        helpers["events"].setDelays("zone", 2)
                        
                    elseif not waypoint or (waypoint and waypoint.distance:sqrt() > 6 and warp) then
                        helpers["actions"].moveToPosition(npc[zone.name]["Entrance"].x, npc[zone.name]["Entrance"].y)
                        helpers["events"].setDelays("zone", 15)
                        
                    end
                    
                elseif status == 3 then
                    helpers["events"].setDelays("zone", 10)
                    windower.send_command("bp mw wp Western Adoulin 3")
                    
                end
                
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

legend["missions"] = function(id,original,modified,injected,blocked)
    local mission   = {id=17825851, index=59, option=63400, _u1=29,  _u2=0, message=false, zone=256, menu=2012}
    local complete  = {id=17825851, index=59, option=63401, _u1=125, _u2=0, message=false, zone=256, menu=2012}
    local injecting = helpers["events"].getInjecting()
    
    if id == 0x034 and injecting then
        local p = packets.parse('incoming', original)
        local status = helpers["events"].getStatus()
        
        if p["NPC"] == mission.id and status == 0 then

            helpers["actions"].injectMenu(mission.id, mission.index, mission.zone, mission.option, mission.menu, mission.message, mission._u1, mission._u2)
            helpers["events"].setDelays("zone", 3)
            helpers["events"].setStatus(1)
            
        elseif p["NPC"] == complete.id and status == 3 then
            helpers["actions"].injectMenu(complete.id, complete.index, complete.zone, complete.option, complete.menu, complete.message, complete._u1, complete._u2)
            helpers["events"].setDelays("zone", 3)
            helpers["events"].setStatus(4)
            
        else
            helpers["actions"].doExitMenu(p, mission)
            
        end
        helpers["events"].setInjecting(false)
        helpers["events"].setClocks("ping", os.clock())
        return true
        
    end
    
end

legend["find article"] = function(id,original,modified,injected,blocked)
    
    if id == 0x00e then
        local p      = packets.parse("incoming", original)
        local npc    = p["NPC"]
        local index  = p["Index"]
        local status = p["Status"]
        
        if p and npc then
            local zone       = helpers["events"].getZone()
            local info       = helpers["npcupdater"]:build(original)
            local spawned    = info.mbits:sub(6,6)
            local name       = p["Name"]
            
            if name:match("Article") and info.mbits == "11110000" then
                local x, y, z = p["X"], p["Y"], p["Z"]
                local total   = (x+y+z)
                
                if x and y and z and total ~= 0 and not found then
                    helpers["actions"].reposition(x, y, z)
                    found = true
                
                else
                    attempts = (attempts + 1)
                    
                    if attempts == 15 and zone.name == "Kamihr Drifts" then
                        helpers["events"].setDelays("zone", 5)
                        helpers["events"].setStaus(2)
                        attempts = 0
                    end
                    
                end
            
            end
            
        end
        
    end
    
end

legend['registry'] = {
    
    ["zone change"]  = "zone change",
    ["prerender"]    = "prerender",
    ["missions"]     = "incoming chunk",
    ["find article"] = "incoming chunk",
    
}
return legend