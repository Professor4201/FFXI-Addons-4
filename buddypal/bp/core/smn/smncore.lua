--------------------------------------------------------------------------------
-- GEO Core: Handle all job automation for Summoner.
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
        
        ["Dia"]             = {["allowed"]=0,["delay"]=60},  ["Dia II"]      ={["allowed"]=0,["delay"]=120},
        ["Bio"]             = {["allowed"]=0,["delay"]=60},  ["Bio II"]      ={["allowed"]=0,["delay"]=120},
        ["Distract"]        = {["allowed"]=0,["delay"]=120}, ["Dispel"]      ={["allowed"]=0,["delay"]=15},
        ["Frazzle"]         = {["allowed"]=0,["delay"]=120}, ["Slow"]        ={["allowed"]=0,["delay"]=120}, 
        ["Paralyze"]        = {["allowed"]=0,["delay"]=120}, 
        ["Silence"]         = {["allowed"]=0,["delay"]=120}, 
        
    }
    
    -- SUMMON COLORS
    settings["COLORS"]={
        
        ["LightSpirit"]     = {r=235, g=230, b=245},
        ["FireSpirit"]      = {r=190, g=060, b=050},
        ["IceSpirit"]       = {r=180, g=195, b=250},
        ["AirSpirit"]       = {r=100, g=230, b=120},
        ["EarthSpirit"]     = {r=165, g=150, b=090},
        ["ThunderSpirit"]   = {r=170, g=135, b=220},
        ["WaterSpirit"]     = {r=050, g=150, b=255},
        ["DarkSpirit"]      = {r=140, g=120, b=130},
        ["Carbuncle"]       = {r=135, g=190, b=210},
        ["Cait Sith"]       = {r=115, g=110, b=095},
        ["Ifrit"]           = {r=190, g=060, b=050},
        ["Shiva"]           = {r=180, g=195, b=250},
        ["Garuda"]          = {r=100, g=230, b=120},
        ["Titan"]           = {r=165, g=150, b=090},
        ["Ramuh"]           = {r=170, g=135, b=220},
        ["Leviathan"]       = {r=050, g=150, b=255},
        ["Fenrir"]          = {r=195, g=180, b=215},
        ["Diabolos"]        = {r=150, g=040, b=030},
        ["Odin"]            = {r=255, g=240, b=220},
        ["Alexander"]       = {r=140, g=120, b=130},
        ["Siren"]           = {r=180, g=190, b=130},
        
    }
    
    -- BLOOD PACT RAGES.
    settings["RAGES"]={
        
        ["Carbuncle"]       = I{"Poison Nails","Meteorite"},
        ["Cait Sith"]       = I{"Regal Scratch","Regal Gash"},
        ["Ifrit"]           = I{"Flaming Crush","Meteor Strike"},
        ["Shiva"]           = I{"Rush","Heavenly Strike"},
        ["Garuda"]          = I{"Predator Claws","Wind Blade"},
        ["Titan"]           = I{"Megalith Throw","Geocrush","Mountain Buster","Crag Throw"},
        ["Ramuh"]           = I{"Volt Strike","Thunderstorm","Thunderspark"},
        ["Leviathan"]       = I{"Spinning Dive","Grand Fall"},
        ["Fenrir"]          = I{"Eclipse Bite","Lunar Bay","Impact"},
        ["Diabolos"]        = I{"Nether Blast","Night Terror","Blindside"},
        ["Siren"]           = I{"Sonic Buffet","Hysteric Assault"},
        
    }
    
    -- BLOOD PACT WARDS.
    settings["WARDS"]={
        
        ["Carbuncle"]       = I{"Glittering Ruby","Healing Ruby II","Soothing Ruby"},
        ["Cait Sith"]       = I{"Mewing Lullaby"},
        ["Ifrit"]           = I{"Crimson Howl","Inferno Howl"},
        ["Shiva"]           = I{"Crystal Blessing","Frost Armor"},
        ["Garuda"]          = I{"Aerial Armor","Hastega II","Whispering Wind"},
        ["Titan"]           = I{"Earthen Ward","Earthen Armor"},
        ["Ramuh"]           = I{"Rolling Thunder","Lightning Armor"},
        ["Leviathan"]       = I{"Spring Water","Soothing Current"},
        ["Fenrir"]          = I{"Lunar Cry","Lunar Growl","Ecliptic Growl","Ecliptic Howl"},
        ["Diabolos"]        = I{"Dream Shroud","Noctoshield"},
        ["Siren"]           = I{"Chinook","Bitter Elegy","Wind's Blessing"},
        
    }
    
    -- PET ICONS.
    settings["ICONS"]={
        
        ["Light Spirit"]    = ("bp/core/smn/icons/lightspirit.png"),
        ["Fire Spirit"]     = ("bp/core/smn/icons/firespirit.png"),
        ["Ice Spirit"]      = ("bp/core/smn/icons/icespirit.png"),
        ["Air Spirit"]      = ("bp/core/smn/icons/airspirit.png"),
        ["Earth Spirit"]    = ("bp/core/smn/icons/earthspirit.png"),
        ["Thunder Spirit"]  = ("bp/core/smn/icons/thunderspirit.png"),
        ["Water Spirit"]    = ("bp/core/smn/icons/waterspirit.png"),
        ["Dark Spirit"]     = ("bp/core/smn/icons/darkspirit.png"),
        ["Carbuncle"]       = ("bp/core/smn/icons/carbuncle.png"),
        ["Cait Sith"]       = ("bp/core/smn/icons/caitsith.png"),
        ["Ifrit"]           = ("bp/core/smn/icons/ifrit.png"),
        ["Shiva"]           = ("bp/core/smn/icons/shiva.png"),
        ["Garuda"]          = ("bp/core/smn/icons/garuda.png"),
        ["Titan"]           = ("bp/core/smn/icons/titan.png"),
        ["Ramuh"]           = ("bp/core/smn/icons/ramuh.png"),
        ["Leviathan"]       = ("bp/core/smn/icons/leviathan.png"),
        ["Fenrir"]          = ("bp/core/smn/icons/fenrir.png"),
        ["Diabolos"]        = ("bp/core/smn/icons/diabolos.png"),
        ["Siren"]           = ("bp/core/smn/icons/siren.png"),
        ["Rage"]            = ("bp/core/smn/icons/rages.png"),
        ["Ward"]            = ("bp/core/smn/icons/wards.png"),
        
    }
    
    -- MAGIC BURST.
    settings["MAGIC BURST"]={
        
        ["Transfixion"]   = T{},
        ["Compression"]   = T{},
        ["Liquefaction"]  = T{"Meteor Strike"},
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
    local avatar = images.new({color={alpha = 255},texture={fit = false},draggable=true})
    
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
            
            if command == "bprage" then
                local pet = windower.ffxi.get_mob_by_target("pet") or false
                
                if pet then
                    settings["RAGES"][pet.name]:next()
                    helpers['popchat']:pop(("CURRENT BP RAGE: " .. tostring(settings["RAGES"][pet.name]:current())):upper(), system["Popchat Window"])
                    
                end
                
            elseif command == "bpward" then
                local pet = windower.ffxi.get_mob_by_target("pet") or false
                
                if pet then
                    settings["WARDS"][pet.name]:next()
                    helpers['popchat']:pop(("CURRENT BP RAGE: " .. tostring(settings["WARDS"][pet.name]:current())):upper(), system["Popchat Window"])
                    
                end
                
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
                local pet = windower.ffxi.get_mob_by_target("pet") or false
                local target = helpers["target"].getTarget() or windower.ffxi.get_mob_by_target("t") or false
                
                -- SKILLUP LOGIC.
                if settings["SKILLUP"]:current() then
                    
                    if bpcore:findItemByName("B.E.W. Pitaru") and not helpers["queue"].inQueue(IT["B.E.W. Pitaru"], player) and not bpcore:buffActive(251) then
                        helpers["queue"].add(IT["B.E.W. Pitaru"], "me")
                    
                    elseif windower.ffxi.get_mob_by_target("pet") then
                        helpers["queue"].add(JA["Release"], "me")
                        
                    elseif not windower.ffxi.get_mob_by_target("pet") then
                    
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
                            
                            if player["vitals"].mpp < system["SMN"]["Moonlight Threshold"] and bpcore:getAvailable("WS", "Moonlight") then
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
                        
                        if player["vitals"].mpp < system["SMN"]["Moonlight Threshold"] and bpcore:getAvailable("WS", "Moonlight") then
                            helpers["queue"].addToFront(WS["Moonlight"], "me")
                        
                        elseif bpcore:getAvailable("WS", settings["WSNAME"]) and player["vitals"].tp > settings["TP THRESHOLD"] then
                            helpers["queue"].addToFront(WS[settings["WSNAME"]], "t")
                        end
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- SMN/.
                    if player.main_job == "SMN" then
                    
                        if pet then
                            
                            if target and pet.status == 0 and bpcore:isJAReady(JA["Assault"].recast_id) and bpcore:getAvailable("JA", "Assault") and bpcore:canEngage(target) then
                                helpers["queue"].add(JA["Assault"], target)
                                
                            elseif settings["BPRAGE"]:current() and target and pet.status == 1 and bpcore:isJAReady(JA["Blood Pact: Rage"].recast_id) and bpcore:getAvailable("JA", settings["RAGES"][pet.name]:current()) then 
                                helpers["queue"].add(JA[settings["RAGES"][pet.name]:current()], target)                                
                                
                            end
                            
                        elseif not pet and settings["PET"]:current() then 
    
                            if bpcore:isMAReady(MA[settings["SUMMON"]:current()].recast_id) and bpcore:getAvailable("MA", settings["SUMMON"]:current()) then
                                helpers["queue"].add(MA[settings["SUMMON"]:current()], "me")
                            end
                            
                        end
                        
                    end
                    
                    -- /RDM.
                    if player.sub_job == "RDM" then
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and player["vitals"].hpp > system["SMN"]["Convert Threshold"].hpp and player["vitals"].mpp < system["SMN"]["Convert Threshold"].mpp then
                            if bpcore:isJAReady(JA["Convert"].recast_id) then
                                helpers["queue"].add(JA["Convert"], "me")
                            end
                            
                        end
                    
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                        
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
                    
                    -- SMN/.
                    if player.main_job == "SMN" then
                        
                        if pet and settings["BPWARD"]:current() then
                            
                            if bpcore:isJAReady(JA["Blood Pact: Ward"].recast_id) and bpcore:getAvailable("JA", "Blood Pact: Ward") then
                                helpers["queue"].add(JA[settings["WARDS"][pet.name]:current()], player)
                                
                                if settings["ROTATE"]:current() then
                                    settings["WARDS"][pet.name]:next()
                                end
                                
                            end
                            
                        end
                        
                    end
                    
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
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["SMN"]["Steps Timer"] > system["SMN"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers["queue"].add(JA[settings["STEPS"]:current()], "t")                            
                        end
                    
                    end
                
                end
                
                -- DRAINS LOGIC
                if settings["DRAINS"]:current() and bpcore:canCast() then
                    
                    -- DRAIN
                    if bpcore:isMAReady(MA["Drain III"].recast_id) and player["vitals"].hpp < system["SMN"]["Drain Threshold"] then
                        helpers["queue"].add(MA["Drain III"], "t")
                        
                    elseif bpcore:isMAReady(MA["Drain II"].recast_id) and player["vitals"].hpp < system["SMN"]["Drain Threshold"] then
                        helpers["queue"].add(MA["Drain II"], "t")
                        
                    elseif bpcore:isMAReady(MA["Drain"].recast_id) and player["vitals"].hpp < system["SMN"]["Drain Threshold"] then
                        helpers["queue"].add(MA["Drain"], "t")
                    
                    end
                    
                    -- ASPIR
                    if bpcore:isMAReady(MA["Aspir III"].recast_id) and player["vitals"].mpp < system["SMN"]["Aspir Threshold"] then
                        helpers["queue"].add(MA["Aspir III"], "t")
                    
                    elseif bpcore:isMAReady(MA["Aspir II"].recast_id) and player["vitals"].mpp < system["SMN"]["Aspir Threshold"] then
                        helpers["queue"].add(MA["Aspir II"], "t")
                    
                    elseif bpcore:isMAReady(MA["Aspir"].recast_id) and player["vitals"].mpp < system["SMN"]["Aspir Threshold"] then
                        helpers["queue"].add(MA["Aspir"], "t")
                    
                    end
                    
                end
            
            -- PLAYER IS DISENGAGED LOGIC.
            elseif (player.status == 0 or settings["SUPER-TANK"]:current()) then
                local pet = windower.ffxi.get_mob_by_target("pet") or false
                local target = helpers["target"].getTarget()
                
                -- SKILLUP LOGIC.
                if settings["SKILLUP"]:current() then
                    
                    if bpcore:findItemByName("B.E.W. Pitaru") and not helpers["queue"].inQueue(IT["B.E.W. Pitaru"], player) and not bpcore:buffActive(251) then
                        helpers["queue"].add(IT["B.E.W. Pitaru"], "me")
                    
                    elseif windower.ffxi.get_mob_by_target("pet") then
                        helpers["queue"].add(JA["Release"], "me")
                        
                    elseif not windower.ffxi.get_mob_by_target("pet") then
                    
                        for i,v in pairs(system["Skillup"][settings["SKILLS"]:current()].list) do
    
                            if windower.ffxi.get_spells()[MA[v].id] and bpcore:isMAReady(MA[v].recast_id) then
                                helpers["queue"].add(MA[v], system["Skillup"][settings["SKILLS"]:current()].target)
                            end
                            
                        end
                    
                    end
                    
                end
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() then
                    
                    if player["vitals"].tp > 999 and player["vitals"].mpp < system["SMN"]["Myrkr Threshold"] and bpcore:getAvailable("WS", "Myrkr") then
                        helpers["queue"].addToFront(WS["Myrkr"], "me")                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- SMN/.
                    if player.main_job == "SMN" then
                    
                        if pet then
                            
                            if target and pet.status == 0 and bpcore:isJAReady(JA["Assault"].recast_id) and bpcore:getAvailable("JA", "Assault") and bpcore:canEngage(target) then
                                helpers["queue"].add(JA["Assault"], target)
                                
                            elseif settings["BPRAGE"]:current() and target and pet.status == 1 and bpcore:isJAReady(JA["Blood Pact: Rage"].recast_id) and bpcore:getAvailable("JA", settings["RAGES"][pet.name]:current()) then 
                                helpers["queue"].add(JA[settings["RAGES"][pet.name]:current()], target)                                
                                
                            end
                            
                        elseif not pet and settings["PET"]:current() then 
    
                            if bpcore:isMAReady(MA[settings["SUMMON"]:current()].recast_id) and bpcore:getAvailable("MA", settings["SUMMON"]:current()) then
                                helpers["queue"].add(MA[settings["SUMMON"]:current()], "me")
                            end
                            
                        end
                        
                    end
                    
                    -- /RDM.
                    if player.sub_job == "RDM" then
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and player["vitals"].hpp > system["SMN"]["Convert Threshold"].hpp and player["vitals"].mpp < system["SMN"]["Convert Threshold"].mpp then
                            
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
                    
                    -- SMN/.
                    if player.main_job == "SMN" then
                        
                        if pet and settings["BPWARD"]:current() then
                            
                            if bpcore:isJAReady(JA["Blood Pact: Ward"].recast_id) and bpcore:getAvailable("JA", "Blood Pact: Ward") then
                                helpers["queue"].add(JA[settings["WARDS"][pet.name]:current()], player)
                                
                                if settings["ROTATE"]:current() then
                                    settings["WARDS"][pet.name]:next()
                                end
                                
                            end
                            
                        end
                        
                    end
                    
                    -- /RDM.
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
                    
                    -- /WHM.
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
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["SMN"]["Steps Timer"] > system["SMN"]["Steps Delay"] and bpcore:getAvailable("MA", settings["STEPS"]:current()) then
                            helpers["queue"].add(JA[settings["STEPS"]:current()], target)                            
                        end
                    
                    end
                
                end
                
                -- DRAINS LOGIC
                if settings["DRAINS"]:current() and bpcore:canCast() and bpcore:canEngage(helpers["target"].getTarget()) then
                    
                    -- DRAIN
                    if bpcore:isMAReady(MA["Drain III"].recast_id) and player["vitals"].hpp < system["SMN"]["Drain Threshold"] and bpcore:getAvailable("MA", "Drain III") then
                        helpers["queue"].add(MA["Drain III"], target)
                        
                    elseif bpcore:isMAReady(MA["Drain II"].recast_id) and player["vitals"].hpp < system["SMN"]["Drain Threshold"] and bpcore:getAvailable("MA", "Drain II") then
                        helpers["queue"].add(MA["Drain II"], target)
                        
                    elseif bpcore:isMAReady(MA["Drain"].recast_id) and player["vitals"].hpp < system["SMN"]["Drain Threshold"] and bpcore:getAvailable("MA", "Drain") then
                        helpers["queue"].add(MA["Drain"], target)
                    
                    end
                    
                    -- ASPIR
                    if bpcore:isMAReady(MA["Aspir III"].recast_id) and player["vitals"].mpp < system["SMN"]["Aspir Threshold"] and bpcore:getAvailable("MA", "Aspir III") then
                        helpers["queue"].add(MA["Aspir III"], target)
                    
                    elseif bpcore:isMAReady(MA["Aspir II"].recast_id) and player["vitals"].mpp < system["SMN"]["Aspir Threshold"] and bpcore:getAvailable("MA", "Aspir II") then
                        helpers["queue"].add(MA["Aspir II"], target)
                    
                    elseif bpcore:isMAReady(MA["Aspir"].recast_id) and player["vitals"].mpp < system["SMN"]["Aspir Threshold"] and bpcore:getAvailable("MA", "Aspir") then
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

    self.handleWindow = function(released)
        
        if display:current() and windower.ffxi.get_mob_by_target("pet") then
            local player   = windower.ffxi.get_player()
            local pet      = windower.ffxi.get_mob_by_target("pet") or false
            local released = released or false
            
            -- Set path to pet icon.
            avatar:path(string.format("%sbp/core/smn/icons/%s.png", windower.addon_path, pet.name))
                
            if pet and not released then
                local pName     = pet.name
                local pDistance = pet.distance:sqrt()
                local pHPP      = system["Pet"].hpp
                local pMPP      = system["Pet"].mpp
                local pTP       = system["Pet"].tp
                local rRage     = windower.ffxi.get_ability_recasts()[JA["Blood Pact: Rage"].recast_id]
                local rWard     = windower.ffxi.get_ability_recasts()[JA["Blood Pact: Ward"].recast_id]
                local color     = "\\cs(25,200,230)"
                local value = string.format("[ \\cs(250,200,230)%s™\\cr ► HP%%: %s%s%%\\cr + MP%%: %s%s%%\\cr + TP: %s%s\\cr + Distance: %s%.2f\\cr + Rage: %s%s\\cr + Ward: %s%s\\cr ]",
                    pName,
                    color, pHPP,
                    color, pMPP,
                    color, pTP,
                    color, pDistance,
                    color, rRage,
                    color, rWard
                )
                
                if bpcore:fileExists(string.format("../equipviewer/pets/%s.png", pet.name:lower())) then
                    windower.send_command(string.format("ev %s", pet.name:lower()))
                    
                elseif bpcore:fileExists(string.format("../equipviewer/pets/%s.png", player.name:lower())) then
                    windower.send_command(string.format("ev %s", player.name:lower()))
                
                elseif bpcore:fileExists(string.format("../equipviewer/pets/%s.png", "moogle")) then
                    windower.send_command(string.format("ev %s", "moogle"))
                
                end
                
                avatar:size(32, 32)
                avatar:transparency(0)
                avatar:pos_x((window:pos_x()-35))
                avatar:pos_y(window:pos_y()-1)
                avatar:show()
                
                window:text(value)
                window:bg_visible(true)
                window:update()
                window:show()
            
            elseif released then
                avatar:hide()
            
                window:bg_visible(false)
                window:update()
                window:hide()
                
            end
                
        elseif not display:current() and window:visible() then
            avatar:hide()
            
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