--------------------------------------------------------------------------------
-- GEO Core: Handle all job automation for Geomancer.
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
        
        ["Dia"]           = {["allowed"]=0,["delay"]=60},  ["Dia II"]      ={["allowed"]=0,["delay"]=120},
        ["Bio"]           = {["allowed"]=0,["delay"]=60},  ["Bio II"]      ={["allowed"]=0,["delay"]=120},
        ["Distract"]      = {["allowed"]=0,["delay"]=120}, ["Dispel"]      ={["allowed"]=0,["delay"]=15},
        ["Frazzle"]       = {["allowed"]=0,["delay"]=120}, ["Blind"]       ={["allowed"]=0,["delay"]=180}, 
        ["Paralyze"]      = {["allowed"]=0,["delay"]=120}, ["Slow"]        ={["allowed"]=0,["delay"]=120}, 
        ["Silence"]       = {["allowed"]=0,["delay"]=120}, 
        
    }
    
    -- MAGIC BURST.
    settings["MAGIC BURST"]={
        
        ["Transfixion"]   = T{},
        ["Compression"]   = T{"Bio II","Bio III","Aspir III","Drain","Frazzle"},
        ["Liquefaction"]  = T{"Fire","Fire II","Fire III","Fire IV","Fire V"},
        ["Scission"]      = T{"Stone","Stone II","Stone III","Stone IV","Stone V"},
        ["Reverberation"] = T{"Water","Water II","Water III","Water IV","Water V","Poison II"},
        ["Detonation"]    = T{"Aero","Aero II","Aero III","Aero IV","Aero V","Silence"},
        ["Induration"]    = T{"Blizzard","Blizzard II","Blizzard III","Blizzard IV","Blizzard V"},
        ["Impaction"]     = T{"Thunder","Thunder II","Thunder III","Thunder IV","Thunder V"},
        
    }
    
    -- JOB POINTS AVAILABLE.
    settings["JOB POINTS"] = windower.ffxi.get_player()["job_points"][windower.ffxi.get_player().main_job:lower()].jp_spent
    
    -- SPELL SHORTCUTS.
    local shortcuts = {
        
        ["I-SPELLS"] = {
            
            -- PLAYER ENHANCING.
            ["str"]    = "Indi-STR",         ["dex"]     = "Indi-DEX",
            ["agi"]    = "Indi-AGI",         ["int"]     = "Indi-INT",
            ["mnd"]    = "Indi-MND",         ["chr"]     = "Indi-CHR",
            ["vit"]    = "Indi-VIT",         ["refresh"] = "Indi-Refresh",
            ["regen"]  = "Indi-Regen",       ["haste"]   = "Indi-Haste",
            ["eva"]    = "Indi-Voidance",    ["acc"]     = "Indi-Precision",
            ["mev"]    = "Indi-Attunement",  ["macc"]    = "Indi-Focus",
            ["def"]    = "Indi-Barrier",     ["att"]     = "Indi-Fury",
            ["mdb"]    = "Indi-Fend",        ["mab"]     = "Indi-Acumen",
            
            -- ENEMY REDUCTION.
            ["para"]   = "Indi-Paralysis",   ["grav"]    = "Indi-Gravity",
            ["poison"] = "Indi-Poison",      ["Slow"]    = "Indi-Slow",
            ["macc-"]  = "Indi-Vex",         ["eva-"]    = "Indi-Torpor",
            ["acc-"]   = "Indi-Slip",        ["mev-"]    = "Indi-Languor",
            ["def-"]   = "Indi-Frailty",     ["att-"]    = "Indi-Wilt",
            ["mdb-"]   = "Indi-Malaise",     ["mab-"]    = "Indi-Fade",
        
        },
        ["G-SPELLS"] = {
            
            -- PLAYER ENHANCING.
            ["str"]    = "Geo-STR",         ["dex"]     = "Geo-DEX",
            ["agi"]    = "Geo-AGI",         ["int"]     = "Geo-INT",
            ["mnd"]    = "Geo-MND",         ["chr"]     = "Geo-CHR",
            ["vit"]    = "Geo-VIT",         ["refresh"] = "Geo-Refresh",
            ["regen"]  = "Geo-Regen",       ["haste"]   = "Geo-Haste",
            ["eva"]    = "Geo-Voidance",    ["acc"]     = "Geo-Precision",
            ["mev"]    = "Geo-Attunement",  ["macc"]    = "Geo-Focus",
            ["def"]    = "Geo-Barrier",     ["att"]     = "Geo-Fury",
            ["mdb"]    = "Geo-Fend",        ["mab"]     = "Geo-Acumen",
            
            -- ENEMY REDUCTION.
            ["para"]   = "Geo-Paralysis",   ["grav"]    = "Geo-Gravity",
            ["poison"] = "Geo-Poison",      ["Slow"]    = "Geo-Slow",
            ["macc-"]  = "Geo-Vex",         ["eva-"]    = "Geo-Torpor",
            ["acc-"]   = "Geo-Slip",        ["mev-"]    = "Geo-Languor",
            ["def-"]   = "Geo-Frailty",     ["att-"]    = "Geo-Wilt",
            ["mdb-"]   = "Geo-Malaise",     ["mab-"]    = "Geo-Fade",
            
        },
    
    }
    
    -- CURRENT BUFFS.
    local colure_active = 0
    local luopan_active = 0
    helpers["target"].setEntrustTarget("Eliidyr")
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
            
            if command == "i" then
                settings["INDI"]:next()
                message = string.format("AUTO-INDICOLURE: %s", tostring(settings["INDI"]:current()))
                
            elseif command == "g" then
                settings["GEO"]:next()
                message = string.format("AUTO-GEOCOLURE: %s", tostring(settings["GEO"]:current()))
                
            elseif command == "e" then
                settings["ENTRUST"]:next()
                message = string.format("AUTO-ENTRUST: %s", tostring(settings["ENTRUST"]:current()))
                
            elseif command == "ispell" then
                local spell   = commands[2] or false
                local entrust = commands[3] or false
                
                if shortcuts["I-SPELLS"][spell:lower()] and not entrust then                
                    settings["ISPELL"] = shortcuts["I-SPELLS"][spell:lower()]
                    message = string.format("INDI-SPELL NOW SET TO: %s", tostring(settings["ISPELL"]))
                    
                elseif shortcuts["I-SPELLS"][spell] and shortcuts["I-SPELLS"][entrust] then
                    settings["ISPELL"] = shortcuts["I-SPELLS"][spell:lower()]
                    settings["ESPELL"] = shortcuts["I-SPELLS"][entrust:lower()]
                    message = string.format("INDI-SPELL & ENTRUST SPELL NOW SET TO: %s & %s", tostring(settings["ISPELL"]), tostring(settings["ESPELL"]))
                    
                end
            
            elseif command == "gspell" then
                local spell = commands[2]:lower() or false
                
                if shortcuts["G-SPELLS"][spell] then
                    settings["GSPELL"] = shortcuts["G-SPELLS"][spell]
                    message = string.format("GEO-SPELL NOW SET TO: %s", tostring(settings["GSPELL"]))
                    
                end
            
            elseif command == "espell" then
                local spell = commands[2]:lower() or false
                
                if shortcuts["I-SPELLS"][spell] then
                    settings["ESPELL"] = shortcuts["I-SPELLS"][spell]
                    message = string.format("ENTRUST-SPELL NOW SET TO: %s", tostring(settings["ESPELL"]))
                    
                end
            
            elseif ("ecliptic"):match(command) or ("lasting"):match(command) then
                settings["BUBBLE BUFF"]:next()
                message = string.format("BUBBLE ENHANCEMENT NOW SET TO: %s", tostring(settings["BUBBLE BUFF"]:current()))
                
            elseif command == "ambuscade" then
                settings["HATE"]:setTo(false)
                settings["BUFFS"]:setTo(true)
                settings["JA"]:setTo(true)
                settings["WS"]:setTo(true)
                settings["WSNAME"] = "Judgment"
                settings["TP Threshold"] = 1300
                settings["INDI"]:setTo(true)
                settings["GEO"]:setTo(true)
                settings["ENTRUST"]:setTo(true)
                settings["ISPELL"] = "Indi-Fury"
                settings["GSPELL"] = "Geo-Frailty"
                settings["ESPELL"] = "Indi-Barrier"
                settings["CURES"]:setTo(2)
                settings["STATUS"]:setTo(true)
                helpers["controls"].setEnabled(true)
                
                -- Set Bubbles.
                helpers["target"].setEntrustTarget("Eliidyr")
                
                if bpcore:isLeader() and windower.ffxi.get_party().party1_count < 6 then
                    helpers["trust"].setEnabled(true)
                end
                
            elseif command == "disable" then
                settings["HATE"]:setTo(false)
                settings["BUFFS"]:setTo(false)
                settings["JA"]:setTo(false)
                settings["WS"]:setTo(true)
                settings["WSNAME"] = "Judgment"
                settings["TP Threshold"] = 1000
                settings["INDI"]:setTo(false)
                settings["GEO"]:setTo(false)
                settings["ENTRUST"]:setTo(false)
                settings["CURES"]:setTo(1)
                settings["STATUS"]:setTo(false)
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
            local player  = windower.ffxi.get_player() or false
            local current = helpers["queue"].getNextAction() or false
            local gtarget = helpers["target"].getLuopanTarget() or helpers["target"].getTarget() or false
            local etarget = helpers["target"].getEntrustTarget() or false
            local luopan  = windower.ffxi.get_mob_by_target("pet") or false
            
            -- Determine how to handle status debuffs.
            if settings["STATUS"]:current() then
                helpers["status"].manangeStatuses()
            end
            
            -- Update Luopan Active ID.
            if not luopan then
                system["Core"].setLuopan(0)
                
            end
            
            -- PLAYER IS ENGAGED.
            if player.status == 1 then
                local target = helpers["target"].getTarget() or windower.ffxi.get_mob_by_target("t") or false
                
                -- LUOPAN DISTANCE LOGIC.
                if luopan and (luopan.distance):sqrt() > 30 then
                
                    if bpcore:getAvailable("JA", "Full Circle") and bpcore:isJAReady(JA["Full Circle"].recast_id) then
                        helpers["queue"].addToFront(JA["Full Circle"], "me")
                    end
                    
                end
                
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
                
                -- INDICOLURE LOGIC.
                if settings["INDI"]:current() and bpcore:canCast() then
                    local indispell = MA[settings["ISPELL"]] or false
                    local active    = system["Core"].getColure()
                    
                    if indispell and (active ~= indispell.id or active == 0) and bpcore:getAvailable("MA", indispell.name) and bpcore:isMAReady(MA[indispell.name].recast_id) then
                        helpers["queue"].addToFront(MA[indispell.name], "me")                        
                    end
                    
                end
                
                -- ENTRUST LOGIC.
                if settings["ENTRUST"]:current() and bpcore:canCast() and bpcore:canAct() and etarget and not bpcore:buffActive(584) and bpcore:isJAReady(JA["Entrust"].recast_id) and bpcore:getAvailable("JA", "Entrust") then
                    local entrustspell = MA[settings["ESPELL"]] or false
                    
                    if entrustspell and bpcore:getAvailable("MA", entrustspell.name) and bpcore:isMAReady(MA[entrustspell.name].recast_id) then
                        helpers["queue"].addToFront(MA[entrustspell.name], etarget)
                        helpers["queue"].addToFront(JA["Entrust"], "me")
                    end
                    
                end
                
                -- LUOPAN LOGIC.
                if settings["GEO"]:current() and bpcore:canCast() and gtarget then
                    local geospell = MA[settings["GSPELL"]] or false
                    local active   = system["Core"].getLuopan()
                    
                    if geospell and (active ~= geospell.id or active == 0) and bpcore:getAvailable("MA", geospell.name) and bpcore:isMAReady(MA[geospell.name].recast_id) then
                        
                        if settings["JA"]:current() and bpcore:canAct() and not bpcore:buffActive(569) and bpcore:getAvailable("JA", "Blaze of Glory") and bpcore:getAvailable("JA", settings["BUBBLE BUFF"]:current()) then
                            
                            if bpcore:isJAReady(JA[settings["BUBBLE BUFF"]:current()].recast_id) and bpcore:isJAReady(JA["Blaze of Glory"].recast_id) then
                                helpers["queue"].addToFront(JA[settings["BUBBLE BUFF"]:current()], "me")
                                helpers["queue"].addToFront(MA[geospell.name], gtarget)
                                helpers["queue"].addToFront(JA["Blaze of Glory"], "me")
                                helpers["queue"].add(MA["Stone"], gtarget)
                            
                            else
                                helpers["queue"].addToFront(MA[geospell.name], gtarget)
                                helpers["queue"].add(MA["Stone"], gtarget)                            
                            end
                        
                        else
                            helpers["queue"].addToFront(MA[geospell.name], gtarget)
                            helpers["queue"].add(MA["Stone"], gtarget)
                            
                        end
                        
                    end
                    
                end
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() then
                    
                    if settings["AM"]:current() then
                        
                        if bpcore:buffActive(272) and player["vitals"].tp > 1000 then
                            
                            if player["vitals"].mpp < system["GEO"]["Moonlight Threshold"] and bpcore:getAvailable("WS", "Moonlight") then
                                helpers["queue"].addToFront(WS["Moonlight"], "me")
                            
                            elseif bpcore:getAvailable("WS", settings["WSNAME"]) and player["vitals"].tp > settings["TP THRESHOLD"] then
                                helpers["queue"].addToFront(WS[settings["WSNAME"]], "t")
                            end
                            
                        elseif not bpcore:buffActive(272) and player["vitals"].tp > settings["AM THRESHOLD"] and system["Weapon"].en == "Tishtrya" and bpcore:getAvailable("WS", "Realmrazer") then
                            helpers["queue"].addToFront(WS["Realmrazer"], "t")
                        
                        elseif not bpcore:buffActive(272) and player["vitals"].tp > settings["AM THRESHOLD"] and system["Weapon"].en == "Idris" and bpcore:getAvailable("WS", "Exudation") then
                            helpers["queue"].addToFront(WS["Exudation"], "t")
                        end
                        
                    elseif player["vitals"].tp > 1000 then
                        
                        if player["vitals"].mpp < system["GEO"]["Moonlight Threshold"] and bpcore:getAvailable("WS", "Moonlight") then
                            helpers["queue"].addToFront(WS["Moonlight"], "me")
                        
                        elseif bpcore:getAvailable("WS", settings["WSNAME"]) and player["vitals"].tp > settings["TP THRESHOLD"] then
                            helpers["queue"].addToFront(WS[settings["WSNAME"]], "t")
                        end
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- /RDM.
                    if player.sub_job == "RDM" then
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and player["vitals"].hpp > system["GEO"]["Convert Threshold"].hpp and player["vitals"].mpp < system["GEO"]["Convert Threshold"].mpp then
                            if bpcore:isJAReady(JA["Convert"].recast_id) then
                                helpers["queue"].add(JA["Convert"], "me")
                            end
                            
                        end
                    
                    end
                    
                    -- /DNC.
                    if player.sub_job == "DNC" then
                        
                        -- REVERSE FLOURISH.
                        if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) and bpcore:getFinishingMoves() > 4 then
                            helpers["queue"].add(JA["Reverse Flourish"], "me")                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    -- /WAR.
                    if player.sub_job == "WAR" and bpcore:canAct() then
                        
                        -- PROVOKE.
                        if bpcore:isJAReady(JA["Provoke"].recast_id) then
                            helpers["queue"].add(JA["Provoke"], "t")
                        end
                        
                    -- /DNC.
                    elseif player.sub_job == "DNC" and bpcore:canAct() then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 then
                            helpers["queue"].add(JA["Animated Flourish"], "t")
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    -- /RDM
                    if player.sub_job == "RDM" and bpcore:canCast() then
                        
                        -- REFRESH I
                        if bpcore:isMAReady(MA["Refresh"].recast_id) and not bpcore:buffActive(43) then
                            helpers["queue"].add(MA["Refresh"], "me")
                        end
                        
                        -- HASTE
                        if bpcore:isMAReady(MA["Haste"].recast_id) and not bpcore:buffActive(33) then
                            helpers["queue"].add(MA["Haste"], "me")
                        end
                        
                        -- PHALANX
                        if bpcore:isMAReady(MA["Phalanx"].recast_id) and not bpcore:buffActive(116) then
                            helpers["queue"].add(MA["Phalanx"], "me")
                        end
                        
                        -- STONESKIN
                        if bpcore:isMAReady(MA["Stoneskin"].recast_id) and not bpcore:buffActive(37) then
                            helpers["queue"].add(MA["Stoneskin"], "me")
                        end
                        
                        -- AQUAVEIL
                        if bpcore:isMAReady(MA["Aquaveil"].recast_id) and not bpcore:buffActive(39) then
                            helpers["queue"].add(MA["Aquaveil"], "me")
                        end
                    
                        -- SPIKES
                        if settings["SPIKES"]:current() ~= "None" and bpcore:isMAReady(MA[settings["SPIKES"]:current()].recast_id) and not bpcore:buffActive(34) and not bpcore:buffActive(35) and not bpcore:buffActive(38) then
                            helpers["queue"].add(MA[settings["SPIKES"]:current()], "me")                        
                        end
                    
                    -- /WHM
                    elseif player.sub_job == "WHM" and bpcore:canCast() then
                        
                        -- HASTE
                        if bpcore:isMAReady(MA["Haste"].recast_id) and not bpcore:buffActive(33) then
                            helpers["queue"].add(MA["Haste"], "me")
                        end
                        
                        -- RERAISE
                        if bpcore:isMAReady(MA["Reraise"].recast_id) and not bpcore:buffActive(113) then
                            helpers["queue"].add(MA["Reraise"], "me")
                        end
                        
                        -- STONESKIN
                        if bpcore:isMAReady(MA["Stoneskin"].recast_id) and not bpcore:buffActive(37) then
                            helpers["queue"].add(MA["Stoneskin"], "me")
                        end
                        
                        -- AQUAVEIL
                        if bpcore:isMAReady(MA["Aquaveil"].recast_id) and not bpcore:buffActive(39) then
                            helpers["queue"].add(MA["Aquaveil"], "me")
                        end
                    
                    -- /WAR.
                    elseif player.sub_job == "WAR" and bpcore:canAct() then
                        
                        -- BERSERK.
                        if bpcore:isJAReady(JA["Berserk"].recast_id) then
                            helpers["queue"].add(JA["Berserk"], "me")
                        
                        -- AGGRESSOR.
                        elseif bpcore:isJAReady(JA["Aggressor"].recast_id) then
                            helpers["queue"].add(JA["Aggressor"], "me")
                        
                        -- WARCRY.
                        elseif bpcore:isJAReady(JA["Warcry"].recast_id) then
                            helpers["queue"].add(JA["Warcry"], "me")
                            
                        end
                        
                    -- /DNC.
                    elseif player.sub_job == "DNC" and bpcore:canAct() then
                    
                        -- HASTE SAMBA.
                        if bpcore:isJAReady(JA["Haste Samba"].recast_id) then
                            helpers["queue"].add(JA["Haste Samaba"], "me")                            
                        end
                    
                    -- /NIN.
                    elseif player.sub_job == "NIN" and bpcore:canCast() then
                    
                        -- UTSUSEMI
                        if bpcore:findItemByName("Shihei", 0) then
                            
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
                    
                    -- FRAZZLE.
                    if bpcore:canCast() and bpcore:isMAReady(MA["Frazzle"].recast_id) and os.clock()-settings["SPELLS"]["Frazzle"].allowed > settings["SPELLS"]["Frazzle"].delay and bpcore:getAvailable("MA", "Frazzle") then
                        helpers["queue"].add(MA["Frazzle"], "t")
                        settings["SPELLS"]["Frazzle"].allowed = os.clock()

                    -- DISTRACT.
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Distract"].recast_id) and os.clock()-settings["SPELLS"]["Distract"].allowed > settings["SPELLS"]["Distract"].delay and bpcore:getAvailable("MA", "Distract") then
                        helpers["queue"].add(MA["Distract"], "t")
                        settings["SPELLS"]["Distract"].allowed = os.clock()

                    -- DIA / BIO.
                    elseif bpcore:canCast() and os.clock()-settings["SPELLS"][settings["DIA"]:current()].allowed > settings["SPELLS"][settings["DIA"]:current()].delay then
                        
                        -- TIER II.
                        if bpcore:isMAReady(MA[settings["DIA"]:current().." II"].recast_id) and bpcore:getAvailable("MA", settings["DIA"]:current().." II") then
                            helpers["queue"].add(MA[settings["DIA"]:current().." II"], "t")
                            settings["SPELLS"][settings["DIA"]:current()].allowed = os.clock()
                        
                        -- TIER I.
                        elseif bpcore:isMAReady(MA[settings["DIA"]:current()].recast_id) and bpcore:getAvailable("MA", settings["DIA"]:current()) then
                            helpers["queue"].add(MA[settings["DIA"]:current()], "t")
                            settings["SPELLS"][settings["DIA"]:current()].allowed = os.clock()
                            
                        end
                        
                    -- SILENCE.
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Silence"].recast_id) and os.clock()-settings["SPELLS"]["Silence"].allowed > settings["SPELLS"]["Silence"].delay and bpcore:getAvailable("MA", "Silence") then

                        helpers["queue"].add(MA["Silence"], "t")
                        settings["SPELLS"]["Silence"].allowed = os.clock()
                    
                    -- PARALYZE.
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Paralyze"].recast_id) and os.clock()-settings["SPELLS"]["Paralyze"].allowed > settings["SPELLS"]["Paralyze"].delay and bpcore:getAvailable("MA", "Paralyze") then
                        helpers["queue"].add(MA["Paralyze"], "t")
                        settings["SPELLS"]["Paralyze"].allowed = os.clock()
                    
                    -- SLOW.
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Slow"].recast_id) and os.clock()-settings["SPELLS"]["Slow"].allowed > settings["SPELLS"]["Slow"].delay and bpcore:getAvailable("MA", "Slow") then
                        helpers["queue"].add(MA["Slow"], "t")
                        settings["SPELLS"]["Slow"].allowed = os.clock()
                    
                    -- BLIND.
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Blind"].recast_id) and os.clock()-settings["SPELLS"]["Blind"].allowed > settings["SPELLS"]["Blind"].delay and bpcore:getAvailable("MA", "Blind") then
                        helpers["queue"].add(MA["Blind"], "t")
                        settings["SPELLS"]["Blind"].allowed = os.clock()
                    
                    -- DISPEL.
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Dispel"].recast_id) and os.clock()-settings["SPELLS"]["Dispel"].allowed > settings["SPELLS"]["Dispel"].delay and bpcore:getAvailable("MA", "Dispel") then
                        helpers["queue"].add(MA["Dispel"], "t")
                        settings["SPELLS"]["Dispel"].allowed = os.clock()
                    
                    end
                    
                    -- /DNC.
                    if player.sub_job == "DNC" and bpcore:canAct() and target then
                    
                        -- STEPS.
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["GEO"]["Steps Timer"] > system["GEO"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers["queue"].add(JA[settings["STEPS"]:current()], "t")                            
                        end
                    
                    end
                
                end
                
                -- DRAINS LOGIC
                if settings["DRAINS"]:current() and bpcore:canCast() then
                    
                    -- DRAIN
                    if bpcore:isMAReady(MA["Drain III"].recast_id) and player["vitals"].hpp < system["GEO"]["Drain Threshold"] then
                        helpers["queue"].add(MA["Drain III"], "t")
                        
                    elseif bpcore:isMAReady(MA["Drain II"].recast_id) and player["vitals"].hpp < system["GEO"]["Drain Threshold"] then
                        helpers["queue"].add(MA["Drain II"], "t")
                        
                    elseif bpcore:isMAReady(MA["Drain"].recast_id) and player["vitals"].hpp < system["GEO"]["Drain Threshold"] then
                        helpers["queue"].add(MA["Drain"], "t")
                    
                    end
                    
                    -- ASPIR
                    if bpcore:isMAReady(MA["Aspir III"].recast_id) and player["vitals"].mpp < system["GEO"]["Aspir Threshold"] then
                        helpers["queue"].add(MA["Aspir III"], "t")
                    
                    elseif bpcore:isMAReady(MA["Aspir II"].recast_id) and player["vitals"].mpp < system["GEO"]["Aspir Threshold"] then
                        helpers["queue"].add(MA["Aspir II"], "t")
                    
                    elseif bpcore:isMAReady(MA["Aspir"].recast_id) and player["vitals"].mpp < system["GEO"]["Aspir Threshold"] then
                        helpers["queue"].add(MA["Aspir"], "t")
                    
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
                
                -- INDICOLURE LOGIC.
                if settings["INDI"]:current() and bpcore:canCast() then
                    local indispell = MA[settings["ISPELL"]] or false
                    local active    = system["Core"].getColure()
                    
                    if indispell and (active ~= indispell.id or active == 0) and bpcore:getAvailable("MA", indispell.name) and bpcore:isMAReady(MA[indispell.name].recast_id) then
                        helpers["queue"].addToFront(MA[indispell.name], "me")                        
                    end
                    
                end
                
                -- ENTRUST LOGIC.
                if settings["ENTRUST"]:current() and bpcore:canCast() and bpcore:canAct() and etarget and not bpcore:buffActive(584) and bpcore:isJAReady(JA["Entrust"].recast_id) and bpcore:getAvailable("JA", "Entrust") then
                    local entrustspell = MA[settings["ESPELL"]] or false
                    
                    if entrustspell and bpcore:getAvailable("MA", entrustspell.name) and bpcore:isMAReady(MA[entrustspell.name].recast_id) then
                        helpers["queue"].addToFront(MA[entrustspell.name], etarget)
                        helpers["queue"].addToFront(JA["Entrust"], "me")
                    end
                    
                end
                
                -- LUOPAN DISTANCE LOGIC.
                if luopan and math.sqrt(luopan.distance) > 30 then
                
                    if bpcore:getAvailable("JA", "Full Circle") and bpcore:isJAReady(JA["Full Circle"].recast_id) then
                        helpers["queue"].addToFront(JA["Full Circle"], "me")
                    end
                    
                end
                
                -- LUOPAN LOGIC.
                if settings["GEO"]:current() and bpcore:canCast() and gtarget then
                    local geospell = MA[settings["GSPELL"]] or false
                    local active   = system["Core"].getLuopan()
                    
                    if geospell and (active ~= geospell.id or active == 0) and bpcore:getAvailable("MA", geospell.name) and bpcore:isMAReady(MA[geospell.name].recast_id) then
                        
                        if settings["JA"]:current() and bpcore:canAct() and not bpcore:buffActive(569) and bpcore:getAvailable("JA", "Blaze of Glory") and bpcore:getAvailable("JA", settings["BUBBLE BUFF"]:current()) then
                            
                            if bpcore:isJAReady(JA[settings["BUBBLE BUFF"]:current()].recast_id) and bpcore:isJAReady(JA["Blaze of Glory"].recast_id) then
                                helpers["queue"].addToFront(JA[settings["BUBBLE BUFF"]:current()], "me")
                                helpers["queue"].addToFront(MA[geospell.name], gtarget)
                                helpers["queue"].addToFront(JA["Blaze of Glory"], "me")
                                helpers["queue"].add(MA["Stone"], gtarget)
                            
                            else
                                helpers["queue"].addToFront(MA[geospell.name], gtarget)
                                helpers["queue"].add(MA["Stone"], gtarget)
                            end
                        
                        else
                            helpers["queue"].addToFront(MA[geospell.name], gtarget)
                            helpers["queue"].add(MA["Stone"], gtarget)
                        end
                        
                    end
                    
                end
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() then
                    
                    if player["vitals"].mpp < system["GEO"]["Moonlight Threshold"] and bpcore:getAvailable("WS", "Moonlight") then
                        helpers["queue"].addToFront(WS["Moonlight"], "me")                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- /RDM.
                    if player.sub_job == "RDM" then
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and bpcore:canAct() and player["vitals"].hpp > system["GEO"]["Convert Threshold"].hpp and player["vitals"].mpp < system["GET"]["Convert Threshold"].mpp then
                            if bpcore:isJAReady(JA["Convert"].recast_id) then
                                helpers["queue"].add(JA["Convert"], "me")
                            end
                            
                        end
                    
                    end
                    
                    -- /DNC.
                    if player.sub_job == "DNC" then
                        
                        -- REVERSE FLOURISH.
                        if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) and bpcore:getFinishingMoves() > 4 then
                            helpers["queue"].add(JA["Reverse Flourish"], "me")                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    -- /WAR.
                    if player.sub_job == "WAR" and bpcore:canAct() and bpcore:canEngage(helpers["target"].getTarget()) then
                        
                        -- PROVOKE.
                        if bpcore:isJAReady(JA["Provoke"].recast_id) and target then
                            helpers["queue"].add(JA["Provoke"], target)
                        end
                        
                    -- /DNC.
                    elseif player.sub_job == "DNC" and bpcore:canAct() and bpcore:canEngage(helpers["target"].getTarget()) then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and target then
                            helpers["queue"].add(JA["Animated Flourish"], target)
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    -- /RDM
                    if player.sub_job == "RDM" and bpcore:canCast() then
                        
                        -- REFRESH I
                        if bpcore:isMAReady(MA["Refresh"].recast_id) and not bpcore:buffActive(43) then
                            helpers["queue"].add(MA["Refresh"], "me")
                        end
                        
                        -- HASTE
                        if bpcore:isMAReady(MA["Haste"].recast_id) and not bpcore:buffActive(33) then
                            helpers["queue"].add(MA["Haste"], "me")
                        end
                        
                        -- PHALANX
                        if bpcore:isMAReady(MA["Phalanx"].recast_id) and not bpcore:buffActive(116) then
                            helpers["queue"].add(MA["Phalanx"], "me")
                        end
                        
                        -- STONESKIN
                        if bpcore:isMAReady(MA["Stoneskin"].recast_id) and not bpcore:buffActive(37) then
                            helpers["queue"].add(MA["Stoneskin"], "me")
                        end
                        
                        -- AQUAVEIL
                        if bpcore:isMAReady(MA["Aquaveil"].recast_id) and not bpcore:buffActive(39) then
                            helpers["queue"].add(MA["Aquaveil"], "me")
                        end
                    
                        -- SPIKES
                        if settings["SPIKES"]:current() ~= "None" and bpcore:isMAReady(MA[settings["SPIKES"]:current()].recast_id) and not bpcore:buffActive(34) and not bpcore:buffActive(35) and not bpcore:buffActive(38) then
                            helpers["queue"].add(MA[settings["SPIKES"]:current()], "me")                        
                        end
                    
                    -- /WHM
                    elseif player.sub_job == "WHM" and bpcore:canCast() then
                        
                        -- HASTE
                        if bpcore:isMAReady(MA["Haste"].recast_id) and not bpcore:buffActive(33) then
                            helpers["queue"].add(MA["Haste"], "me")
                        end
                        
                        -- PHALANX
                        if bpcore:isMAReady(MA["Phalanx"].recast_id) and not bpcore:buffActive(116) then
                            helpers["queue"].add(MA["Phalanx"], "me")
                        end
                        
                        -- STONESKIN
                        if bpcore:isMAReady(MA["Stoneskin"].recast_id) and not bpcore:buffActive(37) then
                            helpers["queue"].add(MA["Stoneskin"], "me")
                        end
                        
                        -- AQUAVEIL
                        if bpcore:isMAReady(MA["Aquaveil"].recast_id) and not bpcore:buffActive(39) then
                            helpers["queue"].add(MA["Aquaveil"], "me")
                        end
                    
                    -- /WAR.
                    elseif player.sub_job == "WAR" and bpcore:canAct() then
                        
                        -- BERSERK.
                        if bpcore:isJAReady(JA["Berserk"].recast_id) then
                            helpers["queue"].add(JA["Berserk"], "me")
                        
                        -- AGGRESSOR.
                        elseif bpcore:isJAReady(JA["Aggressor"].recast_id) then
                            helpers["queue"].add(JA["Aggressor"], "me")
                        
                        -- WARCRY.
                        elseif bpcore:isJAReady(JA["Warcry"].recast_id) then
                            helpers["queue"].add(JA["Warcry"], "me")
                            
                        end
                        
                    -- /DNC.
                    elseif player.sub_job == "DNC" and bpcore:canAct() then
                    
                        -- HASTE SAMBA.
                        if bpcore:isJAReady(JA["Haste Samba"].recast_id) then
                            helpers["queue"].add(JA["Haste Samaba"], "me")                            
                        end
                    
                    -- /NIN.
                    elseif player.sub_job == "NIN" and bpcore:canCast() then
                    
                        -- UTSUSEMI
                        if bpcore:findItemByName("Shihei", 0) then
                            
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
                if settings["DEBUFFS"]:current() and bpcore:canCast() and bpcore:canEngage(helpers["target"].getTarget()) then
                    
                    -- FRAZZLE.
                    if bpcore:isMAReady(MA["Frazzle"].recast_id) and os.clock()-settings["SPELLS"]["Frazzle"].allowed > settings["SPELLS"]["Frazzle"].delay and bpcore:getAvailable("MA", "Frazzle") then
                        helpers["queue"].add(MA["Frazzle"], target)
                        settings["SPELLS"]["Frazzle"].allowed = os.clock()

                    -- DISTRACT.
                    elseif bpcore:isMAReady(MA["Distract"].recast_id) and os.clock()-settings["SPELLS"]["Distract"].allowed > settings["SPELLS"]["Distract"].delay and bpcore:getAvailable("MA", "Distract") then
                        helpers["queue"].add(MA["Distract"], target)
                        settings["SPELLS"]["Distract"].allowed = os.clock()

                    -- DIA / BIO.
                    elseif os.clock()-settings["SPELLS"][settings["DIA"]:current()].allowed > settings["SPELLS"][settings["DIA"]:current()].delay then
                        
                        -- TIER II.
                        if bpcore:isMAReady(MA[settings["DIA"]:current().." II"].recast_id) and bpcore:getAvailable("MA", settings["DIA"]:current().." II") then
                            helpers["queue"].add(MA[settings["DIA"]:current().." II"], target)
                            settings["SPELLS"][settings["DIA"]:current()].allowed = os.clock()
                        
                        -- TIER I.
                        elseif bpcore:isMAReady(MA[settings["DIA"]:current()].recast_id) and bpcore:getAvailable("MA", settings["DIA"]:current()) then
                            helpers["queue"].add(MA[settings["DIA"]:current()], target)
                            settings["SPELLS"][settings["DIA"]:current()].allowed = os.clock()
                            
                        end
                        
                    -- SILENCE.
                    elseif bpcore:isMAReady(MA["Silence"].recast_id) and os.clock()-settings["SPELLS"]["Silence"].allowed > settings["SPELLS"]["Silence"].delay and bpcore:getAvailable("MA", "Silence") then

                        helpers["queue"].add(MA["Silence"], target)
                        settings["SPELLS"]["Silence"].allowed = os.clock()
                    
                    -- PARALYZE.
                    elseif bpcore:isMAReady(MA["Paralyze"].recast_id) and os.clock()-settings["SPELLS"]["Paralyze"].allowed > settings["SPELLS"]["Paralyze"].delay and bpcore:getAvailable("MA", "Paralyze") then
                        helpers["queue"].add(MA["Paralyze"], target)
                        settings["SPELLS"]["Paralyze"].allowed = os.clock()
                    
                    -- SLOW.
                    elseif bpcore:isMAReady(MA["Slow"].recast_id) and os.clock()-settings["SPELLS"]["Slow"].allowed > settings["SPELLS"]["Slow"].delay and bpcore:getAvailable("MA", "Slow") then
                        helpers["queue"].add(MA["Slow"], target)
                        settings["SPELLS"]["Slow"].allowed = os.clock()
                    
                    -- BLIND.
                    elseif bpcore:isMAReady(MA["Blind"].recast_id) and os.clock()-settings["SPELLS"]["Blind"].allowed > settings["SPELLS"]["Blind"].delay and bpcore:getAvailable("MA", "Blind") then
                        helpers["queue"].add(MA["Blind"], target)
                        settings["SPELLS"]["Blind"].allowed = os.clock()
                    
                    -- DISPEL.
                    elseif bpcore:isMAReady(MA["Dispel"].recast_id) and os.clock()-settings["SPELLS"]["Dispel"].allowed > settings["SPELLS"]["Dispel"].delay and bpcore:getAvailable("MA", "Dispel") then
                        helpers["queue"].add(MA["Dispel"], target)
                        settings["SPELLS"]["Dispel"].allowed = os.clock()
                    
                    end
                    
                    -- /DNC.
                    if player.sub_job == "DNC" and bpcore:canAct() and bpcore:canEngage(helpers["target"].getTarget()) then
                    
                        -- STEPS.
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["GEO"]["Steps Timer"] > system["GEO"]["Steps Delay"] and bpcore:getAvailable("MA", settings["STEPS"]:current()) then
                            helpers["queue"].add(JA[settings["STEPS"]:current()], target)                            
                        end
                    
                    end
                
                end
                
                -- DRAINS LOGIC
                if settings["DRAINS"]:current() and bpcore:canCast() then
                    
                    -- DRAIN
                    if bpcore:isMAReady(MA["Drain"].recast_id) and player["vitals"].mpp < system["GEO"]["Drain Threshold"] and bpcore:getAvailable("MA", "Drain") then
                        helpers["queue"].add(MA["Drain"], target)
                    
                    -- DRAIN II
                    elseif bpcore:isMAReady(MA["Drain II"].recast_id) and player["vitals"].mpp < system["GEO"]["Drain Threshold"] and bpcore:getAvailable("MA", "Drain II") then
                        helpers["queue"].add(MA["Drain II"], target)
                        
                    end
                    
                    -- ASPIR
                    if bpcore:isMAReady(MA["Aspir"].recast_id) and player["vitals"].mpp < system["GEO"]["Aspir Threshold"] and bpcore:getAvailable("MA", "Aspir") then
                        helpers["queue"].add(MA["Aspir"], target)
                        
                    -- ASPIR
                    elseif bpcore:isMAReady(MA["Aspir II"].recast_id) and player["vitals"].mpp < system["GEO"]["Aspir Threshold"] and bpcore:getAvailable("MA", "Aspir II") then
                        helpers["queue"].add(MA["Aspir II"], target)
                        
                    -- ASPIR
                    elseif bpcore:isMAReady(MA["Aspir III"].recast_id) and player["vitals"].mpp < system["GEO"]["Aspir Threshold"] and bpcore:getAvailable("MA", "Aspir III") then
                        helpers["queue"].add(MA["Aspir III"], target)
                        
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
            local luopan        = windower.ffxi.get_mob_by_target("pet") or {name="Luopan", hpp="N/A"}
            local indi_name     = tostring(settings["ISPELL"]:sub(6))
            local geo_name      = tostring(settings["GSPELL"]:sub(5))
            local entrust_name  = tostring(settings["ESPELL"]:sub(6))
            local enmity        = helpers["target"].getPlayerEnmity()
            local strings       = {}
            
            if enmity and helpers["target"].exists(helpers["target"].getPlayerTarget()) then
                enmity = enmity.name
            
            else
                enmity = bpcore:colorize("N/A", "255,51,0")
                
            end
            
            -- Build String Table.
            table.insert(strings, ("[ Enmity: ("    .. bpcore:colorize(enmity, "255,51,0")      .. ") ]"))
            table.insert(strings, ("[ Indi: "       .. bpcore:colorize(indi_name, "255,51,0")      .. " ]"))
            table.insert(strings, ("[ Geo: "        .. bpcore:colorize(geo_name, "255,51,0")       .. " ]"))
            table.insert(strings, ("[ Entrust: "    .. bpcore:colorize(entrust_name, "255,51,0")   .. " ]"))
            table.insert(strings, ("[ " .. luopan.name .. ": HP%: " .. bpcore:colorize(luopan.hpp, "255,51,0") .. " ]"))
            
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
    
    self.setColure = function(value)
        colure_active = value
    end
    
    self.getColure = function()
        return colure_active
    end
    
    self.setLuopan = function(value)
        luopan_active = value
    end
    
    self.getLuopan = function()
        return luopan_active
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