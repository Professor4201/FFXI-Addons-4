-- Global Event Variables.
local settings
local window
local rank     = "FL"
local reserved = {flag=false, target=nil, data=""}

-- Launch Events
local fl = {}
fl["zone change"] = function(new, old)
    local status = helpers["events"].getStatus()
    
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
    if old == 79 and status == 2 then
        helpers["events"].setStatus(3)
        
    elseif old == 79 and status == 3 then
        helpers["events"].setStatus(4)
        
    elseif old == 69 and status == 6 then
        helpers["events"].setStatus(9)
        
    end
    
end

fl["prerender"] = function()
    local player = windower.ffxi.get_mob_by_target("me") or false
    
    if player then
        
        if helpers["events"].getReset() then
            settings    = dofile(windower.addon_path.."bp/events/sequences/leujaoam/settings/fl_settings.lua")
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
            
            if zone.name == "Aht Urhgan Whitegate" then
                
                if status == 0 then
                    local target = npc[zone.name]["Rytaal"]
                    
                    if target then
                        helpers["events"].setInjecting(true)
                        helpers["events"].interact(target, 1, false)
                        helpers["events"].setDelays("zone", 1)
                    end
                    
                elseif status == 1 then
                    local target = npc[zone.name]["Yahsra"]
                    
                    if target then
                        helpers["events"].setInjecting(true)
                        helpers["events"].interact(target, 1, false)
                        helpers["events"].setDelays("zone", 1)
                    end
                
                elseif status == 2 then
                    local target = npc[zone.name]["Runic Portal"]
                    
                    if target then
                        helpers["events"].setInjecting(true)
                        helpers["events"].interact(target, 1, false)
                        helpers["events"].setDelays("zone", 1)
                    end
                
                end
                
            elseif zone.name == "Caedarva Mire" then
                
                if status == 2 then
                    local target = npc[zone.name]["Nareema"]
                    
                    if target then
                        helpers["events"].setInjecting(true)
                        helpers["events"].interact(target, 1, false)
                        helpers["events"].setDelays("zone", 1)
                    end
                
                elseif status == 3 then
                    local target = npc[zone.name]["Runic Seal"]
                    
                    if target then
                        helpers["events"].setInjecting(true)
                        helpers["events"].interact(target, 1, false)
                        helpers["events"].setDelays("zone", 1)
                    end
                    
                end
                
            elseif zone.name == "Leujaoam Sanctum" then
                
                if status == 4 then
                    local target
                    
                    for _,v in pairs(npcs) do
            
                        if type(v) == "table" and (v.name):match("Count Dracula") then
                            local null = (v.x+v.y+v.z)
                            
                            if null ~= 0 then
                                target = v
                                break
                            end
                            
                        end
                    
                    end
                    
                    if target and type(target) == "table" then
                        helpers["actions"].reposition(target.x-2.5, target.y-2.5, target.z)
                        helpers["events"].setDelays("zone", 2)
                        helpers["events"].setStatus(5)
                        
                    end
                    
                elseif status == 6 then
                    local release
                    
                    for _,v in pairs(npcs) do
            
                        if type(v) == "table" and v.id == 17060015 then
                            local null = (v.x+v.y+v.z)
                            
                            if null ~= 0 then
                                release = v
                                break
                            end
                            
                        end
                    
                    end
                    
                    if release and type(release) == "table" then
                        helpers["events"].setInjecting(true)
                        helpers["events"].interact(release, 1, false)
                        helpers["events"].setDelays("zone", 15)
                        
                    end
                    
                end
                
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

fl["count attack"] = function(id,original,modified,injected,blocked)
    
    if id == 0x028 then
        local p        = packets.parse("incoming", original)
        local actor    = windower.ffxi.get_mob_by_id(p["Actor"])
        local target   = windower.ffxi.get_mob_by_id(p["Target 1 ID"])
        local category = p["Category"]
        local param    = p["Param"]
        
        if category == 1 and actor and target and actor.name == "Count Dracula" and target.name == windower.ffxi.get_mob_by_target("me").name then
            
            if actor.distance:sqrt() < 6 and target.status == 0 then
                helpers["actions"].doAction(actor, 0, "engage")
                helpers["events"].setDelays("zone", 15)
                
            end
            
        end
        
    end
    
end

fl["kill counter"] = function(id,original,modified,injected,blocked)
    
    if id == 0x029 then
        local player, target, message = original:unpack("I", 0x04+1) or false, original:unpack("I", 0x08+1) or false, original:unpack("H", 0x18+1) or false

        if player and target and message and player == windower.ffxi.get_mob_by_target("me").id and windower.ffxi.get_mob_by_id(target).name == "Count Dracula" and message == 6 then
            helpers["events"].setStatus(6)
        end
        
    end
    
end

fl["handle menus"] = function(id,original,modified,injected,blocked)
    local injecting  = helpers["events"].getInjecting()
    
    if (id == 0x032 or id == 0x034) and injecting then
        local p         = packets.parse('incoming', original)
        local me        = windower.ffxi.get_mob_by_target("me")
        local midaction = helpers["actions"].getMidaction()
        local clocks    = helpers["events"].getClocks()
        local delays    = helpers["events"].getDelays()
        local zone      = helpers["events"].getZone()
        local npc       = helpers["events"].getNPCs()
        local valid

        --Set current number of tags available.
        helpers["assaults"].setTags(original)
        
        -- Determine if our NPC is a valid NPC in our tables.
        for i,v in pairs(npc[zone.name]) do
            
            if type(v) == "table" and v.id == p["NPC"] then
                valid = true
            end
        
        end
        
        if me and valid then
            local target = windower.ffxi.get_mob_by_id(p["NPC"]) or false
            local status = helpers["events"].getStatus()
            
            if status == 0 and target and target.id == npc[zone.name]["Rytaal"].id then
                
                if helpers["assaults"].getTags() > 0 then
                    helpers["actions"].getTags(p, target)
                    helpers["events"].setStatus(1)
                    
                else
                    helpers["actions"].doExitMenu(p, target)
                    helpers["events"].setDelays("zone", 60)
                    
                end
            
            elseif status == 1 and target and target.id == npc[zone.name]["Yahsra"].id then
                helpers["actions"].getOrders(p, target, rank)
                helpers["events"].setStatus(2)
                
            elseif status == 2 and target and target.id == npc[zone.name]["Runic Portal"].id then
                helpers["actions"].enterRunic(p, target, 1)
                
            elseif status == 2 and target and target.id == npc[zone.name]["Nareema"].id then
                helpers["actions"].getArmband(p, target)
                helpers["events"].setStatus(3)
                
            elseif status == 3 and target and target.id == npc[zone.name]["Runic Seal"].id then
                reserved = {flag=true, target=target, data=p}
                helpers["actions"].reserveAssault(p, target, 0, 4)
            
            elseif status == 6 and target and target.id == npc[zone.name]["Rune of Release"].id then
                local release
                    
                for _,v in pairs(npcs) do
                
                    if type(v) == "table" and v.id == 17060015 then
                        local null = (v.x+v.y+v.z)
                        
                        if null ~= 0 then
                            release = v
                            break
                        end
                        
                    end
                
                end
                
                if release then
                    helpers["actions"].assaultRelease(p, release)
                else
                    helpers["actions"].doExitMenu(p, release)
                end
            
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

fl["reservation"] = function(id,original,modified,injected,blocked)
    
    if id == 0x0bf then
        local enter = original:unpack("C", 0x06+1) or false
        local index = original:unpack("H", 0x0C+1) or false
        
        if reserved.flag and reserved.target ~= nil and reserved.data ~= "" then
            helpers["actions"].enterAssault(reserved.data, reserved.target, 4, 0)
            reserved = {flag=false, target=nil, data=""}
            
        end
        
    end
    
end

fl["registry"] = {
    ["zone change"]     = "zone change",
    ["prerender"]       = "prerender",
    ["count attack"]    = "incoming chunk",
    ["kill counter"]    = "incoming chunk",
    ["handle menus"]    = "incoming chunk",
    ["reservation"]     = "incoming chunk",
}

return fl