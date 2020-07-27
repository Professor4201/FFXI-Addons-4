-- Global Event Variables.
local settings
local window
local attempts = 0
local stop = false
local chamber = {r = 031, x = -129.6670074, y =  289.6010132,   z = -7.354000568, en = 'Brunhilde\'s Chamber' }

-- Launch Events
local brunhilde = {}
brunhilde["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

brunhilde["prerender"] = function()
    local player   = windower.ffxi.get_mob_by_target("me") or false
    local kilusha  = windower.ffxi.get_mob_by_id(16994397) or false
    local chest    = windower.ffxi.get_mob_by_id(17097281) or false
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
                
            elseif zone.name == "Qufim Island" then
                
            elseif zone.name == "Escha - Zi'Tah" then
                
            else
                helpers["actions"].tryWarping()
                helpers["events"].setDelays("zone", 30)
            
            end
            helpers["events"].setClocks("ping", os.clock())
            helpers["events"].updateDisplay()
            
        end
        
    end
    
end

brunhilde["Menu Handler"] = function(id,original,modified,injected,blocked)
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

brunhilde["Reservation Response"] = function(id,original,modified,injected,blocked)
    
    if id == 0x0bf then
        local entry = windower.ffxi.get_mob_by_index(original:unpack("H", 0x0C+1)) or false
        
        if entry then
            
        end
        
    end
    
end

brunhilde["Points Earned"] = function(original, modified, o_mode, m_mode, blocked)
    local message = (original):strip_format() or ""
    
    
    if message ~= "" and o_mode == 148 then
        local filtered = helpers["filter"].filter(message, o_mode)
        
        -- Obtained Lamp.
        if filtered:match("Obtained: Smouldering Lamp.") then
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

brunhilde["registry"] = {
    ["zone change"]     = "zone change",
    ["prerender"]       = "prerender",
    ["Menu Handler"]    = "incoming chunk",
    ["Dragon Killed"]   = "incoming chunk",
    ["Points Earned"]   = "incoming text",
}

return brunhilde