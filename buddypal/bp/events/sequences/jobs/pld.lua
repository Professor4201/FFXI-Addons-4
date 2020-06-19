-- Global Event Variables.
local settings
local window

-- Launch Events
local pld = {}
pld["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

pld["prerender"] = function()
    local player = windower.ffxi.get_mob_by_target('me') or false
    
    if player then
        
        -- Registering event, reset variables.
        if helpers["events"].getReset() then
            settings    = dofile(windower.addon_path.."bp/events/sequences/jobs/settings/pld_settings.lua")
            window      = helpers["events"].getWindow()
            
            -- Set Private Tables.
            helpers["events"].setReset(false)
            helpers["events"].setEvents(settings)
            helpers["events"].setItems(settings)
            helpers["events"].setNPCs(settings)
            helpers["events"].setDelays("zone", 5)
        
        end
        
        local midaction = helpers["actions"].getMidaction()
        local clocks    = helpers["events"].getClocks()
        local delays    = helpers["events"].getDelays()
        local zone      = helpers["events"].getZone()
        local npc       = helpers["events"].getNPCs()
        
        -- Handle cutscenes, and update the display.
        helpers["events"].updateDisplay()
        helpers["events"].handleCutscene()
        
        if os.clock()-clocks.ping > delays.spam + delays.zone and player.status ~= 4 and not midaction then
            local status = helpers["events"].getStatus()
            local locked = helpers["actions"].getLocked()
            
            -- Make sure that all Items needed for quest are in your Inventory.
            if not helpers["events"].checkItems(settings.items) then
                local required = string.format("Items required are: %s.", table.concat(settings.items, " "))
                    
                helpers['popchat']:pop(required:upper(), system["Popchat Window"])
                helpers["events"].setDelays("zone", 15)
                helpers["events"].setClocks("ping", os.clock())
                return
            
            end
            
            -- Reset the zone delay.
            helpers["events"].setDelays("zone", 0)
            
            if zone.name == "Southern San d'Oria" then
                
                if status == 0 then
                    helpers["events"].setInjecting(true)
                    helpers["events"].interact(npc[zone.name]["Balasiel"], 2, 1)
                    helpers["events"].setDelays("zone", 5)
                    
                elseif status == 1 then
                    
                    if bpcore:findItemByName("Revival Root") then
                        helpers["events"].trade(npc[zone.name]["Balasiel"], 2, {bpcore:findItemByName("Revival Root"), 1})
                    end
                
                elseif status == 2 then
                    helpers["events"].setInjecting(true)
                    helpers["events"].interact(npc[zone.name]["Balasiel"], 2, 3)
                    helpers["events"].setDelays("zone", 5)
                
                elseif status == 3 then
                    windower.send_command("bp mw hp Bastok Mines 1")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif status == 5 then
                    helpers["events"].setInjecting(true)
                    helpers["events"].interact(npc[zone.name]["Balasiel"], 2, 6)
                    helpers["events"].setDelays("zone", 2)
                    
                elseif status == 6 then
                    helpers["events"].setInjecting(true)
                    helpers["events"].interact(npc[zone.name]["Balasiel"], 2, 7)
                    helpers["events"].setDelays("zone", 2)
                    
                elseif status == 7 then
                    helpers["events"].interact(npc[zone.name]["Cahaurme"], 1, 8)
                    helpers["events"].setDelays("zone", 2)
                        
                elseif status == 8 then
                    helpers["events"].interact(npc[zone.name]["Baunise"], 1, 9)
                    helpers["events"].setDelays("zone", 2)
                
                elseif status == 9 then
                    windower.send_command("bp mw hp Bastok Mines 1")
                    helpers["events"].setDelays("zone", 10)
                
                elseif status == 10 then
                    helpers["events"].setInjecting(true)
                    helpers["events"].interact(npc[zone.name]["Balasiel"], 2, 11)
                    helpers["events"].setDelays("zone", 5)
                
                elseif status == 11 then
                    helpers["events"].finishEvent("Jobs")
                    
                end
            
            elseif zone.name == "Bastok Mines" then
                
                if status == 3 then
                    windower.send_command("bp mw sg Ordelle's Caves")
                    helpers["events"].setDelays("zone", 10)
                
                elseif status == 5 then
                    windower.send_command("bp mw hp Southern San d'Oria 3")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif status == 9 then
                    windower.send_command("bp mw sg Davoi")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif status == 10 then
                    windower.send_command("bp mw hp Southern San d'Oria 3")
                    helpers["events"].setDelays("zone", 10)
                    
                end
                
            elseif zone.name == "Ordelle's Caves" then
                
                if status == 3 then
                    helpers["events"].interact(npc[zone.name]["???_1"], 1, 4)
                    helpers["events"].setDelays("zone", 3)
                    
                elseif status == 4 then
                    helpers["events"].interact(npc[zone.name]["???_2"], 1, 5)
                    helpers["events"].setDelays("zone", 3)
                
                elseif status == 5 then
                    windower.send_command("bp mw sg Bastok Mines")
                    helpers["events"].setDelays("zone", 10)
                    
                end
            
            elseif zone.name == "Davoi" then
                
                if status == 9 then
                    helpers["events"].interact(npc[zone.name]["Disused Well"], 1, 10)
                
                elseif status == 10 then
                    windower.send_command("bp mw sg Bastok Mines")
                    helpers["events"].setDelays("zone", 10)
                
                end
            
            elseif system["BP Allowed"][zone.id] then
                windower.send_command("bp mw hp Southern San d'Oria 3")
                helpers["events"].setDelays("zone", 10)
                
            else
                helpers["actions"].tryWarping()
                helpers["events"].setDelays("zone", 30)
                
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

pld["menu handler"] = function(id,original,modified,injected,blocked)
    local injecting = helpers["events"].getInjecting()
    local status    = helpers["events"].getStatus()

    if (id == 0x032 or id == 0x034) and injecting == true then
        
        local p          = packets.parse('incoming', original)
        local me         = windower.ffxi.get_mob_by_target('me')
        local midaction  = helpers["actions"].getMidaction()
        local clocks     = helpers["events"].getClocks()
        local delays     = helpers["events"].getDelays()
        local zone       = helpers["events"].getZone()
        local npc        = helpers["events"].getNPCs()
        local valid
        
        -- Reset Injection.
        helpers["events"].setInjecting(false)
        
        for i,v in pairs(npc[zone.name]) do
            
            if type(v) == "table" and v.id == p["NPC"] then
                valid = true
            end
        
        end
        
        if me and valid then
            
            if status == 0 and zone.name == "Southern San d'Oria" and p["NPC"] == npc[zone.name]["Balasiel"].id then
                helpers["events"].simpleMenu(npc[zone.name]["Balasiel"], p)
                
            elseif status == 2 and zone.name == "Southern San d'Oria" and p["NPC"] == npc[zone.name]["Balasiel"].id then
                helpers["events"].simpleMenu(npc[zone.name]["Balasiel"], p)
                
            elseif status == 5 and zone.name == "Southern San d'Oria" and p["NPC"] == npc[zone.name]["Balasiel"].id then
                helpers["events"].simpleMenu(npc[zone.name]["Balasiel"], p)
                
            elseif status == 6 and zone.name == "Southern San d'Oria" and p["NPC"] == npc[zone.name]["Balasiel"].id then
                helpers["events"].simpleMenu(npc[zone.name]["Balasiel"], p)
                
            elseif status == 10 and zone.name == "Southern San d'Oria" and p["NPC"] == npc[zone.name]["Balasiel"].id then
                helpers["events"].simpleMenu(npc[zone.name]["Balasiel"], p)
                
            else
                helpers["events"].exitMenu(npc[zone.name]["Balasiel"], p)
            
            end
            helpers["events"].setClocks("ping", os.clock())
            return true
            
        end
        helpers["events"].setClocks("ping", os.clock())
        
    end
    
end

pld["registry"] = {
    
    ["zone change"]  = "zone change",
    ["prerender"]    = "prerender",
    ["menu handler"] = "incoming chunk",
    
}
return pld