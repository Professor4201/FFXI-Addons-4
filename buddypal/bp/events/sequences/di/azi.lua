-- Global Event Variables.
local settings
local window
local attempts = 0
local stop = false

-- Launch Events
local azi = {}
azi["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

azi["prerender"] = function()
    local player   = windower.ffxi.get_mob_by_target("me") or false
    local npc      = windower.ffxi.get_mob_by_id(17957448) or false
    local entrance = windower.ffxi.get_mob_by_id(17293826) or false
    local exit     = windower.ffxi.get_mob_by_id(17957434) or false
    
    if player then
        
        if helpers["events"].getReset() then
            settings = dofile(windower.addon_path.."bp/events/sequences/di/settings/azi_settings.lua")
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
        local zone      = helpers["events"].getZone()
        
        -- Handle Cutscene Status.
        helpers["events"].handleCutscene()
        
        -- Stop character movement if moving.
        if stop and helpers["actions"].getMoving() then
            helpers["actions"].stopMovement()
            stop = false
        end
        
        if os.clock()-clocks.ping > delays.spam + delays.zone and player.status ~= 4 and not midaction then
            local status = helpers["events"].getStatus()
            
            -- Reset the zone delay, and update the event display.
            helpers["events"].setDelays("zone", 0)
            
            if zone.name == "Bastok Markets" then
                
                if status == 0 then
                    system["BP Enabled"]:setTo(false)
                    windower.send_command("bp mw hp Qufim Island")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif status == 4 then
                    helpers["events"].finishEvent("di", "di", "nagaraja")
                
                end
                
            elseif zone.name == "Qufim Island" then
                
                if status == 0 then
                    windower.send_command("bp mw escha *")
                    helpers["events"].setDelays("zone", 10)
                    
                end
                
            elseif zone.name == "Escha - Zi'Tah" then
                
                if status == 0 then
                    
                    if exit and helpers["actions"].rangeCheck(exit.x, exit.y, 7) then
                        helpers["queue"].add(helpers["actions"].getTemplate("Movement"), {name=npc.name, id=npc.id, x=-351.02267456055, y=-170.92454528809, z=0.39209789037704})
                    
                    elseif npc and helpers["actions"].rangeCheck(npc.x, npc.y, 6) and helpers["actions"].getMoving() then
                        helpers["events"].setDelays("zone", 2)
                        helpers["actions"].stopMovement()

                    elseif npc and helpers["actions"].rangeCheck(npc.x, npc.y, 6) and not helpers["actions"].getMoving() then
                        helpers["events"].setInjecting(true)
                        helpers["events"].setDelays("zone", math.random(1,30))
                        helpers["actions"].doAction(npc, 0, "interact")

                    end
                
                elseif status == 1 then                    

                    if helpers["actions"].rangeCheck(-2, 59.5, 7) and not helpers["actions"].getMoving() then
                        helpers["queue"].add(helpers["actions"].getTemplate("Movement"), {name="Azi Dahaka", id=17957397, x=bpcore:randPOS(-15.743389129639, 5), y=40.585868835449, z=0.77015554904938})
                        
                    elseif helpers["actions"].rangeCheck(-15.743389129639, 40.585868835449, 15) and helpers["actions"].getMoving() then
                        helpers["events"].setDelays("zone", 10)
                        helpers["actions"].stopMovement()
                        system["BP Enabled"]:setTo(true)
                        helpers["events"].setStatus(2)
                        
                    end
                    
                
                elseif status == 2 then
                    local boss = windower.ffxi.get_mob_by_id(17957397) or false
                    local adds = bpcore:findMobInProximity("Azi Dahaka's Dragon", 30)
                    
                    if bpcore:buffActive(603) and boss and (boss.status == 0 or boss.status == 1) then
                        
                        if player.status == 0 then
                            helpers["actions"].doAction(boss, 0, "engage")
                            helpers["events"].setDelays("zone", 5)
                            
                        end
                        
                    elseif bpcore:buffActive(603) and adds and (adds.status == 0 or adds.status == 1) then
                    
                        if player.status == 0 then
                            helpers["actions"].doAction(adds, 0, "engage")
                            helpers["events"].setDelays("zone", 5)
                            
                        end
                        
                    end
                    
                elseif status == 3 then
                    
                    if not bpcore:buffActive(603) then
                        helpers["actions"].tryWarping()
                        helpers["events"].setStatus(4)
                        helpers["events"].setDelays("zone", 30)
                    end
                
                end
                
            else
                helpers["actions"].tryWarping()
                helpers["events"].setDelays("zone", 30)
            
            end
            helpers["events"].setClocks("ping", os.clock())
            helpers["events"].updateDisplay()
            
        end
        
    end
    
end

azi["Menu Handler"] = function(id,original,modified,injected,blocked)
    local injecting  = helpers["events"].getInjecting()
    
    -- Incoming Action Event.
    if (id == 0x032 or id == 0x034) and injecting then
        local p         = packets.parse('incoming', original)
        local me        = windower.ffxi.get_mob_by_target("me") or false
        local npc       = windower.ffxi.get_mob_by_id(17957448) or false
        local entrance  = windower.ffxi.get_mob_by_id(17293826) or false
        local exit      = windower.ffxi.get_mob_by_id(17957434) or false
        local boss      = windower.ffxi.get_mob_by_id(17957397) or false
        local midaction = helpers["actions"].getMidaction()
        local clocks    = helpers["events"].getClocks()
        local delays    = helpers["events"].getDelays()
        local zone      = helpers["events"].getZone()
        local valid
        
        -- Determine if our NPC is a valid NPC in our tables.
        if npc and npc.id == p["NPC"] then
            valid = true        
        end
        
        -- Now handle the menu if its a valid NPC.
        if me and valid then
            local status = helpers["events"].getStatus()
                
            -- Get Elvorseal.
            if status == 0 and zone.name == "Escha - Zi'Tah" and p["NPC"] == npc.id and not bpcore:buffActive(603) then
                local elvorseal = original:sub(9,9):unpack("C")
                
                -- Elvorseal is not active.
                if (elvorseal % 8) == 0 then
                    attempts = (attempts + 1)
                    helpers["events"].exitMenu(npc, p)
                    helpers["events"].setDelays("zone", 30)
                    helpers["popchat"]:pop("Elvorseal isn't currently active, checking again in 30 seconds.", system["Popchat Window"])
                    
                    if attempts >= 10 then
                        helpers["actions"].tryWarping()
                        helpers["events"].setDelays("zone", 30)
                        helpers["events"].finishEvent("di", "di", "nagaraja")
                    end
                    
                -- 10 Minutes until adds spawn.
                elseif (elvorseal % 8) == 1 then
                    helpers["events"].setStatus(1)
                    helpers["events"].getElvorseal(npc, -2, 59.5, 0.97395372390747, p)
                    helpers["popchat"]:pop("Azi Dahaka will be spawning in the next 10 minutes.", system["Popchat Window"])
                
                -- Domain Invasion adds have spawned.
                elseif (elvorseal % 8) == 2 then
                    helpers["events"].setStatus(1)
                    helpers["events"].getElvorseal(npc, -2, 59.5, 0.97395372390747, p)
                    helpers["popchat"]:pop("Warping to battle, the fight has already begun!", system["Popchat Window"])
                
                else
                    helpers["events"].exitMenu(npc, p)
                    
                end
                
            end
            helpers["events"].setInjecting(false)
            helpers["events"].setClocks("ping", os.clock())
            return true
            
        end
        
    end
    
end

azi["Dragon Killed"] = function(id,original,modified,injected,blocked)
    
    if id == 0x029 then
        local p = packets.parse('incoming', original)
        local target = windower.ffxi.get_mob_by_target("t") or false
        
        if p["Message"] == 6 and windower.ffxi.get_mob_array()[p["Target Index"]].name == "Azi Dahaka" and target and p["Target"] == target.id then
            helpers["events"].setStatus(3)
            stop = true
            
        elseif p["Message"] == 6 and windower.ffxi.get_mob_array()[p["Target Index"]].name == "Azi Dahaka's Dragon" and target and p["Target"] == target.id then
            stop = true
            
        end
    
    end
    
end

azi["Points Earned"] = function(original, modified, o_mode, m_mode, blocked)
    local message = (original):strip_format() or ""
    
    -- Domain Invasion Points earned.
    if message ~= "" and o_mode == 121 then
        local filtered = helpers["filter"].filter(message, o_mode)
        
        if filtered:match("defeats Azi Dahaka.") then
            helpers["events"].setDelays("zone", 2)
            helpers["events"].setStatus(3)
        end
        
    -- Mob defeated.
    elseif message ~= "" and o_mode == 44 then
        local filtered = helpers["filter"].filter(message, o_mode)
        
        if filtered:match("defeats Azi Dahaka.") then
            helpers["events"].setDelays("zone", 2)
            helpers["events"].setStatus(3)
        end
        
    end
    
end

azi["registry"] = {
    ["zone change"]     = "zone change",
    ["prerender"]       = "prerender",
    ["Menu Handler"]    = "incoming chunk",
    ["Dragon Killed"]   = "incoming chunk",
    ["Points Earned"]   = "incoming text",
}

return azi