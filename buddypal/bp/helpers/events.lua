--------------------------------------------------------------------------------
-- Events helper: Handles all event registration for the addon.
--------------------------------------------------------------------------------
local events = {}
function events.new()
    local self = {}
    
    --------------------------------------------------------------------------------
    -- Private Event Map.
    --------------------------------------------------------------------------------
    local map = {
        
        -- WINDOWER EVENTS.
        ["incoming"]        = {"globals"},
        ["outgoing"]        = {"globals"},
        ["prerender"]       = {"globals"},
        ["zonechange"]      = {"globals"},
        ["timechange"]      = {"globals"},
        ["daychange"]       = {"globals"},
        ["incomingtext"]    = {"globals"},
        ["chatmessage"]     = {"globals"},
        ["jobchange"]       = {"globals"},
        ["statuschange"]    = {"globals"},
        ["ipcmessage"]      = {"globals"},
        ["partyinvite"]     = {"globals"},
        ["gainbuff"]        = {"globals"},
        ["losebuff"]        = {"globals"},
        ["mouse"]           = {"globals"},
        
        -- CUSTOM EVENTS.
        ["maps"]            = {"promurouve"},
        ["quest"]           = {"mogexit"},
        ["jobs"]            = {"PLD","DRK","BST","BRD","RNG","SMN","SAM","NIN","DRG","BLU","COR","PUP","DNC","SCH","GEO","RUN",},
        ["summoner"]        = {"caitsith","ifrit","shiva","garuda","titan","ramuh","leviathan","fenrir","diabolos","siren","atomos","alexander","odin"},
        ["craft"]           = {"smithing","gold","leathercraft","clothcraft","woodworking","alchemy","bonecraft","cooking"},
        ["sparks"]          = {"Sparks"},
        ["couriers"]        = {"petitioner","probationer","disciple","contributor","partner","advisor","magnate","legend"},
        ["pioneers"]        = {"petitioner","probationer","disciple","contributor","partner","advisor","magnate","legend"},
        ["mummers"]         = {"petitioner","probationer","disciple","contributor","partner","advisor","magnate","legend"},
        ["inventors"]       = {"petitioner","probationer","disciple","contributor","partner","advisor","magnate","legend"},
        ["peacekeepers"]    = {"petitioner","probationer","disciple","contributor","partner","advisor","magnate","legend"},
        ["scouts"]          = {"petitioner","probationer","disciple","contributor","partner","advisor","magnate","legend"},
        ["farm"]            = {"clusters","sparks"},
        ["leujaoam"]        = {"FL"},
            
            --"Leujaoam_PSC",  "Leujaoam_PFC",    "Leujaoam_SP",  "Leujaoam_LC",  "Leujaoam_C",   "Leujaoam_S",   "Leujaoam_SM",  "Leujaoam_CS",  "Leujaoam_SL",  "Leujaoam_FL",
            --"Mamool_PSC",    "Mamool_PFC",      "Mamool_SP",    "Mamool_LC",    "Mamool_C",     "Mamool_S",     "Mamool_SM",    "Mamool_CS",    "Mamool_SL",    "Mamool_FL",
            --"Lebros_PSC",    "Lebros_PFC",      "Lebros_SP",    "Lebros_LC",    "Lebros_C",     "Lebros_S",     "Lebros_SM",    "Lebros_CS",    "Lebros_SL",    "Lebros_FL",
            --"Periqia_PSC",   "Periqia_PFC",     "Periqia_SP",   "Periqia_LC",   "Periqia_C",    "Periqia_S",    "Periqia_SM",   "Periqia_CS",   "Periqia_SL",   "Periqia_FL",
            --"Ilrusi_PSC",    "Ilrusi_PFC",      "Ilrusi_SP",    "Ilrusi_LC",    "Ilrusi_C",     "Ilrusi_S",     "Ilrusi_SM",    "Ilrusi_CS",    "Ilrusi_SL",    "Ilrusi_FL",
            
        ["ambuscade"]       = {"antica","slime","aquans","dullahan","vermin"},
        ["einherjar"]       = {"einherjar"},
        ["salvage"]         = {"arrapago","bhaflau","silversea","zhayolm","arrapagoII","bhaflauii","silverseaii","zhayolmii"},      
        ["di"]              = {"azi","naga","quetz"},
        ["battlefield"]     = {
            
            "NestOfNightmares",
            "ShadowLord","DelfkuttsTower","ArkAngelHM","ArkAngelTT","ArkAngelMR","ArkAngelEV","ArkAngelGK","DivineMight","CelestialNexus","TheSavage","HeadWind","OneToBeFeared","WarriorsPath","Dawn","PuppetInPeril","LegacyOfTheLost",
            "MaidenOfTheDusk","TrialByWind","TrialByLightning","TrialByEarth","TrialByFire","TrialByWater","TrialByIce","TheMoonlitPath","WakingTheBeast","WakingDreams","AStygianPact","DivineInterference","ChampionOfTheDawn"
        
        },
        ["unity"]           = {"99","119","122","125","128","135","Buy Items"},
        ["omen"]            = {"Fu","Kyou","Kei","Gin","Kin","Ou"},
        ["bastok"]          = {"Rank1","Rank2","Rank3","Rank4","Rank5","Rank6","Rank7","Rank8","Rank9","Rank10"},
        ["sandoria"]        = {"Rank1","Rank2","Rank3","Rank4","Rank5","Rank6","Rank7","Rank8","Rank9","Rank10"},
        ["windurst"]        = {"Rank1","Rank2","Rank3","Rank4","Rank5","Rank6","Rank7","Rank8","Rank9","Rank10"},
        ["roz"]             = {},
        ["cop"]             = {},
        ["toau"]            = {},
        ["wotg"]            = {},
        ["soa"]             = {},
        ["rov"]             = {},
    }
    
    -- Private Variables
    local registered = {globals={},current={}}
    local dir = "bp/events/sequences/"
    
    -- Bot Variables
    local debug             = true
    local status            = 0
    local events            = {}
    local items             = {}
    local npc               = {}
    local delays            = {spam=0.4, zone=0}
    local clocks            = {ping=0.0, move=0}
    local zone              = {id=res['zones'][windower.ffxi.get_info().zone].id, name=res['zones'][windower.ffxi.get_info().zone].name}
    local skip              = false
    local interacting       = false
    local injecting         = false
    local reset             = true
    local counts            = {npc=1, kills=0, nav=0}
    
    --Event Window Settings.
    local settings = {
        ['pos']={['x']=225,['y']=740},
        ['bg']={['alpha']=200,['red']=000,['green']=000,['blue']=000,['visible']=false},
        ['flags']={['right']=false,['bottom']=false,['bold']=false,['draggable']=false,['italic']=false},
        ['padding']=8,
        ['text']={['size']=10,['font']='lucida console',['fonts']={},['alpha']=255,['red']=245,['green']=200,['blue']=020,
            ['stroke']={['width']=001,['alpha']=255,['red']=0,['green']=0,['blue']=0}
        },
    }
    
    local events_window = texts.new("", settings, settings)
        events_window:visible(false)
        events_window:bg_visible(false)
        events_window:update()
    
    --------------------------------------------------------------------------------
    -- Get Base Map.
    --------------------------------------------------------------------------------
    self.getMap = function()
        return map
    end
    
    --------------------------------------------------------------------------------
    -- Set Sequence Name.
    --------------------------------------------------------------------------------
    self.getSequenceName = function(seq_name)
        seq_name = seq_name:lower()
        
        for i,_ in pairs(map) do
            if seq_name:match(i:lower()) then
                return i
            end
            
        end
        return false
        
    end
    
    --------------------------------------------------------------------------------
    -- Get Sequence Name.
    --------------------------------------------------------------------------------
    self.getSequences = function(seq_name)
        if map[seq_name] then
            return map[seq_name]        
        
        end
        return false
    
    end
    
    --------------------------------------------------------------------------------
    -- Get Event Name.
    --------------------------------------------------------------------------------
    self.getEventName = function(seq_name, event_name)
        local event_name = event_name:lower()
        if map[seq_name] and event_name then
            for _,v in pairs(map[seq_name]) do
                if event_name:match(v:lower()) then
                    return v
                end
                
            end
            
        end
        return false
        
    end
    
    --------------------------------------------------------------------------------
    -- Call Events from a Sequence.
    --------------------------------------------------------------------------------
    self.callEvents = function(seq_name, event_name)
        local seq_name = helpers["events"].getSequenceName(seq_name)
        local event_name = helpers["events"].getEventName(seq_name, event_name)

        if seq_name and event_name and not once then
            local dir = ((dir .. seq_name:lower() .. ("/") .. event_name:lower()))
            local f = io.open((windower.addon_path .. dir .. ".lua"), "r")
            
            if f then
                io.close(f)
                return require(dir)
            end
        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Register an Event.
    --------------------------------------------------------------------------------
    self.register = function(sequence, event)
        local event = helpers["events"].callEvents(sequence, event)
        
        if event then
            local registry = event.registry
    
            for i,v in pairs(event) do
                
                if type(v) == "function" then
                    local id = windower.register_event(registry[i], event[i])
                    registered["current"][i] = {name=i, id=id, func=event[i]}
                
                end
                
            end
            return true
        
        end
        return false
        
    end
    
    --------------------------------------------------------------------------------
    -- Unregister an Event.
    --------------------------------------------------------------------------------
    self.unregister = function()
        for i, v in pairs(registered['current']) do
            windower.unregister_event(v.id)
            registered['current'][i] = nil
            
        end
        return true
        
    end
    
    --------------------------------------------------------------------------------
    -- Register all Global Events.
    --------------------------------------------------------------------------------
    self.registerGlobals = function()
        local incoming       = helpers["events"].callEvents("incoming",      "globals")
        local outgoing       = helpers["events"].callEvents("outgoing",      "globals")
        local prerender      = helpers["events"].callEvents("prerender",     "globals")
        local daychange      = helpers["events"].callEvents("daychange",     "globals")
        local timechange     = helpers["events"].callEvents("timechange",    "globals")
        local incoming_text  = helpers["events"].callEvents("incomingtext",  "globals")
        local chat_message   = helpers["events"].callEvents("chatmessage",   "globals")
        local jobchange      = helpers["events"].callEvents("jobchange",     "globals")
        local statuschange   = helpers["events"].callEvents("statuschange",  "globals")
        local zonechange     = helpers["events"].callEvents("zonechange",    "globals")
        local ipcmessage     = helpers["events"].callEvents("ipcmessage",    "globals")
        local partyinvite    = helpers["events"].callEvents("partyinvite",   "globals")
        local gainbuff       = helpers["events"].callEvents("gainbuff",      "globals")
        local losebuff       = helpers["events"].callEvents("losebuff",      "globals")
        local mouse          = helpers["events"].callEvents("mouse",         "globals")

        -- Register Globals Events.
        if incoming then
            for i,v in ipairs(incoming) do
                if type(v) == 'function' then
                    local id = windower.register_event('incoming chunk', incoming[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
    
        if outgoing then
            for i,v in ipairs(outgoing) do
                if type(v) == 'function' then
                    local id = windower.register_event('outgoing chunk', outgoing[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
        
        if prerender then
            for i,v in ipairs(prerender) do
                if type(v) == 'function' then
                    local id = windower.register_event('prerender', prerender[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
    
        if daychange then
            for i,v in ipairs(daychange) do
                if type(v) == 'function' then
                    local id = windower.register_event('day change', daychange[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
        
        if timechange then
            for i,v in ipairs(timechange) do
                if type(v) == 'function' then
                    local id = windower.register_event('time change', timechange[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
        
        if incoming_text then
            for i,v in ipairs(incoming_text) do
                if type(v) == 'function' then
                    local id = windower.register_event('incoming text', incoming_text[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
        
        if chat_message then
            for i,v in ipairs(chat_message) do
                if type(v) == 'function' then
                    local id = windower.register_event('chat message', chat_message[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
        
        if jobchange then
            for i,v in ipairs(jobchange) do
                if type(v) == 'function' then
                    local id = windower.register_event('incoming text', jobchange[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
        
        if statuschange then
            for i,v in ipairs(statuschange) do
                if type(v) == 'function' then
                    local id = windower.register_event('status change', statuschange[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
        
        if zonechange then
            for i,v in ipairs(zonechange) do
                if type(v) == 'function' then
                    local id = windower.register_event('zone change', zonechange[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
    
        if ipcmessage then
            for i,v in ipairs(ipcmessage) do
                if type(v) == 'function' then
                    local id = windower.register_event('ipc message', ipcmessage[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
        
        if partyinvite then
            for i,v in ipairs(partyinvite) do
                if type(v) == 'function' then
                    local id = windower.register_event('party invite', partyinvite[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
        
        if gainbuff then
            for i,v in ipairs(gainbuff) do
                if type(v) == 'function' then
                    local id = windower.register_event('gain buff', gainbuff[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
        
        if losebuff then
            for i,v in ipairs(losebuff) do
                if type(v) == 'function' then
                    local id = windower.register_event('lose buff', losebuff[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
        
        if mouse then
            for i,v in ipairs(mouse) do
                if type(v) == 'function' then
                    local id = windower.register_event('mouse', mouse[i])
                    registered['globals'][i] = {name=i, id=id}
                end
            
            end
        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Get current registered event.
    --------------------------------------------------------------------------------
    self.getCurrentRegistered = function()
        return registered['current']
        
    end
    
    --------------------------------------------------------------------------------
    -- Get all global events.
    --------------------------------------------------------------------------------
    self.getGlobalsRegistered = function()
        return registered['globals']
        
    end
    
    --------------------------------------------------------------------------------
    -- Get events window.
    --------------------------------------------------------------------------------
    self.getWindow = function()
        return events_window
        
    end
    
    --------------------------------------------------------------------------------
    -- Show the event window.
    --------------------------------------------------------------------------------
    self.show = function(window)
        window:bg_visible(true)
        window:bg_alpha(155)
        window:show()
    end
    
    --------------------------------------------------------------------------------
    -- Hide the event window.
    --------------------------------------------------------------------------------
    self.hide = function(window)
        window:bg_visible(false)
        window:bg_alpha(0)
        window:hide()
    end
    
    --------------------------------------------------------------------------------
    -- Update the event window.
    --------------------------------------------------------------------------------
    self.update = function(text, window)
        window:text("[ " .. text .. " ]")
        window:bg_visible(true)
        window:bg_alpha(155)
        window:update()
        window:show()    
    
    end
    
    --------------------------------------------------------------------------------
    -- Reset event values on zone and update times..
    --------------------------------------------------------------------------------
    self.zoneUpdate = function(delay)
        helpers["actions"].setLocked(false)
        helpers["events"].setDelays("zone",  20)
        helpers["events"].setCounts("npc",   0)
        helpers["events"].setCounts("kills", 0)
        helpers["events"].setCounts("nav",   0)
        helpers["events"].setInjecting(false)
        helpers["events"].setInteracting(false)
    
    end
    
    --------------------------------------------------------------------------------
    -- Set events list.
    --------------------------------------------------------------------------------
    self.setEvents = function(settings)
        events = settings.events
    end
    
    --------------------------------------------------------------------------------
    -- Get events list.
    --------------------------------------------------------------------------------
    self.getEvents = function()
        return events
    end
    
    --------------------------------------------------------------------------------
    -- Set items list.
    --------------------------------------------------------------------------------
    self.setItems = function(settings)
        items = settings.items
    end
    
    --------------------------------------------------------------------------------
    -- Get items list.
    --------------------------------------------------------------------------------
    self.getItems = function()
        return items
    end
    
    --------------------------------------------------------------------------------
    -- Set NPC list.
    --------------------------------------------------------------------------------
    self.setNPCs = function(settings)
        npc = settings.npcs
    end
    
    --------------------------------------------------------------------------------
    -- Get NPC list.
    --------------------------------------------------------------------------------
    self.getNPCs = function()
        return npc
    end
    
    --------------------------------------------------------------------------------
    -- Set debug.
    --------------------------------------------------------------------------------
    self.setDebug = function(value)
        debug = value
    end
    
    --------------------------------------------------------------------------------
    -- Get debug.
    --------------------------------------------------------------------------------
    self.getDebug = function()
        return debug
    end
    
    --------------------------------------------------------------------------------
    -- Set status.
    --------------------------------------------------------------------------------
    self.setStatus = function(value)
        status = value
    end
    
    --------------------------------------------------------------------------------
    -- Get status.
    --------------------------------------------------------------------------------
    self.getStatus = function()
        return status
    end
    
    --------------------------------------------------------------------------------
    -- Set delays.
    --------------------------------------------------------------------------------
    self.setDelays = function(name, value)
        delays[name] = value
    end
    
    --------------------------------------------------------------------------------
    -- Get delays.
    --------------------------------------------------------------------------------
    self.getDelays = function()
        return delays
    end
    
    --------------------------------------------------------------------------------
    -- Set clocks.
    --------------------------------------------------------------------------------
    self.setClocks = function(name, value)
        clocks[name] = value
    end
    
    --------------------------------------------------------------------------------
    -- Get clocks.
    --------------------------------------------------------------------------------
    self.getClocks = function()
        return clocks
    end
    
    --------------------------------------------------------------------------------
    -- Get zone.
    --------------------------------------------------------------------------------
    self.getZone = function()
        return zone
    end
    
    --------------------------------------------------------------------------------
    -- Set zone.
    --------------------------------------------------------------------------------
    self.setZone = function()
        zone = {id=res['zones'][windower.ffxi.get_info().zone].id, name=res['zones'][windower.ffxi.get_info().zone].name}
    end
    
    --------------------------------------------------------------------------------
    -- Set interacting.
    --------------------------------------------------------------------------------
    self.setInteracting = function(value)
        interacting = value
    end
    
    --------------------------------------------------------------------------------
    -- Get skip.
    --------------------------------------------------------------------------------
    self.getSkip = function()
        return skip
    end
    
    --------------------------------------------------------------------------------
    -- Set skip.
    --------------------------------------------------------------------------------
    self.setSkip = function(value)
        skip = value
    end
    
    --------------------------------------------------------------------------------
    -- Set interacting.
    --------------------------------------------------------------------------------
    self.setInteracting = function(value)
        interacting = value
    end
    
    --------------------------------------------------------------------------------
    -- Get interacting.
    --------------------------------------------------------------------------------
    self.getInteracting = function()
        return interacting
    end
    
    --------------------------------------------------------------------------------
    -- Set injecting.
    --------------------------------------------------------------------------------
    self.setInjecting = function(value)
        injecting = value
    end
    
    --------------------------------------------------------------------------------
    -- Get injecting.
    --------------------------------------------------------------------------------
    self.getInjecting = function()
        return injecting
    end
    
    --------------------------------------------------------------------------------
    -- Set counts.
    --------------------------------------------------------------------------------
    self.setCounts = function(name, value)
        counts[name] = value
    end
    
    --------------------------------------------------------------------------------
    -- Get counts.
    --------------------------------------------------------------------------------
    self.getCounts = function()
        return counts
    end
    
    --------------------------------------------------------------------------------
    -- Set reset.
    --------------------------------------------------------------------------------
    self.setReset = function(value)
        reset = value
    end
    
    --------------------------------------------------------------------------------
    -- Get reset.
    --------------------------------------------------------------------------------
    self.getReset = function()
        return reset
    end
    
    --------------------------------------------------------------------------------
    -- Finish the event that is currently registered.
    --------------------------------------------------------------------------------
    self.finishEvent = function(current_event, sequence, event)
        local current_event, sequence, event = current_event or false, sequence or false, event or false
        
        if current_event then
            helpers["schedule"].updateStats(current_event)
            helpers["events"].setDelays("zone",  20)
            helpers["events"].setCounts("npc",   1)
            helpers["events"].setCounts("kills", 0)
            helpers["events"].setCounts("nav",   0)
            helpers["events"].setStatus(0)
            helpers["events"].setInteracting(false)
            helpers["events"].setInjecting(false)
            helpers["events"].update(("") , helpers["events"].getWindow())
            helpers["events"].hide(helpers["events"].getWindow())
            helpers["events"].setReset(true)
            helpers["actions"].setLocked(false)
            helpers["events"].unregister()
            
            if sequence and event then
                --helpers["events"].register(sequence, event)
                helpers["schedule"].scheduleEvent(sequence, event)
            end
            
            -- Maybe possibly add some sort of time stamp to completion?
            
        end
    
    end
    
    --------------------------------------------------------------------------------
    -- Handle player actions during cutscenes status.
    --------------------------------------------------------------------------------
    self.handleCutscene = function()
        local player = windower.ffxi.get_mob_by_target("me") or false
        local window = helpers["events"].getWindow()
        
        if player and window and os.clock()-clocks.ping > (delays.spam + delays.zone) and player.status == 4 and not skip then

            -- Update Display
            helpers["events"].updateDisplay()
            windower.send_command("setkey enter down; wait 0.2; setkey enter up")
            helpers["events"].setDelays("zone", 0.5)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Handle player actions during cutscenes status.
    --------------------------------------------------------------------------------
    self.updateDisplay = function()
        local player = windower.ffxi.get_mob_by_target("me") or false
        local window = helpers["events"].getWindow()
        
        if player then
            helpers["events"].update(("Player Status: " .. player.status .. " Event: " .. events[status] .. " (" .. status .. ") Attemps: " .. counts.npc), window)
            
        end
        
    end
            
    --------------------------------------------------------------------------------
    -- Check if all event items are acquired before starting.
    --------------------------------------------------------------------------------
    self.checkItems = function(items)
        local items = items or false
        
        if helpers["events"].getStatus() == 0 and #items > 0 then
            
            for i,v in ipairs(items) do
                
                if not bpcore:findItemByName(v) then
                    return false                    
                end
                
            end
            
        end
        return true
        
    end
    
    --------------------------------------------------------------------------------
    -- POS to an NPC and interact with them..
    --------------------------------------------------------------------------------
    self.interact = function(target, attempts, status)
        local status = status or false
        local locked = helpers["actions"].getLocked()
        local count  = helpers["events"].getCounts().npc

        if not locked then
            helpers["actions"].lockPosition(target.x, target.y, target.z)
            helpers["events"].setDelays("zone", 2)
            
        elseif locked then

            if count < attempts + 1 then
                helpers["actions"].doAction(target, 0, "interact")
                
                if count == attempts then
                    helpers["events"].setCounts("npc",  1)
                    helpers["events"].setDelays("zone", 3)
                    helpers["actions"].setLocked(false)
                    
                    if status and type(status) == "number" then
                        helpers["events"].setStatus(status)
                    end
                
                else
                    helpers["events"].setCounts("npc",  (count + 1))
                    helpers["events"].setDelays("zone", 3)
                
                end
                
            end
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- POS to NPC Position and trade them an item.
    --------------------------------------------------------------------------------
    self.trade = function(target, status, ...)
        local status = status or false
        local locked = helpers["actions"].getLocked()
        
        if not locked then
            helpers["actions"].lockPosition(target.x, target.y, target.z)
            helpers["events"].setDelays("zone", 2)
            
        elseif locked then
            helpers["actions"].tradeNPC(target, ...)
            helpers["events"].setDelays("zone", 3)
            
            if status then
                helpers["events"].setStatus(status)
            end
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Handle a home point menu.
    --------------------------------------------------------------------------------
    self.menuHomepoint = function(target, option, packets)
        
        if target and option and packets then
            local hp = target
            helpers["actions"].injectMenu(hp.id, hp.index, packets['Zone'], 8, packets['Menu ID'], true, 0, 0)
            helpers["actions"].injectMenu(hp.id, hp.index, packets['Zone'], 2, packets['Menu ID'], true, option, 0)
            helpers["actions"].injectMenu(hp.id, hp.index, packets['Zone'], 2, packets['Menu ID'], false, option, 0)
            helpers["events"].setDelays("zone", 10)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Handle a home point menu.
    --------------------------------------------------------------------------------
    self.menuSurvivalGuide = function(target, option, packets)
        
        if target and option and packets then
            local guide = target
            helpers["actions"].injectMenu(guide.id, guide.index, packets['Zone'], 7, packets['Menu ID'], true, 0, 0)
            helpers["actions"].injectMenu(guide.id, guide.index, packets['Zone'], 1, packets['Menu ID'], true, 0, 0)
            helpers["actions"].injectMenu(guide.id, guide.index, packets['Zone'], 1, packets['Menu ID'], false, option, 0)
            helpers["events"].setDelays("zone", 10)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Start Ambuscade Normal Ambuscade (114) [Easy].
    --------------------------------------------------------------------------------
    self.menuSurvivalGuide = function(target, option, packets)
        
        if target and option and packets then
            local guide = target
            helpers["actions"].injectMenu(guide.id, guide.index, packets['Zone'], 9, packets['Menu ID'], true, 0, 0)
            helpers["actions"].injectMenu(guide.id, guide.index, packets['Zone'], 9, packets['Menu ID'], true, 0, 0)
            helpers["events"].setDelays("zone", 10)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Exit a menu.
    --------------------------------------------------------------------------------
    self.exitMenu = function(target, packets)
        
        if target and packets then
            helpers["actions"].injectMenu(target.id, target.index, packets['Zone'], 0, packets['Menu ID'], false, 16384, 0)
            helpers["events"].setDelays("zone", 3)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Enter Escha.
    --------------------------------------------------------------------------------
    self.enterEscha = function(target, packets)
        
        if target and packets then
            local entrance = target
            helpers["actions"].injectMenu(entrance.id, entrance.index, packets['Zone'], 0, packets['Menu ID'], true, 0, 0)
            helpers["actions"].injectMenu(entrance.id, entrance.index, packets['Zone'], 1, packets['Menu ID'], false, 0, 0)
            helpers["events"].setDelays("zone", 10)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Get Elvorseal and warp to destination.
    --------------------------------------------------------------------------------
    self.getElvorseal = function(target, pos_x, pos_y, pos_z, packets)

        if target and pos_x and pos_y and pos_z and packets and settings then
            local warp = 'ifffIIHHHCC':pack(0x00005c00, pos_x, pos_z, pos_y, target.id, 12, packets['Zone'], packets['Menu ID'], target.index, 1, 0)
            --local update = 'iHH':pack(0x00001600, target.index, 0)
            
            helpers["actions"].injectMenu(target.id, target.index, packets['Zone'], 14, packets['Menu ID'], true, 0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets['Zone'], 08, packets['Menu ID'], true, 0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets['Zone'], 09, packets['Menu ID'], true, 0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets['Zone'], 09, packets['Menu ID'], true, 0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets['Zone'], 10, packets['Menu ID'], true, 0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets['Zone'], 11, packets['Menu ID'], true, 0, 0)
            windower.packets.inject_outgoing(0x05c, warp)
            helpers["actions"].injectMenu(target.id, target.index, packets['Zone'], 12, packets['Menu ID'], false, 0, 0)
            --windower.packets.inject_outgoing(0x016, update)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Choose yes in a simple 2 option menu..
    --------------------------------------------------------------------------------
    self.simpleMenu = function(target, packets)
        
        if target and packets then
            helpers["actions"].injectMenu(target.id, target.index, packets['Zone'], 0, packets['Menu ID'], false, 0, 0)
            --helpers["actions"].injectMenu(target.id, target.index, packets['Zone'], 1, packets['Menu ID'], false, 0, 0)
            helpers["events"].setDelays("zone", 10)
            
        end
        
    end
    
    return self
    
end
return events.new()
