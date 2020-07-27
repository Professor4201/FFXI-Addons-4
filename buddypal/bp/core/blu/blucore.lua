--------------------------------------------------------------------------------
-- BLU Core: Handle all job automation for Blue Mage.
--------------------------------------------------------------------------------
local core = {}

-- CORE AUTOMATED FUNCTION FOR THIS JOB.
function core.get()
    local self = {}
    
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
    settings["WSNAME"]                             = "Chant du Cygne"
    settings["RANGED WS"]                          = "N/A"
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
    settings["SEKKA"]                              = "Chant du Cygne"
    settings["SHADOWS"]                            = I{false,true}
    settings["FOOD"]                               = I{"Sublime Sushi","Sublime Sushi +1"}
    settings["SAMBAS"]                             = I{"Drain Samba II","Haste Samba"}
    settings["STEPS"]                              = I{"Quickstep","Box Step","Stutter Step"}
    settings["RUNES"]                              = {rune1="",rune2="",rune3=""}
    settings["RUNE1"]                              = I{"Lux","Tenebrae","Unda","Ignis","Gelus","Flabra","Tellus","Sulpor"}
    settings["RUNE2"]                              = I{"Lux","Tenebrae","Unda","Ignis","Gelus","Flabra","Tellus","Sulpor"}
    settings["RUNE3"]                              = I{"Lux","Tenebrae","Unda","Ignis","Gelus","Flabra","Tellus","Sulpor"}
    settings["SKILLUP"]                            = I{false,true}
    settings["SKILLS"]                             = I{"Blue"}
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
        
        ["Sound Blast"]      = {["allowed"]=0,["delay"]=30},  ["Infrasonics"]        = {["allowed"]=0,["delay"]=60},
        ["Blank Gaze"]       = {["allowed"]=0,["delay"]=30},  ["Corrosive Ooze"]     = {["allowed"]=0,["delay"]=90}, 
        ["Awful Eye"]        = {["allowed"]=0,["delay"]=30},  ["Enervation"]         = {["allowed"]=0,["delay"]=30}, 
        ["Geist Wall"]       = {["allowed"]=0,["delay"]=120}, ["Lowing"]             = {["allowed"]=0,["delay"]=60},  
        ["Frightful Roar"]   = {["allowed"]=0,["delay"]=360}, ["Acrid Stream"]       = {["allowed"]=0,["delay"]=120},
        ["Filamented Hold"]  = {["allowed"]=0,["delay"]=240}, ["Demopralizing Roar"] = {["allowed"]=0,["delay"]=30},
        ["Light of Penance"] = {["allowed"]=0,["delay"]=30},  ["Sweeping Gouge"]     = {["allowed"]=0,["delay"]=90},
        ["Voracious Trunk"]  = {["allowed"]=0,["delay"]=360}, ["Water Bomb"]         = {["allowed"]=0,["delay"]=90},
        ["Feather Tickle"]   = {["allowed"]=0,["delay"]=360}, ["Paralyzing Triad"]   = {["allowed"]=0,["delay"]=60},
        
    }
    
    -- MAGIC BURST.
    settings["MAGIC BURST"]={
        
        ["Transfixion"]   = T{"Blinding Fulgor"},
        ["Compression"]   = T{"Tenebral Crush"},
        ["Liquefaction"]  = T{"Searing Tempest"},
        ["Scission"]      = T{"Entomb"},
        ["Reverberation"] = T{"Scouring Spate"},
        ["Detonation"]    = T{"Silent Storm"},
        ["Induration"]    = T{"Spectral Floe"},
        ["Impaction"]     = T{"Anvil Lightning"},
        
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
                
                -- SKILLUP LOGIC.
                if settings["SKILLUP"]:current() then
                    
                    if bpcore:findItemByName("B.E.W. Pitaru") and not helpers["queue"].inQueue(IT["B.E.W. Pitaru"], player) and not bpcore:buffActive(251) then
                        helpers["queue"].add(IT["B.E.W. Pitaru"], "me")
                        
                    else
                    
                        for i,v in pairs(system["Skillup"][settings["SKILLS"]:current()].list) do
    
                            if windower.ffxi.get_spells()[MA[v].id] and bpcore:isMAReady(MA[v].recast_id) then
                                helpers["queue"].add(MA[v], system["Skillup"][settings["SKILLS"]:current()].target)
                            end
                            
                        end
                    
                    end
                    
                end
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() then
                    
                    if settings["AM"]:current() then
                        
                        if bpcore:buffActive(272) and player["vitals"].tp > 1000 then
                            
                            if settings["SANGUINE"]:current() and player["vitals"].hpp > system["BLU"]["Sanguine Threshold"] then
                                helpers["queue"].addToFront(WS["Sanguine Blade"], "t")
                            else
                                helpers["queue"].addToFront(WS[settings["WSNAME"]], "t")
                            end
                            
                        elseif not bpcore:buffActive(272) and player["vitals"].tp > 1000 and system["Weapon"].en == "Lionheart" then
                            helpers["queue"].addToFront(WS["Resolution"], "t")
                        
                        elseif not bpcore:buffActive(272) and player["vitals"].tp > 1000 and system["Weapon"].en == "Epeolatry" then
                            helpers["queue"].addToFront(WS["Dimidiation"], "t")
                            
                        end
                        
                    elseif player["vitals"].tp > 1000 then
                        
                        if settings["SANGUINE"]:current() and player["vitals"].hpp > system["BLU"]["Sanguine Threshold"] then
                            helpers["queue"].addToFront(WS["Sanguine Blade"], "t")
                        else
                            helpers["queue"].addToFront(WS[settings["WSNAME"]], "t")
                        end
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- RUN/.
                    if player.main_job == "RUN" then                        
                        
                        if helpers["runes"].getActive() > 0 then
                            local runes = helpers["runes"].getRunes()
                            
                            if (runes[1] and runes[1].en ~= "Tenebrae") or (runes[2] and runes[2].en ~= "Tenebrae") or (runes[3] and runes[3].en ~= "Tenebrae") then
                                
                                -- VIVACIOUS PULSE.
                                if bpcore:isJAReady(JA["Vivacious Pulse"].recast_id) and bpcore:getAvailable("JA", "Vivacious Pulse") and player["vitals"].hpp < system["BLU"]["Pulse HPP Threshold"] then
                                    helpers["queue"].add(JA["Vivacious Pulse"], "me")
                                end
                                
                            elseif (runes[1] and runes[1].en == "Tenebrae") or (runes[2] and runes[2].en == "Tenebrae") or (runes[3] and runes[3].en == "Tenebrae") then
                                
                                -- VIVACIOUS PULSE.
                                if bpcore:isJAReady(JA["Vivacious Pulse"].recast_id) and bpcore:getAvailable("JA", "Vivacious Pulse") and player["vitals"].mpp < system["BLU"]["Pulse MPP Threshold"] then
                                    helpers["queue"].add(JA["Vivacious Pulse"], "me")
                                end
                                
                            end
                        
                        end
                        
                        -- BATTUTA.
                        if bpcore:canAct() and bpcore:isJAReady(JA["Battuta"].recast_id) and bpcore:getAvailable("JA", "Battuta") then
                            helpers["queue"].add(MA["Battuta"], "me")
                        end
                        
                    end
                    
                    -- /RDM.
                    if player.sub_job == "RDM" then
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and player["vitals"].hpp > system["BLU"]["Convert Threshold"].hpp and player["vitals"].mpp < system["BLU"]["Convert Threshold"].mpp then
                            
                            if bpcore:isJAReady(JA["Convert"].recast_id) and bpcore:getAvailable("JA", "Convert") then
                                helpers["queue"].add(JA["Convert"], "me")
                            end
                            
                        end
                    
                    -- /DRK.
                    elseif player.sub_job == "DRK" then
                        
                        -- WEAPON BASH.
                        if bpcore:canAct() and bpcore:isJAReady(JA["Weapon Bash"].recast_id) and bpcore:getAvailable("JA", "Weapon Bash") then
                            helpers["queue"].add(JA["Weapon Bash"], "t")
                        end
                    
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                    
                        -- REVERSE FLOURISH.
                        if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) and bpcore:getFinishingMoves() > 4 and bpcore:getAvailable("JA", "Reverse Flourish") then
                            helpers["queue"].add(JA["Reverse Flourish"], "me")
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    -- RUN/
                    if player.main_job == "RUN" then
                        
                        -- FLASH.
                        if bpcore:canCast() and bpcore:isMAReady(MA["Flash"].recast_id) and bpcore:getAvailable("MA", "Flash") then
                            helpers["queue"].add(MA["Flash"], "t")
                        
                        -- FOIL.
                        elseif bpcore:canCast() and bpcore:isMAReady(MA["Foil"].recast_id) and bpcore:getAvailable("MA", "Foil") then
                            helpers["queue"].add(MA["Foil"], "t")
                            
                        end
                        
                        if bpcore:canAct() and (os.clock()-system["BLU"]["Hate Timer"]) > system["BLU"]["Hate Delay"] then
                        
                            -- VALLATION.
                            if bpcore:isJAReady(JA["Vallation"].recast_id) and bpcore:getAvailable("JA", "Vallation") and helpers["runes"].getActive() > 0 then
                                helpers["queue"].addToFront(JA["Vallation"], "me")
                                system["BLU"]["Hate Timer"] = os.clock()
                            
                            -- VALIANCE.
                            elseif bpcore:isJAReady(JA["Valiance"].recast_id) and bpcore:getAvailable("JA", "Valiance") and helpers["runes"].getActive() > 0 then
                                helpers["queue"].addToFront(JA["Valiance"], "me")
                                system["BLU"]["Hate Timer"] = os.clock()
                                
                            -- LIEMENT.
                            elseif bpcore:isJAReady(JA["Liement"].recast_id) and bpcore:getAvailable("JA", "Liement") and helpers["runes"].getActive() > 0 then
                                helpers["queue"].addToFront(JA["Liement"], "me")
                                system["BLU"]["Hate Timer"] = os.clock()
                                
                            -- PFLUG.
                            elseif bpcore:isJAReady(JA["Pflug"].recast_id) and bpcore:getAvailable("JA", "Pflug") and helpers["runes"].getActive() > 0 then
                                helpers["queue"].addToFront(JA["Pflug"], "me")
                                system["BLU"]["Hate Timer"] = os.clock()
                                
                            -- ONE FOR ALL.
                            elseif bpcore:isJAReady(JA["One for All"].recast_id) and bpcore:getAvailable("JA", "One for All") then
                                helpers["queue"].addToFront(JA["One for All"], "me")
                                system["BLU"]["Hate Timer"] = os.clock()
                                
                            end
                            
                        end
                        
                    end
                    
                    -- /WAR.
                    if player.sub_job == "WAR" then
                        
                        -- PROVOKE.
                        if bpcore:isJAReady(JA["Provoke"].recast_id) and bpcore:getAvailable("JA", "Provoke") then
                            helpers["queue"].add(JA["Provoke"], "t")
                        end
                    
                    -- /DRK.
                    elseif player.sub_job == "DRK" then
                        
                        -- STUN.
                        if bpcore:isJAReady(MA["Stun"].recast_id) and bpcore:getAvailable("MA", "Stun") then
                            helpers["queue"].add(MA["Stun"], "t")
                        end
                        
                        if bpcore:canAct() and (os.clock()-system["BLU"]["Hate Timer"]) > system["BLU"]["Hate Delay"] then
                        
                            -- LAST RESORT.
                            if bpcore:isJAReady(JA["Last Resort"].recast_id) and bpcore:getAvailable("JA", "Last Resort") then
                                helpers["queue"].add(JA["Last Resort"], "me")
                                system["BLU"]["Hate Timer"] = os.clock()
                            
                            -- SOULEATER.
                            elseif bpcore:isJAReady(JA["Souleater"].recast_id) and bpcore:getAvailable("JA", "Souleater") then
                                helpers["queue"].add(JA["Souleater"], "me")
                                system["BLU"]["Hate Timer"] = os.clock()
                                
                            end
                            
                        end
                        
                    -- /BLU.
                    elseif player.sub_job == "BLU" and bpcore:canCast() then
                        
                        -- JETTATURA.
                        if bpcore:isMAReady(MA["Jettatura"].recast_id) and bpcore:getAvailable("MA", "Jettatura") then
                            helpers["queue"].add(MA["Jettatura"], "t")
                            
                        -- BLANK GAZE.
                        elseif bpcore:isMAReady(MA["Blank Gaze"].recast_id) and bpcore:getAvailable("MA", "Blank Gaze") then
                            helpers["queue"].add(MA["Blank Gaze"], "t")
                            
                        end
                        
                        if settings["AOEHATE"]:current() and (os.clock()-system["BLU"]["Hate Timer"]) > system["BLU"]["Hate Delay"] then
                            
                            -- SOPORIFIC.
                            if bpcore:isMAReady(MA["Soporific"].recast_id) and bpcore:getAvailable("MA", "Soporific") then
                                helpers["queue"].add(MA["Soporific"], "t")
                                system["BLU"]["Hate Timer"] = os.clock()
                            
                            -- GEIST WALL.
                            elseif bpcore:isMAReady(MA["Geist Wall"].recast_id) and bpcore:getAvailable("MA", "Geist Wall") then
                                helpers["queue"].add(MA["Geist Wall"], "t")
                                system["BLU"]["Hate Timer"] = os.clock()
                            
                            -- JETTATURA.
                            elseif bpcore:isMAReady(MA["Sheep Song"].recast_id) and bpcore:getAvailable("MA", "Sheep Song") then
                                helpers["queue"].add(MA["Sheep Song"], "t")
                                system["BLU"]["Hate Timer"] = os.clock()
                            
                            end
                            
                        end
                    
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and bpcore:getAvailable("JA", "Animated Flourish") then
                            helpers["queue"].add(JA["Animated Flourish"], "t")
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    if player.main_job == "RUN" then
                        local runes  = helpers["runes"].getRunes()
                        local active = helpers["runes"].getActive()
                        
                        if runes:length() > active then
                            helpers["runes"].remove()
                        end
                        
                        -- RUNE ENCHANMENTS.
                        if runes:length() > 0 and runes:length() < 3 then
                            
                            if bpcore:canAct() and runes[runes:length()].position == 1 then
                                
                                if bpcore:isJAReady(JA[settings["RUNE2"]:current()].recast_id) and bpcore:getAvailable("JA", settings["RUNE2"]:current()) and not helpers["queue"].inQueue(JA[settings["RUNE2"]:current()], player) then
                                    helpers["queue"].add(JA[settings["RUNE2"]:current()], "me")
                                end
                                
                            elseif bpcore:canAct() and runes[runes:length()].position == 2 then
                                
                                if bpcore:isJAReady(JA[settings["RUNE3"]:current()].recast_id) and bpcore:getAvailable("JA", settings["RUNE3"]:current()) and not helpers["queue"].inQueue(JA[settings["RUNE3"]:current()], player) then
                                    helpers["queue"].add(JA[settings["RUNE3"]:current()], "me")
                                end
                                
                            elseif bpcore:canAct() and runes[runes:length()].position == 3 then
                                
                                if bpcore:isJAReady(JA[settings["RUNE1"]:current()].recast_id) and bpcore:getAvailable("JA", settings["RUNE1"]:current()) and not helpers["queue"].inQueue(JA[settings["RUNE1"]:current()], player) then
                                    helpers["queue"].add(JA[settings["RUNE1"]:current()], "me")
                                end
                                
                            end
                            
                        elseif runes:length() == 0 then
                            
                            if bpcore:isJAReady(JA[settings["RUNE1"]:current()].recast_id) and bpcore:getAvailable("JA", settings["RUNE1"]:current()) and not helpers["queue"].inQueue(JA[settings["RUNE1"]:current()], player) then
                                helpers["queue"].add(JA[settings["RUNE1"]:current()], "me")
                            end
                            
                        end
                        
                        -- PHALANX.
                        if bpcore:canCast() and bpcore:isMAReady(MA["Phalanx"].recast_id) and bpcore:getAvailable("MA", "Phalanx") and not bpcore:buffActive(289) then
                            
                            if settings["EMBOLDEN"]:current() == "Phalanx" and bpcore:isJAReady(JA["Embolden"].recast_id) and bpcore:getAvailable("JA", "Embolden") then
                                helpers["queue"].add(JA["Embolde"], "me")
                                helpers["queue"].add(MA["Phalanx"], "me")
                            else
                                helpers["queue"].add(MA["Phalanx"], "me")
                            end
                        
                        -- CRUSADE.
                        elseif bpcore:canCast() and bpcore:isMAReady(MA["Crusade"].recast_id) and bpcore:getAvailable("MA", "Crusade") and not bpcore:buffActive(289) then
                            helpers["queue"].add(MA["Crusade"], "me")
                            
                        -- TEMPER.
                        elseif bpcore:canCast() and bpcore:isMAReady(MA["Temper"].recast_id) and bpcore:getAvailable("MA", "Temper") and not bpcore:buffActive(432) then
                            
                            if settings["EMBOLDEN"]:current() == "Temper" and bpcore:isJAReady(JA["Embolden"].recast_id) and bpcore:getAvailable("JA", "Embolden") then
                                helpers["queue"].add(JA["Embolde"], "me")
                                helpers["queue"].add(MA["Temper"], "me")
                            else
                                helpers["queue"].add(MA["Temper"], "me")
                            end
                            
                        -- REGEN IV.
                        elseif bpcore:canCast() and bpcore:isMAReady(MA["Regen IV"].recast_id) and bpcore:getAvailable("MA", "Regen IV") and not bpcore:buffActive(42) and not bpcore:buffActive(539) then
                            
                            if settings["EMBOLDEN"]:current() == "Regen IV" and bpcore:isJAReady(JA["Embolden"].recast_id) and bpcore:getAvailable("JA", "Embolden") then
                                helpers["queue"].add(JA["Embolde"], "me")
                                helpers["queue"].add(MA["Regen IV"], "me")
                            else
                                helpers["queue"].add(MA["Regen IV"], "me")
                            end
                            
                        -- REFRESH.
                        elseif bpcore:canCast() and bpcore:isMAReady(MA["Refresh"].recast_id) and bpcore:getAvailable("MA", "Refresh") and not bpcore:buffActive(43) and not bpcore:buffActive(541) then
                            helpers["queue"].add(MA["Refresh"], "me")
                            
                        -- SPIKES.
                        elseif bpcore:canCast() and settings["SPIKES"]:current() ~= "None" and not bpcore:buffActive(34) and not bpcore:buffActive(35) and not bpcore:buffActive(38) then
                        
                            if bpcore:isMAReady(MA[settings["SPIKES"]:current()].recast_id) and bpcore:getAvailable("MA", settings["SPIKES"]:current()) then
                                helpers["queue"].add(MA[settings["SPIKES"]:current()], "me")
                            end
                            
                        end
                        
                    end
                    
                    if player.sub_job == "WAR" then
                    
                        -- BERSERK.
                        if bpcore:canAct() and not settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Berserk"].recast_id) and not bpcore:buffActive(56) and bpcore:getAvailable("JA", "Berserk") then
                            helpers["queue"].add(JA["Berserk"], "me")
                        
                        -- DEFENDER.
                        elseif bpcore:canAct() and settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Defender"].recast_id) and not bpcore:buffActive(57) and bpcore:getAvailable("JA", "Defender") then
                            helpers["queue"].add(JA["Defender"], "me")
                            
                        -- AGGRESSOR.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Aggressor"].recast_id) and not bpcore:buffActive(58) and bpcore:getAvailable("JA", "Aggressor") then
                            helpers["queue"].add(JA["Aggressor"], "me")
                        
                        -- WARCRY.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Warcry"].recast_id) and not bpcore:buffActive(68) and not bpcore:buffActive(460) and bpcore:getAvailable("JA", "Warcry") then
                            helpers["queue"].add(JA["Warcry"], "me")
                        
                        end
                    
                    -- /SAM.
                    elseif player.sub_job == "SAM" then
                        
                        -- HASSO.
                        if bpcore:canAct() and settings["HASSO MODE"]:current() and bpcore:isJAReady(JA["Hasso"].recast_id) and not bpcore:buffActive(353) and bpcore:getAvailable("JA", "Hasso") then
                            helpers["queue"].add(JA["Hasso"], "me")
                        
                        -- SEIGAN.
                        elseif bpcore:canAct() and not settings["HASSO MODE"]:current() and bpcore:isJAReady(JA["Seigan"].recast_id) and not bpcore:buffActive(354) and bpcore:getAvailable("JA", "Seigan") then
                            helpers["queue"].add(JA["Seigan"], "me")
                        
                        -- MEDITATE.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Meditate"].recast_id) and bpcore:getAvailable("JA", "Meditate") then
                            helpers["queue"].addToFront(JA["Meditate"], "me")
                        
                        -- THIRD EYE.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Third Eye"].recast_id) and not bpcore:buffActive(67) and bpcore:getAvailable("JA", "Third Eye") then
                            helpers["queue"].add(JA["Third Eye"], "me")
                        
                        end
                    
                    -- /DRK.
                    elseif player.sub_job == "DRK" then

                    
                    -- /BLU.
                    elseif player.sub_job == "BLU" then

                    
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                    
                        -- SAMBAS.
                        if bpcore:canAct() and bpcore:isJAReady(JA[settings["SAMBAS"]:current()].recast_id) and (not bpcore:buffActive(368) or not bpcore:buffActive(370)) and bpcore:getAvailable("JA", settings["SAMBAS"]:current()) then
                            helpers["queue"].add(JA[settings["SAMBAS"]:current()], "me")                            
                        end
                    
                    -- /NIN.
                    elseif player.sub_job == "NIN" then
                    
                        -- UTSUSEMI
                        if bpcore:canCast() and bpcore:findItemByName("Shihei", 0) then
                            
                            if not bpcore:buffActive(444) and not bpcore:buffActive(445) and not bpcore:buffActive(446) and not bpcore:buffActive(36) then
                                
                                if bpcore:isMAReady(MA["Utsusemi: Ni"].recast_id) and bpcore:getAvailable("MA", "Utsusemi: Ni") then
                                    helpers["queue"].addToFront(MA["Utsusemi: Ni"], "me")
                                    
                                elseif bpcore:isMAReady(MA["Utsusemi: Ichi"].recast_id) and bpcore:getAvailable("MA", "Utsusemi: Ichi") then
                                    helpers["queue"].addToFront(MA["Utsusemi: Ichi"], "me")
                                    
                                end
                            
                            end
                        
                        end
                    
                    end
                    
                end
                
                -- DEBUFF LOGIC.
                if settings["DEBUFFS"]:current() then
                    
                    -- RUN/.
                    if player.main_job == "RUN" then
                    
                    end
                    
                    -- /DNC.
                    if player.sub_job == "DNC" and bpcore:canAct() then
                    
                        -- STEPS.
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["BLU"]["Steps Timer"] > system["BLU"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers["queue"].add(JA[settings["STEPS"]:current()], "t")                            
                        end
                    
                    end
                    
                    -- DRAINS LOGIC
                    if settings["DRAINS"]:current() and bpcore:canCast() then
                        
                        -- DRAIN
                        if bpcore:isMAReady(MA["Drain"].recast_id) and player["vitals"].mpp < system["WHM"]["Drain Threshold"] and bpcore:getAvailable("MA", "Drain") then
                            helpers["queue"].add(MA["Drain"], "t")
                        end
                        
                        -- ASPIR
                        if bpcore:isMAReady(MA["Aspir"].recast_id) and player["vitals"].mpp < system["WHM"]["Aspir Threshold"] and bpcore:getAvailable("MA", "Aspir") then
                            helpers["queue"].add(MA["Aspir"], "t")
                        end
                        
                    end
                    
                end
            
            -- PLAYER IS DISENGAGED LOGIC.
            elseif (player.status == 0 or settings["SUPER-TANK"]:current()) and helpers["target"].isEnemy(helpers["target"].getTarget()) then
                local target = helpers["target"].getTarget()
                
                -- SKILLUP LOGIC.
                if settings["SKILLUP"]:current() then
                    
                    if bpcore:findItemByName("B.E.W. Pitaru") and not helpers["queue"].inQueue(IT["B.E.W. Pitaru"], player) and not bpcore:buffActive(251) then
                        helpers["queue"].add(IT["B.E.W. Pitaru"], "me")
                        
                    else
                    
                        for i,v in pairs(system["Skillup"][settings["SKILLS"]:current()].list) do
    
                            if windower.ffxi.get_spells()[MA[v].id] and bpcore:isMAReady(MA[v].recast_id) then
                                helpers["queue"].add(MA[v], system["Skillup"][settings["SKILLS"]:current()].target)
                            end
                            
                        end
                    
                    end
                    
                end
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() and target then
                    
                    if settings["AM"]:current() then
                        
                        if bpcore:buffActive(272) and player["vitals"].tp > 1000 then
                            
                            if settings["SANGUINE"]:current() and player["vitals"].hpp > system["BLU"]["Sanguine Threshold"] then
                                helpers["queue"].addToFront(WS["Sanguine Blade"], target)
                            else
                                helpers["queue"].addToFront(WS[settings["WSNAME"]], target)
                            end
                            
                        elseif not bpcore:buffActive(272) and player["vitals"].tp > 1000 and system["Weapon"].en == "Lionheart" then
                            helpers["queue"].addToFront(WS["Resolution"], target)
                        
                        elseif not bpcore:buffActive(272) and player["vitals"].tp > 1000 and system["Weapon"].en == "Epeolatry" then
                            helpers["queue"].addToFront(WS["Dimidiation"], target)
                            
                        end
                        
                    elseif player["vitals"].tp > 1000 then
                        
                        if settings["SANGUINE"]:current() and player["vitals"].hpp > system["BLU"]["Sanguine Threshold"] then
                            helpers["queue"].addToFront(WS["Sanguine Blade"], target)
                        else
                            helpers["queue"].addToFront(WS[settings["WSNAME"]], target)
                        end
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- RUN/.
                    if player.main_job == "RUN" then                        
                        
                        if helpers["runes"].getActive() > 0 then
                            local runes = helpers["runes"].getRunes()
                            
                            if (runes[1] and runes[1].en ~= "Tenebrae") or (runes[2] and runes[2].en ~= "Tenebrae") or (runes[3] and runes[3].en ~= "Tenebrae") then
                                
                                -- VIVACIOUS PULSE.
                                if bpcore:isJAReady(JA["Vivacious Pulse"].recast_id) and bpcore:getAvailable("JA", "Vivacious Pulse") and player["vitals"].hpp < system["BLU"]["Pulse HPP Threshold"] then
                                    helpers["queue"].add(JA["Vivacious Pulse"], "me")
                                end
                                
                            elseif (runes[1] and runes[1].en == "Tenebrae") or (runes[2] and runes[2].en == "Tenebrae") or (runes[3] and runes[3].en == "Tenebrae") then
                                
                                -- VIVACIOUS PULSE.
                                if bpcore:isJAReady(JA["Vivacious Pulse"].recast_id) and bpcore:getAvailable("JA", "Vivacious Pulse") and player["vitals"].mpp < system["BLU"]["Pulse MPP Threshold"] then
                                    helpers["queue"].add(JA["Vivacious Pulse"], "me")
                                end
                                
                            end
                        
                        end
                        
                        -- BATTUTA.
                        if bpcore:canAct() and bpcore:isJAReady(JA["Battuta"].recast_id) and bpcore:getAvailable("JA", "Battuta") and target then
                            helpers["queue"].add(MA["Battuta"], "me")
                        end
                        
                    end
                    
                    -- /RDM.
                    if player.sub_job == "RDM" then
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and player["vitals"].hpp > system["BLU"]["Convert Threshold"].hpp and player["vitals"].mpp < system["BLU"]["Convert Threshold"].mpp then
                            
                            if bpcore:isJAReady(JA["Convert"].recast_id) and bpcore:getAvailable("JA", "Convert") then
                                helpers["queue"].add(JA["Convert"], "me")
                            end
                            
                        end
                    
                    -- /DRK.
                    elseif player.sub_job == "DRK" then
                        
                        -- WEAPON BASH.
                        if bpcore:canAct() and bpcore:isJAReady(JA["Weapon Bash"].recast_id) and bpcore:getAvailable("JA", "Weapon Bash") and target then
                            helpers["queue"].add(JA["Weapon Bash"], target)
                        end
                        
                    
                    -- /SCH.
                    elseif player.sub_job == "SCH" then
                        
                        -- LIGHT ARTS.
                        if bpcore:isJAReady(JA["Light Arts"].recast_id) and bpcore:getAvailable("JA", "Light Arts") and not bpcore:buffActive(358) then
                            helpers["queue"].addToFront(JA["Light Arts"], "me")
                        end
                    
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                    
                        -- REVERSE FLOURISH.
                        if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) and bpcore:getFinishingMoves() > 4 and bpcore:getAvailable("JA", "Reverse Flourish") then
                            helpers["queue"].add(JA["Reverse Flourish"], "me")
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() and target then
                    
                    -- RUN/
                    if player.main_job == "RUN" then
                        
                        -- FLASH.
                        if bpcore:canCast() and bpcore:isMAReady(MA["Flash"].recast_id) and bpcore:getAvailable("MA", "Flash") then
                            helpers["queue"].add(MA["Flash"], target)
                        
                        -- FOIL.
                        elseif bpcore:canCast() and bpcore:isMAReady(MA["Foil"].recast_id) and bpcore:getAvailable("MA", "Foil") then
                            helpers["queue"].add(MA["Foil"], "me")
                            
                        end
                        
                        if bpcore:canAct() and (os.clock()-system["BLU"]["Hate Timer"]) > system["BLU"]["Hate Delay"] then
                        
                            -- VALLATION.
                            if bpcore:isJAReady(JA["Vallation"].recast_id) and bpcore:getAvailable("JA", "Vallation") and helpers["runes"].getActive() > 0 then
                                helpers["queue"].addToFront(JA["Vallation"], "me")
                                system["BLU"]["Hate Timer"] = os.clock()
                            
                            -- VALIANCE.
                            elseif bpcore:isJAReady(JA["Valiance"].recast_id) and bpcore:getAvailable("JA", "Valiance") and helpers["runes"].getActive() > 0 then
                                helpers["queue"].addToFront(JA["Valiance"], "me")
                                system["BLU"]["Hate Timer"] = os.clock()
                                
                            -- LIEMENT.
                            elseif bpcore:isJAReady(JA["Liement"].recast_id) and bpcore:getAvailable("JA", "Liement") and helpers["runes"].getActive() > 0 then
                                helpers["queue"].addToFront(JA["Liement"], "me")
                                system["BLU"]["Hate Timer"] = os.clock()
                                
                            -- PFLUG.
                            elseif bpcore:isJAReady(JA["Pflug"].recast_id) and bpcore:getAvailable("JA", "Pflug") and helpers["runes"].getActive() > 0 then
                                helpers["queue"].addToFront(JA["Pflug"], "me")
                                system["BLU"]["Hate Timer"] = os.clock()
                                
                            -- ONE FOR ALL.
                            elseif bpcore:isJAReady(JA["One for All"].recast_id) and bpcore:getAvailable("JA", "One for All") then
                                helpers["queue"].addToFront(JA["One for All"], "me")
                                system["BLU"]["Hate Timer"] = os.clock()
                                
                            end
                            
                        end
                        
                    end
                    
                    -- /WAR.
                    if player.sub_job == "WAR" then
                        
                        -- PROVOKE.
                        if bpcore:isJAReady(JA["Provoke"].recast_id) and bpcore:getAvailable("JA", "Provoke") then
                            helpers["queue"].add(JA["Provoke"], target)
                        end
                    
                    -- /DRK.
                    elseif player.sub_job == "DRK" then
                        
                        -- STUN.
                        if bpcore:isJAReady(MA["Stun"].recast_id) and bpcore:getAvailable("MA", "Stun") then
                            helpers["queue"].add(MA["Stun"], target)
                        end
                        
                        if bpcore:canAct() and (os.clock()-system["BLU"]["Hate Timer"]) > system["BLU"]["Hate Delay"] then
                        
                            -- LAST RESORT.
                            if bpcore:isJAReady(JA["Last Resort"].recast_id) and bpcore:getAvailable("JA", "Last Resort") then
                                helpers["queue"].add(JA["Last Resort"], "me")
                            
                            -- SOULEATER.
                            elseif bpcore:isJAReady(JA["Souleater"].recast_id) and bpcore:getAvailable("JA", "Souleater") then
                                helpers["queue"].add(JA["Souleater"], "me")
                                
                            end
                            system["BLU"]["Hate Timer"] = os.clock()
                            
                        end
                        
                    -- /BLU.
                    elseif player.sub_job == "BLU" and target then
                        
                        -- JETTATURA.
                        if bpcore:isMAReady(MA["Jettatura"].recast_id) and bpcore:getAvailable("MA", "Jettatura") then
                            helpers["queue"].add(MA["Jettatura"], target)
                            
                        -- BLANK GAZE.
                        elseif bpcore:isMAReady(MA["Blank Gaze"].recast_id) and bpcore:getAvailable("MA", "Blank Gaze") then
                            helpers["queue"].add(MA["Blank Gaze"], target)
                            
                        end
                        
                        if settings["AOEHATE"]:current() and (os.clock()-system["BLU"]["Hate Timer"]) > system["BLU"]["Hate Delay"] then
                            
                            -- SOPORIFIC.
                            if bpcore:isMAReady(MA["Soporific"].recast_id) and bpcore:getAvailable("MA", "Soporific") then
                                helpers["queue"].add(MA["Soporific"], target)
                                system["BLU"]["Hate Timer"] = os.clock()
                            
                            -- GEIST WALL.
                            elseif bpcore:isMAReady(MA["Geist Wall"].recast_id) and bpcore:getAvailable("MA", "Geist Wall") then
                                helpers["queue"].add(MA["Geist Wall"], target)
                                system["BLU"]["Hate Timer"] = os.clock()
                            
                            -- JETTATURA.
                            elseif bpcore:isMAReady(MA["Sheep Song"].recast_id) and bpcore:getAvailable("MA", "Sheep Song") then
                                helpers["queue"].add(MA["Sheep Song"], target)
                                system["BLU"]["Hate Timer"] = os.clock()
                            
                            end
                            
                        end
                    
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and bpcore:getAvailable("JA", "Animated Flourish") then
                            helpers["queue"].add(JA["Animated Flourish"], target)
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    if player.main_job == "RUN" then
                        local runes  = helpers["runes"].getRunes()
                        local active = helpers["runes"].getActive()
                        
                        if runes:length() > active then
                            helpers["runes"].remove()
                        end
                        
                        -- RUNE ENCHANMENTS.
                        if runes:length() > 0 and runes:length() < 3 then
                            
                            if bpcore:canAct() and runes[runes:length()].position == 1 then
                                
                                if bpcore:isJAReady(JA[settings["RUNE2"]:current()].recast_id) and bpcore:getAvailable("JA", settings["RUNE2"]:current()) and not helpers["queue"].inQueue(JA[settings["RUNE2"]:current()], player) then
                                    helpers["queue"].add(JA[settings["RUNE2"]:current()], "me")
                                end
                                
                            elseif bpcore:canAct() and runes[runes:length()].position == 2 then
                                
                                if bpcore:isJAReady(JA[settings["RUNE3"]:current()].recast_id) and bpcore:getAvailable("JA", settings["RUNE3"]:current()) and not helpers["queue"].inQueue(JA[settings["RUNE3"]:current()], player) then
                                    helpers["queue"].add(JA[settings["RUNE3"]:current()], "me")
                                end
                                
                            elseif bpcore:canAct() and runes[runes:length()].position == 3 then
                                
                                if bpcore:isJAReady(JA[settings["RUNE1"]:current()].recast_id) and bpcore:getAvailable("JA", settings["RUNE1"]:current()) and not helpers["queue"].inQueue(JA[settings["RUNE1"]:current()], player) then
                                    helpers["queue"].add(JA[settings["RUNE1"]:current()], "me")
                                end
                                
                            end
                            
                        elseif runes:length() == 0 then
                            
                            if bpcore:isJAReady(JA[settings["RUNE1"]:current()].recast_id) and bpcore:getAvailable("JA", settings["RUNE1"]:current()) and not helpers["queue"].inQueue(JA[settings["RUNE1"]:current()], player) then
                                helpers["queue"].add(JA[settings["RUNE1"]:current()], "me")
                            end
                            
                        end
                            
                        -- PHALANX.
                        if bpcore:canCast() and bpcore:isMAReady(MA["Phalanx"].recast_id) and bpcore:getAvailable("MA", "Phalanx") and not bpcore:buffActive(116) then
                            
                            if settings["EMBOLDEN"]:current() == "Phalanx" and bpcore:isJAReady(JA["Embolden"].recast_id) and bpcore:getAvailable("JA", "Embolden") then
                                helpers["queue"].add(JA["Embolde"], "me")
                                helpers["queue"].add(MA["Phalanx"], "me")
                            else
                                helpers["queue"].add(MA["Phalanx"], "me")
                            end
                        
                        -- CRUSADE.
                        elseif bpcore:canCast() and bpcore:isMAReady(MA["Crusade"].recast_id) and bpcore:getAvailable("MA", "Crusade") and not bpcore:buffActive(289) then
                            helpers["queue"].add(MA["Crusade"], "me")
                            
                        -- TEMPER.
                        elseif bpcore:canCast() and bpcore:isMAReady(MA["Temper"].recast_id) and bpcore:getAvailable("MA", "Temper") and not bpcore:buffActive(432) then
                            
                            if settings["EMBOLDEN"]:current() == "Temper" and bpcore:isJAReady(JA["Embolden"].recast_id) and bpcore:getAvailable("JA", "Embolden") then
                                helpers["queue"].add(JA["Embolde"], "me")
                                helpers["queue"].add(MA["Temper"], "me")
                            else
                                helpers["queue"].add(MA["Temper"], "me")
                            end
                            
                        -- REGEN IV.
                        elseif bpcore:canCast() and bpcore:isMAReady(MA["Regen IV"].recast_id) and bpcore:getAvailable("MA", "Regen IV") and not bpcore:buffActive(42) and not bpcore:buffActive(539) then
                            
                            if settings["EMBOLDEN"]:current() == "Regen IV" and bpcore:isJAReady(JA["Embolden"].recast_id) and bpcore:getAvailable("JA", "Embolden") then
                                helpers["queue"].add(JA["Embolde"], "me")
                                helpers["queue"].add(MA["Regen IV"], "me")
                            else
                                helpers["queue"].add(MA["Regen IV"], "me")
                            end
                            
                        -- REFRESH.
                        elseif bpcore:canCast() and bpcore:isMAReady(MA["Refresh"].recast_id) and bpcore:getAvailable("MA", "Refresh") and not bpcore:buffActive(43) and not bpcore:buffActive(541) then
                            helpers["queue"].add(MA["Refresh"], "me")
                            
                        -- SPIKES.
                        elseif bpcore:canCast() and settings["SPIKES"]:current() ~= "None" and not bpcore:buffActive(34) and not bpcore:buffActive(35) and not bpcore:buffActive(38) then
                        
                            if bpcore:isMAReady(MA[settings["SPIKES"]:current()].recast_id) and bpcore:getAvailable("MA", settings["SPIKES"]:current()) then
                                helpers["queue"].add(MA[settings["SPIKES"]:current()], "me")
                            end
                            
                        end
                        
                    end
                    
                    if player.sub_job == "WAR" then
                        
                        -- DEFENDER.
                        if bpcore:canAct() and settings["TANK MODE"]:current() and bpcore:isJAReady(JA["Defender"].recast_id) and not bpcore:buffActive(57) and bpcore:getAvailable("JA", "Defender") then
                            helpers["queue"].add(JA["Defender"], "me")
                        
                        end
                    
                    -- /SAM.
                    elseif player.sub_job == "SAM" then
                        
                        -- HASSO.
                        if bpcore:canAct() and settings["HASSO MODE"]:current() and bpcore:isJAReady(JA["Hasso"].recast_id) and not bpcore:buffActive(353) and bpcore:getAvailable("JA", "Hasso") then
                            helpers["queue"].add(JA["Hasso"], "me")
                        
                        -- SEIGAN.
                        elseif bpcore:canAct() and not settings["HASSO MODE"]:current() and bpcore:isJAReady(JA["Seigan"].recast_id) and not bpcore:buffActive(354) and bpcore:getAvailable("JA", "Seigan") then
                            helpers["queue"].add(JA["Seigan"], "me")
                        
                        -- MEDITATE.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Meditate"].recast_id) and bpcore:getAvailable("JA", "Meditate") then
                            helpers["queue"].addToFront(JA["Meditate"], "me")
                        
                        -- THIRD EYE.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Third Eye"].recast_id) and not bpcore:buffActive(67) and bpcore:getAvailable("JA", "Third Eye") then
                            helpers["queue"].add(JA["Third Eye"], "me")
                        
                        end
                    
                    -- /DRK.
                    elseif player.sub_job == "DRK" then

                    
                    -- /BLU.
                    elseif player.sub_job == "BLU" then

                    
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                    
                        -- SAMBAS.
                        if bpcore:canAct() and bpcore:isJAReady(JA[settings["SAMBAS"]:current()].recast_id) and (not bpcore:buffActive(368) or not bpcore:buffActive(370)) and bpcore:getAvailable("JA", settings["SAMBAS"]:current()) then
                            helpers["queue"].add(JA[settings["SAMBAS"]:current()], "me")                            
                        end
                    
                    -- /NIN.
                    elseif player.sub_job == "NIN" then
                    
                        -- UTSUSEMI
                        if bpcore:canCast() and bpcore:findItemByName("Shihei", 0) then
                            
                            if not bpcore:buffActive(444) and not bpcore:buffActive(445) and not bpcore:buffActive(446) and not bpcore:buffActive(36) then
                                
                                if bpcore:isMAReady(MA["Utsusemi: Ni"].recast_id) and bpcore:getAvailable("MA", "Utsusemi: Ni") then
                                    helpers["queue"].addToFront(MA["Utsusemi: Ni"], "me")
                                    
                                elseif bpcore:isMAReady(MA["Utsusemi: Ichi"].recast_id) and bpcore:getAvailable("MA", "Utsusemi: Ichi") then
                                    helpers["queue"].addToFront(MA["Utsusemi: Ichi"], "me")
                                    
                                end
                            
                            end
                        
                        end
                    
                    end
                    
                end
                
                -- DEBUFF LOGIC.
                if settings["DEBUFFS"]:current() then
                    
                    -- RUN/.
                    if player.main_job == "RUN" then
                    
                    end
                    
                    -- /DNC.
                    if player.sub_job == "DNC" and bpcore:canAct() and target then
                    
                        -- STEPS.
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["BLU"]["Steps Timer"] > system["BLU"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers["queue"].add(JA[settings["STEPS"]:current()], target)                            
                        end
                    
                    end
                    
                    -- DRAINS LOGIC
                    if settings["DRAINS"]:current() and bpcore:canCast() and target then
                        
                        -- DRAIN
                        if bpcore:isMAReady(MA["Drain"].recast_id) and player["vitals"].mpp < system["WHM"]["Drain Threshold"] and bpcore:getAvailable("MA", "Drain") then
                            helpers["queue"].add(MA["Drain"], target)
                        end
                        
                        -- ASPIR
                        if bpcore:isMAReady(MA["Aspir"].recast_id) and player["vitals"].mpp < system["WHM"]["Aspir Threshold"] and bpcore:getAvailable("MA", "Aspir") then
                            helpers["queue"].add(MA["Aspir"], target)
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
            local enmity  = ""
            local strings = {}
            
            if helpers["target"].exists(system["Enmity Target"]) and helpers["target"].exists(system["Attacker Target"]) then
                enmity = system["Enmity Target"].name
            
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