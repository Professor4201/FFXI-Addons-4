local settings = require('bp/events/sequences/jobs/settings/dnc_settings')
local window   = helpers["events"].getWindow()

-- Set Private Tables.
helpers["events"].setEvents(settings)
helpers["events"].setItems(settings)
helpers["events"].setNPCs(settings)
helpers["events"].setDelays("zone", 5)

-- Launch Events
local dnc = {}
dnc['zone change'] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

dnc['prerender'] = function()
    
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
                    windower.send_command("bp mw homepoint Lower Jeuno 1")
                    helpers["events"].setDelays("zone", 10)
                end
                
            elseif zone.name == "Upper Jeuno" then
                
                if status == 0 then
                    helpers['events'].interact(npc[zone.name]['Laila'], 2, s, 1)
                    
                elseif status == 1 then
                    helpers['events'].interact(npc[zone.name]['Rhea Myuliah'], 2, 2)
                    
                elseif status == 2 then
                    windower.send_command("bp mw homepoint Lower Jeuno 1")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif status == 3 then
                    helpers['events'].interact(npc[zone.name]['Rhea Myuliah'], 2, 4)
                    
                elseif status == 4 then
                    windower.send_command("bp mw homepoint Lower Jeuno 1")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif status == 5 then
                    helpers['events'].interact(npc[zone.name]['Laila'], 2, 6)
                    
                elseif status == 6 then
                    helpers['events'].unregister()
                    
                end
                
            elseif zone.name == "Bastok Mines" then
                
                if status == 4 then
                    windower.send_command("bp mw homepoint Lower Jeuno 1")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif status == 5 then
                    windower.send_command("bp mw homepoint Lower Jeuno 1")
                    helpers["events"].setDelays("zone", 10)
                    
                end
            
            elseif zone.name == "Southern San d'Oria" then
                
                if status == 2 then
                    helpers['events'].interact(npc[zone.name]['Valderotaux'], 2, 3)
                
                elseif status == 3 then
                    windower.send_command("bp mw homepoint Lower Jeuno 1")
                    helpers["events"].setDelays("zone", 10)
                    
                end
                
            elseif zone.name == "Jugner Forest [S]" then
                
                if status == 4 then
                    helpers['events'].interact(npc[zone.name]['Glowing Pebbles'], 2, 5)
                    
                elseif status == 5 then
                    windower.send_command("bp mw homepoint Lower Jeuno 1")
                    helpers["events"].setDelays("zone", 10)
                    
                end
            
            else
                helpers["actions"].tryWarping()
                helpers["events"].setDelays("zone", 25)
                
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

dnc['registry'] = {
    ['zone change']     = "zone change",
    ['prerender']       = "prerender",
}
return dnc