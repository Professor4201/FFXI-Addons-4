-- Global Event Variables.
local settings
local window

-- Launch Events
local sch = {}
sch["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

sch['prerender'] = function()
    local player = windower.ffxi.get_mob_by_target("me") or false
    
    if player then
        
        if helpers["events"].getReset() then
            settings    = dofile(windower.addon_path.."bp/events/sequences/jobs/settings/sch_settings.lua")
            window      = helpers["events"].getWindow()
            
            -- Set Private Tables.
            helpers["events"].setEvents(settings)
            helpers["events"].setItems(settings)
            helpers["events"].setNPCs(settings)
            helpers["events"].setReset(false)
        
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
            
            if zone.name == "Bastok Markets" then
                
                if status == 0 then
                    windower.send_command("bp mw home Western Adoulin 1")
                    helpers["events"].setDelays("zone", 10)
                end
                
            elseif zone.name == "Bastok Mines" then
                local nation = system["Nation"][windower.ffxi.get_player().nation]
                
                if status == 1 then
                    
                    if nation == "Sandoria" then
                        windower.send_command("bp mw sg La Theine Plateau")
                        helpers["events"].setDelays("zone", 10)
                    
                    elseif nation == "Bastok" then
                        windower.send_command("bp mw sg Konschtat Highlands")
                        helpers["events"].setDelays("zone", 10)
                        
                    elseif nation == "Windurst" then
                        windower.send_command("bp mw sg Tahrongi Canyon")
                        helpers["events"].setDelays("zone", 10)
                        
                    end
                
                elseif status == 2 then
                    windower.send_command("bp mw home Western Adoulin 1")
                    helpers["events"].setDelays("zone", 10)
                    
                end
                
            elseif zone.name == "Western Adoulin" then
                
                if status == 0 then
                    local target = windower.ffxi.get_mob_by_name("Sylvie") or false
                    
                    if not target or (target and target.distance:sqrt() > 6) then
                        helpers["actions"].reposition(npc[zone.name]["Sylvie"].x, npc[zone.name]["Sylvie"].y, npc[zone.name]["Sylvie"].z)
                        helpers["events"].setDelays("zone", 3)
                    
                    elseif target and target.distance:sqrt() < 6 then
                        helpers["events"].interact(target, 2, 1)
                        
                    end
                    
                elseif status == 1 then
                    windower.send_command("bp mw hp Bastok Mines 1")
                    helpers["events"].setDelays("zone", 10)
                
                elseif status == 2 then
                    helpers['events'].trade(npc[zone.name]["Sylvie"], 3, {bpcore:findItemByName("Petrified Log"), 1})
                    helpers["events"].setDelays("zone", 4)
                    
                elseif status == 3 then
                    windower.send_command("bp mw hp Ceizak Battlegrounds 1")
                    helpers["events"].setDelays("zone", 10)
                    helpers["events"].setStatus(3)
                    
                elseif status == 4 then
                    local target = windower.ffxi.get_mob_by_name("Sylvie") or false
                    
                    if not target or (target and target.distance:sqrt() > 6) then
                        helpers["actions"].reposition(npc[zone.name]["Sylvie"].x, npc[zone.name]["Sylvie"].y, npc[zone.name]["Sylvie"].z)
                        helpers["events"].setDelays("zone", 3)
                    
                    elseif target and target.distance:sqrt() < 6 then
                        helpers["events"].interact(target, 1, 5)
                        
                    end
                    
                elseif status == 5 then
                    helpers["popchat"]:pop(("GEO is now unlocked!"), system["Popchat Window"])
                    helpers["events"].finishEvent("Jobs")
                
                end
                
            elseif (zone.name == "Konschtat Highlands" or zone.name == "La Theine Plateau" or zone.name == "Tahrongi Canyon") then
                local target = windower.ffxi.get_mob_by_id(npc[zone.name]["Soil"].id) or false
                    
                if status == 1 then
                    
                    if not target or (target and target.distance:sqrt() > 6) then
                        helpers["actions"].reposition(npc[zone.name]["Soil"].x, npc[zone.name]["Soil"].y, npc[zone.name]["Soil"].z)
                        helpers["events"].setDelays("zone", 3)
                    
                    elseif target and target.distance:sqrt() < 6 then
                        helpers["events"].interact(target, 1, 2)
                        
                    end
                    
                elseif status == 2 then
                    windower.send_command("bp mw sg Bastok Mines")
                    helpers["events"].setDelays("zone", 10)
                    
                end
                
            elseif zone.name == "Ceizak Battlegrounds" then
                local target = windower.ffxi.get_mob_by_id(npc[zone.name]["Ergon Locus"].id) or false
                
                if status == 3 then
                    
                    if not target or (target and target.distance:sqrt() > 6) then
                        helpers["actions"].reposition(npc[zone.name]["Ergon Locus"].x, npc[zone.name]["Ergon Locus"].y, npc[zone.name]["Ergon Locus"].z)
                        helpers["events"].setDelays("zone", 4)
                    
                    elseif target and target.distance:sqrt() < 6 then
                        
                        if system["Player"].status ~= 33 then
                            windower.send_command("input /heal")
                            helpers["events"].setDelays("zone", 60)
                        end
                        
                    end
                
                elseif status == 4 then
                    windower.send_command("bp mw hp Western Adoulin 1")
                    helpers["events"].setDelays("zone", 10)
                
                end
                
            else
                
                if bpcore:findHomepoint() then
                    windower.send_command("bp mw hp Western Adoulin")
                    helpers["events"].setDelays("zone", 10)
                    
                else
                    helpers["actions"].tryWarping()
                
                end
            
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        helpers['events'].updateDisplay()
        
    end
    
end

sch["Handle Messages"] = function(id,original,modified,injected,blocked)
    
    if id == 0x036 then
        local p = packets.parse('incoming', original)

        if p['Message ID'] == 8027 and system["Player"].id == p["Actor"] then
            helpers["actions"].stepBackwards()
            helpers["events"].setStatus(4)
            helpers["events"].setDelays("zone", 1)
            
        end
    
    end
    
end

sch['registry'] = {
    ["zone change"]     = "zone change",
    ["prerender"]       = "prerender",
    ["Handle Messages"] = "incoming chunk",
}

return sch