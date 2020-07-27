--------------------------------------------------------------------------------
-- RDM Core: Handle all job automation for Red Mage.
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
    settings["ROTATE"]                             = I{false,true}
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
        
        ["Dia"]           = {["allowed"]=0,["delay"]=60},  ["Dia II"]      ={["allowed"]=0,["delay"]=120}, ["Dia III"]      ={["allowed"]=0,["delay"]=90},
        ["Bio"]           = {["allowed"]=0,["delay"]=60},  ["Bio II"]      ={["allowed"]=0,["delay"]=120}, ["Bio III"]      ={["allowed"]=0,["delay"]=30}, 
        ["Distract"]      = {["allowed"]=0,["delay"]=120}, ["Distract II"] ={["allowed"]=0,["delay"]=120}, ["Distract III"] ={["allowed"]=0,["delay"]=120},
        ["Frazzle"]       = {["allowed"]=0,["delay"]=120}, ["Frazzle II"]  ={["allowed"]=0,["delay"]=120}, ["Frazzle III"]  ={["allowed"]=0,["delay"]=120},
        ["Addle"]         = {["allowed"]=0,["delay"]=120}, ["Addle II"]    ={["allowed"]=0,["delay"]=120},
        ["Blind"]         = {["allowed"]=0,["delay"]=180}, ["Blind II"]    ={["allowed"]=0,["delay"]=180},
        ["Paralyze"]      = {["allowed"]=0,["delay"]=120}, ["Paralyze II"] ={["allowed"]=0,["delay"]=120},
        ["Slow"]          = {["allowed"]=0,["delay"]=120}, ["Slow II"]     ={["allowed"]=0,["delay"]=120},
        ["Silence"]       = {["allowed"]=0,["delay"]=120}, ["Inundation"]  ={["allowed"]=0,["delay"]=300}, ["Dispel"]       ={["allowed"]=0,["delay"]=15},
        
    }
    
    -- MAGIC BURST.
    settings["MAGIC BURST"]={
        
        ["Transfixion"]   = T{"Inundation"},
        ["Compression"]   = T{"Bio II","Bio III","Blind II","Aspir","Drain","Frazzle III","Impact"},
        ["Liquefaction"]  = T{"Fire","Fire II","Fire III","Fire IV","Fire V","Addle II"},
        ["Scission"]      = T{"Stone","Stone II","Stone III","Stone IV","Stone V","Slow II"},
        ["Reverberation"] = T{"Water","Water II","Water III","Water IV","Water V","Poison II"},
        ["Detonation"]    = T{"Aero","Aero II","Aero III","Aero IV","Aero V","Silence"},
        ["Induration"]    = T{"Blizzard","Blizzard II","Blizzard III","Blizzard IV","Blizzard V","Paralyze II","Distract III"},
        ["Impaction"]     = T{"Thunder","Thunder II","Thunder III","Thunder IV","Thunder V"},
        
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
                            
                            if settings["SANGUINE"]:current() and player["vitals"].hpp < system["RDM"]["Sanguine Threshold"] and bpcore:getAvailable("WS", "Sanguine Blade") then
                                helpers['queue'].addToFront(WS["Sanguine Blade"], "t")
                            
                            elseif bpcore:getAvailable("WS", settings["WSNAME"]) and player["vitals"].tp > settings["TP THRESHOLD"] then
                                helpers['queue'].addToFront(WS[settings["WSNAME"]], "t")
                            end
                            
                        elseif not bpcore:buffActive(272) and player["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Excalibur" and bpcore:getAvailable("WS", "Knights of Round") then
                            helpers['queue'].addToFront(WS["Knights of Round"], "t")
                        
                        elseif not bpcore:buffActive(272) and player["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Almace" and bpcore:getAvailable("WS", "Chant Du Cygne") then
                            helpers['queue'].addToFront(WS["Chant Du Cygne"], "t")
                        
                        elseif not bpcore:buffActive(272) and player["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Murgleis" and bpcore:getAvailable("WS", "Death Blossom") then
                            helpers['queue'].addToFront(WS["Death Blossom"], "t")
                            
                        elseif not bpcore:buffActive(272) and player["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Sequence" and bpcore:getAvailable("WS", "Requiescat") then
                            helpers['queue'].addToFront(WS["Requiescat"], "t")
                            
                        end
                        
                    elseif player["vitals"].tp > 1000 then
                        
                        if settings["SANGUINE"]:current() and player["vitals"].hpp < system["RDM"]["Sanguine Threshold"] and bpcore:getAvailable("WS", "Sanguine Blade") then
                            helpers['queue'].addToFront(WS["Sanguine Blade"], "t")
                        
                        elseif bpcore:getAvailable("WS", settings["WSNAME"]) and player["vitals"].tp > settings["TP THRESHOLD"] then
                            helpers['queue'].addToFront(WS[settings["WSNAME"]], "t")
                        end
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- RDM/.
                    if player.main_job == "RDM" then
                        
                        -- COMPOSURE LOGIC.
                        if settings["COMPOSURE"]:current() and bpcore:isJAReady(JA["Composure"].recast_id) and not bpcore:buffActive(419) and bpcore:getAvailable("JA", "Composure") then
                            helpers['queue'].add(JA["Composure"], "me")                            
                        end
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and player["vitals"].hpp > system["RDM"]["Convert Threshold"].hpp and player["vitals"].mpp < system["RDM"]["Convert Threshold"].mpp then
                            if bpcore:isJAReady(JA["Convert"].recast_id) and bpcore:getAvailable("JA", "Convert") then
                                helpers['queue'].add(JA["Convert"], "me")
                            end
                            
                        end
                    
                    end
                    
                    -- /DNC.
                    if player.sub_job == "DNC" then
                        
                        -- REVERSE FLOURISH.
                        if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) and bpcore:getFinishingMoves() > 4 then
                            helpers['queue'].add(JA["Reverse Flourish"], "me")                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    -- /WAR.
                    if player.sub_job == "WAR" and bpcore:canAct() then
                        
                        -- PROVOKE.
                        if bpcore:isJAReady(JA["Provoke"].recast_id) and bpcore:getAvailable("JA", "Provoke") then
                            helpers['queue'].add(JA["Provoke"], "t")                            
                        end
                        
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and bpcore:getAvailable("JA", "Animated Flourish") then
                            helpers['queue'].add(JA["Animated Flourish"], "t")                            
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    -- REFRESH III
                    if bpcore:canCast() and bpcore:isMAReady(MA["Refresh III"].recast_id) and bpcore:getAvailable("MA", "Refresh III") and not bpcore:buffActive(43) then
                        helpers['queue'].add(MA["Refresh III"], "me")
                    
                    -- REFRESH II
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Refresh II"].recast_id) and bpcore:getAvailable("MA", "Refresh II") and not bpcore:buffActive(43) then
                        helpers['queue'].add(MA["Refresh II"], "me")
                    
                    -- REFRESH I
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Refresh"].recast_id) and bpcore:getAvailable("MA", "Refresh") and not bpcore:buffActive(43) then
                        helpers['queue'].add(MA["Refresh"], "me")
                        
                    end
                    
                    -- HASTE II
                    if bpcore:canCast() and bpcore:isMAReady(MA["Haste II"].recast_id) and bpcore:getAvailable("MA", "Haste II") and not bpcore:buffActive(33) then
                        helpers['queue'].add(MA["Haste II"], "me")
                    
                    -- HASTE
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Haste"].recast_id) and bpcore:getAvailable("MA", "Haste") and not bpcore:buffActive(33) then
                        helpers['queue'].add(MA["Haste"], "me")
                        
                    end
                    
                    -- TEMPER II
                    if bpcore:canCast() and bpcore:isMAReady(MA["Temper II"].recast_id) and bpcore:getAvailable("MA", "Temper II") and not bpcore:buffActive(432) then
                        helpers['queue'].add(MA["Temper II"], "me")
                    
                    -- TEMPER
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Temper"].recast_id) and bpcore:getAvailable("MA", "Temper") and not bpcore:buffActive(432) then
                        helpers['queue'].add(MA["Temper"], "me")
                        
                    end   
                    
                    -- PHALANX
                    if bpcore:canCast() and bpcore:isMAReady(MA["Phalanx"].recast_id) and bpcore:getAvailable("MA", "Phalanx") and not bpcore:buffActive(116) then
                        helpers['queue'].add(MA["Phalanx"], "me")                    
                    end
                    
                    -- AQUAVEIL
                    if bpcore:canCast() and bpcore:isMAReady(MA["Aquaveil"].recast_id) and bpcore:getAvailable("MA", "Aquaveil") and not bpcore:buffActive(39) then
                        helpers['queue'].add(MA["Aquaveil"], "me")                    
                    end
                    
                    -- GAINS
                    if bpcore:canCast() and bpcore:isMAReady(MA[settings["GAINS"]:current()].recast_id) and bpcore:getAvailable("MA", settings["GAINS"]:current()) then
                        if not bpcore:buffActive(119) and not bpcore:buffActive(120) and not bpcore:buffActive(121) and not bpcore:buffActive(122) and not bpcore:buffActive(123) and not bpcore:buffActive(124) and not bpcore:buffActive(125) then
                            helpers['queue'].add(MA[settings["GAINS"]:current()], "me")
                        end                    
                    end
                    
                    -- ENSPELLS
                    if bpcore:canCast() and bpcore:isMAReady(MA[settings["ENSPELL"]:current()].recast_id) and bpcore:getAvailable("MA", settings["ENSPELL"]:current()) then
                        if not bpcore:buffActive(94) and not bpcore:buffActive(95) and not bpcore:buffActive(96) and not bpcore:buffActive(97) and not bpcore:buffActive(98) and not bpcore:buffActive(99) then
                            helpers['queue'].add(MA[settings["ENSPELL"]:current()], "me")
                        end                    
                    end
                    
                    -- SPIKES
                    if settings["SPIKES"]:current() ~= "None" then
                        if bpcore:canCast() and bpcore:isMAReady(MA[settings["SPIKES"]:current()].recast_id) and bpcore:getAvailable("MA", settings["SPIKES"]:current()) then
                            if bpcore:isMAReady(MA[settings["SPIKES"]:current()].recast_id) and not bpcore:buffActive(34) and not bpcore:buffActive(35) and not bpcore:buffActive(38) then
                                helpers['queue'].add(MA[settings["SPIKES"]:current()], "me")
                            end
                        end
                    end
                    
                    -- /WAR.
                    if player.sub_job == "WAR" then
                        
                        -- BERSERK.
                        if bpcore:canAct() and bpcore:isJAReady(JA["Berserk"].recast_id) and bpcore:getAvailable("JA", "Berserk") then
                            helpers['queue'].add(JA["Berserk"], "me")
                        
                        -- AGGRESSOR.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Aggressor"].recast_id) and bpcore:getAvailable("JA", "Aggressor") then
                            helpers['queue'].add(JA["Aggressor"], "me")
                        
                        -- WARCRY.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Warcry"].recast_id) and bpcore:getAvailable("JA", "Warcry") then
                            helpers['queue'].add(JA["Warcry"], "me")
                            
                        end
                        
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                    
                        -- HASTE SAMBA.
                        if bpcore:canAct() and bpcore:isJAReady(JA["Haste Samba"].recast_id) and bpcore:getAvailable("JA", "Haste Samba") then
                            helpers['queue'].add(JA["Haste Samaba"], "me")                            
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
                    
                    -- RDM/.
                    if player.main_job == "RDM" and bpcore:canCast() then
                    
                        -- FRAZZLE II.
                        if bpcore:isMAReady(MA["Frazzle II"].recast_id) and os.clock()-settings["SPELLS"]["Frazzle II"].allowed > settings["SPELLS"]["Frazzle II"].delay and bpcore:getAvailable("MA", "Frazzle II") then
                            helpers['queue'].add(MA["Frazzle II"], "t")
                            settings["SPELLS"]["Frazzle II"].allowed = os.clock()
                            
                        -- FRAZZLE III.
                        elseif bpcore:isMAReady(MA["Frazzle III"].recast_id) and os.clock()-settings["SPELLS"]["Frazzle III"].allowed > settings["SPELLS"]["Frazzle III"].delay and bpcore:getAvailable("MA", "Frazzle II") then
                            helpers['queue'].add(MA["Frazzle III"], "t")
                            settings["SPELLS"]["Frazzle III"].allowed = os.clock()
                            
                        -- DISTRACT III.
                        elseif bpcore:isMAReady(MA["Distract III"].recast_id) and os.clock()-settings["SPELLS"]["Distract III"].allowed > settings["SPELLS"]["Distract III"].delay and bpcore:getAvailable("MA", "Frazzle II") then
                            helpers['queue'].add(MA["Distract III"], "t")
                            settings["SPELLS"]["Distract III"].allowed = os.clock()
                            
                        -- DIA / BIO III.
                        elseif bpcore:getAvailable("MA", settings["DIA"]:current().." III") then
                        
                            if bpcore:isMAReady(MA[settings["DIA"]:current().." III"].recast_id) and os.clock()-settings["SPELLS"][settings["DIA"]:current().." III"].allowed > settings["SPELLS"][settings["DIA"]:current().." III"].delay then
                                helpers['queue'].add(MA[settings["DIA"]:current().." III"], "t")
                                settings["SPELLS"][settings["DIA"]:current().." III"].allowed = os.clock()
                                
                            end
                        
                        -- SILENCE.
                        elseif bpcore:isMAReady(MA["Silence"].recast_id) and os.clock()-settings["SPELLS"]["Silence"].allowed > settings["SPELLS"]["Silence"].delay and bpcore:getAvailable("MA", "Silence") then
                            helpers['queue'].add(MA["Silence"], "t")
                            settings["SPELLS"]["Silence"].allowed = os.clock()
                        
                        -- ADDLE II.
                        elseif bpcore:isMAReady(MA["Addle II"].recast_id) and os.clock()-settings["SPELLS"]["Addle II"].allowed > settings["SPELLS"]["Addle II"].delay and bpcore:getAvailable("MA", "Addle II")  then
                            helpers['queue'].add(MA["Addle II"], "t")
                            settings["SPELLS"]["Addle II"].allowed = os.clock()
                        
                        -- PARALYZE II.
                        elseif bpcore:isMAReady(MA["Paralyze II"].recast_id) and os.clock()-settings["SPELLS"]["Paralyze II"].allowed > settings["SPELLS"]["Paralyze II"].delay and bpcore:getAvailable("MA", "Paralyze II")  then
                            helpers['queue'].add(MA["Paralyze II"], "t")
                            settings["SPELLS"]["Paralyze II"].allowed = os.clock()
                        
                        -- SLOW II.
                        elseif bpcore:isMAReady(MA["Slow II"].recast_id) and os.clock()-settings["SPELLS"]["Slow II"].allowed > settings["SPELLS"]["Slow II"].delay and bpcore:getAvailable("MA", "Slow II") then
                            helpers['queue'].add(MA["Slow II"], "t")
                            settings["SPELLS"]["Slow II"].allowed = os.clock()
                        
                        -- BLIND II.
                        elseif bpcore:isMAReady(MA["Blind II"].recast_id) and os.clock()-settings["SPELLS"]["Blind II"].allowed > settings["SPELLS"]["Blind II"].delay and bpcore:getAvailable("MA", "Blind II") then
                            helpers['queue'].add(MA["Blind II"], "t")
                            settings["SPELLS"]["Blind II"].allowed = os.clock()
                        
                        -- INUNDATION.
                        elseif bpcore:isMAReady(MA["Inundation"].recast_id) and os.clock()-settings["SPELLS"]["Inundation"].allowed > settings["SPELLS"]["Inundation"].delay and bpcore:getAvailable("MA", "Inundation") then
                            helpers['queue'].add(MA["Inundation"], "t")
                            settings["SPELLS"]["Inundation"].allowed = os.clock()
                        
                        -- DISPEL.
                        elseif bpcore:isMAReady(MA["Dispel"].recast_id) and os.clock()-settings["SPELLS"]["Dispel"].allowed > settings["SPELLS"]["Dispel"].delay and bpcore:getAvailable("MA", "Dispel") then
                            helpers['queue'].add(MA["Dispel"], "t")
                            settings["SPELLS"]["Dispel"].allowed = os.clock()
                        
                        end
                    
                    end
                    
                    -- /DNC.
                    if player.sub_job == "DNC" and bpcore:canAct() then
                    
                        -- STEPS.
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["RDM"]["Steps Timer"] > system["RDM"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers['queue'].add(JA[settings["STEPS"]:current()], "me")                            
                        end
                    
                    end
                    
                    -- DRAINS LOGIC
                    if settings["DRAINS"]:current() and bpcore:canCast() then
                        
                        -- DRAIN
                        if bpcore:isMAReady(MA["Drain"].recast_id) and player["vitals"].mpp < system["RDM"]["Drain Threshold"] and bpcore:getAvailable("MA", "Drain") then
                            helpers['queue'].add(MA["Drain"], "t")
                        end
                        
                        -- ASPIR
                        if bpcore:isMAReady(MA["Aspir"].recast_id) and player["vitals"].mpp < system["RDM"]["Aspir Threshold"] and bpcore:getAvailable("MA", "Aspir") then
                            helpers['queue'].add(MA["Aspir"], "t")
                        end
                        
                    end
                    
                end
            
            -- PLAYER IS DISENGAGED LOGIC.
            elseif (player.status == 0 or settings["SUPER-TANK"]:current()) then
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
                if settings["WS"]:current() and bpcore:canAct() and settings["RA"]:current() and bpcore:canEngage(helpers["target"].getTarget()) then
                    
                    if not settings["AM"]:current() and player["vitals"].tp > settings["TP THRESHOLD"] and (system["Ranged"].en == "Kaja Bow" or system["Ranged"].en == "Ullr Bow") then
                        helpers['queue'].addToFront(WS[settings["Empyreal Arrow"]], target)
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- RDM/.
                    if player.main_job == "RDM" then
                        
                        -- COMPOSURE LOGIC.
                        if settings["COMPOSURE"]:current() and bpcore:isJAReady(JA["Composure"].recast_id) and not bpcore:buffActive(419) and bpcore:getAvailable("JA", "Composure") then
                            helpers['queue'].add(JA["Composure"], "me")                            
                        end
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and player["vitals"].hpp > system["RDM"]["Convert Threshold"].hpp and player["vitals"].mpp < system["RDM"]["Convert Threshold"].mpp then
                            
                            if bpcore:isJAReady(JA["Convert"].recast_id) and bpcore:getAvailable("JA", "Convert") then
                                helpers['queue'].add(JA["Convert"], "me")
                            end
                            
                        end
                    
                    end
                    
                    -- /DNC.
                    if player.sub_job == "DNC" and bpcore:canAct() then
                        
                        -- REVERSE FLOURISH.
                        if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) and bpcore:getFinishingMoves() > 4 and bpcore:getAvailable("JA", "Reverse Flourish") then
                            helpers['queue'].add(JA["Reverse Flourish"], "me")                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    -- /WAR.
                    if player.sub_job == "WAR" and bpcore:canAct() and bpcore:canEngage(helpers["target"].getTarget()) then
                        
                        -- PROVOKE.
                        if bpcore:isJAReady(JA["Provoke"].recast_id) and bpcore:getAvailable("JA", "Provoke") then
                            helpers['queue'].add(JA["Provoke"], target)                            
                        end
                        
                    -- /DNC.
                    elseif player.sub_job == "DNC" and bpcore:canAct() and bpcore:canEngage(helpers["target"].getTarget()) then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and bpcore:getAvailable("JA", "Animated Flourish") then
                            helpers['queue'].add(JA["Animated Flourish"], target)                            
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    -- RDM/.
                    if player.main_job == "RDM" and bpcore:canCast() then
                    
                        -- REFRESH III
                        if bpcore:isMAReady(MA["Refresh III"].recast_id) and not bpcore:buffActive(43) and bpcore:getAvailable("MA", "Refresh III") then
                            helpers['queue'].add(MA["Refresh III"], "me")
                        
                        -- REFRESH II
                        elseif bpcore:isMAReady(MA["Refresh II"].recast_id) and not bpcore:buffActive(43) and bpcore:getAvailable("MA", "Refresh II") then
                            helpers['queue'].add(MA["Refresh II"], "me")
                        
                        -- REFRESH I
                        elseif bpcore:isMAReady(MA["Refresh"].recast_id) and not bpcore:buffActive(43) and bpcore:getAvailable("MA", "Refresh") then
                            helpers['queue'].add(MA["Refresh"], "me")
                            
                        end
                        
                        -- HASTE II
                        if bpcore:isMAReady(MA["Haste II"].recast_id) and not bpcore:buffActive(33) and not bpcore:buffActive(580) and bpcore:getAvailable("MA", "Haste II") then
                            helpers['queue'].add(MA["Haste II"], "me")
                        
                        -- HASTE
                        elseif bpcore:isMAReady(MA["Haste"].recast_id) and not bpcore:buffActive(33) and not bpcore:buffActive(580) and bpcore:getAvailable("MA", "Haste") then
                            helpers['queue'].add(MA["Haste"], "me")
                            
                        end
                        
                        -- TEMPER II
                        if bpcore:isMAReady(MA["Temper II"].recast_id) and not bpcore:buffActive(432) and bpcore:getAvailable("MA", "Temper II") then
                            helpers['queue'].add(MA["Temper II"], "me")
                        
                        -- TEMPER
                        elseif bpcore:isMAReady(MA["Temper"].recast_id) and not bpcore:buffActive(432) and bpcore:getAvailable("MA", "Temper") then
                            helpers['queue'].add(MA["Temper"], "me")
                            
                        end   
                        
                        -- PHALANX
                        if bpcore:isMAReady(MA["Phalanx"].recast_id) and not bpcore:buffActive(116) and bpcore:getAvailable("MA", "Phalanx") then
                            helpers['queue'].add(MA["Phalanx"], "me")                        
                        end
                        
                        -- AQUAVEIL
                        if bpcore:isMAReady(MA["Aquaveil"].recast_id) and not bpcore:buffActive(39) and bpcore:getAvailable("MA", "Aquaveil") then
                            helpers['queue'].add(MA["Aquaveil"], "me")
                        end
                        
                        -- GAINS
                        if bpcore:isMAReady(MA[settings["GAINS"]:current()].recast_id) and bpcore:getAvailable("MA", settings["GAINS"]:current()) then
                            
                            if not bpcore:buffActive(119) and not bpcore:buffActive(120) and not bpcore:buffActive(121) and not bpcore:buffActive(122) and not bpcore:buffActive(123) and not bpcore:buffActive(124) and not bpcore:buffActive(125) then
                                helpers['queue'].add(MA[settings["GAINS"]:current()], "me")
                            end
                        
                        end
                        
                        -- ENSPELLS
                        if bpcore:isMAReady(MA[settings["ENSPELL"]:current()].recast_id) and bpcore:getAvailable("MA", settings["ENSPELL"]:current()) then
                            if not bpcore:buffActive(94) and not bpcore:buffActive(95) and not bpcore:buffActive(96) and not bpcore:buffActive(97) and not bpcore:buffActive(98) and not bpcore:buffActive(99) then
                                helpers['queue'].add(MA[settings["ENSPELL"]:current()], "me")
                            end
                        
                        end
                        
                        -- SPIKES
                        if settings["SPIKES"]:current() ~= "None" and bpcore:isMAReady(MA[settings["SPIKES"]:current()].recast_id)and bpcore:getAvailable("MA", settings["SPIKES"]:current()) then
                            if not bpcore:buffActive(34) and not bpcore:buffActive(35) and not bpcore:buffActive(38) then
                                helpers['queue'].add(MA[settings["SPIKES"]:current()], "me")
                            end
                        
                        end
                    
                    end
                    
                    -- /WAR.
                    if player.sub_job == "WAR" and bpcore:canAct() then
                        
                        -- BERSERK.
                        if bpcore:isJAReady(JA["Berserk"].recast_id) and bpcore:getAvailable("JA", "Berserk") then
                            helpers['queue'].add(JA["Berserk"], "me")
                        
                        -- AGGRESSOR.
                        elseif bpcore:isJAReady(JA["Aggressor"].recast_id) and bpcore:getAvailable("JA", "Aggressor") then
                            helpers['queue'].add(JA["Aggressor"], "me")
                        
                        -- WARCRY.
                        elseif bpcore:isJAReady(JA["Warcry"].recast_id) and bpcore:getAvailable("JA", "Warcry") then
                            helpers['queue'].add(JA["Warcry"], "me")
                            
                        end
                        
                    -- /DNC.
                    elseif player.sub_job == "DNC" and bpcore:canAct() then
                    
                        -- HASTE SAMBA.
                        if bpcore:isJAReady(JA["Haste Samba"].recast_id) and bpcore:getAvailable("JA", "Warcry") then
                            helpers['queue'].add(JA["Haste Samaba"], "me")                            
                        end
                    
                    -- /NIN.
                    elseif player.sub_job == "NIN" then
                    
                        -- UTSUSEMI
                        if bpcore:findItemByName("Shihei", 0) then
                            
                            if not bpcore:buffActive(444) and not bpcore:buffActive(445) and not bpcore:buffActive(446) and not bpcore:buffActive(36) then
                                
                                if windower.ffxi.get_spells()[MA["Utsusemi: Ni"].id] and bpcore:isMAReady(MA["Utsusemi: Ni"].recast_id) then
                                    helpers['queue'].addToFront(MA["Utsusemi: Ni"], "me")
                                    
                                elseif windower.ffxi.get_spells()[MA["Utsusemi: Ichi"].id] and bpcore:isMAReady(MA["Utsusemi: Ichi"].recast_id) then
                                    helpers['queue'].addToFront(MA["Utsusemi: Ichi"], "me")
                                    
                                end
                            
                            end
                        
                        end
                    
                    end
                    
                end
                
                -- DEBUFF LOGIC.
                if settings["DEBUFFS"]:current() then
                    
                    -- RDM/.
                    if player.main_job == "RDM" and bpcore:canCast() and bpcore:canEngage(helpers["target"].getTarget()) then
                    
                        -- FRAZZLE II.
                        if bpcore:isMAReady(MA["Frazzle II"].recast_id) and os.clock()-settings["SPELLS"]["Frazzle II"].allowed > settings["SPELLS"]["Frazzle II"].delay and bpcore:getAvailable("MA", "Frazzle II") then
                            helpers['queue'].add(MA["Frazzle II"], target)
                            settings["SPELLS"]["Frazzle II"].allowed = os.clock()
                            
                        -- FRAZZLE III.
                        elseif bpcore:isMAReady(MA["Frazzle III"].recast_id) and os.clock()-settings["SPELLS"]["Frazzle III"].allowed > settings["SPELLS"]["Frazzle III"].delay and bpcore:getAvailable("MA", "Frazzle II") then
                            helpers['queue'].add(MA["Frazzle III"], target)
                            settings["SPELLS"]["Frazzle III"].allowed = os.clock()
                            
                        -- DISTRACT III.
                        elseif bpcore:isMAReady(MA["Distract III"].recast_id) and os.clock()-settings["SPELLS"]["Distract III"].allowed > settings["SPELLS"]["Distract III"].delay and bpcore:getAvailable("MA", "Frazzle II") then
                            helpers['queue'].add(MA["Distract III"], target)
                            settings["SPELLS"]["Distract III"].allowed = os.clock()
                            
                        -- DIA / BIO III.
                        elseif bpcore:getAvailable("MA", settings["DIA"]:current().." III") then
                        
                            if bpcore:isMAReady(MA[settings["DIA"]:current().." III"].recast_id) and os.clock()-settings["SPELLS"][settings["DIA"]:current().." III"].allowed > settings["SPELLS"][settings["DIA"]:current().." III"].delay then
                                helpers['queue'].add(MA[settings["DIA"]:current().." III"], target)
                                settings["SPELLS"][settings["DIA"]:current().." III"].allowed = os.clock()
                                
                            end
                        
                        -- SILENCE.
                        elseif bpcore:isMAReady(MA["Silence"].recast_id) and os.clock()-settings["SPELLS"]["Silence"].allowed > settings["SPELLS"]["Silence"].delay and bpcore:getAvailable("MA", "Silence") then
                            helpers['queue'].add(MA["Silence"], target)
                            settings["SPELLS"]["Silence"].allowed = os.clock()
                        
                        -- ADDLE II.
                        elseif bpcore:isMAReady(MA["Addle II"].recast_id) and os.clock()-settings["SPELLS"]["Addle II"].allowed > settings["SPELLS"]["Addle II"].delay and bpcore:getAvailable("MA", "Addle II") then
                            helpers['queue'].add(MA["Addle II"], target)
                            settings["SPELLS"]["Addle II"].allowed = os.clock()
                        
                        -- PARALYZE II.
                        elseif bpcore:isMAReady(MA["Paralyze II"].recast_id) and os.clock()-settings["SPELLS"]["Paralyze II"].allowed > settings["SPELLS"]["Paralyze II"].delay and bpcore:getAvailable("MA", "Paralyze II") then
                            helpers['queue'].add(MA["Paralyze II"], target)
                            settings["SPELLS"]["Paralyze II"].allowed = os.clock()
                        
                        -- SLOW II.
                        elseif bpcore:isMAReady(MA["Slow II"].recast_id) and os.clock()-settings["SPELLS"]["Slow II"].allowed > settings["SPELLS"]["Slow II"].delay and bpcore:getAvailable("MA", "Slow II") then
                            helpers['queue'].add(MA["Slow II"], target)
                            settings["SPELLS"]["Slow II"].allowed = os.clock()
                        
                        -- BLIND II.
                        elseif bpcore:isMAReady(MA["Blind II"].recast_id) and os.clock()-settings["SPELLS"]["Blind II"].allowed > settings["SPELLS"]["Blind II"].delay and bpcore:getAvailable("MA", "Blind II") then
                            helpers['queue'].add(MA["Blind II"], target)
                            settings["SPELLS"]["Blind II"].allowed = os.clock()
                        
                        -- INUNDATION.
                        elseif bpcore:isMAReady(MA["Inundation"].recast_id) and os.clock()-settings["SPELLS"]["Inundation"].allowed > settings["SPELLS"]["Inundation"].delay and bpcore:getAvailable("MA", "Inundation") then
                            helpers['queue'].add(MA["Inundation"], target)
                            settings["SPELLS"]["Inundation"].allowed = os.clock()
                        
                        -- DISPEL.
                        elseif bpcore:isMAReady(MA["Dispel"].recast_id) and os.clock()-settings["SPELLS"]["Dispel"].allowed > settings["SPELLS"]["Dispel"].delay and bpcore:getAvailable("MA", "Dispel") then
                            helpers['queue'].add(MA["Dispel"], target)
                            settings["SPELLS"]["Dispel"].allowed = os.clock()
                        
                        end
                    
                    end
                
                end
                
                -- DRAINS LOGIC
                if settings["DRAINS"]:current() and bpcore:canCast() then
                    
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
            
            -- HANDLE EVERYTHING INSIDE THE QUEUE.
            helpers["cures"].handleCuring()
            helpers["buffer"].handleBuffs()
            helpers['queue'].handleQueue()
        
        end
        
    end
    
    self.handleWindow = function()
        
        if display:current() then
            
            -- Build Variables.
            local player  = windower.ffxi.get_player() or false
            local enmity  = ""
            local strings = {}
            
            if helpers["target"].exists(system["Enmity Target"]) and helpers["target"].exists(system["Attacker Target"]) then
                enmity = system["Enmity Target"].name
            
            else
                enmity = "N/A"
                
            end
            
            -- Build String Table.
            table.insert(strings, ("[ HP%: "        .. bpcore:colorize(player["vitals"].hpp, "255,51,0") .. " ]"))
            table.insert(strings, ("[ MP%: "        .. bpcore:colorize(player["vitals"].mpp, "255,51,0") .. " ]"))
            table.insert(strings, ("[ Enmity: ("    .. bpcore:colorize(enmity, "255,51,0")               .. ") ]"))
            
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