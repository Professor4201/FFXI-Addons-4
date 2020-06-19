--------------------------------------------------------------------------------
-- PLD Core: Handle all job automation for Paladin.
--------------------------------------------------------------------------------
local core = {}

-- CORE AUTOMATED FUNCTION FOR THIS JOB.
function core.get()
    self = {}
    
    -- Master Settings
    local settings = {}
    settings["TOGGLED"]                            = I{false,true}
    settings["AM"]                                 = I{false,true}
    settings["AM THRESHOLD"]                       = I{3000,2000,1000}
    settings["1HR"]                                = I{false,true}
    settings["JA"]                                 = I{false,true}
    settings["RA"]                                 = I{false,true}
    settings["HATE"]                               = I{true,false}
    settings["BUFFS"]                              = I{true,false}
    settings["DEBUFFS"]                            = I{false,true}
    settings["WS"]                                 = I{false,true}
    settings["WSNAME"]                             = "Savage Blade"
    settings["TP THRESHOLD"]                       = 1000
    settings["SC"]                                 = I{false,true}
    settings["BURST"]                              = I{false,true}
    settings["ELEMENT"]                            = I{"Fire","Ice","Wind","Earth","Lightning","Water","Light","Dark","Random"}
    settings["TIER"]                               = I{"I","II","III","IV","V","Random"}
    settings["ALLOW-AOE"]                          = I{false,true}
    settings["DRAINS"]                             = I{false,true}
    settings["STUNS"]                              = I{false,true}
    settings["SUPER-TANK"]                         = I{false,true}
    settings["SHADOWS"]                            = I{false,true}
    settings["FOOD"]                               = I{"Sublime Sushi","Sublime Sushi +1"}
    settings["SAMBAS"]                             = I{"Drain Samba II","Haste Samba"}
    settings["STEPS"]                              = I{"Quickstep","Box Step","Stutter Step"}
    settings["RUNE1"]                              = I{"Lux","Tenebrae","Unda","Ignis","Gelus","Flabra","Tellus","Sulpor"}
    settings["RUNE2"]                              = I{"Lux","Tenebrae","Unda","Ignis","Gelus","Flabra","Tellus","Sulpor"}
    settings["RUNE3"]                              = I{"Lux","Tenebrae","Unda","Ignis","Gelus","Flabra","Tellus","Sulpor"}
    settings["SKILLUP"]                            = I{false,true}
    settings["SKILLS"]                             = I{"Enhancing","Divine"}
    
    -- Specialty Settings
    settings["SANGUINE"]                           = I{false,true}
    settings["TANK MODE"]                          = I{true,false}
    settings["HASSO MODE"]                         = I{true,false}
    settings["SEKKA"]                              = "Savage Blade"
    settings["DIA"]                                = I{"Dia","Bio"}
    settings["CHIVALRY"]                           = I{1000,1500,2000,2500,3000}
    
    -- DEBUFFS.
    settings["SPELLS"]={
    }
    
    -- MAGIC BURST.
    settings["Magic Burst"]={
        
        ["Transfixion"]   = T{},
        ["Compression"]   = T{},
        ["Liquefaction"]  = T{},
        ["Scission"]      = T{},
        ["Reverberation"] = T{},
        ["Detonation"]    = T{},
        ["Induration"]    = T{},
        ["Impaction"]     = T{},
        
    }
    
    -- JOB POINTS AVAILABLE.
    settings["JOB POINTS"] = windower.ffxi.get_player()["job_points"][windower.ffxi.get_player().main_job:lower()].jp_spent
    
    -- DISPLAY SETTINGS
    local display          = I{false, true}
    local display_settings = {
        ['pos']={['x']=system["Job Window X"],['y']=system["Job Window Y"]},
        ['bg']={['alpha']=155,['red']=0,['green']=0,['blue']=0,['visible']=false},
        ['flags']={['right']=false,['bottom']=false,['bold']=false,['draggable']=system["Job Draggable"],['italic']=false},
        ['padding']=system["Job Padding"],
        ['text']={['size']=system["Job Font"].size,['font']=system["Job Font"].font,['fonts']={},['alpha']=system["Job Font"].alpha,['red']=system["Job Font"].r,['green']=system["Job Font"].g,['blue']=system["Job Font"].b,
            ['stroke']={['width']=system["Job Stroke"].width,['alpha']=system["Job Stroke"].alpha,['red']=system["Job Stroke"].r,['green']=system["Job Stroke"].g,['blue']=system["Job Stroke"].b}
        },
    }

    local window = texts.new(windower.ffxi.get_player().main_job_full, display_settings)
    
    self.handleChat = function(message, sender, mode, gm)
        
        if mode == 3 or mode == 4 then
            
            if system["Controllers"]:contains(sender) then
                local commands = message:split(" ")
                
                if commands[1] and system["Player"].name:lower():match(commands[1]) then
                    
                end
                
            else
                
            end
            
        end
        
    end
    
    self.handleCommands = function(commands)
        local command = commands[1] or false
        
        if command then
            command = command:lower()
        end
        
        if command == "on" or command == "toggle" or command == "off" then
            system["BP Enabled"]:next()
            helpers['popchat']:pop(("Automation: " .. tostring(system["BP Enabled"]:current())):upper(), system["Popchat Window"])
            
            if not system["BP Enabled"]:current() then
                helpers['queue'].clear()
            end
        
        elseif command == "display" then
            display:next()
            helpers['popchat']:pop(("DISPLAY: " .. tostring(display:current())):upper(), system["Popchat Window"])
        
        elseif command == "am" then
            settings["AM"]:next()
            helpers['popchat']:pop(("Auto-Aftermath: " .. tostring(settings["AM"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "amt" then
            settings["AM THRESHOLD"]:next()
            helpers['popchat']:pop(("Aftermath Threshold: " .. tostring(settings["AM THRESHOLD"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "1hr" then
            settings["1HR"]:next()
            helpers['popchat']:pop(("Auto-1hour: " .. tostring(settings["1HR"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "ja" then
            settings["JA"]:next()
            helpers['popchat']:pop(("Auto-Job Abilities: " .. tostring(settings["JA"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "ra" then
            settings["RA"]:next()
            helpers['popchat']:pop(("Auto-Ranged Attacks: " .. tostring(settings["RA"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "hate" then
            settings["HATE"]:next()
            helpers['popchat']:pop(("Auto-Enmity: " .. tostring(settings["HATE"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "buffs" then
            settings["BUFFS"]:next()
            helpers['popchat']:pop(("Auto-Buffing: " .. tostring(settings["BUFFS"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "debuffs" then
            settings["DEBUFFS"]:next()
            helpers['popchat']:pop(("Auto-Debuffing: " .. tostring(settings["DEBUFFS"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "tpt" then
            local number = commands[2] or false
            
            if number then
                number = tonumber(number)
                
                if number > 999 and number <= 3000 then
                    settings["TP THRESHOLD"] = number
                    helpers['popchat']:pop(("TP THRESHOLD: " .. tostring(number) .. "."):upper(), system["Popchat Window"])
                
                else
                    helpers['popchat']:pop(("Enter a number from 1000 to 3000"):upper(), system["Popchat Window"])
                    
                end
            
            end
        
        elseif command == "ws" then
            settings["WS"]:next()
            helpers['popchat']:pop(("Auto-Weapon Skills: " .. tostring(settings["WS"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "chiv" then
            settings["CHIVALRY"]:next()
            helpers['popchat']:pop(("Chivalry TP set to: " .. tostring(settings["CHIVALRY"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "wsname" then
            local weaponskill = windower.convert_auto_trans(table.concat(commands, " "):sub(8)):lower()
            for _,v in pairs(windower.ffxi.get_abilities().weapon_skills) do
                
                if v and res.weapon_skills[v].en then
                    local match = res.weapon_skills[v].en:lower():match(("[%a%s%']+"))

                    if weaponskill:sub(1,5) == match:sub(1,5) then
                        settings["WSNAME"] = res.weapon_skills[v].en
                        helpers['popchat']:pop(("Weapon Skill now set to: " .. tostring(settings["WSNAME"])):upper(), system["Popchat Window"])
                    end
                    
                end
                
            end
        
        elseif command == "sekka" then
            local weaponskill = windower.convert_auto_trans(table.concat(commands, " "):sub(8)):lower()
            for _,v in pairs(windower.ffxi.get_abilities().weapon_skills) do
                
                if v and res.weapon_skills[v].en then
                    local match = res.weapon_skills[v].en:lower():match(("[%a%s%']+"))

                    if weaponskill:sub(1,5) == match:sub(1,5) then
                        settings["SEKKA"] = res.weapon_skills[v].en
                        helpers['popchat']:pop(("Weapon Skill now set to: " .. tostring(settings["SEKKA"])):upper(), system["Popchat Window"])
                    end
                    
                end
                
            end
        
        elseif command == "sanguine" then
            settings["SANGUINE"]:next()
            helpers['popchat']:pop(("Auto-Sanguine Blade: " .. tostring(settings["SANGUINE"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "tank" then
            settings["TANK MODE"]:next()
            helpers['popchat']:pop(("Tank Mode: " .. tostring(settings["TANK MODE"]:current())):upper(), system["Popchat Window"])
            
        elseif (command == "hasso" or command == "seigan") then
            settings["HASSO MODE"]:next()
            helpers['popchat']:pop(("Hasso Mode: " .. tostring(settings["HASSO MODE"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "sc" then
            settings["SC"]:next()
            helpers['popchat']:pop(("Auto-Skillchains: " .. tostring(settings["SC"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "burst" then
            settings["BURST"]:next()
            helpers['popchat']:pop(("Auto-Bursting: " .. tostring(settings["BURST"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "element" then
            local element = windower.convert_auto_trans(commands[2]):lower() or false
            if element then

                for _,v in pairs(res.elements) do

                    if v and element:sub(1,6) == v.en:sub(1,6):lower() then
                        settings["ELEMENT"]:setTo(v.en)
                        helpers['popchat']:pop(("Auto-Burst Element now set to: " .. tostring(settings["ELEMENT"]:current())):upper(), system["Popchat Window"])    
                    end
                    
                end
                
            end
            
        elseif command == "tier" then
            settings["TIER"]:next()
            helpers['popchat']:pop(("Auto-Bursting Tier now set to: " .. tostring(settings["TIER"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "aoe" then
            settings["ALLOW-AOE"]:next()
            helpers['popchat']:pop(("AOE-Bursting now: " .. tostring(settings["ALLOW-AOE"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "drains" then
            settings["DRAINS"]:next()
            helpers['popchat']:pop(("Auto-Drains: " .. tostring(settings["DRAINS"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "stuns" then
            settings["STUNS"]:next()
            helpers['popchat']:pop(("Auto-Stunning: " .. tostring(settings["STUNS"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "super" then
            settings["SUPER-TANK"]:next()
            helpers['popchat']:pop(("Super-tanking: " .. tostring(settings["SUPER-TANK"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "utsu" then
            settings["SHADOWS"]:next()
            helpers['popchat']:pop(("Auto-Shadows: " .. tostring(settings["SHADOWS"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "food" then
            settings["FOOD"]:next()
            helpers['popchat']:pop(("Auto-Food: " .. tostring(settings["FOOD"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "sambas" then
            settings["SAMBAS"]:next()
            helpers['popchat']:pop(("Auto-Steps: " .. tostring(settings["SAMBAS"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "steps" then
            settings["STEPS"]:next()
            helpers['popchat']:pop(("Auto-Steps: " .. tostring(settings["STEPS"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "skillup" then
            settings["SKILLUP"]:next()
            helpers['popchat']:pop(("Auto-Skillup: " .. tostring(settings["SKILLUP"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "skills" then
            settings["SKILLS"]:next()
            helpers['popchat']:pop(("Skill-Up spell now set to: " .. tostring(settings["SKILLS"]:current())):upper(), system["Popchat Window"])
        
        else
            system["Core"].event(command)
            
        end
        
    end
    
    self.handleItems = function()
        
        if bpcore:canItem() and bpcore:checkReady() and not system["Midaction"] then
            
            if bpcore:buffActive(15) then
                
                if bpcore:findItemByName("Holy Water") then
                    helpers["queue"].add(IT["Holy Water"], "me")
                
                elseif bpcore:findItemByName("Hallowed Water") then
                    helpers["queue"].add(IT["Hallowed Water"], "me")
                    
                end
            
            elseif bpcore:buffActive(6) then
                
                if bpcore:findItemByName("Echo Drops") then
                    helpers["queue"].add(IT["Echo Drops"], "me")
                end
                
            end
        
        end
        
    end
    
    self.handleAutomation = function()
        
        -- Handle items.
        system["Core"].handleItems()
        
        if bpcore:checkReady() and not helpers["actions"].getMoving() and system["BP Enabled"]:current() then
            
            -- PLAYER IS ENGAGED.
            if system["Player"].status == 1 then
                
                -- SKILLUP LOGIC.
                if settings["SKILLUP"]:current() then
                    
                    if bpcore:canCast() and settings["SKILLS"]:current() == "Divine" then
                        
                        -- BANISH.
                        if bpcore:isMAReady(MA["Banish"].recast_id) and bpcore:getAvailable("MA", "Banish") then
                            helpers["queue"].add(MA["Banish"], "me")
                        
                        -- BANISH II.
                        elseif bpcore:isMAReady(MA["Banish II"].recast_id) and bpcore:getAvailable("MA", "Banish II") then
                            helpers["queue"].add(MA["Banish II"], "me")
                            
                        -- FLASH.
                        elseif bpcore:isMAReady(MA["Flash"].recast_id) and bpcore:getAvailable("MA", "Flash") then
                            helpers["queue"].add(MA["Flash"], "t")
                        
                        end
                        
                    end
                    
                end
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() and system["Player"]["vitals"].mpp > system["PLD"]["Chivalry Threshold"] then
                    
                    if settings["AM"]:current() then
                        
                        if bpcore:buffActive(272) and system["Player"]["vitals"].tp > settings["TP THRESHOLD"] then
                            
                            if settings["SANGUINE"]:current() and system["Player"]["vitals"].hpp < system["PLD"]["Sanguine Threshold"] and bpcore:getAvailable("WS", "Sanguine Blade") then
                                helpers["queue"].addToFront(WS["Sanguine Blade"], "t")
                            
                            elseif bpcore:getAvailable("WS", settings["WSNAME"]) and system["Player"]["vitals"].tp > settings["TP THRESHOLD"] then
                                
                                if bpcore:isJAReady(JA["Sekkanoki"].recast_id) and bpcore:isJAReady(JA["Konzen-ittai"].recast_id) and bpcore:getAvailable("JA", "Sekkanoki") and bpcore:getAvailable("JA", "Konzen-ittai") then
                                    helpers['queue'].addToFront(WS[settings["SEKKA"]], "t")
                                    helpers['queue'].addToFront(JA["Konzen-ittai"], "t")
                                    helpers['queue'].addToFront(JA["Sekkanoki"], "me")
                                    
                                else
                                    helpers['queue'].addToFront(WS[settings["WSNAME"]], "t")
                                
                                end
                                
                            end
                            
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Ragnarok" and bpcore:getAvailable("WS", "Scourge") then
                            helpers['queue'].addToFront(WS["Ragnarok"], "t")
                            
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Excalibur" and bpcore:getAvailable("WS", "Knights of Round") then
                            helpers['queue'].addToFront(WS["Excalibur"], "t")
                        
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Almace" and bpcore:getAvailable("WS", "Chant du Cygne") then
                            helpers['queue'].addToFront(WS["Almace"], "t")
                        
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Caladbolg" and bpcore:getAvailable("WS", "Torcleaver") then
                            helpers['queue'].addToFront(WS["Caladbolg"], "t")
                            
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Burtgang" and bpcore:getAvailable("WS", "Atonement") then
                            helpers['queue'].addToFront(WS["Burtgang"], "t")
                            
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Sequence" and bpcore:getAvailable("WS", "Requiescat") then
                            helpers['queue'].addToFront(WS["Sequence"], "t")
                            
                        end
                        
                    elseif system["Player"]["vitals"].tp > settings["TP THRESHOLD"] then
                        
                        if settings["SANGUINE"]:current() and system["Player"]["vitals"].hpp < system["PLD"]["Sanguine Threshold"] and bpcore:getAvailable("WS", "Sanguine Blade") then
                            helpers['queue'].addToFront(WS["Sanguine Blade"], "t")
                            
                        elseif bpcore:isJAReady(JA["Sekkanoki"].recast_id) and bpcore:isJAReady(JA["Konzen-ittai"].recast_id) and bpcore:getAvailable("JA", "Sekkanoki") and bpcore:getAvailable("JA", "Konzen-ittai") then
                            helpers['queue'].addToFront(WS[settings["SEKKA"]], "t")
                            helpers['queue'].addToFront(JA["Konzen-ittai"], "t")
                            helpers['queue'].addToFront(JA["Sekkanoki"], "me")
                        
                        elseif bpcore:getAvailable("WS", settings["WSNAME"]) and system["Player"]["vitals"].tp > settings["TP THRESHOLD"] then
                            helpers['queue'].addToFront(WS[settings["WSNAME"]], "t")
                            
                        end
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- CHIVALRY.
                    if bpcore:isJAReady(JA["Chivalry"].recast_id) and bpcore:getAvailable("JA", "Chivalry") and system["Player"]["vitals"].mpp < system["PLD"]["Chivalry Threshold"] and system["Player"]["vitals"].tp > settings["CHIVALRY"]:current() then
                        helpers['queue'].add(JA["Chivalry"], "me")
                        
                    -- PALISADE.
                    elseif bpcore:isJAReady(JA["Palisade"].recast_id) and bpcore:getAvailable("JA", "Palisade") then
                        helpers['queue'].add(JA["Palisade"], "me")
                        
                    -- MAJESTY.
                    elseif bpcore:isJAReady(JA["Majesty"].recast_id) and bpcore:getAvailable("JA", "Majesty") then
                        helpers['queue'].add(JA["Majesty"], "me")
                        
                    -- SHIELD BASH.
                    elseif bpcore:isJAReady(JA["Shield Bash"].recast_id) and bpcore:getAvailable("JA", "Shield Bash") then
                        helpers['queue'].add(JA["Shield Bash"], "t")
                        
                    end
                    
                    -- /DNC.
                    if system["Player"].sub_job == "DNC" then
                        
                        -- REVERSE FLOURISH.
                        if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) and bpcore:getFinishingMoves() > 4 and bpcore:getAvailable("JA", "Reverse Flourish") then
                            helpers['queue'].add(JA["Reverse Flourish"], "me")                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    if os.clock()-system["PLD"]["Hate Timer"] > system["PLD"]["Hate Delay"] then
                    
                        -- FLASH.
                        if bpcore:isMAReady(MA["Flash"].recast_id) and bpcore:getAvailable("MA", "Flash") then
                            
                            if bpcore:isJAReady(JA["Divine Emblem"].recast_id) and bpcore:getAvailable("JA", "Divine Emblem") and not bpcore:buffActive(438) then
                                helpers['queue'].add(JA["Divine Emblem"], "me")
                                helpers['queue'].add(MA["Flash"], "t")
                                system["PLD"]["Hate Timer"] = os.clock()
                                
                            else
                                helpers['queue'].add(MA["Flash"], "t")
                                system["PLD"]["Hate Timer"] = os.clock()
                                
                            end
                        
                        -- SENTINEL.
                        elseif bpcore:isJAReady(JA["Sentinel"].recast_id) and bpcore:getAvailable("JA", "Sentinel") then
                            helpers['queue'].add(JA["Sentinel"], "me")
                            system["PLD"]["Hate Timer"] = os.clock()
                        
                        end
                            
                        -- /WAR.
                        if system["Player"].sub_job == "WAR" then
                            
                            -- PROVOKE.
                            if bpcore:isJAReady(JA["Provoke"].recast_id) and bpcore:getAvailable("JA", "Provoke") then
                                helpers['queue'].add(JA["Provoke"], "t")
                                system["PLD"]["Hate Timer"] = os.clock()
                                
                            -- WARCRY.
                            elseif bpcore:canAct() and bpcore:isJAReady(JA["Warcry"].recast_id) and not bpcore:buffActive(68) and not bpcore:buffActive(460) and bpcore:getAvailable("JA", "Warcry") then
                                helpers['queue'].add(JA["Warcry"], "me")
                                system["PLD"]["Hate Timer"] = os.clock()
                                
                            end
                        
                        -- /BLU.
                        elseif system["Player"].sub_job == "BLU" then
                            
                            
                        
                        -- /DNC.
                        elseif system["Player"].sub_job == "DNC" then
                            
                            -- ANIMATED FLOURISH.
                            if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and bpcore:getAvailable("JA", "Animated Flourish") then
                                helpers['queue'].add(JA["Animated Flourish"], "t")
                                system["PLD"]["Hate Timer"] = os.clock()
                            end
                        
                        end
                        
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    -- REPRISAL.
                    if bpcore:canCast() and bpcore:isMAReady(MA["Reprisal"].recast_id) and not bpcore:buffActive(403) and bpcore:getAvailable("MA", "Reprisal") then
                        helpers['queue'].add(MA["Reprisal"], "me")
                    
                    -- PHALANX.
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Phalanx"].recast_id) and not bpcore:buffActive(116) and bpcore:getAvailable("MA", "Phalanx") then
                        helpers['queue'].add(MA["Phalanx"], "me")
                        
                    -- CRUSADE.
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Crusade"].recast_id) and not bpcore:buffActive(116) and bpcore:getAvailable("MA", "Crusade") then
                        helpers['queue'].add(MA["Crusade"], "me")
                    
                    -- ENLIGHT.
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Enlight II"].recast_id) and not bpcore:buffActive(274) and bpcore:getAvailable("MA", "Enlight II") and settings["JOB POINTS"] > 99 then
                        helpers['queue'].add(MA["Enlight II"], "me")
                        
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Enlight"].recast_id) and not bpcore:buffActive(274) and bpcore:getAvailable("MA", "Enlight") and settings["JOB POINTS"] < 100 then
                        helpers['queue'].add(MA["Enlight"], "me")
                    
                    end
                    
                    -- /SAM.
                    if system["Player"].sub_job == "SAM" then
                        
                        -- HASSO.
                        if bpcore:canAct() and settings["HASSO MODE"]:current() and bpcore:isJAReady(JA["Hasso"].recast_id) and not bpcore:buffActive(353) and bpcore:getAvailable("JA", "Hasso") then
                            helpers['queue'].add(JA["Hasso"], "me")
                        
                        -- SEIGAN.
                        elseif bpcore:canAct() and not settings["HASSO MODE"]:current() and bpcore:isJAReady(JA["Seigan"].recast_id) and not bpcore:buffActive(354) and bpcore:getAvailable("JA", "Seigan") then
                            helpers['queue'].add(JA["Seigan"], "me")
                        
                        -- MEDITATE.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Meditate"].recast_id) and bpcore:getAvailable("JA", "Meditate") then
                            helpers['queue'].addToFront(JA["Meditate"], "me")
                        
                        -- THIRD EYE.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Third Eye"].recast_id) and not bpcore:buffActive(67) and bpcore:getAvailable("JA", "Third Eye") then
                            helpers['queue'].add(JA["Third Eye"], "me")
                        
                        end
                    
                    -- /WAR.
                    elseif system["Player"].sub_job == "WAR" then
                        
                        -- BERSERK.
                        if bpcore:canAct() and not settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Berserk"].recast_id) and not bpcore:buffActive(56) and bpcore:getAvailable("JA", "Berserk") then
                            helpers['queue'].add(JA["Berserk"], "me")
                        
                        -- DEFENDER.
                        elseif bpcore:canAct() and settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Defender"].recast_id) and not bpcore:buffActive(57) and bpcore:getAvailable("JA", "Defender") then
                            helpers['queue'].add(JA["Defender"], "me")
                            
                        -- AGGRESSOR.
                        elseif bpcore:canAct() and not settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Aggressor"].recast_id) and not bpcore:buffActive(58) and bpcore:getAvailable("JA", "Aggressor") then
                            helpers['queue'].add(JA["Aggressor"], "me")
                        
                        end
                    
                    -- /BLU.
                    elseif system["Player"].sub_job == "BLU" then

                    
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" then
                    
                        -- SAMBAS.
                        if bpcore:canAct() and bpcore:isJAReady(JA[settings["SAMBAS"]:current()].recast_id) and (not bpcore:buffActive(368) or not bpcore:buffActive(370)) and bpcore:getAvailable("JA", settings["SAMBAS"]:current()) then
                            helpers['queue'].add(JA[settings["SAMBAS"]:current()], "me")                            
                        end
                    
                    -- /NIN.
                    elseif system["Player"].sub_job == "NIN" then
                    
                        -- UTSUSEMI
                        if bpcore:canCast() and bpcore:findItemByName("Shihei", 0) then
                            
                            if not bpcore:buffActive(444) and not bpcore:buffActive(445) and not bpcore:buffActive(446) and not bpcore:buffActive(36) then
                                
                                if bpcore:isMAReady(MA["Utsusemi: Ni"].recast_id) and bpcore:getAvailable("MA", "Utsusemi: Ni") then
                                    helpers['queue'].addToFront(MA["Utsusemi: Ni"], "me")
                                    
                                elseif bpcore:isMAReady(MA["Utsusemi: Ichi"].recast_id) and bpcore:getAvailable("MA", "Utsusemi: Ichi") then
                                    helpers['queue'].addToFront(MA["Utsusemi: Ichi"], "me")
                                    
                                end
                            
                            end
                        
                        end
                    
                    end
                    
                end
                
                -- DEBUFF LOGIC.
                if settings["DEBUFFS"]:current() then
                    
                    -- /DNC.
                    if system["Player"].sub_job == "DNC" and bpcore:canAct() then
                    
                        -- STEPS.
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["PLD"]["Steps Timer"] > system["PLD"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers['queue'].add(JA[settings["STEPS"]:current()], "t")                            
                        end
                    
                    end
                    
                end
            
            -- PLAYER IS DISENGAGED LOGIC.
            elseif system["Player"].status == 0 and settings["SUPER-TANK"]:current() and helpers["target"].getTarget() and bpcore:canEngage(helpers["target"].getTarget()) then
                
                -- Determine which target is mine.
                local target = helpers["target"].getTarget()
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() and settings["RA"]:current() and bpcore:canEngage(target) then
                    
                    if not settings["AM"]:current() and system["Player"]["vitals"].tp > settings["TP THRESHOLD"] and (system["Ranged"].en == "Kaja Bow" or system["Ranged"].en == "Ullr Bow") then
                        helpers['queue'].addToFront(WS[settings["Empyreal Arrow"]], target)
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- CHIVALRY.
                    if bpcore:isJAReady(JA["Chivalry"].recast_id) and bpcore:getAvailable("JA", "Chivalry") and system["Player"]["vitals"].mpp < system["PLD"]["Chivalry Threshold"] and system["Player"]["vitals"].tp > settings["CHIVALRY"]:current() then
                        helpers['queue'].add(JA["Chivalry"], "me")
                        
                    -- PALISADE.
                    elseif bpcore:isJAReady(JA["Palisade"].recast_id) and bpcore:getAvailable("JA", "Palisade") then
                        helpers['queue'].add(JA["Palisade"], "me")
                        
                    -- MAJESTY.
                    elseif bpcore:isJAReady(JA["Majesty"].recast_id) and bpcore:getAvailable("JA", "Majesty") then
                        helpers['queue'].add(JA["Majesty"], "me")
                        
                    -- SHIELD BASH.
                    elseif bpcore:isJAReady(JA["Shield Bash"].recast_id) and bpcore:getAvailable("JA", "Shield Bash") then
                        helpers['queue'].add(JA["Shield Bash"], target)
                        
                    end
                    
                    -- /DNC.
                    if system["Player"].sub_job == "DNC" then
                        
                        -- REVERSE FLOURISH.
                        if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) and bpcore:getFinishingMoves() > 4 and bpcore:getAvailable("JA", "Reverse Flourish") then
                            helpers['queue'].add(JA["Reverse Flourish"], "me")                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    if os.clock()-system["PLD"]["Hate Timer"] > system["PLD"]["Hate Delay"] then
                    
                        -- FLASH.
                        if bpcore:isMAReady(MA["Flash"].recast_id) and bpcore:getAvailable("MA", "Flash") then
                            
                            if bpcore:isJAReady(JA["Divine Emblem"].recast_id) and bpcore:getAvailable("JA", "Divine Emblem") and not bpcore:buffActive(438) then
                                helpers['queue'].add(JA["Divine Emblem"], "me")
                                helpers['queue'].add(MA["Flash"], target)
                                system["PLD"]["Hate Timer"] = os.clock()
                                
                            else
                                helpers['queue'].add(MA["Flash"], target)
                                system["PLD"]["Hate Timer"] = os.clock()
                                
                            end
                        
                        -- SENTINEL.
                        elseif bpcore:isJAReady(JA["Sentinel"].recast_id) and bpcore:getAvailable("JA", "Sentinel") then
                            helpers['queue'].add(JA["Sentinel"], "me")
                            system["PLD"]["Hate Timer"] = os.clock()
                        
                        end
                            
                        -- /WAR.
                        if system["Player"].sub_job == "WAR" then
                            
                            -- PROVOKE.
                            if bpcore:isJAReady(JA["Provoke"].recast_id) and bpcore:getAvailable("JA", "Provoke") then
                                helpers['queue'].add(JA["Provoke"], target)
                                system["PLD"]["Hate Timer"] = os.clock()
                                
                            -- WARCRY.
                            elseif bpcore:canAct() and bpcore:isJAReady(JA["Warcry"].recast_id) and not bpcore:buffActive(68) and not bpcore:buffActive(460) and bpcore:getAvailable("JA", "Warcry") then
                                helpers['queue'].add(JA["Warcry"], "me")
                                system["PLD"]["Hate Timer"] = os.clock()
                                
                            end
                        
                        -- /BLU.
                        elseif system["Player"].sub_job == "BLU" then
                            
                            
                        
                        -- /DNC.
                        elseif system["Player"].sub_job == "DNC" then
                            
                            -- ANIMATED FLOURISH.
                            if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and bpcore:getAvailable("JA", "Animated Flourish") then
                                helpers['queue'].add(JA["Animated Flourish"], target)
                                system["PLD"]["Hate Timer"] = os.clock()
                            end
                        
                        end
                        
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    -- REPRISAL.
                    if bpcore:canCast() and bpcore:isMAReady(MA["Reprisal"].recast_id) and not bpcore:buffActive(403) and bpcore:getAvailable("MA", "Reprisal") then
                        helpers['queue'].add(MA["Reprisal"], "me")
                    
                    -- PHALANX.
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Phalanx"].recast_id) and not bpcore:buffActive(116) and bpcore:getAvailable("MA", "Phalanx") then
                        helpers['queue'].add(MA["Phalanx"], "me")
                        
                    -- CRUSADE.
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Crusade"].recast_id) and not bpcore:buffActive(116) and bpcore:getAvailable("MA", "Crusade") then
                        helpers['queue'].add(MA["Crusade"], "me")
                    
                    -- ENLIGHT II.
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Enlight II"].recast_id) and not bpcore:buffActive(274) and bpcore:getAvailable("MA", "Enlight II") and settings["JOB POINTS"] > 99 then
                        helpers['queue'].add(MA["Enlight II"], "me")
                    
                    -- ENLIGHT.
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Enlight"].recast_id) and not bpcore:buffActive(274) and bpcore:getAvailable("MA", "Enlight") and settings["JOB POINTS"] < 100 then
                        helpers['queue'].add(MA["Enlight"], "me")
                    
                    end
                    
                    -- /SAM.
                    if system["Player"].sub_job == "SAM" then
                        
                        -- HASSO.
                        if bpcore:canAct() and settings["HASSO MODE"]:current() and bpcore:isJAReady(JA["Hasso"].recast_id) and not bpcore:buffActive(353) and bpcore:getAvailable("JA", "Hasso") then
                            helpers['queue'].add(JA["Hasso"], "me")
                        
                        -- SEIGAN.
                        elseif bpcore:canAct() and not settings["HASSO MODE"]:current() and bpcore:isJAReady(JA["Seigan"].recast_id) and not bpcore:buffActive(354) and bpcore:getAvailable("JA", "Seigan") then
                            helpers['queue'].add(JA["Seigan"], "me")
                        
                        -- MEDITATE.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Meditate"].recast_id) and bpcore:getAvailable("JA", "Meditate") then
                            helpers['queue'].addToFront(JA["Meditate"], "me")
                        
                        -- THIRD EYE.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Third Eye"].recast_id) and not bpcore:buffActive(67) and bpcore:getAvailable("JA", "Third Eye") then
                            helpers['queue'].add(JA["Third Eye"], "me")
                        
                        end
                    
                    -- /WAR.
                    elseif system["Player"].sub_job == "WAR" then
                        
                        -- BERSERK.
                        if bpcore:canAct() and not settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Berserk"].recast_id) and not bpcore:buffActive(56) and bpcore:getAvailable("JA", "Berserk") then
                            helpers['queue'].add(JA["Berserk"], "me")
                        
                        -- DEFENDER.
                        elseif bpcore:canAct() and settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Defender"].recast_id) and not bpcore:buffActive(57) and bpcore:getAvailable("JA", "Defender") then
                            helpers['queue'].add(JA["Defender"], "me")
                            
                        -- AGGRESSOR.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Aggressor"].recast_id) and not bpcore:buffActive(58) and bpcore:getAvailable("JA", "Aggressor") then
                            helpers['queue'].add(JA["Aggressor"], "me")
                        
                        end
                    
                    -- /BLU.
                    elseif system["Player"].sub_job == "BLU" then

                    
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" then
                    
                        -- SAMBAS.
                        if bpcore:canAct() and bpcore:isJAReady(JA[settings["SAMBAS"]:current()].recast_id) and (not bpcore:buffActive(368) or not bpcore:buffActive(370)) and bpcore:getAvailable("JA", settings["SAMBAS"]:current()) then
                            helpers['queue'].add(JA[settings["SAMBAS"]:current()], "me")                            
                        end
                    
                    -- /NIN.
                    elseif system["Player"].sub_job == "NIN" then
                    
                        -- UTSUSEMI
                        if bpcore:canCast() and bpcore:findItemByName("Shihei", 0) then
                            
                            if not bpcore:buffActive(444) and not bpcore:buffActive(445) and not bpcore:buffActive(446) and not bpcore:buffActive(36) then
                                
                                if bpcore:isMAReady(MA["Utsusemi: Ni"].recast_id) and bpcore:getAvailable("MA", "Utsusemi: Ni") then
                                    helpers['queue'].addToFront(MA["Utsusemi: Ni"], "me")
                                    
                                elseif bpcore:isMAReady(MA["Utsusemi: Ichi"].recast_id) and bpcore:getAvailable("MA", "Utsusemi: Ichi") then
                                    helpers['queue'].addToFront(MA["Utsusemi: Ichi"], "me")
                                    
                                end
                            
                            end
                        
                        end
                    
                    end
                    
                end
                
                -- DEBUFF LOGIC.
                if settings["DEBUFFS"]:current() then
                    
                    -- /DNC.
                    if system["Player"].sub_job == "DNC" and bpcore:canAct() then
                    
                        -- STEPS.
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["PLD"]["Steps Timer"] > system["PLD"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers['queue'].add(JA[settings["STEPS"]:current()], target)                            
                        end
                    
                    end
                    
                end
                
            end
            
            -- HANDLE EVERYTHING INSIDE THE QUEUE.
            helpers['queue'].handleQueue()
        
        end
        
    end
    
    self.handleWindow = function()
        
        if display:current() then
            
            -- Build Variables.
            local enmity  = ""
            local strings = {}
            
            if helpers["target"].exists(helpers["target"].getPlayerEnmity()) and helpers["target"].exists(helpers["target"].getTarget()) then
                enmity = helpers["target"].getPlayerEnmity().name
            
            else
                enmity = "N/A"
                
            end
            
            -- Build String Table.
            table.insert(strings, ("[ HP%: "        .. bpcore:colorize(system["Player"]["vitals"].hpp, "255,51,0") .. " ]"))
            table.insert(strings, ("[ MP%: "        .. bpcore:colorize(system["Player"]["vitals"].mpp, "255,51,0") .. " ]"))
            table.insert(strings, ("[ Enmity: ("    .. bpcore:colorize(enmity, "255,51,0")                         .. ") ]"))
            
            -- Construct String.
            strings = table.concat(strings, " ")
            
            -- Update Text.
            local string = strings
                window:text(string)
                window:bg_visible(true)
                window:update()
                window:show()
                
        else
            window:bg_visible(false)
            window:update()
            window:hide()
                
        end
        
    end
    
    self.toggleDisplay = function()
        display:next()
    end
    
    self.setSetting = function(setting, value)
        name:setTo(value)
    end
    
    self.event = function(name)
        local name = name or false
        
        if name then
            local msg = string.format("TOGGLING CORE SETTING FOR EVENT: ( %s ), NOW %s.", name, tostring(settings["TOGGLED"]:current()))
            
            if name == "trash" then
                
            elseif name == "domaininvasion" then
                settings["TOGGLED"]:next()
                settings["JA"]:setTo(settings["TOGGLED"]:current())
                settings["WS"]:setTo(settings["TOGGLED"]:current())
                settings["BUFFS"]:setTo(settings["TOGGLED"]:current())
                settings["SANGUINE"]:setTo(settings["TOGGLED"]:current())
                helpers["controls"].setEnabled(settings["TOGGLED"]:current())
                helpers["trust"].setEnabled(settings["TOGGLED"]:current())
                
            end
            
            local msg = string.format("TOGGLING CORE SETTING FOR EVENT: ( %s ), NOW %s.", name, tostring(settings["TOGGLED"]:current()))
            helpers['popchat']:pop((msg):upper(), system["Popchat Window"])
            
        end
        
    end
    
    return self
    
end

return core.get()