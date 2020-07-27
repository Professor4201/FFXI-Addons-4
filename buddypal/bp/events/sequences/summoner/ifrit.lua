-- Global Event Variables.
local settings
local window

-- Event List.
local events = {
        
    [0]  = "Start the quest: 'Trial By Fire.'",
    [1]  = "Travel to 'Cloister of Flames.'",
    [2]  = "Initializing character settings...",
    [3]  = "Defeat Ifrit Prime.",
    [4]  = "Complete the quest, and select Ifrit as your reward.",
    
}


-- Launch Events
local ifrit = {}
ifrit["zone change"] = function(new, old)
    local status = helpers["events"].getStatus()
    
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

ifrit["prerender"] = function()
    local player = windower.ffxi.get_mob_by_target("me") or false
    
    if player then
        
        if helpers["events"].getReset() then
            window = helpers["events"].getWindow()
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
            local town   = system["BP Allowed"][windower.ffxi.get_info().zone]
            
            -- Reset the zone delay.
            helpers["events"].setDelays("zone", 0)
            
            if not town then
                
                if zone.name == "Ifrit's Cauldron" then
                    
                    if status == 1 then
                        helpers["actions"].zone(879768954)
                        helpers["events"].setDelays("zone", 10)
                        
                    elseif status == 4 then
                        windower.send_command("bp mw hp Kazham")
                        helpers["events"].setDelays("zone", 10)
                        
                    end
                
                elseif zone.name == "Cloister of Flames" then
                
                    if status == 1 then
                        local target = npcs[17625134]
                        
                        if not target or (target and target.distance:sqrt() > 6) then
                            helpers["actions"].move(target.x, target.y)
                            helpers["events"].setDelays("zone", 2)
                    
                        elseif target and target.distance:sqrt() < 6 then
                        
                            if helpers["actions"].getMoving() then
                                helpers["actions"].stopMovement()
                                
                            else
                                helpers["events"].setInjecting(false)
                                helpers["events"].interact(target, 1)
                                
                            end
                            
                        end
                    
                    elseif status == 2 then
                        helpers["events"].setDelays("zone", 60)
                        helpers["events"].setStatus(3)
                        print("Initializing settings...")
                        
                    elseif status == 3 then
                        local target = npcs[17625089]
                        
                        if not target or (target and target.distance:sqrt() > 6) then
                            helpers["actions"].reposition(target.x, target.y, target.z)
                            helpers["events"].setDelays("zone", 2)
                    
                        elseif target and target.distance:sqrt() < 6 then
                        
                            
                            
                        end
                    
                    elseif status == 4 then
                        helpers["actions"].zone(812791162, 165, 2)
                        helpers["events"].setDelays("zone", 10)
                        
                    end
                
                end
                
            else
                
                if zone.name == "Kazham" then
                    
                    if status == 0 then
                        local target = npcs[17801322]
                        
                        if not target or (target and target.distance:sqrt() > 6) then
                            helpers["actions"].reposition(target.x, target.y, target.z)
                            helpers["events"].setDelays("zone", 2)
                    
                        elseif target and target.distance:sqrt() < 6 then
                            helpers["events"].interact(target, 1)
                            
                        end
                        
                    elseif status == 1 then
                        windower.send_command("bp mw hp Ifrit's Cauldron")
                        helpers["events"].setDelays("zone", 10)
                        
                    elseif status == 4 then
                        local target = npcs[17801322]
                        
                        if not target or (target and target.distance:sqrt() > 6) then
                            helpers["actions"].reposition(target.x, target.y, target.z)
                            helpers["events"].setDelays("zone", 2)
                    
                        elseif target and target.distance:sqrt() < 6 then
                            helpers["events"].interact(target, 1)
                            
                        end
                        
                    end
                    
                else
                    
                    if status == 0 then
                        windower.send_command("bp mw hp Kazham")
                        helpers["events"].setDelays("zone", 10)
                    
                    end
                    
                end
                
            end
            helpers["events"].updateDisplay()
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

ifrit["handle menus"] = function(id,original,modified,injected,blocked)
    local injecting  = helpers["events"].getInjecting()
    
    if (id == 0x032 or id == 0x034) and injecting then
        local p         = packets.parse('incoming', original)
        local me        = windower.ffxi.get_mob_by_target("me")
        local midaction = helpers["actions"].getMidaction()
        local clocks    = helpers["events"].getClocks()
        local delays    = helpers["events"].getDelays()
        local zone      = helpers["events"].getZone()
        local npc       = helpers["events"].getNPCs()
        
        if me then
            local target   = windower.ffxi.get_mob_by_id(p["NPC"]) or false
            local status   = helpers["events"].getStatus()
            
            if status == 0 and target and target.id == 17625134 then
                helpers["actions"].injectMenu(17625134, 46, 207, 255, 3200, true, 0, 0)
                helpers["actions"].injectMenu(17625134, 46, 207, 100, 3200, false, 0, 0)
            
            else
                return original
                
            end
            helpers["events"].setInjecting(false)
            helpers["events"].setDelays("zone", 3)
            helpers["events"].setClocks("ping", os.clock())
            return true
            
        else
            return original
            
        end
        
    end
    
end

ifrit["handle items"] = function(id,original,modified,injected,blocked)
    
end

ifrit["handle text"] = function(original,modified,o_mode,m_mode,blocked)
    local message = (original):strip_format() or ""
    local status  = helpers["events"].getStatus()
    local zone    = helpers["events"].getZone()
    
    if message ~= "" then
        local message = helpers["filter"].filter(message, o_mode)
        
        --'Entering the battlefield for "Trial by Fire"!'
        
        if o_mode == 150 then
            
        elseif o_mode == 148 then
            
            if zone.name == "Kazham" then
                
                if status == 0 then
                    
                    if string.find(message, "Obtained key item: Tuning fork of fire.") then
                        helpers["events"].setDelays("zone", 2)
                        helpers["events"].setStatus(1)
                        
                    end
                    
                end
            
            elseif zone.name == "Cloister of Flames" then
                
                if status == 3 then
                    
                    if string.find(message, "Obtained key item: Whisper of flames.") then
                        helpers["events"].setDelays("zone", 2)
                        helpers["events"].setStatus(4)
                        
                    end
                    
                end
            
            end                
            
        end
        
    end
    
end

ifrit["registry"] = {
    ["zone change"]     = "zone change",
    ["prerender"]       = "prerender",
    ["handle menus"]    = "incoming chunk",
    ["spawn"]           = "incoming chunk",
    ["handle items"]    = "incoming chunk",
    ["handle text"]     = "incoming text",
}

return ifrit