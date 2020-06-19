-- Global Event Variables.
local settings
local window

-- Launch Events
local run = {}
run["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

run["prerender"] = function()
    local player = windower.ffxi.get_mob_by_target("me") or false
    
    if player then
        
        if helpers["events"].getReset() then
            settings    = dofile(windower.addon_path.."bp/events/sequences/jobs/settings/run_settings.lua")
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
                           helpers["events"].setDelays("zone", 0)
            
            -- EASTERN ADOULIN.
            if zone.name == "Eastern Adoulin" then
                
                if status == 0 then
                    helpers["events"].interact(npc[zone.name]["Octavien"], 1, 1)
                    
                elseif status == 1 then
                    windower.send_command("bp mw wp Yahse Hunting Grounds 1")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif status == 2 then
                        
                    if not bpcore:findItemByName("Sowilo Claymore", 0) then
                        helpers["events"].interact(npc[zone.name]["Octavien"], 3, false)
                            
                    elseif bpcore:findItemByName("Sowilo Claymore", 0) then
                        helpers["events"].setStatus(3)                        
                        
                    end
                    
                elseif status == 3 then
                    helpers["popchat"]:pop(("RUN is now unlocked!"), system["Popchat Window"])
                    helpers["events"].finishEvent("Jobs")
                    
                end
                
            -- YAHSE HUNTING GROUNDS.
            elseif zone.name == "Yahse Hunting Grounds" then
                    
                if status == 1 then
                    helpers["events"].interact(npc[zone.name]["Flower"], 1, 2)
                    
                elseif status == 2 then
                    windower.send_command("bp mw wp Eastern Adoulin 1")
                    helpers["events"].setDelays("zone", 10)
                    
                end
            
            else
                
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        helpers["events"].updateDisplay()
        
    end
    
end

run['registry'] = {
    ['zone change']  = "zone change",
    ['prerender']    = "prerender",
}

return run