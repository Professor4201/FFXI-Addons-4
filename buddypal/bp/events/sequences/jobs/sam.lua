local settings = dofile(windower.addon_path.."bp/events/sequences/jobs/settings/sam_settings.lua")
local window   = helpers["events"].getWindow()

-- Set Private Tables.
helpers["events"].setEvents(settings)
helpers["events"].setItems(settings)
helpers["events"].setNPCs(settings)
helpers["events"].setDelays("zone", 5)

-- Global Variables.
local days_count = 0
local tree_spawn = false

-- Launch Events
local sam = {}
sam["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

sam["prerender"] = function()
    local player = windower.ffxi.get_mob_by_target('me') or false
    
    if player then
        local midaction = helpers["actions"].getMidaction()
        local clocks    = helpers["events"].getClocks()
        local delays    = helpers["events"].getDelays()
        local zone      = helpers["events"].getZone()
        local npc       = helpers["events"].getNPCs()
        
        -- Handle Cutscene Status.
        helpers['events'].handleCutscene()
        
        if os.clock()-clocks.ping > delays.spam + delays.zone and player.status ~= 4 and not midaction then
            local status = helpers["events"].getStatus()

            -- Reset the zone delay, and update the event display.
            helpers["events"].setDelays("zone", 0)
            helpers['events'].updateDisplay()
            
            if zone.name == "Norg" then
                
                if status == 0 then
                    helpers["events"].interact(npc[zone.name]["Jaucribaix"], 1, 1)
                
                elseif status == 1 then
                    
                    if (bpcore:findItemByName("Oriental Steel") or bpcore:findItemByName("Bomb Steel")) then
                        helpers["events"].setStatus(2)
                    else
                        helpers["events"].interact(npc[zone.name]["Aeka"], 1, false)
                    end
                    
                elseif status == 2 then
                    
                    if (bpcore:findItemByName("Sacred Sprig") or bpcore:findItemByName("Sacred Branch")) then
                        helpers["events"].setStatus(3)
                    else
                        helpers["events"].interact(npc[zone.name]["Ranemaud"], 1, false)
                    end
                    
                elseif status == 3 then
                    windower.send_command("bp mw sg Konschtat Highlands")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif status == 4 then
                    windower.send_command("bp mw hp Mhaura 1")
                    helpers["events"].setDelays("zone", 10)
                
                elseif status == 5 then
                    windower.send_command("bp mw sg The Sanctuary of Zi'Tah")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif status == 6 then
                    local locked = helpers["actions"].getLocked()
                    
                    if not locked and bpcore:findItemByName("Bomb Steel") and bpcore:findItemByName("Sacred Branch") then
                        helpers["actions"].lockPosition(npc[zone.name]["Jaucribaix"].x, npc[zone.name]["Jaucribaix"].y, npc[zone.name]["Jaucribaix"].z)
                        
                    elseif locked and bpcore:findItemByName("Bomb Steel") and bpcore:findItemByName("Sacred Branch") then
                        helpers["events"].trade(npc[zone.name]["Jaucribaix"], 7, {bpcore:findItemByName("Bomb Steel"), 1}, {bpcore:findItemByName("Sacred Branch"), 1})
                        helpers["actions"].setLocked(false)
                        
                    end
                
                elseif (status == 7 or status == 8 or status == 9) then
                    local locked = helpers["actions"].getLocked()
                    
                    if not locked then
                        helpers["actions"].lockPosition(npc[zone.name]["Jaucribaix"].x, npc[zone.name]["Jaucribaix"].y, npc[zone.name]["Jaucribaix"].z)
                        
                    elseif locked and days_count > 2 then
                        helpers["events"].setStatus(10)
                    
                    end
                
                elseif status == 10 then
                    local locked = helpers["actions"].getLocked()
                    
                    if locked then
                        helpers["events"].interact(npc[zone.name]["Jaucribaix"], 1, 11)
                        helpers["actions"].setLocked(false)
                        
                    elseif not locked then
                        helpers["actions"].lockPosition(npc[zone.name]["Jaucribaix"].x, npc[zone.name]["Jaucribaix"].y, npc[zone.name]["Jaucribaix"].z)
                        
                    end
                
                elseif status == 11 then
                    helpers["events"].finishEvent("Jobs")
                    
                end
                
            elseif zone.name == "Konschtat Highlands" then
                
                if status == 3 then
                    local locked = helpers["actions"].getLocked()
                    
                    if not locked and not bpcore:findItemByName("Bomb Steel") and bpcore:findItemByName("Oriental Steel") then
                        helpers["actions"].lockPosition(npc[zone.name]["???"].x, npc[zone.name]["???"].y, npc[zone.name]["???"].z)
                        
                    elseif not locked and bpcore:findItemByName("Bomb Steel") and not bpcore:findItemByName("Oriental Steel") then
                        helpers["actions"].lockPosition(npc[zone.name]["???"].x, npc[zone.name]["???"].y, npc[zone.name]["???"].z)
                        
                    elseif locked and not bpcore:findItemByName("Bomb Steel") and bpcore:findItemByName("Oriental Steel") then
                        helpers["events"].trade(npc[zone.name]["???"], false, {bpcore:findItemByName("Oriental Steel"), 1})
                        
                    elseif locked and bpcore:findItemByName("Bomb Steel") then
                        helpers["actions"].setLocked(false)
                        helpers["events"].setStatus(4)
                        helpers["events"].setDelays("zone", 10)
                        
                    end
                    
                elseif status == 4 then
                    windower.send_command("bp mw sg Norg")
                    helpers["events"].setDelays("zone", 10)
                
                end
            
            elseif zone.name == "The Sanctuary of Zi'Tah" then
                
                if status == 5 then
                    local locked = helpers["actions"].getLocked()
                    
                    if not locked and bpcore:findItemByName("Hatchet") and bpcore:findItemByName("Sacred Sprig") and not bpcore:findItemByName("Sacred Branch") then
                        helpers["actions"].lockPosition(npc[zone.name]["???"].x, npc[zone.name]["???"].y, npc[zone.name]["???"].z)
                    
                    elseif not locked and not bpcore:findItemByName("Sacred Sprig") and bpcore:findItemByName("Sacred Branch") then
                        helpers["events"].trade(npc[zone.name]["???"], false, {bpcore:findItemByName("Sacred Sprig"), 1})
                        
                    elseif locked and bpcore:findItemByName("Hatchet") and bpcore:findItemByName("Sacred Sprig") and not bpcore:findItemByName("Sacred Branch") and not tree_spawn then
                        helpers["events"].trade(npc[zone.name]["???"], false, {bpcore:findItemByName("Hatchet"), 1})
                        
                    elseif locked and bpcore:findItemByName("Sacred Sprig") and not bpcore:findItemByName("Sacred Branch") and tree_spawn then
                        helpers["events"].trade(npc[zone.name]["???"], false, {bpcore:findItemByName("Sacred Sprig"), 1})
                        
                    elseif locked and not bpcore:findItemByName("Sacred Sprig") and bpcore:findItemByName("Sacred Branch") then
                        helpers["actions"].setLocked(false)
                        helpers["events"].setStatus(6)
                        helpers["events"].setDelays("zone", 10)
                        
                    end
                    
                elseif status == 6 then
                    windower.send_command("bp mw sg Norg")
                    helpers["events"].setDelays("zone", 10)
                
                end
                
            elseif zone.name == "Mhaura" then
                
                if status == 4 then
                    local locked = helpers["actions"].getLocked()
                    
                    if not locked and not bpcore:findItemByName("Hatchet") then
                        helpers["actions"].lockPosition(npc[zone.name]["Pikini-Mikini"].x, npc[zone.name]["Pikini-Mikini"].y, npc[zone.name]["Pikini-Mikini"].z)
                        helpers["events"].setDelays("zone", 2)
                        
                    elseif locked and not bpcore:findItemByName("Hatchet") then
                        helpers["actions"].poke(npc[zone.name]["Pikini-Mikini"])
                        helpers["actions"].buyItem(7, 1)
                        helpers["events"].setDelays("zone", 2)
                        helpers["actions"].setLocked(false)
                        
                    elseif bpcore:findItemByName("Hatchet") then
                        helpers["events"].setDelays("zone", 2)
                        helpers["events"].setStatus(5)
                        
                    end
                
                elseif status == 5 then
                    windower.send_command("bp mw hp Norg 1")
                    helpers["events"].setDelays("zone", 10)
                    
                end
            
            else
                windower.send_command("bp mw hp Norg 1")
                helpers["events"].setDelays("zone", 10)
            
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

sam["kill mobs"] = function(id,original,modified,injected,blocked)
    
    -- Incoming Action Event.
    if id == 0x028  then
        local p        = packets.parse("incoming", original)
        local actor    = windower.ffxi.get_mob_by_id(p["Actor"])
        local target   = windower.ffxi.get_mob_by_id(p["Target 1 ID"])
        local category = p["Category"]
        local param    = p["Param"]
        
        if actor and target then
            
            -- Melee Attacks.
            if p["Category"] == 1 then
                
                if actor.name == "Forger" then
                    windower.ffxi.turn(math.random(-180, 180))
                    
                elseif actor.name == "Guardian Treant" then
                    windower.ffxi.turn(math.random(-180, 180))
                
                end
                
            end    
        
        end
    
    elseif id == 0x05b then
        local p = packets.parse("incoming", original)
        
        if p["Type"] and p["ID"] and p["Index"] then
            local target = windower.ffxi.get_mob_by_id(p["ID"])
            
            if p["Type"] == 3 and windower.ffxi.get_mob_array()[p["Index"]].name == "Forger" then
                helpers["actions"].doAction(target, false, "engage")
                helpers["events"].setDelays("zone", 2)
                
            elseif p["Type"] == 3 and windower.ffxi.get_mob_array()[p["Index"]].name == "Guardian Treant" then
                helpers["actions"].doAction(target, false, "engage")
                helpers["events"].setDelays("zone", 2)
                tree_spawn = true
                
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
    
    end
    
end

sam["day change"] = function(new, old)
    
    if new and helpers["events"].getStatus() > 6 then
        helpers["events"].setStatus(helpers["events"].getStatus()+1)    
    end
    
end

sam["registry"] = {
    
    ["zone change"]  = "zone change",
    ["prerender"]    = "prerender",
    ["day change"]   = "day change",
    ["kill mobs"]    = "incoming chunk",
    
}
return sam