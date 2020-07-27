--------------------------------------------------------------------------------
-- COR Core: Handle all job automation for Corsair.
--------------------------------------------------------------------------------
local core = {}

-- CORE AUTOMATED FUNCTION FOR THIS JOB.
function core.get()
    self = {}
    
    -- MASTER SETTINGS.
    local settings = {}
    settings["AM"]                                 = I{false,true}
    settings["AM THRESHOLD"]                       = I{3000,2000,1000}
    settings["1HR"]                                = I{false,true}
    settings["JA"]                                 = I{false,true}
    settings["RA"]                                 = I{false,true}
    settings["CURES"]                              = I{1,2,3}
    settings["SUBLIMATION"]                        = I{true,false}
    settings["HATE"]                               = I{false,true}
    settings["BUFFS"]                              = I{false,true}
    settings["DEBUFFS"]                            = I{false,true}
    settings["STATUS"]                             = I{false,true}
    settings["WS"]                                 = I{false,true}
    settings["WSNAME"]                             = "Fast Blade"
    settings["RANGED WS"]                          = "Leaden Salute"
    settings["TP THRESHOLD"]                       = 1000
    settings["SC"]                                 = I{false,true}
    settings["BURST"]                              = I{false,true}
    settings["ELEMENT"]                            = I{"Fire","Ice","Wind","Earth","Lightning","Water","Light","Dark","Random"}
    settings["TIER"]                               = I{"I","II","III","IV","V","Random"}
    settings["ALLOW-AOE"]                          = I{false,true}
    settings["DRAINS"]                             = I{false,true}
    settings["STUNS"]                              = I{false,true}
    settings["TANK MODE"]                          = I{false,true}
    settings["SUPER-TANK"]                         = I{false,true}
    settings["SEKKA"]                              = "Resolution"
    settings["SHADOWS"]                            = I{false,true}
    settings["FOOD"]                               = I{"Sublime Sushi","Sublime Sushi +1"}
    settings["SAMBAS"]                             = I{"Drain Samba II","Haste Samba"}
    settings["STEPS"]                              = I{"Quickstep","Box Step","Stutter Step"}
    settings["RUNES"]                              = {rune1="",rune2="",rune3=""}
    settings["RUNE1"]                              = I{"Lux","Tenebrae","Unda","Ignis","Gelus","Flabra","Tellus","Sulpor"}
    settings["RUNE2"]                              = I{"Lux","Tenebrae","Unda","Ignis","Gelus","Flabra","Tellus","Sulpor"}
    settings["RUNE3"]                              = I{"Lux","Tenebrae","Unda","Ignis","Gelus","Flabra","Tellus","Sulpor"}
    settings["SKILLUP"]                            = I{false,true}
    settings["SKILLS"]                             = I{"Enhancing"}
    settings["COMPOSURE"]                          = I{true,false}
    settings["CONVERT"]                            = I{true,false}
    settings["ENSPELL"]                            = I{"Enfire","Enblizzard","Enaero","Enstone","Enthunder","Enwater"}
    settings["GAINS"]                              = I{"Gain-DEX","Gain-STR","Gain-MND","Gain-INT","Gain-AGI","Gain-VIT","Gain-CHR"}
    settings["SPIKES"]                             = I{"None","Blaze Spikes","Ice Spikes","Shock Spikes"}
    settings["DIA"]                                = I{"Dia","Bio"}
    settings["SANGUINE"]                           = I{false,true}
    settings["REPEAT"]                             = I{false,true}
    settings["LAST REPEAT"]                        = os.clock()
    settings["ROLL"]                               = I{false,true}
    settings["QD"]                                 = I{false,true}
    settings["SHOTS"]                              = I{"Fire Shot","Ice Shot","Wind Shot","Earth Shot","Thunder Shot","Water Shot","Light Shot","Dark Shot"}
    settings["ROLL1"]                              = false
    settings["ROLL2"]                              = false
    settings["INDI"]                               = I{false,true}
    settings["GEO"]                                = I{false,true}
    settings["ENTRUST"]                            = I{false,true}
    settings["ISPELL"]                             = ""
    settings["GSPELL"]                             = ""
    settings["ESPELL"]                             = ""
    settings["ETARGET"]                            = system["Main Character"]
    settings["BUBBLE BUFF"]                        = I{"Ecliptic Attrition","Lasting Emanation"}
    settings["BOOST"]                              = I{false,true}
    settings["PET"]                                = I{false,true}
    settings["SPIRITS"]                            = T{"Light Spirit","Fire Spirirt","Ice Spirit","Air Spirit","Earth Spirit","Thunder Spirit","Water Spirit","Dark Spirit"}
    settings["SUMMON"]                             = I{"Carbuncle","Cait Sith","Ifrit","Shiva","Garuda","Titan","Ramuh","Leviathan","Fenrir","Diabolos","Siren"}
    settings["BPRAGE"]                             = I{false,true}
    settings["BPWARD"]                             = I{false,true}
    settings["AUTO SIC"]                           = I{false,true}
    settings["AOEHATE"]                            = I{false,true}
    settings["EMBOLDEN"]                           = I{"Palanx","Temper","Regen IV"}
    settings["BLU MODE"]                           = I{"DPS","NUKE"}
    settings["MIGHTY GUARD"]                       = I{true,false}
    settings["CHIVALRY"]                           = I{1000,1500,2000,2500,3000}
    settings["WEATHER"]                            = I{"Firestorm","Hailstorm","Windstorm","Sandstorm","Thunderstorm","Rainstorm","Voidstorm","Aurorastorm"}
    settings["ARTS"]                               = I{1,2,3}
    settings["MISERY"]                             = I{false,true}
    settings["IMPETUS WS"]                         = "Raging Fists"
    settings["FOORWORK WS"]                        = "Tornado Kick"
    settings["DEFAULT WS"]                         = "Howling Fist"
    
    -- DEBUFFS.
    settings["SPELLS"]={}
    
    -- MAGIC BURST.
    settings["MAGIC BURST"]={
        
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
        ['bg']={['alpha']=200,['red']=0,['green']=0,['blue']=0,['visible']=false},
        ['flags']={['right']=false,['bottom']=false,['bold']=false,['draggable']=system["Job Draggable"],['italic']=false},
        ['padding']=system["Job Padding"],
        ['text']={['size']=system["Job Font"].size,['font']=system["Job Font"].font,['fonts']={},['alpha']=system["Job Font"].alpha,['red']=system["Job Font"].r,['green']=system["Job Font"].g,['blue']=system["Job Font"].b,
            ['stroke']={['width']=system["Job Stroke"].width,['alpha']=system["Job Stroke"].alpha,['red']=system["Job Stroke"].r,['green']=system["Job Stroke"].g,['blue']=system["Job Stroke"].b}
        },
    }

    local window = texts.new(windower.ffxi.get_player().main_job_full, display_settings)
    
    -- HANDLE PARTY CHAT COMMANDS
    self.handleChat = function(message, sender, mode, gm)
        
        if (mode == 3 or mode == 4) then
            local player   = windower.ffxi.get_player() or false
            local accounts = T(system["Controllers"])
            
            if (accounts):contains(sender) then
                local commands = message:split(" ")
                
                if commands[1] and player and player.name:lower():match(commands[1]) then
                    
                end
                
            else
                
            end
            
        end
        
    end
    
    -- HANDLE CORE JOB COMMANDS.
    self.handleCommands = function(commands)
        local command = commands[1] or false
        
        if command and type(command) == "string" then
            local command = command:lower()
            local message = ""
            
            if command == "roll" then
                settings["ROLL"]:next()
                message = string.format("AUTO-ROLLING: %s", tostring(settings["ROLL"]:current()))
            
            elseif command == "roll1" then
                local name = commands[2] or false
                
                if name and helpers["rolls"].getRoll(name) then
                    
                    if settings["ROLL2"] and helpers["rolls"].getRoll(name).en ~= settings["ROLL2"].en then
                        settings["ROLL1"] = helpers["rolls"].getRoll(name)
                        message = string.format("ROLL #1 IS NOW SET TO: %s", tostring(settings["ROLL1"].en))
                        
                    elseif not settings["ROLL2"] then
                        settings["ROLL1"] = helpers["rolls"].getRoll(name)
                        message = string.format("ROLL #1 IS NOW SET TO: %s", tostring(settings["ROLL1"].en))
                        
                    end
                    
                end
                
            elseif command == "roll2" then
                local name = commands[2] or false
                
                if name and helpers["rolls"].getRoll(name) then
                    
                    if settings["ROLL1"] and helpers["rolls"].getRoll(name).en ~= settings["ROLL1"].en then
                        settings["ROLL2"] = helpers["rolls"].getRoll(name)
                        message = string.format("ROLL #2 IS NOW SET TO: %s", tostring(settings["ROLL2"].en))
                        
                    elseif not settings["ROLL1"] then
                        settings["ROLL2"] = helpers["rolls"].getRoll(name)
                        message = string.format("ROLL #2 IS NOW SET TO: %s", tostring(settings["ROLL2"].en))
                        
                    end
                    
                end
                
            elseif command == "ambuscade" then
                message = ("AMBUSCADE SETTINGS ENABLED!")
                settings["HATE"]:setTo(false)
                settings["BUFFS"]:setTo(true)
                settings["JA"]:setTo(true)
                settings["WS"]:setTo(true)
                settings["ROLL"]:setTo(true)
                settings["WSNAME"] = "Fast Blade"
                helpers["controls"].setEnabled(true)
                
                -- SET ROLLS.
                settings["ROLL1"] = res.job_abilities["Fighter's Roll"]
                settings["ROLL2"] = res.job_abilities["Samurai's Roll"]
                
                if bpcore:isLeader() and windower.ffxi.get_party().party1_count < 6 then
                    helpers["trust"].setEnabled(true)
                end
                
            elseif command == "disable" then
                message = ("SETTINGS DISABLED!")
                settings["HATE"]:setTo(false)
                settings["BUFFS"]:setTo(false)
                settings["JA"]:setTo(false)
                settings["WS"]:setTo(false)
                settings["ROLL"]:setTo(false)
                helpers["controls"].setEnabled(true)
                helpers["trust"].setEnabled(false)
                
            end
            
            if message ~= "" then
                helpers['popchat']:pop(message:upper() or ("INVALID COMANDS"):upper(), system["Popchat Window"])
            end
            
        end
        
        -- HANDLE GLOBAL COMMANDS.
        helpers["corecommands"].handle(commands)
        
    end
    
    -- HANDLE ITEM LOGIC.
    self.handleItems = function()
        
        if bpcore:canItem() and bpcore:checkReady() and not system["Midaction"] then
            
            if bpcore:buffActive(15) then
                
                if bpcore:findItemByName("Holy Water") and not helpers["queue"].inQueue(IT["Holy Water"], "me") then
                    helpers["queue"].add(IT["Holy Water"], "me")
                
                elseif bpcore:findItemByName("Hallowed Water") and not helpers["queue"].inQueue(IT["Hallowed Water"], "me") then
                    helpers["queue"].add(IT["Hallowed Water"], "me")
                    
                end
            
            elseif bpcore:buffActive(6) then
                
                if bpcore:findItemByName("Echo Drops") and not helpers["queue"].inQueue(IT["Echo Drops"], "me") then
                    helpers["queue"].add(IT["Echo Drops"], "me")
                end
                
            end
        
        end
        
    end
    
    self.handleAutomation = function()
        
        -- Handle items.
        system["Core"].handleItems()
        
        if bpcore:checkReady() and not helpers["actions"].getMoving() and system["BP Enabled"]:current() then
            local player  = windower.ffxi.get_player() or false
            local current = helpers["queue"].getNextAction() or false
            local rolling = helpers["rolls"].getRolling()
            
            -- Determine how to handle status debuffs.
            if settings["STATUS"]:current() then
                helpers["status"].manangeStatuses()
            end
            
            -- PLAYER IS ENGAGED.
            if player.status == 1 then
                local target = helpers["target"].getTarget() or windower.ffxi.get_mob_by_target("t") or false
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() then
                    
                    if settings["AM"]:current() then
                        
                        if bpcore:buffActive(272) and system["Player"]["vitals"].tp > settings["TP THRESHOLD"] then
                            
                            if bpcore:getAvailable("WS", settings["WSNAME"]) and system["Player"]["vitals"].tp > settings["TP THRESHOLD"] then
                                
                                if settings["BOOST"]:current() and bpcore:isJAReady(JA["Boost"].recast_id) and bpcore:getAvailable("JA", "Boost") then
                                    helpers['queue'].addToFront(WS[settings["WSNAME"]], "t")
                                    helpers['queue'].addToFront(JA["Boost"], "me")
                                    
                                else
                                    helpers['queue'].addToFront(WS[settings["WSNAME"]], "t")
                                
                                end
                                
                            end
                            
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Spharai" and bpcore:getAvailable("WS", "Final Heaven") then
                            helpers['queue'].addToFront(WS["Final Heaven"], "t")
                            
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Verethragna" and bpcore:getAvailable("WS", "Victory Smite") then
                            helpers['queue'].addToFront(WS["Victory Smite"], "t")
                            
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Glanzfaust" and bpcore:getAvailable("WS", "Ascetic's Fury") then
                            helpers['queue'].addToFront(WS["Ascetic's Fury"], "t")
                            
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Godhands" and bpcore:getAvailable("WS", "Shijin Spiral") then
                            helpers['queue'].addToFront(WS["Shijin Spiral"], "t")
                            
                        end
                        
                    elseif bpcore:getAvailable("WS", settings["WSNAME"]) and system["Player"]["vitals"].tp > settings["TP THRESHOLD"] then
                        helpers['queue'].addToFront(WS[settings["WSNAME"]], "t")
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- CHAKRA.
                    if bpcore:isJAReady(JA["Chakra"].recast_id) and bpcore:getAvailable("JA", "Chakra") and system["Player"]["vitals"].hpp < system["MNK"]["Chakra Threshold"] then
                        helpers['queue'].add(JA["Chakra"], "me")                            
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
                        
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" then
                        
                        -- PROVOKE.
                        if bpcore:isJAReady(JA["Provoke"].recast_id) and bpcore:getAvailable("JA", "Provoke") then
                            helpers['queue'].add(JA["Provoke"], "t")                            
                        end
                    
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and bpcore:getAvailable("JA", "Animated Flourish") then
                            helpers['queue'].add(JA["Animated Flourish"], "t")                            
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    --ROLLS.
                    
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" then
                        
                        -- BERSERK.
                        if bpcore:canAct() and bpcore:isJAReady(JA["Berserk"].recast_id) and not bpcore:buffActive(56) and bpcore:getAvailable("JA", "Berserk") then
                            helpers['queue'].add(JA["Berserk"], "me")
                            
                        -- AGGRESSOR.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Aggressor"].recast_id) and not bpcore:buffActive(58) and bpcore:getAvailable("JA", "Aggressor") then
                            helpers['queue'].add(JA["Aggressor"], "me")
                        
                        -- WARCRY.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Warcry"].recast_id) and not bpcore:buffActive(68) and not bpcore:buffActive(460) and bpcore:getAvailable("JA", "Warcry") then
                            helpers['queue'].add(JA["Warcry"], "me")
                        
                        end
                    
                    -- /SAM.
                    elseif system["Player"].sub_job == "SAM" then
                        
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
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["WAR"]["Steps Timer"] > system["WAR"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers['queue'].add(JA[settings["STEPS"]:current()], "t")                            
                        end
                    
                    end
                    
                end
            
            -- PLAYER IS DISENGAGED LOGIC.
            elseif (player.status == 0 or settings["SUPER-TANK"]:current()) then
                local target = helpers["target"].getTarget()
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- CHAKRA.
                    if bpcore:isJAReady(JA["Chakra"].recast_id) and bpcore:getAvailable("JA", "Chakra") and system["Player"]["vitals"].hpp < system["MNK"]["Chakra Threshold"] then
                        helpers['queue'].add(JA["Chakra"], "me")                            
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
                        
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" then
                        
                        -- PROVOKE.
                        if bpcore:isJAReady(JA["Provoke"].recast_id) and bpcore:getAvailable("JA", "Provoke") then
                            helpers['queue'].add(JA["Provoke"], target)                            
                        end
                    
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and bpcore:getAvailable("JA", "Animated Flourish") then
                            helpers['queue'].add(JA["Animated Flourish"], target)
                        end
                    
                    end
                    
                end
                
                -- CORSAIR ROLLS.
                if settings["ROLL"]:current() and bpcore:canAct() and settings["ROLL1"] and settings["ROLL2"] and bpcore:isJAReady(JA["Phantom Roll"].recast_id) and not bpcore:buffActive(308) and bpcore:getAvailable("JA", "Phantom Roll") then
                    local lucky1 = helpers["rolls"].getLucky(settings["ROLL1"].en)
                    local lucky2 = helpers["rolls"].getLucky(settings["ROLL2"].en)
                    
                    -- CHECK IF YOU NEED TO FOLD BEFOR ATTEMPTING TO ROLL, AND RESET ROLL NUMBER.
                    if bpcore:isJAReady(JA["Fold"].recast_id) and bpcore:buffActive(309) and bpcore:getAvailable("JA", "Fold") then
                        helpers['queue'].add(JA["Fold"], "me")
                        helpers["rolls"].setRolling("", 0)
                        
                    end
                    
                    -- MAKE SURE THAT THIS IS THE FIRST ROLL WHEN USING PHANTOM ROLL.
                    if rolling.dice == 0 then
                        
                        if not helpers["rolls"].findBuff(settings["ROLL1"].en:sub(1, 4)) then
                            
                            -- IF CROOKED IS READY USE ONLY ON THE FIRST ROLL SLOT.
                            if bpcore:isJAReady(JA["Crooked Cards"].recast_id) and not bpcore:buffActive(601) and bpcore:getAvailable("JA", "Crooked Cards") then
                                helpers['queue'].add(JA["Crooked Cards"], "me")
                                helpers['queue'].add(JA[settings["ROLL1"].en], "me")
                                
                            else
                                helpers['queue'].add(JA[settings["ROLL1"].en], "me")
                                
                            end
                            
                        
                        elseif not helpers["rolls"].findBuff(settings["ROLL2"].en:sub(1, 4)) then
                            helpers['queue'].add(JA[settings["ROLL2"].en], "me")
                            
                        end
                        
                    end
                    
                elseif settings["ROLL"]:current() and bpcore:canAct() and bpcore:isJAReady(JA["Double-Up"].recast_id) and bpcore:buffActive(308) and bpcore:getAvailable("JA", "Double-Up") then
                    local lucky1 = helpers["rolls"].getLucky(settings["ROLL1"].en)
                    local lucky2 = helpers["rolls"].getLucky(settings["ROLL2"].en)
                    
                    -- CHECK IF YOU NEED TO FOLD BEFOR ATTEMPTING TO ROLL, AND RESET ROLL NUMBER.
                    if bpcore:isJAReady(JA["Fold"].recast_id) and bpcore:buffActive(309) and bpcore:getAvailable("JA", "Fold") then
                        helpers['queue'].add(JA["Fold"], "me")
                        helpers["rolls"].setRolling("", 0)
                        
                    end
                    
                    -- ONLY DOUBLE-UP IF THIS ISNT THE FIRST ROLL, AND THE ROLL IS LESS THAN 7.
                    if rolling.dice > 0 and rolling.dice < 7 then
                        
                        -- DONT ROLL IF ON A LUCKY!
                        if rolling.dice ~= lucky1 and settings["ROLL1"].en == rolling.name then
                            helpers['queue'].add(JA["Double-Up"], "me")
                        
                        elseif rolling.dice ~= lucky2 and settings["ROLL2"].en == rolling.name then
                            helpers['queue'].add(JA["Double-Up"], "me")
                            
                        end
                    
                    -- ONLY SNAKE EYE IF THIS ISNT THE FIRST ROLL, AND THE ROLL IS GREATER THAN 6.
                    elseif rolling.dice > 6 and bpcore:isJAReady(JA["Snake Eye"].recast_id) and not bpcore:buffActive(357) and bpcore:getAvailable("JA", "Snake Eye") then
                        
                        -- DONT ROLL IF ON A LUCKY!
                        if rolling.dice ~= lucky1 and settings["ROLL1"].en == rolling.name then
                            helpers['queue'].add(JA["Snake Eye"], "me")
                            helpers['queue'].add(JA["Double-Up"], "me")
                        
                        elseif rolling.dice ~= lucky2 and settings["ROLL2"].en == rolling.name then
                            helpers['queue'].add(JA["Snake Eye"], "me")
                            helpers['queue'].add(JA["Double-Up"], "me")
                            
                        end
                        
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    -- /SAM.
                    if system["Player"].sub_job == "SAM" and bpcore:canAct() then
                        
                        -- MEDITATE.
                        if bpcore:isJAReady(JA["Meditate"].recast_id) and bpcore:getAvailable("JA", "Meditate") then
                            helpers['queue'].addToFront(JA["Meditate"], "me")
                        
                        -- THIRD EYE.
                        elseif bpcore:isJAReady(JA["Third Eye"].recast_id) and not bpcore:buffActive(67) and bpcore:getAvailable("JA", "Third Eye") then
                            helpers['queue'].add(JA["Third Eye"], "me")
                        
                        end
                    
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" and bpcore:canAct() then
                    
                        -- SAMBAS.
                        if bpcore:isJAReady(JA[settings["SAMBAS"]:current()].recast_id) and (not bpcore:buffActive(368) or not bpcore:buffActive(370)) and bpcore:getAvailable("JA", settings["SAMBAS"]:current()) then
                            helpers['queue'].add(JA[settings["SAMBAS"]:current()], "me")                            
                        end
                    
                    -- /NIN.
                    elseif system["Player"].sub_job == "NIN" and bpcore:canCast() then
                    
                        -- UTSUSEMI
                        if bpcore:findItemByName("Shihei", 0) then
                            
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
                    if system["Player"].sub_job == "DNC" and bpcore:canAct() and bpcore:canEngage(helpers["target"].getTarget()) then
                    
                        -- STEPS.
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["WAR"]["Steps Timer"] > system["WAR"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers['queue'].add(JA[settings["STEPS"]:current()], target)                            
                        end
                    
                    end
                    
                end
            
            end
            
            -- HANDLE ALL CURING.
            if settings["CURES"]:current() == 2 and (player.sub_job == "WHM" or player.sub_job == "RDM" or player.sub_job == "SCH") then
                helpers["cures"].handleParty()
                
            elseif settings["CURES"]:current() == 3 and (player.sub_job == "WHM" or player.sub_job == "RDM" or player.sub_job == "SCH") then
                helpers["cures"].handleParty()
                helpers["cures"].handleAlliance()
            end
            
            -- HANDLE EVERYTHING INSIDE THE QUEUE.
            helpers["cures"].handleCuring()
            helpers['queue'].handleQueue()
        
        end
        
    end
    
    self.handleWindow = function()
        
        if display:current() then
            
            -- Build Variables.
            local enmity  = ""
            local attacks = ""
            local strings = {}
            
            if helpers["target"].getPlayerEnmity() and windower.ffxi.get_player().in_combat then
                enmity = helpers["target"].getPlayerEnmity().name
            else
                enmity = "N/A"
            end
            
            if bpcore:buffActive(406) then
                attacks = "Foorwork Activated"
            elseif bpcore:buffActive(461) then
                attacks = "Impetus Activated"
            else
                attacks = "Normal Stance"
            end
                
            
            -- Build String Table.
            table.insert(strings, ("[ HP%: "        .. bpcore:colorize(system["Player"]["vitals"].hpp, "255,51,0") .. " ]"))
            table.insert(strings, ("[ Mode: "       .. bpcore:colorize(attacks, "255,51,0")                        .. " ]"))
            table.insert(strings, ("[ Enmity: ("    .. bpcore:colorize(enmity, "255,51,0")                         .. ") ]"))
            
            -- Construct String.
            strings = table.concat(strings, " ")
            
            -- Update Text.
            local string = strings
                window:text(string)
                window:bg_visible(true)
                window:update()
                window:show()
                
        elseif not display:current() and window:visible() then
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
    
    self.toggleDisplay = function()
        display:next()
    end
    
    self.getDisplay = function()
        return display:current()
    end
    
    self.next = function(name)
        local name = name or false
        
        if name then
            settings[name]:next()
        end
        
    end
    
    self.current = function(name)
        local name = name or false
        
        if name then        
            return settings[name]:current()
        end
        
    end
    
    self.set = function(name, value)
        local name, value = name or false, value or false
        
        if name and value then
            settings[name]:setTo(value)
        end
        
    end
    
    self.value = function(name, value)
        local name, value = name or false, value or false
        
        if name and value then
            settings[name] = (value)
        end
        
    end
    
    self.get = function(name)
        local name = name or false
        
        if name then        
            return settings[name]
        end
        
    end
    
    self.getSettings = function()
        return settings
    end
    
    return self
    
end

return core.get()