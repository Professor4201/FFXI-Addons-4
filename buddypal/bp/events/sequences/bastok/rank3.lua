-- Global Event Variables.
local settings
local window
local npc = {["Cleades"]=17739827, ["IM"]=17739828,["Makarim"]=17481821,["Naji"]=17748013}

-- Launch Events
local rank1 = {}
rank1["zone change"] = function(new, old)
    local status = helpers["events"].getStatus()
    
    helpers["events"].setZone()
    helpers["events"].zoneUpdate()
    
    if old == 79 and status == 2 then
        helpers["events"].setStatus(3)
        
    elseif old == 79 and status == 3 then
        helpers["events"].setStatus(4)
        
    elseif old == 69 and status == 6 then
        helpers["events"].setStatus(9)
        
    end
    
end

rank1["prerender"] = function()
    local player = windower.ffxi.get_mob_by_target("me") or false
    
    if player then
        
        if helpers["events"].getReset() then
            settings    = dofile(windower.addon_path.."bp/events/sequences/leujaoam/settings/fl_settings.lua")
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
            
            -- Reset the zone delay, and update the event display.
            helpers["events"].setDelays("zone", 0)
            helpers["events"].updateDisplay()
            
            if zone.name == "Bastok Markets" then
                
                if status == 0 then
                 
                    
                end
                
            elseif zone.name == "Bastok Mines" then
                
            elseif zone.name == "Zeruhn Mines" then
                
            elseif zone.name == "Metalworks" then
                
            end
            helpers["events"].setClocks("ping", os.clock())
            
        end
        
    end
    
end

rank1["handle menus"] = function(id,original,modified,injected,blocked)
    local injecting  = helpers["events"].getInjecting()
    
    if (id == 0x032 or id == 0x034) and injecting then
        local p         = packets.parse('incoming', original)
        local me        = windower.ffxi.get_mob_by_target("me")
        local midaction = helpers["actions"].getMidaction()
        local clocks    = helpers["events"].getClocks()
        local delays    = helpers["events"].getDelays()
        local zone      = helpers["events"].getZone()
        local npc       = helpers["events"].getNPCs()
        local valid
        
        ----------------------------------
        -- MENU INFO [Menu 1001, 2,0,0 ]
        ----------------------------------
        
        --Set current number of tags available.
        helpers["assaults"].setTags(original)
        
        -- Determine if our NPC is a valid NPC in our tables.
        for i,v in pairs(npc[zone.name]) do
            
            if type(v) == "table" and v.id == p["NPC"] then
                valid = true
            end
        
        end
        
        if me and valid then
            local target = windower.ffxi.get_mob_by_id(p["NPC"]) or false
            local status = helpers["events"].getStatus()
            
            if status == 0 and target and target.id == npc[zone.name]["Rytaal"].id then
                
                if helpers["assaults"].getTags() > 0 then
                    helpers["actions"].getTags(p, target)
                    helpers["events"].setStatus(1)
                    
                else
                    helpers["actions"].doExitMenu(p, target)
                    helpers["events"].setDelays("zone", 60)
                    
                end
            
            else
                return original
            
            end
            helpers["events"].setInjecting(false)
            helpers["events"].setDelays("zone", 3)
            helpers["events"].setClocks("ping", os.clock())
            return true
            
        else
            return original
            
        end
        
        
    end
    
end

rank1["registry"] = {
    ["zone change"]     = "zone change",
    ["prerender"]       = "prerender",
    ["handle menus"]    = "incoming chunk",
}

return rank1