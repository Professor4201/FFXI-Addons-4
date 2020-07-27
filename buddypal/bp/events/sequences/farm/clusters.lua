-- Event Variables.
local settings, window
local detection  = false
local target     = false
local elementals = {}
local elements   = {"Fire","Water","Thunder","Earth","Wind","Ice","Light","Dark"}
local element    = ""
local scan       = 1
local attempts   = {last=os.clock(), count=0}
local timers     = {scan=os.clock()}

-- Launch Events
local clusters = {}
clusters["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    helpers["events"].setStatus(0)        
    
end

clusters["prerender"] = function()
    local player = windower.ffxi.get_mob_by_target("me") or false
    
    if player then
        
        if helpers["events"].getReset() then
            settings    = dofile(windower.addon_path.."bp/events/sequences/farm/settings/clusters_settings.lua")
            window      = helpers["events"].getWindow()
                          helpers["events"].setReset(false)
            
            -- Set Private Tables.
            helpers["events"].setEvents(settings)
            
            -- Build Elementals List.
            for i,v in pairs(npcs) do
                
                if type(v) == "table" and (v.name):match("Elemental") then
                    table.insert(elementals, v)
                end
                
            end
            
        end
        
        -- Get Event Variables.
        local midaction = helpers["actions"].getMidaction()
        local clocks    = helpers["events"].getClocks()
        local delays    = helpers["events"].getDelays()
        local zone      = helpers["events"].getZone()
        local npc       = helpers["events"].getNPCs()
        local max       = #elementals
        
        if os.clock()-clocks.ping > delays.spam + delays.zone and player.status ~= 4 and not midaction then
            local status = helpers["events"].getStatus()
            
            -- Reset the zone delay, and update the event display.
            helpers["events"].setDelays("zone", 0)
            helpers["events"].updateDisplay()
            
            if zone.name == "Ru'Aun Gardens" and not detection then
                
                -- Check Inventory space.
                if bpcore:getSpace() < 2 then
                    helpers["events"].setStatus(4)
                end
                
                -- Make sure you have not index passed maximum number of mobs.
                if scan > max then
                    scan = 1
                end
                    
                if status == 0 and player.status == 0 and not target then
                    packets.inject(packets.new("outgoing", 0x016, {["Target Index"]=elementals[scan].index}))
                    
                    if attempts.count <= 10 then
                        attempts.count = (attempts.count + 1)
                        
                    else
                        attempts.count = 0
                        
                        if scan <= max then
                            scan = (scan + 1)                            
                        end
                    
                    end
                
                elseif status == 1 and player.status == 0 and target and type(target) == "table" then
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
                                helpers["events"].setStatus(0)                                
                            end
                        
                        end
                        
                    end
                
                elseif status == 1 and player.status == 1 then
                
                elseif status == 4 then
                
                    -- Check Inventory space.
                    if bpcore:getSpace() > 1 then
                        helpers["events"].setStatus(0)
                    end
                
                end
                
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

clusters["npc tracker"] = function(id,original,modified,injected,blocked)
    local player = windower.ffxi.get_player()
    
    if id == 0x00e then
        local p      = packets.parse("incoming", original)
        local npc    = p["NPC"]
        local name   = p["Name"]
        local index  = p["Index"]
        local status = p["Status"]
        
        if p and npc and p["Status"] == 0 and player.status == 0 and not target and not detection then
            
            if (name):match("Fire") or (name):match("Water") or (name):match("Thunder") or (name):match("Earth") or (name):match("Air") or (name):match("Ice") or (name):match("Light") or (name):match("Dark") then
                local zone    = helpers["events"].getZone()
                local info    = helpers["npcupdater"]:build(original)
                local spawned = info.mbits:sub(6,6)
                local coords  = {x=p["X"], y=p["Y"], z=p["Z"]}
                
                if info.mbits == "11110000" then
                            
                    if coords.x and coords.y and coords.z then
                        helpers["events"].setStatus(1)
                        
                        for _,v in ipairs(elements) do
                        
                            if (name):match(v) then
                                element = (name):match(v)
                            end
                            
                        end
                        
                        target = {id=npc, index=index, status=status, element=element, x=coords.x, y=coords.y, z=coords.z}
                        helpers["actions"].reposition(coords.x-0.3, coords.y-0.3, coords.z)
                    
                    end
                
                end
                
            end
            
        end
    
    end
    
end

clusters["auto detection"] = function(id,original,modified,injected,blocked)
    
    if id == 0x00d then
       local despawn = {original:unpack("q8", 0x0a+1)}
       
       if despawn[2] == true and despawn[6] == true then
           detection = false
           helpers["events"].setStatus(0)
           attempts.count = 0
           
        else
            detection = true
            helpers["events"].setStatus(3)
            
        end
        
    end
    
end

clusters["message parsing"] = function(original, modified, o_mode, m_mode, blocked)
    local message = (original):strip_format() or ""

    if message ~= "" and o_mode == 36 and target then
        local mob      = windower.ffxi.get_mob_by_id(target.id)
        local filtered = helpers["filter"].filter(message, o_mode)
        
        if mob then
            local match = (filtered):match(mob.name)
            
            if match ~= "" then
                local max = #elementals
                
                -- Reset the target.
                target = false
                attempts.count = 0
                helpers["events"].setStatus(0)
                
                if scan <= max then
                    scan = (scan + 1)                    
                end
                
            end
            
        end
        
    end
    
end

clusters['registry'] = {
    
    ["zone change"]     = "zone change",
    ["prerender"]       = "prerender",
    ["npc tracker"]     = "incoming chunk",
    ["auto detection"]  = "incoming chunk",
    ["message parsing"] = "incoming text",
    
}

return clusters