-- Global Event Variables.
local settings
local window

-- Launch Events
local brd = {}
brd["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

brd['prerender'] = function()
    local player = windower.ffxi.get_mob_by_target("me") or false
    
    if player then
        
        if helpers["events"].getReset() then
            settings    = dofile(windower.addon_path.."bp/events/sequences/jobs/settings/brd_settings.lua")
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
            
            if zone.name == "Bastok Markets" then
                
                if status == 0 then
                    
                    if bpcore:findItemByName("Poetic Parchment") then
                        helpers["events"].setStatus(5)
                    
                    else
                        windower.send_command("bp mw homepoint Lower Jeuno 1")
                        helpers["events"].setDelays("zone", 10)
                        
                    end
                
                elseif status == 3 then
                    windower.send_command("bp mw un Buburimu Peninsula")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif status == 5 then
                    windower.send_command("bp mw hp Lower Jeuno 1")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif status == 7 then
                    windower.send_command("bp mw un Valkurm Dunes")
                    helpers["events"].setDelays("zone", 10)
                    
                end
                
            elseif zone.name == "Lower Jeuno" then
                
                if status == 0 then
                    
                    if bpcore:findItemByName("Poetic Parchment") then
                        helpers["events"].setStatus(5)
                    
                    else
                        helpers["events"].interact(npc[zone.name]["Mertaire"], 1, 1)
                        
                    end
                
                elseif status == 1 then
                    helpers["events"].interact(npc[zone.name]["Bki Tbujhja"], 1, 2)
                    
                elseif status == 2 then
                    
                    if bpcore:findItemByName("Parchment") then
                        windower.send_command("bp mw home Bastok Markets 1")
                        helpers["events"].setDelays("zone", 10)
                        helpers["events"].setStatus(3)
                    else
                        windower.send_command("bp mw home Mhaura 1")
                        helpers["events"].setDelays("zone", 10)
                    
                    end
                
                elseif status == 5 then
                    helpers["events"].trade(npc[zone.name]["Mertaire"], 6, {bpcore:findItemByName("Poetic Parchment"), 1})
                    
                elseif status == 6 then
                    helpers["events"].interact(npc[zone.name]["Bki Tbujhja"], 1, 7)
                    
                elseif status == 7 then
                    windower.send_command("bp mw home Bastok Markets 1")
                    helpers["events"].setDelays("zone", 10)
                
                end
                
            elseif zone.name == "Mhaura" then
                
                if status == 2 then
                    local locked = helpers["actions"].getLocked()
                    
                    if not locked and not bpcore:findItemByName("Parchment") then
                        helpers["actions"].lockPosition(npc[zone.name]["Pikini-Mikini"].x, npc[zone.name]["Pikini-Mikini"].y, npc[zone.name]["Pikini-Mikini"].z)
                        helpers["events"].setDelays("zone", 7)
                        
                    elseif locked and not bpcore:findItemByName("Parchment") then
                        helpers["actions"].poke(npc[zone.name]["Pikini-Mikini"])
                        helpers["actions"].buyItem(5, 1)
                        helpers["actions"].setLocked(false)
                        helpers["events"].setDelays("zone", 7)
                        
                    elseif bpcore:findItemByName("Parchment") then
                        helpers["events"].setStatus(3)
                        helpers["events"].setDelays("zone", 7)
                        
                    end
                
                elseif status == 3 then
                    windower.send_command("bp mw home Bastok Markets 1")
                    helpers["events"].setDelays("zone", 10)
                    
                end
                
            elseif zone.name == "Buburimu Peninsula" then
                
                if status == 3 then
                    helpers["events"].interact(npc[zone.name]["Song Runes"], 1, 4)
                    
                elseif status == 4 then
                    
                    if bpcore:findItemByName("Parchment") then
                        helpers['events'].trade(npc[zone.name]["Song Runes"], 5, {bpcore:findItemByName("Parchment"), 1})
                    
                    elseif bpcore:findItemByName("Poetic Parchment") then
                        helpers["actions"].setLocked(false)
                        helpers["events"].setStatus(5)
                    
                    end
                    
                elseif status == 5 then
                    helpers['actions'].tryWarping()
                    helpers["events"].setDelays("zone", 25)
                    
                end
                
            elseif zone.name == "Valkurm Dunes" then
                
                if status == 7 then
                    helpers["events"].interact(npc[zone.name]["Song Runes"], 1, 8)
                    
                elseif status == 8 then
                    helpers['actions'].tryWarping()
                    helpers["events"].setDelays("zone", 25)
                    helpers["events"].finishEvent("BRD")
                    
                end
                
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        helpers['events'].updateDisplay()
        
    end
    
end
        
brd['registry'] = {
    
    ["zone change"]  = "zone change",
    ["prerender"]    = "prerender",
    
}
return brd