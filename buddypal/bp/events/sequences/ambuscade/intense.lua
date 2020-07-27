local settings = require('bp/events/sequences/couriers/settings/intense_settings')
local window   = helpers["events"].getWindow()

-- Set Private Tables.
helpers["events"].setEvents(settings)
helpers["events"].setItems(settings)
helpers["events"].setNPCs(settings)

-- Launch Events
local intense = {}
intense['zone change'] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

intense['prerender'] = function()
    
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
                end
            
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

intense['registry'] = {
    
    ["zone change"]  = "zone change",
    ["prerender"]    = "prerender",
    ["ready check"]  = "incoming chunk",
    
}
return intense