--------------------------------------------------------------------------------
-- WAR Core: Handle all job automation for Warrior.
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
    settings["WSNAME"]                             = "Resolution"
    settings["RANGED WS"]                          = "Empyreal Arrow"
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
    settings["SPELLS"]={
        
        ["Full Break"] = {["allowed"]=0,["delay"]=180},
        
    }
    
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
            
            if command == "ambuscade" then
                settings["HATE"]:setTo(true)
                settings["BUFFS"]:setTo(true)
                settings["JA"]:setTo(true)
                settings["WS"]:setTo(true)
                settings["WSNAME"] = "Penta Thrust"
                helpers["controls"].setEnabled(true)
                
                if bpcore:isLeader() and windower.ffxi.get_party().party1_count < 6 then
                    helpers["trust"].setEnabled(true)
                end
                
            elseif command == "disable" then
                settings["HATE"]:setTo(true)
                settings["BUFFS"]:setTo(false)
                settings["JA"]:setTo(true)
                settings["WS"]:setTo(true)
                settings["WSNAME"] = "Penta Thrust"
                helpers["controls"].setEnabled(true)
                helpers["trust"].setEnabled(false)
                
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
                        
                        if bpcore:buffActive(272) and player["vitals"].tp > settings["TP THRESHOLD"] then
                            
                            if settings["SANGUINE"]:current() and player["vitals"].hpp < system["WAR"]["Sanguine Threshold"] and bpcore:getAvailable("WS", "Sanguine Blade") then
                                helpers["queue"].addToFront(WS["Sanguine Blade"], "t")
                                
                            elseif settings["DEBUFFS"]:current() and os.clock()-settings["SPELLS"]["Full Break"].allowed > settings["SPELLS"]["Full Break"].delay and bpcore:getAvailable("WS", "Full Break") then
                                helpers["queue"].addToFront(WS["Full Break"], target)
                                settings["SPELLS"]["Full Break"].allowed = os.clock()
                                settings["SPELLS"]["Full Break"].delay = ( (player["vitals"].tp * 120 ) / 1000 )
                            
                            elseif bpcore:getAvailable("WS", settings["WSNAME"]) then
                                
                                if bpcore:isJAReady(JA["Sekkanoki"].recast_id) and bpcore:getAvailable("JA", "Sekkanoki") then
                                    helpers['queue'].addToFront(WS[settings["SEKKA"]], "t")
                                    helpers['queue'].addToFront(JA["Sekkanoki"], "me")
                                
                                else
                                    helpers['queue'].addToFront(WS[settings["WSNAME"]], "t")
                                    
                                    if bpcore:isJAReady(JA["Warrior's Charge"].recast_id) and bpcore:getAvailable("JA", "Warrior's Charge") then
                                        helpers['queue'].addToFront(JA["Warrior's Charge"], "me")
                                    end    
                                
                                end
                            
                            end
                            
                        elseif not bpcore:buffActive(272) and player["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Ragnarok" and bpcore:getAvailable("WS", "Scourge") then
                            helpers['queue'].addToFront(WS["Scourge"], "t")
                            
                        elseif not bpcore:buffActive(272) and player["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Bravura" and bpcore:getAvailable("WS", "Metatron Torment") then
                            helpers['queue'].addToFront(WS["Metatron Torment"], "t")
                        
                        elseif not bpcore:buffActive(272) and player["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Farsha" and bpcore:getAvailable("WS", "Cloudsplitter") then
                            helpers['queue'].addToFront(WS["Cloudsplitter"], "t")
                        
                        elseif not bpcore:buffActive(272) and player["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Ukonvasara" and bpcore:getAvailable("WS", "Ukko's Fury") then
                            helpers['queue'].addToFront(WS["Ukko's Fury"], "t")
                            
                        elseif not bpcore:buffActive(272) and player["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Conqueror" and bpcore:getAvailable("WS", "King's Justice") then
                            helpers['queue'].addToFront(WS["King's Justice"], "t")
                            
                        elseif not bpcore:buffActive(272) and player["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Chango" and bpcore:getAvailable("WS", "Upheaval") then
                            helpers['queue'].addToFront(WS["Upheaval"], "t")
                            
                        end
                        
                    elseif player["vitals"].tp > settings["TP THRESHOLD"] then
                        
                        if settings["SANGUINE"]:current() and player["vitals"].hpp < system["WAR"]["Sanguine Threshold"] and bpcore:getAvailable("WS", "Sanguine Blade") then
                                helpers["queue"].addToFront(WS["Sanguine Blade"], "t")
                                
                        elseif settings["DEBUFFS"]:current() and os.clock()-settings["SPELLS"]["Full Break"].allowed > settings["SPELLS"]["Full Break"].delay and bpcore:getAvailable("WS", "Full Break") then
                            helpers["queue"].addToFront(WS["Full Break"], "t")
                            settings["SPELLS"]["Full Break"].allowed = os.clock()
                            settings["SPELLS"]["Full Break"].delay = ( (player["vitals"].tp * 120 ) / 1000 )
                        
                        elseif bpcore:getAvailable("WS", settings["WSNAME"]) then
                            
                            if bpcore:isJAReady(JA["Sekkanoki"].recast_id) and bpcore:getAvailable("JA", "Sekkanoki") then
                                helpers['queue'].addToFront(WS[settings["SEKKA"]], "t")
                                helpers['queue'].addToFront(JA["Sekkanoki"], "me")
                            
                            else
                                helpers['queue'].addToFront(WS[settings["WSNAME"]], "t")
                                
                                if bpcore:isJAReady(JA["Warrior's Charge"].recast_id) and bpcore:getAvailable("JA", "Warrior's Charge") then
                                    helpers['queue'].addToFront(JA["Warrior's Charge"], "me")
                                end    
                            
                            end
                            
                        end
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- /DNC.
                    if player.sub_job == "DNC" then
                        
                        -- REVERSE FLOURISH.
                        if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) and bpcore:getFinishingMoves() > 4 and bpcore:getAvailable("JA", "Reverse Flourish") then
                            helpers['queue'].add(JA["Reverse Flourish"], "me")                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                        
                    -- PROVOKE.
                    if bpcore:isJAReady(JA["Provoke"].recast_id) and bpcore:getAvailable("JA", "Provoke") then
                        helpers['queue'].add(JA["Provoke"], "t")                            
                    end
                        
                    -- /DNC.
                    if player.sub_job == "DNC" then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and bpcore:getAvailable("JA", "Animated Flourish") then
                            helpers['queue'].add(JA["Animated Flourish"], "t")                            
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    -- BERSERK.
                    if bpcore:canAct() and not settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Berserk"].recast_id) and not bpcore:buffActive(56) and bpcore:getAvailable("JA", "Berserk") then
                        helpers['queue'].add(JA["Berserk"], "me")
                    
                    -- DEFENDER.
                    elseif bpcore:canAct() and settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Defender"].recast_id) and not bpcore:buffActive(57) and bpcore:getAvailable("JA", "Defender") then
                        helpers['queue'].add(JA["Defender"], "me")
                        
                    -- AGGRESSOR.
                    elseif bpcore:canAct() and bpcore:isJAReady(JA["Aggressor"].recast_id) and not bpcore:buffActive(58) and bpcore:getAvailable("JA", "Aggressor") then
                        helpers['queue'].add(JA["Aggressor"], "me")
                    
                    -- RETALIATION.
                    elseif bpcore:canAct() and bpcore:isJAReady(JA["Retaliation"].recast_id) and not bpcore:buffActive(405) and bpcore:getAvailable("JA", "Retaliation") then
                        helpers['queue'].add(JA["Retaliation"], "me")
                    
                    -- WARCRY.
                    elseif bpcore:canAct() and bpcore:isJAReady(JA["Warcry"].recast_id) and not bpcore:buffActive(68) and not bpcore:buffActive(460) and bpcore:getAvailable("JA", "Warcry") then
                        helpers['queue'].add(JA["Warcry"], "me")
                        
                    -- BLOOD RAGE.
                    elseif bpcore:canAct() and bpcore:isJAReady(JA["Blood Rage"].recast_id) and not bpcore:buffActive(68) and not bpcore:buffActive(460) and bpcore:getAvailable("JA", "Blood Rage") then
                        helpers['queue'].add(JA["Blood Rage"], "me")
                        
                    -- RESTRAINT.
                    elseif bpcore:canAct() and bpcore:isJAReady(JA["Restraint"].recast_id) and not bpcore:buffActive(435) and bpcore:getAvailable("JA", "Restraint") then
                        helpers['queue'].add(JA["Restraint"], "me")
                        
                    -- MIGHTY STRIKES.
                    elseif bpcore:canAct() and bpcore:isJAReady(JA["Mighty Strikes"].recast_id) and not bpcore:buffActive(44) and not bpcore:buffActive(490) and bpcore:getAvailable("JA", "Mighty Strikes") and settings["1HR"]:current() then
                        helpers['queue'].add(JA["Mighty Strikes"], "me")
                        
                    -- BRAZEN RUSH.
                    elseif bpcore:canAct() and bpcore:isJAReady(JA["Brazen Rush"].recast_id) and not bpcore:buffActive(44) and not bpcore:buffActive(490) and bpcore:getAvailable("JA", "Brazen Rush") and settings["1HR"]:current() then
                        helpers['queue'].add(JA["Brazen Rush"], "me")
                    
                    end
                    
                    -- /SAM.
                    if player.sub_job == "SAM" then
                        
                        -- HASSO.
                        if bpcore:canAct() and settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Hasso"].recast_id) and not bpcore:buffActive(353) and bpcore:getAvailable("JA", "Hasso") then
                            helpers['queue'].add(JA["Hasso"], "me")
                        
                        -- SEIGAN.
                        elseif bpcore:canAct() and not settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Seigan"].recast_id) and not bpcore:buffActive(354) and bpcore:getAvailable("JA", "Seigan") then
                            helpers['queue'].add(JA["Seigan"], "me")
                        
                        -- MEDITATE.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Meditate"].recast_id) and bpcore:getAvailable("JA", "Meditate") then
                            helpers['queue'].addToFront(JA["Meditate"], "me")
                        
                        -- THIRD EYE.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Third Eye"].recast_id) and not bpcore:buffActive(67) and bpcore:getAvailable("JA", "Third Eye") then
                            helpers['queue'].add(JA["Third Eye"], "me")
                        
                        end
                    
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                    
                        -- SAMBAS.
                        if bpcore:canAct() and bpcore:isJAReady(JA[settings["SAMBAS"]:current()].recast_id) and (not bpcore:buffActive(368) or not bpcore:buffActive(370)) and bpcore:getAvailable("JA", settings["SAMBAS"]:current()) then
                            helpers['queue'].add(JA[settings["SAMBAS"]:current()], "me")                            
                        end
                    
                    -- /NIN.
                    elseif player.sub_job == "NIN" then
                    
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
                    if player.sub_job == "DNC" and bpcore:canAct() then
                    
                        -- STEPS.
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["WAR"]["Steps Timer"] > system["WAR"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers['queue'].add(JA[settings["STEPS"]:current()], "t")                            
                        end
                    
                    end
                    
                end
            
            -- PLAYER IS DISENGAGED LOGIC.
            elseif (player.status == 0 or settings["SUPER-TANK"]:current()) and helpers["target"].isEnemy(helpers["target"].getTarget()) then
                local target = helpers["target"].getTarget()
                
                -- Determine which target is mine.
                local target = helpers["target"].getTarget()
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() and settings["RA"]:current() and bpcore:canEngage(helpers["target"].getTarget()) then
                    
                    if not settings["AM"]:current() and player["vitals"].tp > settings["TP THRESHOLD"] and (system["Ranged"].en == "Kaja Bow" or system["Ranged"].en == "Ullr Bow") then
                        helpers['queue'].addToFront(WS[settings["Empyreal Arrow"]], target)
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- /DNC.
                    if player.sub_job == "DNC" then
                        
                        -- REVERSE FLOURISH.
                        if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) and bpcore:getFinishingMoves() > 4 and bpcore:getAvailable("JA", "Reverse Flourish") then
                            helpers['queue'].add(JA["Reverse Flourish"], "me")                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                        
                    -- PROVOKE.
                    if bpcore:canAct() and bpcore:isJAReady(JA["Provoke"].recast_id) and bpcore:getAvailable("JA", "Provoke") and bpcore:canEngage(helpers["target"].getTarget()) then
                        helpers['queue'].add(JA["Provoke"], target)                            
                    end
                        
                    -- /DNC.
                    if player.sub_job == "DNC" then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:canAct() and bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and bpcore:getAvailable("JA", "Animated Flourish") and bpcore:canEngage(helpers["target"].getTarget()) then
                            helpers['queue'].add(JA["Animated Flourish"], target)                            
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    -- DEFENDER.
                    if bpcore:canAct() and settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Defender"].recast_id) and not bpcore:buffActive(57) and bpcore:getAvailable("JA", "Defender") then
                        helpers['queue'].add(JA["Defender"], "me")
                    
                    -- RETALIATION.
                    elseif bpcore:canAct() and bpcore:isJAReady(JA["Retaliation"].recast_id) and not bpcore:buffActive(405) and bpcore:getAvailable("JA", "Retaliation") then
                        helpers['queue'].add(JA["Retaliation"], "me")
                    
                    end
                    
                    -- /SAM.
                    if player.sub_job == "SAM" and bpcore:canAct() then
                        
                        -- HASSO.
                        if not settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Hasso"].recast_id) and not bpcore:buffActive(353) and bpcore:getAvailable("JA", "Hasso") then
                            helpers['queue'].add(JA["Hasso"], "me")
                        
                        -- SEIGAN.
                        elseif settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Seigan"].recast_id) and not bpcore:buffActive(354) and bpcore:getAvailable("JA", "Seigan") then
                            helpers['queue'].add(JA["Seigan"], "me")
                        
                        -- MEDITATE.
                        elseif bpcore:isJAReady(JA["Meditate"].recast_id) and bpcore:getAvailable("JA", "Meditate") then
                            helpers['queue'].addToFront(JA["Meditate"], "me")
                        
                        -- THIRD EYE.
                        elseif bpcore:isJAReady(JA["Third Eye"].recast_id) and not bpcore:buffActive(67) and bpcore:getAvailable("JA", "Third Eye") then
                            helpers['queue'].add(JA["Third Eye"], "me")
                        
                        end
                    
                    -- /DNC.
                    elseif player.sub_job == "DNC" and bpcore:canAct() then
                    
                        -- SAMBAS.
                        if bpcore:isJAReady(JA[settings["SAMBAS"]:current()].recast_id) and (not bpcore:buffActive(368) or not bpcore:buffActive(370)) and bpcore:getAvailable("JA", settings["SAMBAS"]:current()) then
                            helpers['queue'].add(JA[settings["SAMBAS"]:current()], "me")                            
                        end
                    
                    -- /NIN.
                    elseif player.sub_job == "NIN" and bpcore:canCast() then
                    
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
                    if player.sub_job == "DNC" and bpcore:canAct() and bpcore:canEngage(helpers["target"].getTarget()) then
                    
                        -- STEPS.
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["WAR"]["Steps Timer"] > system["WAR"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers['queue'].add(JA[settings["STEPS"]:current()], target)                            
                        end
                    
                    end
                    
                end
                
            end
            
            -- HANDLE EVERYTHING INSIDE THE QUEUE.
            helpers["cures"].handleCuring()
            helpers["queue"].handleQueue()
        
        end
        
    end
    
    self.handleWindow = function()
        
        if display:current() then
            
            -- Build Variables.
            local player  = windower.ffxi.get_player()
            local enmity  = ""
            local strings = {}
            
            if helpers["target"].exists(system["Enmity Target"]) and helpers["target"].exists(system["Attacker Target"]) then
                enmity = system["Enmity Target"].name
            
            else
                enmity = "N/A"
                
            end
            
            -- Build String Table.
            table.insert(strings, ("[ HP%: "        .. bpcore:colorize(player["vitals"].hpp, "255,51,0")    .. " ]"))
            table.insert(strings, ("[ MP%: "        .. bpcore:colorize(player["vitals"].mpp, "255,51,0")    .. " ]"))
            table.insert(strings, ("[ Enmity: ("    .. bpcore:colorize(enmity, "255,51,0")                  .. ") ]"))
            
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