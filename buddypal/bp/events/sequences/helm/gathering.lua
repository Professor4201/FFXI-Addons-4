-- Global Event Variables.
local settings
local window

-- Launch Events
local gethering = {}
gethering["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

gethering["prerender"] = function()
    local player   = windower.ffxi.get_mob_by_target("me") or false
    
    
    if player then
        
        if helpers["events"].getReset() then
            settings    = dofile(windower.addon_path.."bp/events/sequences/craft/settings/gathering_settings.lua")
            window      = helpers["events"].getWindow()
            
            -- Set Private Tables.
            helpers["events"].setEvents(settings)
            helpers["events"].setItems(settings)
            helpers["events"].setNPCs(settings)
            helpers["events"].setReset(false)
            
        end
        
        local gathering, success = helpers["helm"].getFlag("gathering"), helpers["helm"].getFlag("success")
        local midaction = helpers["actions"].getMidaction()
        local clocks    = helpers["events"].getClocks()
        local delays    = helpers["events"].getDelays()
        local zone      = helpers["events"].getZone()
        local npc       = helpers["events"].getNPCs()
        local item      = helpers["helm"].determineTool(helpers["helm"].getMode())
        local nodes     = helpers["helm"].getNodes()
        local max       = (#nodes)
        local r         = helpers["helm"].getRound()
        
        -- Handle Cutscene Status.
        helpers["events"].handleCutscene()
        
        if os.clock()-clocks.ping > delays.spam + delays.zone and player.status ~= 4 and player.status ~= 44 and not midaction then
            local status   = helpers["events"].getStatus()
            local messages = {
                
                ["valid"]    = string.format("Performing Synthesis: Current Skill ---> %s", skill),
                ["selling"]  = string.format("Attempting to make room in player inventory..."),
                ["crystals"] = string.format("Out of crystals, getting more %s's.", crafting.crystal or "(Loading...)"),
                ["clusters"] = string.format("Out of clusters, getting more %s's.", crafting.cluster or "(Loading...)"),
                ["space"]    = string.format("There is currently no inventory space."),
                
            }
            
            -- Reset the zone delay, and update the event display.
            helpers["events"].setDelays("zone", 0)
            helpers["events"].updateDisplay()
            
            if zone.name == "Northern San d'Oria" then
            
            
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

gethering["gather message1"] = function(id,original,modified,injected,blocked)
    
    if id == 0x02a then
        local player   = original:unpack("I", 0x04+1)
        local param1   = original:unpack("I", 0x08+1)
        local param2   = original:unpack("I", 0x0C+1)
        local param3   = original:unpack("I", 0x10+1)
        local param4   = original:unpack("I", 0x14+1)
        local message  = original:unpack("b16", 0x1A+1)
        local messages = {
            
            [39156] = string.format("Obtained a %s", param1),
            [40027] = "You can still gather",
            [40028] = "",
            [40029] = "",
            [40031] = "",
            
        }
        
        print(message)
        
        if param1 == 0 then
            helpers["helm"].setFlag("fatigue", true)
        end
        
    end

end

gethering["gather message2"] = function(id,original,modified,injected,blocked)
    
    if id == 0x036 then
        local actor    = original:unpack("I", 0x04+1)
        local message  = original:unpack("b15", 0x0A+1)
        local messages = {
            
            [6993] = "Node isn't available.",
            [7258] = "You're currently fatigued."
        
        if helpers["helm"].getFlag("gathering") then
            local node  = helpers["helm"].getCurrentNode()
            local round = helpers["helm"].getRound()
            local max   = #helpers["helm"].getNodes()

            if actor == node.id then
                
                -- Gathering point is out of range.
                if message == 6993 then
                    helpers["helm"].setFlag("gathering", false)
                    helpers["helm"].setFlag("success", false)
                    helpers["helm"].setAttempts(0)
                    helpers["helm"].setRound(round+1)
                    helpers["actions"].setLocked(false)
                    helpers["helm"].setTimer(os.clock())
                    
                    if round >= max then
                        helpers["helm"].setRound(1)
                    end
                    
                elseif message == 7258 then
                    helpers["helm"].setFlag("gathering", false)
                    helpers["helm"].setFlag("success", false)
                    helpers["helm"].setAttempts(0)
                    helpers["helm"].setRound(round+1)
                    helpers["actions"].setLocked(false)
                    helpers["helm"].setTimer(os.clock())
                    
                    if round >= max then
                        helpers["helm"].setRound(1)
                    end
                    
                end
                
            end
            
        end
        
    end

end

gethering['registry'] = {
    
    ["zone change"]     = "zone change",
    ["prerender"]       = "prerender",
    ["gather message1"] = "incoming chunk",
    ["gather message2"] = "incoming chunk",
    
}

return gethering