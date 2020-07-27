-- Global Event Variables.
local settings
local window
local mobs     = {}
local target   = false
local scan     = 1
local attempts = {last=os.clock(), count=0}
local timers   = {scan=os.clock()}

-- Launch Events
local aquans = {}
aquans["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

aquans["prerender"] = function()
    local player = windower.ffxi.get_mob_by_target("me") or false
    local gorpa  = windower.ffxi.get_mob_by_id(17797273) or false
    local tome   = windower.ffxi.get_mob_by_id(17797270) or false
    
    if player then
        
        if helpers["events"].getReset() then
            settings = dofile(windower.addon_path.."bp/events/sequences/ambuscade/settings/aquans_settings.lua")
            window = helpers["events"].getWindow()
            
            -- Set Private Tables.
            helpers["events"].setEvents(settings)
            helpers["events"].setItems(settings)
            helpers["events"].setNPCs(settings)
            helpers["events"].setReset(false)
            
        end
        
        local midaction = helpers["actions"].getMidaction()
        local clocks    = helpers["events"].getClocks()
        local delays    = helpers["events"].getDelays()
        local zone      = {id=windower.ffxi.get_info().zone, name=res.zones[windower.ffxi.get_info().zone].en}
        
        -- Handle Cutscene Status.
        helpers["events"].handleCutscene()
        
        if os.clock()-clocks.ping > delays.spam + delays.zone and player.status ~= 4 and not midaction then
            local status = helpers["events"].getStatus()
            
            -- Reset the zone delay, and update the event display.
            helpers["events"].setDelays("zone", 0)
            
            -- Update the mobs table when entering the proper zone.
            if zone.name == "Morimar Basalt Fields" and #mobs == 0 then
                
                for i,v in pairs(npcs) do
                    
                    if type(v) == "table" and (v.name):match("Jagil") then
                        table.insert(mobs, v)
                    end
                    
                end
                
            end
            
            if ((zone.name):match("Bastok") or (zone.name):match("San d'Oria") or (zone.name):match("Windurst") or (zone.name):match("Norg") or (zone.name):match("Selbina") or (zone.name):match("Adoulin")) then
                
                if status == 0 then
                    windower.send_command("bp mw hp Morimar Basalt Fields")
                    helpers["events"].setDelays("zone", 10)
                
                end
            
            elseif zone.name == "Mhaura" then
                
                if status == 0 then
                    windower.send_command("bp mw hp Morimar Basalt Fields")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif status == 1 then
                    
                    if tome and (tome.distance):sqrt() > 10 then
                        helpers["actions"].jumpBehind(tome)
                        helpers["events"].setDelays("zone", 2)
                        
                    elseif tome and (tome.distance):sqrt() < 6 then
                        helpers["events"].setInjecting(true)
                        helpers["events"].setDelays("zone", 5)
                        helpers["actions"].doAction(tome, 0, "interact")
                        
                    end
                
                end
                
            elseif zone.name == "Morimar Basalt Fields" then
                local max = #mobs
                    
                -- Make sure you have not index passed maximum number of mobs.
                if scan > max then
                    scan = 1
                end
                
                if status == 0 and player.status == 0 and not target then
                    helpers["actions"].pingMob(mobs[scan].index)
                    
                    if attempts.count <= 10 then
                        attempts.count = (attempts.count + 1)
                        
                    else
                        attempts.count = 0
                        
                        if scan <= max then
                            scan = (scan + 1)                            
                        end
                    
                    end
                
                elseif status == 0 and player.status == 0 and target and type(target) == "table" then
                    local mob = windower.ffxi.get_mob_by_id(target.id) or false
                    
                    if mob and (mob.distance):sqrt() < 15 then
                        helpers["actions"].doAction(mob, 0, "engage")
                        
                    else

                        if attempts.count <= 10 then
                            attempts.count = (attempts.count + 1)
                            
                        else
                            attempts.count = 0
                            
                            if scan <= max then
                                scan = (scan + 1)
                            end
                        
                        end
                        
                    end
                
                elseif status == 1 then
                    windower.send_command("bp mw hp Mhaura")
                    helpers["events"].setDelays("zone", 10)
                    
                end
                
            elseif (zone.name):match("Maquette Abdhaljs-Legion") then
                
                if status == 3 then
                    
                    windower.send_command("bp > P ambuscade")
                    helpers["events"].setDelays("zone", 60)
                    helpers["events"].setStatus(4)
                    
                elseif status == 4 then
                    local nm = windower.ffxi.get_mob_by_id(17952874) or false
                    
                    if nm and (nm.distance):sqrt() > 20 then
                        helpers["actions"].jumpTo(nm)
                        helpers["events"].setDelays("zone", 2)
                        
                    elseif nm and (nm.distance):sqrt() < 15 then
                        helpers["actions"].doAction(mob, 0, "engage")
                        
                    end
                    
                end                    
            
            end
            helpers["events"].setClocks("ping", os.clock())
            helpers["events"].updateDisplay()
            
        end
        
    end
    
end

aquans["menu handler"] = function(id,original,modified,injected,blocked)
    local injecting  = helpers["events"].getInjecting()
    
    -- Incoming Action Event.
    if (id == 0x032 or id == 0x034) and injecting then
        local zone      = {id=windower.ffxi.get_info().zone, name=res.zones[windower.ffxi.get_info().zone].en}
        local p         = packets.parse('incoming', original)
        local player    = windower.ffxi.get_mob_by_target("me") or false
        local tome      = windower.ffxi.get_mob_by_id(17797270) or false
        local midaction = helpers["actions"].getMidaction()
        local valid
        
        -- Determine if our NPC is a valid NPC in our tables.
        if tome and tome.id == p["NPC"] then
            valid = true        
        end
        
        -- Now handle the menu if its a valid NPC.
        if player and valid and not midaction then
                
            if zone.name == "Mhaura" and p["NPC"] == tome.id then
                local status = helpers["events"].getStatus()
                
                if status == 1 then
                    helpers["actions"].reserveAmbuscade(p, tome, 6)
                    helpers["events"].setDelays("zone", 10)
                    helpers["events"].setStatus(2)
                
                elseif status == 2 then
                    helpers["actions"].enterAmbuscade(p, tome)
                    helpers["events"].setDelays("zone", 10)
                    helpers["events"].setStatus(3)
                    
                else
                    helpers["actions"].doExitMenu(p, tome)
                    
                end
                
            end
            helpers["events"].setInjecting(false)
            helpers["events"].setClocks("ping", os.clock())
            return true
            
        end
        
    end
    
end

aquans["mob tracker"] = function(id,original,modified,injected,blocked)
    local player = windower.ffxi.get_player()
    
    if id == 0x00e then
        local p      = packets.parse("incoming", original)
        local npc    = p["NPC"]
        local name   = p["Name"]
        local index  = p["Index"]
        local status = p["Status"]
        
        if p and npc and p["Status"] == 0 and player.status == 0 and not target then
            
            if (name):match("Jagil") then
                local zone    = {id=windower.ffxi.get_info().zone, name=res.zones[windower.ffxi.get_info().zone].en}
                local info    = helpers["npcupdater"]:build(original)
                local spawned = info.mbits:sub(6,6)
                local coords  = {x=p["X"], y=p["Y"], z=p["Z"]}
                
                if info.mbits == "11110000" then
                            
                    if coords.x and coords.y and coords.z then
                        target = {id=npc, index=index, status=status, x=coords.x, y=coords.y, z=coords.z}
                        helpers["actions"].reposition(target.x-0.3, target.y-0.3, target.z)
                    
                    end
                
                end
                
            end
            
        end
    
    end
    
end

aquans["incoming text"] = function(original, modified, o_mode, m_mode, blocked)
    local message = (original):strip_format() or ""    
    
    if message ~= "" and o_mode == 127 then
        local filtered = helpers["filter"].filter(message, o_mode)
        
        -- Primer Volume Two.
        if filtered:match("Ambuscade Primer Volume Two") then
            helpers["events"].setDelays("zone", 2)
            helpers["events"].setStatus(1)
        end
    
    elseif message ~= "" and o_mode == 121 then
        local filtered = helpers["filter"].filter(message, o_mode)
        local tome     = windower.ffxi.get_mob_by_id(17797270) or false
        
        -- Reservation is ready.
        if filtered:match("The battle commences!") then
            helpers["events"].setDelays("zone", 10)
            
            if tome and (tome.distance):sqrt() < 6 then
                helpers["events"].setInjecting(true)
                helpers["actions"].doAction(tome, 0, "engage")
            end
            
        end
    
    -- NM defeated.
    elseif message ~= "" and (o_mode == 36 or o_mode == 37 or o_mode == 44) then
        local filtered = helpers["filter"].filter(message, o_mode) or ""
        local mob      = windower.ffxi.get_mob_by_id(target.id) or false
        local nm       = windower.ffxi.get_mob_by_id(17952874) or false
        
        if nm and filtered ~= "" and filtered:match(string.format("defeats %s.", nm.name)) then
            helpers["events"].setDelays("zone", 2)
            helpers["events"].setStatus(3)
            
        elseif mob and filtered ~= "" and filtered:match(string.format("defeats %s.", mob.name)) then
            local max = #mobs
                
            -- Reset the target.
            target = false
            attempts.count = 0
            
            if scan <= max then
                scan = (scan + 1)                    
            end
        
        end
    
    end
    
end

aquans["registry"] = {
    
    ["zone change"]   = "zone change",
    ["prerender"]     = "prerender",
    ["menu handler"]  = "incoming chunk",
    ["mob tracker"]   = "incoming chunk",
    ["incoming text"] = "incoming text",
    
}

return aquans