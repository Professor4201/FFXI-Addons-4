-- Global Event Variables.
local settings
local window
local kills
local spawned

-- Launch Events
local nin = {}
nin["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

nin["prerender"] = function()
    local player = windower.ffxi.get_mob_by_target("me") or false
    
    if player then
        
        if helpers["events"].getReset() then
            settings    = dofile(windower.addon_path.."bp/events/sequences/jobs/settings/nin_settings.lua")
            window      = helpers["events"].getWindow()
            
            -- Set Private Tables.
            helpers["events"].setEvents(settings)
            helpers["events"].setItems(settings)
            helpers["events"].setNPCs(settings)
            helpers["events"].setReset(false)
            kills   = 0
            spawned = false
        
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
                           helpers["events"].setDelays("zone", 0)
            
            if zone.name == "Port Bastok" then
                
                if status == 0 then
                    local target = windower.ffxi.get_mob_by_name("Kaede") or false
                    
                    if not target or (target and target.distance:sqrt() > 6) then
                        helpers["actions"].reposition(npc[zone.name]["Kaede"].x, npc[zone.name]["Kaede"].y, npc[zone.name]["Kaede"].z)
                        helpers["events"].setDelays("zone", 1)
                    
                    elseif target and target.distance:sqrt() < 6 then
                        helpers["events"].interact(target, 2, 1)
                        
                    end
                    
                elseif status == 1 then
                    local target = windower.ffxi.get_mob_by_name("Kagetora") or false
                    
                    if not target or (target and target.distance:sqrt() > 6) then
                        helpers["actions"].reposition(npc[zone.name]["Kagetora"].x, npc[zone.name]["Kagetora"].y, npc[zone.name]["Kagetora"].z)
                        helpers["events"].setDelays("zone", 1)
                        
                    elseif target and target.distance:sqrt() < 6 then
                        helpers["events"].interact(target, 2, 2)
                        
                    end
                    
                elseif status == 2 then
                    local target = windower.ffxi.get_mob_by_name("Ensetsu") or false
                    
                    if not target or (target and target.distance:sqrt() > 6) then
                        helpers["actions"].reposition(npc[zone.name]["Ensetsu"].x, npc[zone.name]["Ensetsu"].y, npc[zone.name]["Ensetsu"].z)
                        helpers["events"].setDelays("zone", 1)
                            
                    elseif target and target.distance:sqrt() < 6 then
                        helpers["events"].interact(target, 2, 3)
                    
                    end
                    
                elseif status == 3 then
                    local target = windower.ffxi.get_mob_by_name("Ensetsu") or false
                    
                    if target and target.distance:sqrt() < 6 then
                        helpers["events"].setDelays("zone", 10)
                        windower.send_command("bp mw hp Bastok Mines 3")                    
                    end
                    
                elseif status == 7 then
                    local target = windower.ffxi.get_mob_by_name("Ensetsu") or false
                    
                    if not target or (target and target.distance:sqrt() > 6) then
                        helpers["actions"].reposition(npc[zone.name]["Ensetsu"].x, npc[zone.name]["Ensetsu"].y, npc[zone.name]["Ensetsu"].z)
                        helpers["events"].setDelays("zone", 1)
                            
                    elseif target and target.distance:sqrt() < 6 then
                        helpers["events"].interact(target, 2, 8)
                    
                    end
                    
                elseif status == 8 then
                    helpers["events"].setDelays("zone", 10)
                    windower.send_command("bp mw hp Norg 1")
                    
                elseif status == 9 then
                    local target = windower.ffxi.get_mob_by_name("Ensetsu") or false
                    
                    if not target or (target and target.distance:sqrt() > 6) then
                        helpers["actions"].reposition(npc[zone.name]["Ensetsu"].x, npc[zone.name]["Ensetsu"].y, npc[zone.name]["Ensetsu"].z)
                        helpers["events"].setDelays("zone", 1)
                            
                    elseif target and target.distance:sqrt() < 6 then
                        helpers["events"].interact(target, 2, 10)
                    
                    end
                    
                elseif status == 10 then
                    helpers["events"].finishEvent("Jobs")
                    
                end
                
            elseif zone.name == "Korroloka Tunnel" then
                
                if status == 3 then
                    helpers["events"].setStatus(4)
                
                elseif status == 4 then
                    local target = windower.ffxi.get_mob_by_id(npc[zone.name]["???"].id) or false
                    
                    if not target or (target and target.distance:sqrt() > 6) then
                        helpers["actions"].reposition(npc[zone.name]["???"].x, npc[zone.name]["???"].y, npc[zone.name]["???"].z)
                        helpers["events"].setDelays("zone", 1)
                            
                    elseif target and target.distance:sqrt() < 6 then
                        helpers["events"].interact(target, 2, 5)
                    
                    end
                    
                elseif status == 5 then
                    local leeches = {17486187,17486188,17486189}
                    local target
                    
                    if player.status == 0 then
                        
                        if kills == 3 then
                            helpers["events"].setStatus(6)
                            helpers["events"].setDelays("zone", 10)
                            
                        end
                        
                        
                    end
                    
                elseif status == 6 then
                    local target = windower.ffxi.get_mob_by_id(npc[zone.name]["???"].id) or false
                    
                    if target and target.distance:sqrt() < 6 then
                        helpers["events"].interact(target, 2, 7)
                        
                    elseif not target then
                        helpers["events"].setDelays("zone", 3)
                        
                    end
                    
                elseif status == 7 then
                    helpers["events"].setDelays("zone", 10)
                    windower.send_command("bp mw sg Bastok Mines")
                
                end
                
            elseif zone.name == "Norg" then
                
                if status == 8 then
                    local target = windower.ffxi.get_mob_by_name("Ryoma") or false
                    
                    if not target or (target and target.distance:sqrt() > 6) then
                        helpers["actions"].reposition(npc[zone.name]["Ryoma"].x, npc[zone.name]["Ryoma"].y, npc[zone.name]["Ryoma"].z)
                        helpers["events"].setDelays("zone", 1)
                            
                    elseif target and target.distance:sqrt() < 6 then
                        helpers["events"].interact(target, 2, 9)
                    
                    end
                    
                elseif status == 9 then
                    helpers["events"].setDelays("zone", 10)
                    windower.send_command("bp mw hp Port Bastok 3")
                
                else
                    helpers["events"].setDelays("zone", 10)
                    windower.send_command("bp mw hp Bastok Markets 1")
                
                end
                
            elseif zone.name == "Bastok Mines" then
                
                if status == 3 then
                    helpers["events"].setDelays("zone", 10)
                    windower.send_command("bp mw sg Korroloka Tunnel")
                    
                elseif status == 7 then
                    helpers["events"].setDelays("zone", 10)
                    windower.send_command("bp mw hp Port Bastok 3")
                
                else
                    helpers["events"].setDelays("zone", 10)
                    windower.send_command("bp mw hp Bastok Markets 1")
                
                end
                
            else
                helpers["events"].setDelays("zone", 10)
                windower.send_command("bp mw hp Port Bastok 3")
                
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        helpers["events"].updateDisplay()
        
    end
    
end

nin["leech attack"] = function(id,original,modified,injected,blocked)
    
    if id == 0x028 then
        local p        = packets.parse("incoming", original)
        local actor    = windower.ffxi.get_mob_by_id(p["Actor"])
        local target   = windower.ffxi.get_mob_by_id(p["Target 1 ID"])
        local category = p["Category"]
        local param    = p["Param"]
        
        if category == 1 and actor and target and actor.name == "Korroloka Leech" and target.name == windower.ffxi.get_mob_by_target("me").name then
            
            if actor.distance:sqrt() < 6 and kills < 3 and target.status == 0 then
                helpers["actions"].doAction(actor, 0, "engage")
                helpers["events"].setDelays("zone", 15)
                
            end
            
        end
        
    end
    
end

nin["kill counter"] = function(id,original,modified,injected,blocked)
    
    if id == 0x029 then
        local player, target, message = original:unpack("I", 0x04+1) or false, original:unpack("I", 0x08+1) or false, original:unpack("H", 0x18+1) or false

        if player and target and message and player == windower.ffxi.get_mob_by_target("me").id and windower.ffxi.get_mob_by_id(target).name == "Korroloka Leech" and message == 6 then
            kills = (kills + 1)
        end
        
    end
    
end

nin["registry"] = {
    ["zone change"]     = "zone change",
    ["prerender"]       = "prerender",
    ["leech attack"]    = "incoming chunk",
    ["kill counter"]    = "incoming chunk",
}

return nin