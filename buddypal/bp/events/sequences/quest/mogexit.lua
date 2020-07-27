-- Global Event Variables.
local settings
local window

-- Launch Events
local mogexit = {}
mogexit["zone change"] = function(new, old)
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
end

mogexit["prerender"] = function()
    local player = windower.ffxi.get_mob_by_target('me') or false
    
    if player then
        
        -- Registering event, reset variables.
        if helpers["events"].getReset() then
            settings    = dofile(windower.addon_path.."bp/events/sequences/quest/settings/mogexit_settings.lua")
            window      = helpers["events"].getWindow()
            
            -- Set Private Tables.
            helpers["events"].setReset(false)
            helpers["events"].setEvents(settings)
            helpers["events"].setItems(settings)
            helpers["events"].setNPCs(settings)
            helpers["events"].setDelays("zone", 5)
            helpers["events"].setStatus(5)
        
        end
        
        local midaction = helpers["actions"].getMidaction()
        local clocks    = helpers["events"].getClocks()
        local delays    = helpers["events"].getDelays()
        local zone      = helpers["events"].getZone()
        local npc       = helpers["events"].getNPCs()
        
        -- Handle cutscenes, and update the display.
        helpers["events"].updateDisplay()
        helpers["events"].handleCutscene()
        
        if os.clock()-clocks.ping > delays.spam + delays.zone and player.status ~= 4 and not midaction then
            local status = helpers["events"].getStatus()
            local locked = helpers["actions"].getLocked()
            
            -- Reset the zone delay.
            helpers["events"].setDelays("zone", 0)
            
            -- Check for items.
            if not bpcore:findItemByName("Marguerite")  and not bpcore:findItemByName("Amaryllis") and not bpcore:findItemByName("Lilac") and 
               not bpcore:findItemByName("Yellow Rock") and not bpcore:findItemByName("Parchment") and not bpcore:findItemByName("Black Ink") then
                
                helpers["events"].finishEvent("Quest")                
                
            end
            
            if zone.name == "Northern San d'Oria" and status ~= 5 then
                
                if status == 0 and bpcore:findItemByName("Marguerite") then
                    helpers["events"].trade(npcs[17723503], 5, {bpcore:findItemByName("Marguerite"), 1})
                    helpers["events"].setDelays("zone", 2)
                
            elseif bpcore:findItemByName("Amaryllis") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(1)
                    windower.send_command("bp mw hp Port Bastok 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif bpcore:findItemByName("Lilac") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(2)
                    windower.send_command("bp mw hp Windurst Walls 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif bpcore:findItemByName("Yellow Rock") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(3)
                    windower.send_command("bp mw hp Port Jeuno 1")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif bpcore:findItemByName("Parchment") and bpcore:findItemByName("Black Ink") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(4)
                    windower.send_command("bp mw hp Aht Urgan Whitegate 3")
                    helpers["events"].setDelays("zone", 10)
                    
                end
            
            elseif zone.name == "Port Bastok" and status ~= 5 then
                
                if bpcore:findItemByName("Marguerite") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(0)
                    windower.send_command("bp mw hp Northern San d'Oria 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif status == 1 and bpcore:findItemByName("Amaryllis") then
                    helpers["events"].trade(npcs[17743942], 5, {bpcore:findItemByName("Amaryllis"), 1})
                    helpers["events"].setDelays("zone", 2)
                
                elseif bpcore:findItemByName("Lilac") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(2)
                    windower.send_command("bp mw hp Windurst Walls 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif bpcore:findItemByName("Yellow Rock") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(3)
                    windower.send_command("bp mw hp Port Jeuno 1")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif bpcore:findItemByName("Parchment") and bpcore:findItemByName("Black Ink") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(4)
                    windower.send_command("bp mw hp Aht Urgan Whitegate 3")
                    helpers["events"].setDelays("zone", 10)
                    
                end
                
            elseif zone.name == "Windurst Walls" and status ~= 5 then
                
                if bpcore:findItemByName("Marguerite") then
                    helpers["events"].setStatus(0)
                    windower.send_command("bp mw hp Northern San d'Oria 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif bpcore:findItemByName("Amaryllis") then
                    helpers["events"].setStatus(1)
                    windower.send_command("bp mw hp Port Bastok 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif status == 2 and bpcore:findItemByName("Lilac") then
                    helpers["events"].trade(npcs[17756261], 5, {bpcore:findItemByName("Lilac"), 1})
                    helpers["events"].setDelays("zone", 2)
                
                elseif bpcore:findItemByName("Yellow Rock") then
                    helpers["events"].setStatus(3)
                    windower.send_command("bp mw hp Port Jeuno 1")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif bpcore:findItemByName("Parchment") and bpcore:findItemByName("Black Ink") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(4)
                    windower.send_command("bp mw hp Aht Urgan Whitegate 3")
                    helpers["events"].setDelays("zone", 10)
                    
                end
            
            elseif zone.name == "Port Jeuno" and status ~= 5 then
                
                if bpcore:findItemByName("Marguerite") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(0)
                    windower.send_command("bp mw hp Northern San d'Oria 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif bpcore:findItemByName("Amaryllis") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(1)
                    windower.send_command("bp mw hp Port Bastok 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif bpcore:findItemByName("Lilac") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(2)
                    windower.send_command("bp mw hp Windurst Walls 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif status == 3 and bpcore:findItemByName("Yellow Rock") then
                    helpers["events"].trade(npcs[17784896], 5, {bpcore:findItemByName("Yellow Rock"), 1})
                    helpers["events"].setDelays("zone", 2)
                    
                elseif bpcore:findItemByName("Parchment") and bpcore:findItemByName("Black Ink") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(4)
                    windower.send_command("bp mw hp Aht Urgan Whitegate 3")
                    helpers["events"].setDelays("zone", 10)
                    
                end
            
            elseif zone.name == "Aht Urgan Whitegate" and status ~= 5 then
                
                if bpcore:findItemByName("Marguerite") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(0)
                    windower.send_command("bp mw hp Northern San d'Oria 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif bpcore:findItemByName("Amaryllis") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(1)
                    windower.send_command("bp mw hp Port Bastok 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif bpcore:findItemByName("Lilac") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(2)
                    windower.send_command("bp mw hp Windurst Walls 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif bpcore:findItemByName("Yellow Rock") then
                    helpers["actions"].setLocked(false)
                    helpers["events"].setStatus(3)
                    windower.send_command("bp mw hp Port Jeuno 1")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif status == 4 and bpcore:findItemByName("Parchment") and bpcore:findItemByName("Black Ink") then
                    helpers["events"].trade(npcs[16982293], 5, {bpcore:findItemByName("Parchment"), 1}, {bpcore:findItemByName("Black Ink"), 1})
                    helpers["events"].setDelays("zone", 2)
                    
                end
                
            elseif (system["BP Allowed"][zone.id] or status == 5) then
                
                if bpcore:findItemByName("Marguerite") then                    
                    helpers["events"].setStatus(0)
                    windower.send_command("bp mw hp Northern San d'Oria 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif bpcore:findItemByName("Amaryllis") then                
                    helpers["events"].setStatus(1)
                    windower.send_command("bp mw hp Port Bastok 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif bpcore:findItemByName("Lilac") then                    
                    helpers["events"].setStatus(2)
                    windower.send_command("bp mw hp Windurst Wall 3")
                    helpers["events"].setDelays("zone", 10)
                
                elseif bpcore:findItemByName("Yellow Rock") then                    
                    helpers["events"].setStatus(3)
                    windower.send_command("bp mw hp Port Jeuno 1")
                    helpers["events"].setDelays("zone", 10)
                    
                elseif bpcore:findItemByName("Parchment") and bpcore:findItemByName("Black Ink") then                    
                    helpers["events"].setStatus(4)
                    windower.send_command("bp mw hp Aht Urgan Whitegate 3")
                    helpers["events"].setDelays("zone", 10)
                    
                end
                
            else
                helpers["actions"].tryWarping()
                helpers["events"].setDelays("zone", 30)
                
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

mogexit["registry"] = {
    
    ["zone change"]  = "zone change",
    ["prerender"]    = "prerender",
    
}
return mogexit