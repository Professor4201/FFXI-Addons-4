local settings = require('bp/events/sequences/inventors/settings/legend_settings')
local window   = helpers["events"].getWindow()

-- Set Private Tables.
helpers["events"].setEvents(settings)
helpers["events"].setItems(settings)
helpers["events"].setNPCs(settings)

-- Launch Events
local legend = {}
legend['zone change'] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

legend['prerender'] = function()
    
    if windower.ffxi.get_mob_by_target('me') then
        local midaction = helpers["actions"].getMidaction()
        local clocks    = helpers["events"].getClocks()
        local delays    = helpers["events"].getDelays()
        local zone      = helpers["events"].getZone()
        local npc       = helpers["events"].getNPCs()
        
        -- Handle Cutscene Status.
        helpers['events'].handleCutscene()
        
        if os.clock()-clocks.ping > delays.spam + delays.zone and windower.ffxi.get_mob_by_target('me').status ~= 4 and not midaction then
            local status = helpers["events"].getStatus()
            
            -- Reset the zone delay, and update the event display.
            helpers["events"].setDelays("zone", 0)
            helpers['events'].updateDisplay()
            
            if zone.name == "Bastok Markets" then
                
                if status == 0 then
                    windower.send_command("bp mw hp Western Adoulin 1")
                    helpers["events"].setDelays("zone", 10)
                end
            
            elseif zone.name == "Western Adoulin" then
                
                if status == 0 then
                    local locked = helpers["actions"].getLocked()
                    
                    if not locked then
                        helpers["actions"].lockPosition(npc[zone.name]["Task Delegator"].x, npc[zone.name]["Task Delegator"].y, npc[zone.name]["Task Delegator"].z)
                        helpers["events"].setDelays("zone", 1.5)
                    
                    elseif locked then
                        helpers["events"].setInjecting(true)
                        helpers["actions"].poke(npc[zone.name]["Task Delegator"])
                        helpers["events"].setDelays("zone", 1.5)
                    
                    end
                    
                elseif status == 1 then
                    local locked = helpers["actions"].getLocked()
                        
                    if locked then
                        helpers["events"].trade(npc[zone.name]["Mertaire"], 2, {bpcore:findItemByName("Raaz Tusk"), 3})
                        helpers["events"].setDelays("zone", 2)
                        
                    end                    
                
                elseif status == 2 then
                    local locked = helpers["actions"].getLocked()
                    
                    if not locked then
                        helpers["events"].finishEvent("Inventors")
                    
                    elseif locked then
                        helpers["actions"].setLocked(false)
                        helpers["events"].setDelays("zone", 1.5)
                        
                    end   
                    
                end
                
            else
                windower.send_command("bp mw hp Western Adoulin 1")
                helpers["events"].setDelays("zone", 10)
                
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

legend["Missions"] = function(id,original,modified,injected,blocked)
    local mission   = {id=17825849, index=57, option=8848, _u1=27,  _u2=0, message=false, zone=256, menu=2009}
    local complete  = {id=17825849, index=57, option=8849, _u1=123, _u2=0, message=false, zone=256, menu=2009}
    local injecting = helpers["events"].getInjecting()
    
    if id == 0x034 and injecting then
        local p = packets.parse('incoming', original)
        local status = helpers["events"].getStatus()
        
        if p["NPC"] == mission.id and status == 0 then

            helpers["actions"].injectMenu(mission.id, mission.index, mission.zone, mission.option, mission.menu, mission.message, mission._u1, mission._u2)
            helpers["events"].setStatus(1)
            helpers["events"].setInjecting(false)
            helpers["events"].setDelays("zone", 3)
            
        elseif p["NPC"] == complete.id and status == 2 then
            helpers["actions"].injectMenu(complete.id, complete.index, complete.zone, complete.option, complete.menu, complete.message, complete._u1, complete._u2)
            helpers["events"].setStatus(3)
            helpers["events"].setInjecting(false)
            helpers["events"].setDelays("zone", 3)
            
        else
            helpers["actions"].doExitMenu(p, mission)
            
        end
        helpers["events"].setClocks("ping", os.clock())
        return true
        
    end
    
end

legend['registry'] = {
    
    ["zone change"]  = "zone change",
    ["prerender"]    = "prerender",
    ["Missions"]     = "incoming chunk"
    
}
return legend