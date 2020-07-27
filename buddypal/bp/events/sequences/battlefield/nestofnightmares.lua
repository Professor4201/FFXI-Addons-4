-- Global Event Variables.
local settings
local window

-- Launch Events
local nestofnightmares = {}
nestofnightmares["zone change"] = function(new, old)
    local status = helpers["events"].getStatus()
    
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

nestofnightmares["prerender"] = function()
    local player = windower.ffxi.get_mob_by_target("me") or false
    
    if player then
        
        if helpers["events"].getReset() then
            settings    = dofile(windower.addon_path.."bp/events/sequences/leujaoam/settings/nestofnightmares_settings.lua")
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
            local town   = system["BP Allowed"][windower.ffxi.get_info().zone]
            
            -- Reset the zone delay, and update the event display.
            helpers["events"].setDelays("zone", 0)
            helpers["events"].updateDisplay()
            
            if not town then
                
                
                
            else
                
            end
            
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
                
            end
            
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

nestofnightmares["handle menus"] = function(id,original,modified,injected,blocked)
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

nestofnightmares["registry"] = {
    ["zone change"]     = "zone change",
    ["prerender"]       = "prerender",
    ["handle menus"]    = "incoming chunk",
    ["spawn"]           = "incoming chunk",
    ["item obtained"]   = "incoming chunk",
}

return nestofnightmares