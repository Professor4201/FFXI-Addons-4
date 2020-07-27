-- Global Event Variables.
local settings
local window
local mobs = {}
local target = false
local scan = 1
local attempts = {last=os.clock(), count=1, pings=1, pos=1, max=5}
local timers = {scan=os.clock()}
local difficulties = {veasy=10,easy=9,normal=8,difficult=7,vdifficult=6}
windower.send_command("bp > P bp disable")

-- Settings
local ki_zone    = "The Boyahda Tree"
local nm_name    = "Aurantia"
local mob_scan   = "Spider"
local difficulty = difficulties.difficult

-- Launch Events
local vermin = {}
vermin["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

vermin["prerender"] = function()
    local player = windower.ffxi.get_mob_by_target("me") or false
    local gorpa  = windower.ffxi.get_mob_by_id(17797273) or false
    local tome   = windower.ffxi.get_mob_by_id(17797270) or false
    
    -- Update display.
    if not helpers["events"].getReset() then
        helpers["events"].updateDisplay()
    end
    
    if player then
        
        if helpers["events"].getReset() then
            settings = dofile(windower.addon_path.."bp/events/sequences/ambuscade/settings/vermin_settings.lua")
            window   = helpers["events"].getWindow()
            mobs     = {}
            target   = false
            scan     = 1
            attempts = {last=os.clock(), count=1, pings=1, pos=1, max=5}
            timers   = {scan=os.clock()}
            
            -- Set Private Tables.
            helpers["events"].setEvents(settings)
            helpers["events"].setItems(settings)
            helpers["events"].setNPCs(settings)
            helpers["events"].setReset(false)
            windower.send_command("bp > P bp disable")
            
            -- Set the status.
            helpers["events"].setStatus(0)
            
            -- Set Difficulty on re-run.
            difficulty = difficulties.normal
            
        end
        
        local midaction = helpers["actions"].getMidaction()
        local clocks    = helpers["events"].getClocks()
        local delays    = helpers["events"].getDelays()
        local zone      = {id=windower.ffxi.get_info().zone, name=res.zones[windower.ffxi.get_info().zone].en}
        
        if os.clock()-clocks.ping > delays.spam + delays.zone and player.status ~= 4 and not midaction then
            local status = helpers["events"].getStatus()
            --print(string.format("Event Status: %s | Player Status: %s | Member Range: %s |  Leader Check: %s | Scan: %s/%s | Attempts: %s", status, player.status, tostring(bpcore:membersAreInRange()), tostring(bpcore:isLeader()), scan, #mobs, attempts.count))
            
            -- Reset the zone delay, and update the event display.
            helpers["events"].setDelays("zone", 0)
            
            -- Update the mobs table when entering the proper zone.
            if zone.name == ki_zone and #mobs == 0 then
                
                for i,v in pairs(npcs) do
                    
                    if type(v) == "table" and (v.name):match(mob_scan) then
                        table.insert(mobs, v)
                    end
                    
                end
                
            end
            
            if zone.name == "Mhaura" then
                
                -- Check if all players are in the zone.
                if status == 0 and bpcore:membersAreInRange() then
                    
                    if bpcore:isLeader() then
                        helpers["events"].setDelays("zone", 4)
                        helpers["events"].setStatus(1)
                    
                    elseif not bpcore:isLeader() then
                        helpers["events"].setStatus(1)
                        
                    end
                
                elseif status == 0 and not bpcore:membersAreInRange() then
                    
                    if bpcore:isLeader() then
                        windower.send_command(string.format("bp > P- bp mw hp %s", ki_zone))
                        helpers["events"].setDelays("zone", 10)
                    end
                
                elseif status == 1 and bpcore:membersAreInRange() then
                    
                    if bpcore:isLeader() then
                        windower.send_command(string.format("bp > P- bp mw hp %s", ki_zone))
                        helpers["events"].setDelays("zone", 10)
                    end
                
                elseif status == 3 and not bpcore:membersAreInRange() and bpcore:isLeader() then
                    windower.send_command("bp > P- bp mw hp Mhaura")
                    helpers["events"].setDelays("zone", 10)
                
                elseif status == 3 and bpcore:membersAreInRange() and bpcore:isLeader() then
                    
                    if tome and (tome.distance):sqrt() > 15 then
                        helpers["events"].setDelays("zone", 2)
                        helpers["actions"].jumpBehind(tome)
                        
                    elseif tome and (tome.distance):sqrt() < 6 then
                        helpers["events"].setInjecting(true)
                        helpers["events"].setDelays("zone", 1)
                        helpers["actions"].doAction(tome, 0, "interact")
                        
                    end
                
                elseif status == 3 and not bpcore:isLeader() and not bpcore:buffActive(481) and bpcore:findItemByName("Abdhaljs Seal") then
                    helpers["events"].setDelays("zone", 10)
                    helpers["actions"].useItem("Abdhaljs Seal")
                    
                elseif status == 4 and not bpcore:buffActive(481) and bpcore:findItemByName("Abdhaljs Seal") then
                    helpers["events"].setDelays("zone", 10)
                    helpers["actions"].useItem("Abdhaljs Seal")
                
                elseif status == 5 and bpcore:membersAreInRange() and bpcore:isLeader() then

                    if tome and (tome.distance):sqrt() < 6 then
                        helpers["events"].setInjecting(true)
                        helpers["events"].setDelays("zone", 1)
                        helpers["actions"].doAction(tome, 0, "interact")
                    end

                elseif status == 6 and bpcore:membersAreInRange() then
                
                    if bpcore:isLeader() then
                        helpers["events"].setDelays("zone", 4)
                        helpers["events"].setStatus(7)
                    
                    elseif not bpcore:isLeader() then
                        --helpers["events"].finishEvent("ambuscade", "ambuscade", "vermin")
                        helpers["ambuscade"].reset("vermin")
                        
                    end
                        
                elseif status == 7 and bpcore:isLeader() then
                    --helpers["events"].finishEvent("ambuscade", "ambuscade", "vermin")
                    helpers["ambuscade"].reset("vermin")
                
                end
                
            elseif zone.name == ki_zone then
                local max = #mobs
                
                -- Chack target status.
                if target and (target.status == 2 or target.status == 3) then
                    attempts.count, attempts.pings, attempts.pos = 1,1,1
                    scan = (scan+1)
                    target = false
                end
                
                -- Check scan indexing.
                if scan > max then
                    attempts.count, attempts.pings, attempts.pos = 1,1,1
                    scan = 1
                end
                
                -- Correct status if starting events from this zone.
                if status == 0 then
                    helpers["events"].setStatus(1)
                end
                
                if status == 1 and not bpcore:membersAreInRange() then
                    
                    if bpcore:isLeader() then
                        windower.send_command(string.format("bp > P- bp mw hp %s", ki_zone))
                        helpers["events"].setDelays("zone", 10)
                    end
                
                elseif status == 1 and player.status == 0 and not target and bpcore:membersAreInRange() then
                    helpers["actions"].pingMob(mobs[scan].index)
                    helpers["events"].setDelays("zone", 1)

                    if attempts.pings < attempts.max then
                        attempts.pings = (attempts.pings + 1)
                    else
                        attempts.count, attempts.pings, attempts.pos = 1,1,1
                        if scan <= max then
                            scan = (scan + 1) 
                            target = false
                        end
                    
                    end
                
                elseif status == 1 and player.status == 0 and target and type(target) == "table" and bpcore:membersAreInRange() then
                    local mob = windower.ffxi.get_mob_by_id(target.id) or false

                    if mob and bpcore:canEngage(mob) and (mob.distance):sqrt() < 10 then
                        helpers["actions"].doAction(mob, 0, "engage")
                        helpers["events"].setDelays("zone", 1)
                        helpers["actions"].stopMovement()
                        
                        if attempts.count < attempts.max then
                            attempts.count = (attempts.count + 1)
                        else
                            attempts.count, attempts.pings, attempts.pos = 1,1,1
                            if scan <= max then
                                scan = (scan + 1)
                                target = false
                            end
                        end
                        
                    else

                        if attempts.count < attempts.max then
                            attempts.count = (attempts.count + 1)
                        else
                            attempts.count, attempts.pings, attempts.pos = 1,1,1
                            if scan <= max then
                                scan = (scan + 1)
                                target = false
                            end
                        end
                        
                    end
                
                elseif status == 1 and player.status == 1 and target and type(target) == "table" and bpcore:membersAreInRange() then
                    local mob = windower.ffxi.get_mob_by_id(target.id) or false

                    if mob and (mob.distance):sqrt() > 15 then
                        helpers["actions"].stopMovement()
                        helpers["events"].setDelays("zone", 1)
                        helpers["actions"].doAction(mob, 0, "disengage")
                    end
                    
                elseif status == 2 then
                    local homepoint = windower.ffxi.get_mob_by_id(warps["homepoints"][17404415].id) or false
                    
                    if not homepoint or (homepoint and (homepoint.distance):sqrt() > 6 or (homepoint.distance):sqrt() == 0) then
                        helpers["actions"].reposition(warps["homepoints"][17404415].x, warps["homepoints"][17404415].y, warps["homepoints"][17404415].z)
                        helpers["events"].setDelays("zone", 3)
                        helpers["actions"].stopMovement()
                        helpers["actions"].stopMovement()
                        
                    elseif homepoint and (homepoint.distance):sqrt() < 3 then
                        helpers["actions"].stopMovement()
                        
                        if bpcore:isLeader() and bpcore:membersAreInRange(3) then
                            helpers["events"].setDelays("zone", 5)
                            helpers["events"].setStatus(3)
                            
                        elseif bpcore:isLeader() and not bpcore:membersAreInRange(3) then
                            helpers["events"].setDelays("zone", 5)
                        
                        elseif not bpcore:isLeader() then
                            helpers["events"].setStatus(3)
                            
                        end
                        
                    end
                
                elseif status == 3 then
                    local homepoint = windower.ffxi.get_mob_by_id(warps["homepoints"][17404415].id) or false
                    
                    if bpcore:isLeader() and bpcore:membersAreInRange(3) then
                        windower.send_command("bp > P- bp mw hp Mhaura")
                        helpers["events"].setDelays("zone", 10)
                        
                    elseif not homepoint or (homepoint and (homepoint.distance):sqrt() > 6 or (homepoint.distance):sqrt() == 0) then
                        helpers["actions"].reposition(warps["homepoints"][17404415].x, warps["homepoints"][17404415].y, warps["homepoints"][17404415].z)
                        helpers["events"].setDelays("zone", 3)
                        helpers["actions"].stopMovement()
                        helpers["actions"].stopMovement()
                        
                    end
                    
                end
                
            elseif (zone.name):match("Maquette Abdhaljs") then
                
                -- Status correction for non-leader members.
                if status < 5 then
                    helpers["events"].setStatus(5)
                end
                    
                if status == 5 then
                    windower.send_command("bp ambuscade")                    
                    helpers["events"].setDelays("zone", 45)
                    helpers["events"].setStatus(6)
                    
                elseif status == 6  and player.status == 0 then
                    local nm = windower.ffxi.get_mob_by_id(17526891) or windower.ffxi.get_mob_by_id(17952875) or false
                    
                    if nm and (nm.distance):sqrt() > 30 then
                        helpers["actions"].jumpTo(nm)
                        helpers["events"].setDelays("zone", 1)
                        
                    elseif nm and (nm.distance):sqrt() < 15 then
                        helpers["actions"].doAction(nm, 0, "engage")
                        
                    end                    
                    
                end                    
            
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

vermin["menu handler"] = function(id,original,modified,injected,blocked)
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

                if status == 3 then
                    helpers["actions"].reserveAmbuscade(p, tome, difficulty)
                    helpers["events"].setDelays("zone", 2)
                    helpers["events"].setStatus(4)
                
                elseif status == 5 then
                    helpers["actions"].enterAmbuscade(p, tome)
                    helpers["events"].setDelays("zone", 5)
                    
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

vermin["mob tracker"] = function(id,original,modified,injected,blocked)
    local player = windower.ffxi.get_player()
    local status = helpers["events"].getStatus()
    
    if id == 0x00e and status == 1 then
        local p      = packets.parse("incoming", original)
        local npc    = p["NPC"]
        local name   = p["Name"]
        local index  = p["Index"]
        local status = p["Status"]
        local max    = #mobs
        
        -- p["Status"] == 0
        if p and npc and player.status == 0 and not target then
            
            if (name):match(mob_scan) then
                local zone    = {id=windower.ffxi.get_info().zone, name=res.zones[windower.ffxi.get_info().zone].en}
                local info    = helpers["npcupdater"]:build(original)
                local spawned = info.mbits:sub(6,6)
                local coords  = {x=p["X"], y=p["Y"], z=p["Z"]}
                
                if info.mbits == "11110000" then
                            
                    if coords.x and coords.y and coords.z then
                        target = {id=npc, index=index, status=status, x=coords.x, y=coords.y, z=coords.z}
                        helpers["actions"].reposition(target.x-0.3, target.y-0.3, target.z)
                        helpers["events"].setDelays("zone", 2)
                        helpers["actions"].stopMovement()
                    end
                
                end
                
            end
            
        end
    
    end
    
end

vermin["incoming text"] = function(original, modified, o_mode, m_mode, blocked)
    local message = (original):strip_format() or ""    
    local zone    = {id=windower.ffxi.get_info().zone, name=res.zones[windower.ffxi.get_info().zone].en}
    
    if message ~= "" and o_mode == 121 then
        local filtered = helpers["filter"].filter(message, o_mode)
        local tome     = windower.ffxi.get_mob_by_id(17797270) or false
        
        -- Reservation is ready.
        if filtered:match("The battle commences!") then
            
            if tome and (tome.distance):sqrt() < 6 then
                helpers["events"].setDelays("zone", 10)
                helpers["events"].setStatus(5)
            end
        
        -- Primer Volume Two.
        elseif message ~= "" and filtered:match("You have obtained an Ambuscade Primer Volume Two") then
            helpers["events"].setDelays("zone", 5)
            helpers["actions"].stopMovement()
            helpers["events"].setStatus(2)
            target = false
            
        end
        
    end
    
end

vermin["registry"] = {
    
    ["zone change"]   = "zone change",
    ["prerender"]     = "prerender",
    ["menu handler"]  = "incoming chunk",
    ["mob tracker"]   = "incoming chunk",
    ["incoming text"] = "incoming text",
    
}

return vermin