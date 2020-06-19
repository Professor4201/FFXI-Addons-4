--------------------------------------------------------------------------------
-- GEO Core: Handle all job automation for Geomancer.
--------------------------------------------------------------------------------
local core = {}

-- CORE AUTOMATED FUNCTION FOR THIS JOB.
function core.get()
    self = {}
    
    -- Master Settings
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
    settings["WSNAME"]                             = "Moonlight"
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
    settings["HASSO MODE"]                         = I{true,false}
    settings["SEKKA"]                              = "Upheaval"
    settings["SHADOWS"]                            = I{false,true}
    settings["FOOD"]                               = I{"Sublime Sushi","Sublime Sushi +1"}
    settings["SAMBAS"]                             = I{"Drain Samba II","Haste Samba"}
    settings["STEPS"]                              = I{"Quickstep","Box Step","Stutter Step"}
    settings["RUNE1"]                              = I{"Lux","Tenebrae","Unda","Ignis","Gelus","Flabra","Tellus","Sulpor"}
    settings["RUNE2"]                              = I{"Lux","Tenebrae","Unda","Ignis","Gelus","Flabra","Tellus","Sulpor"}
    settings["RUNE3"]                              = I{"Lux","Tenebrae","Unda","Ignis","Gelus","Flabra","Tellus","Sulpor"}
    settings["SKILLUP"]                            = I{false,true}
    settings["SKILLS"]                             = I{"Geomancy","Enhancing","Dark","Enfeebling"}
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
    settings["MYRKR"]                              = I{false,true}
    settings["SPIRITS"]                            = T{"Light Spirit","Fire Spirirt","Ice Spirit","Air Spirit","Earth Spirit","Thunder Spirit","Water Spirit","Dark Spirit"}
    settings["SUMMON"]                             = I{"Carbuncle","Cait Sith","Ifrit","Shiva","Garuda","Titan","Ramuh","Leviathan","Fenrir","Diabolos","Siren"}
    settings["BPRAGE"]                             = I{false,true}
    settings["BPWARD"]                             = I{false,true}
    
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
    settings["Magic Burst"]={
        
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
            
        elseif command == "wsname" then
            local weaponskill = windower.convert_auto_trans(table.concat(commands, " "):sub(8)):lower()
            for _,v in pairs(windower.ffxi.get_abilities().weapon_skills) do
                
                if v and res.weapon_skills[v].en then
                    local match = res.weapon_skills[v].en:lower():match(("[%a%s%'%:]+"))

                    if weaponskill:sub(1, #weaponskill) == match:sub(1, #weaponskill) then
                        settings["WSNAME"] = res.weapon_skills[v].en
                        helpers['popchat']:pop(("Weapon Skill now set to: " .. tostring(settings["WSNAME"])):upper(), system["Popchat Window"])
                    end
                    
                end
                
            end
            
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
            helpers['popchat']:pop(("Skill-Up Skill now set to: " .. tostring(settings["SKILLS"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "moonlight" then
            settings["MOONLIGHT"]:next()
            helpers['popchat']:pop(("Auto-Moonlight: " .. tostring(settings["MOONLIGHT"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "i" then
            settings["INDI"]:next()
            helpers['popchat']:pop(("Auto-Indispells: " .. tostring(settings["INDI"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "g" then
            settings["GEO"]:next()
            helpers['popchat']:pop(("Auto-Geospells: " .. tostring(settings["GEO"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "e" then
            settings["ENTRUST"]:next()
            helpers['popchat']:pop(("Auto-Entrust: " .. tostring(settings["ENTRUST"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "ispell" then
            local spell   = commands[2] or false
            local entrust = commands[3] or false
            
            if shortcuts["I-SPELLS"][spell:lower()] and not entrust then                
                settings["ISPELL"] = shortcuts["I-SPELLS"][spell:lower()]
                helpers['popchat']:pop(("Auto-Indispell now set to: " .. tostring(settings["ISPELL"])):upper(), system["Popchat Window"])
                
            elseif shortcuts["I-SPELLS"][spell] and shortcuts["I-SPELLS"][entrust] then
                settings["ISPELL"] = shortcuts["I-SPELLS"][spell:lower()]
                settings["ESPELL"] = shortcuts["I-SPELLS"][entrust:lower()]
                
                helpers['popchat']:pop(("Indicolure and Entrust now set to: " .. tostring(settings["ISPELL"]) .. " & " .. tostring(settings["ESPELL"])):upper(), system["Popchat Window"])    
                
            end
        
        elseif command == "gspell" then
            local spell = commands[2]:lower() or false
            if shortcuts["G-SPELLS"][spell] then
                settings["GSPELL"] = shortcuts["G-SPELLS"][spell]
                helpers['popchat']:pop(("Auto-Geospell now set to: " .. tostring(settings["GSPELL"])):upper(), system["Popchat Window"])    
                
            end
        
        elseif command == "espell" then
            local spell = commands[2]:lower() or false
            if shortcuts["I-SPELLS"][spell] then
                settings["ESPELL"] = shortcuts["I-SPELLS"][spell]
                helpers['popchat']:pop(("Auto-Entrust now set to: " .. tostring(settings["ESPELL"])):upper(), system["Popchat Window"])    
                
            end
        
        elseif ("ecliptic"):match(command) or ("lasting"):match(command) then
            settings["BUBBLE BUFF"]:next()
            helpers['popchat']:pop(("Bubble-JA set to: " .. tostring(settings["BUBBLE BUFF"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "convert" then
            settings["CONVERT"]:next()
            helpers['popchat']:pop(("Auto-Convert: " .. tostring(settings["CONVERT"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "spikes" then
            settings["SPIKES"]:next()
            helpers['popchat']:pop(("Auto-Spikes now set to: " .. tostring(settings["SPIKES"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "dia" or command == "bio" then
            settings["DIA"]:next()
            helpers['popchat']:pop(("Dia/Bio Mode now set to: " .. tostring(settings["DIA"]:current())):upper(), system["Popchat Window"])
        
        else
            
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
        
        if bpcore:checkReady() and not helpers["actions"].getMoving() and system["BP Enabled"]:current() then

            -- Determine which target is mine.
            local target  = helpers["target"].getTarget() or false
            local gtarget = helpers["target"].getLuopanTarget() or target or false
            local etarget = helpers["target"].getEntrustTarget() or false
            local luopan  = windower.ffxi.get_mob_by_target("pet") or false
            
            -- Update Luopan Active ID.
            if not luopan then
                system["Core"].setLuopan(0)
                
            end
            
            -- PLAYER IS ENGAGED.
            if system["Player"].status == 1 then
                
                -- SKILLUP LOGIC.
                if settings["SKILLUP"]:current() then
                    
                    if bpcore:canCast() and settings["SKILLS"]:current() == "Enhancing" then
                        
                        -- BARFIRE.
                        if bpcore:isMAReady(MA["Barfire"].recast_id) and bpcore:getAvailable("MA", "Barfire") then
                            helpers["queue"].add(MA["Barfire"], "me")
                        
                        -- BARWATER.
                        elseif bpcore:isMAReady(MA["Barwater"].recast_id) and bpcore:getAvailable("MA", "Barwater") then
                            helpers["queue"].add(MA["Barwater"], "me")
                            
                        -- BARTHUNDER.
                        elseif bpcore:isMAReady(MA["Barthunder"].recast_id) and bpcore:getAvailable("MA", "Barthunder") then
                            helpers["queue"].add(MA["Barthunder"], "me")
                        
                        -- BARSTONE
                        elseif bpcore:isMAReady(MA["Barstone"].recast_id) and bpcore:getAvailable("MA", "Barstone") then
                            helpers["queue"].add(MA["Barstone"], "me")
                            
                        -- BARAERO
                        elseif bpcore:isMAReady(MA["Baraero"].recast_id) and bpcore:getAvailable("MA", "Baraero") then
                            helpers["queue"].add(MA["Baraero"], "me")
                        
                        -- BARBLIZZARD.
                        elseif bpcore:isMAReady(MA["Barblizzard"].recast_id) and bpcore:getAvailable("MA", "Barblizzard") then
                            helpers["queue"].add(MA["Barblizzard"], "me")
                        
                        end
                        
                    elseif bpcore:canCast() and settings["SKILLS"]:current() == "Elemental" then
                        
                        -- STONE.
                        if bpcore:isMAReady(MA["Stone"].recast_id) and bpcore:getAvailable("MA", "Stone") then
                            helpers["queue"].add(MA["Stone"], "me")
                        end
                        
                    elseif bpcore:canCast() and settings["SKILLS"]:current() == "Enfeebling" then
                        
                        -- DIA.
                        if bpcore:isMAReady(MA["Dia"].recast_id) and bpcore:getAvailable("MA", "Dia") then
                            helpers["queue"].add(MA["Dia"], "me")
                        
                        -- BLIND.
                        elseif bpcore:isMAReady(MA["Blind"].recast_id) and bpcore:getAvailable("MA", "Blind") then
                            helpers["queue"].add(MA["Blind"], "me")
                            
                        -- GRAVITY.
                        elseif bpcore:isMAReady(MA["Gravity"].recast_id) and bpcore:getAvailable("MA", "Gravity") then
                            helpers["queue"].add(MA["Gravity"], "me")
                        
                        -- POISON
                        elseif bpcore:isMAReady(MA["Poison"].recast_id) and bpcore:getAvailable("MA", "Poison") then
                            helpers["queue"].add(MA["Poison"], "me")
                            
                        -- PARALYZE
                        elseif bpcore:isMAReady(MA["Paralyze"].recast_id) and bpcore:getAvailable("MA", "Paralyze") then
                            helpers["queue"].add(MA["Paralyze"], "me")
                        
                        end
                        
                    elseif bpcore:canCast() and settings["SKILLS"]:current() == "Dark" then
                        
                        -- BIO.
                        if bpcore:isMAReady(MA["Bio"].recast_id) and bpcore:getAvailable("MA", "Bio") then
                            helpers["queue"].add(MA["Bio"], "me")
                        
                        -- DRAIN.
                        elseif bpcore:isMAReady(MA["Drain"].recast_id) and bpcore:getAvailable("MA", "Drain") then
                            helpers["queue"].add(MA["Drain"], "me")
                            
                        -- ASPIR.
                        elseif bpcore:isMAReady(MA["Aspir"].recast_id) and bpcore:getAvailable("MA", "Aspir") then
                            helpers["queue"].add(MA["Aspir"], "me")
                        
                        end
                    
                    elseif bpcore:canCast() and settings["SKILLS"]:current() == "Geomancy" then
                        
                        -- KEEP GEO-REFRESH UP.
                        local geospell = MA["Geo-Refresh"] or false
                        local active   = system["Core"].getLuopan()
                        
                        if geospell and (active ~= geospell.id or active == 0) and bpcore:isMAReady(MA[geospell.name].recast_id) and bpcore:getAvailable("MA", geospell.name) then
                            helpers["queue"].addToFront(MA[geospell.name], "me")
                        end
                        
                        -- INDI-REGEN.
                        if bpcore:isMAReady(MA["Indi-Regen"].recast_id) and bpcore:getAvailable("MA", "Indi-Regen") then
                            helpers["queue"].add(MA["Indi-Regen"], "me")
                        
                        -- INDI-POISON.
                        elseif bpcore:isMAReady(MA["Indi-Poison"].recast_id) and bpcore:getAvailable("MA", "Indi-Poison") then
                            helpers["queue"].add(MA["Indi-Poison"], "me")
                            
                        -- INDI-PRECISION.
                        elseif bpcore:isMAReady(MA["Indi-Precision"].recast_id) and bpcore:getAvailable("MA", "Indi-Precision") then
                            helpers["queue"].add(MA["Indi-Precision"], "me")
                        
                        -- INDI-VOIDANCE.
                        elseif bpcore:isMAReady(MA["Indi-Voidance"].recast_id) and bpcore:getAvailable("MA", "Indi-Voidance") then
                            helpers["queue"].add(MA["Indi-Voidance"], "me")
                        
                        -- INDI-ATTUNEMENT.
                        elseif bpcore:isMAReady(MA["Indi-Attunement"].recast_id) and bpcore:getAvailable("MA", "Indi-Atunement") then
                            helpers["queue"].add(MA["Indi-Attunement"], "me")
                        
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
                if settings["ENTRUST"]:current() and bpcore:canCast() and bpcore:canAct() and etarget and not bpcore:buffActive(584) then
                    local entrustspell = MA[settings["ESPELL"]] or false
                    
                    if entrustspell and bpcore:getAvailable("JA", "Entrust") and bpcore:getAvailable("MA", entrustspell.name) and bpcore:isMAReady(MA[entrustspell.name].recast_id) then
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
                            
                            else
                                helpers["queue"].addToFront(MA[geospell.name], gtarget)
                            
                            end
                        
                        else
                            helpers["queue"].addToFront(MA[geospell.name], gtarget)
                            
                        end
                        
                    end
                    
                end
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() then
                    
                    if settings["AM"]:current() then
                        
                        if bpcore:buffActive(272) and system["Player"]["vitals"].tp > 1000 then
                            
                            if settings["MOONLIGHT"]:current() and system["Player"]["vitals"].mpp < system["GEO"]["Moonlight Threshold"] and bpcore:getAvailable("WS", "Moonlight") then
                                helpers["queue"].addToFront(WS["Moonlight"], "me")
                            
                            elseif bpcore:getAvailable("WS", settings["WSNAME"]) and system["Player"]["vitals"].tp > settings["TP THRESHOLD"] then
                                helpers["queue"].addToFront(WS[settings["WSNAME"]], "t")
                            end
                            
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp > settings["AM THRESHOLD"] and system["Weapon"].en == "Tishtrya" and bpcore:getAvailable("WS", "Realmrazer") then
                            helpers["queue"].addToFront(WS["Realmrazer"], "t")
                        
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp > settings["AM THRESHOLD"] and system["Weapon"].en == "Idris" and bpcore:getAvailable("WS", "Exudation") then
                            helpers["queue"].addToFront(WS["Exudation"], "t")
                        end
                        
                    elseif system["Player"]["vitals"].tp > 1000 then
                        
                        if settings["MOONLIGHT"]:current() and system["Player"]["vitals"].mpp < system["GEO"]["Moonlight Threshold"] and bpcore:getAvailable("WS", "Moonlight") then
                            helpers["queue"].addToFront(WS["Moonlight"], "me")
                        
                        elseif bpcore:getAvailable("WS", settings["WSNAME"]) and system["Player"]["vitals"].tp > settings["TP THRESHOLD"] then
                            helpers["queue"].addToFront(WS[settings["WSNAME"]], "t")
                        end
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- /RDM.
                    if system["Player"].sub_job == "RDM" then
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and system["Player"]["vitals"].hpp > system["GEO"]["Convert Threshold"].hpp and system["Player"]["vitals"].mpp < system["GEO"]["Convert Threshold"].mpp then
                            if bpcore:isJAReady(JA["Convert"].recast_id) then
                                helpers["queue"].add(JA["Convert"], "me")
                            end
                            
                        end
                    
                    end
                    
                    -- /DNC.
                    if system["Player"].sub_job == "DNC" then
                        
                        -- REVERSE FLOURISH.
                        if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) and bpcore:getFinishingMoves() > 4 then
                            helpers["queue"].add(JA["Reverse Flourish"], "me")                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" and bpcore:canAct() then
                        
                        -- PROVOKE.
                        if bpcore:isJAReady(JA["Provoke"].recast_id) then
                            helpers["queue"].add(JA["Provoke"], "t")
                        end
                        
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" and bpcore:canAct() then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 then
                            helpers["queue"].add(JA["Animated Flourish"], "t")
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    -- /RDM
                    if system["Player"].sub_job == "RDM" and bpcore:canCast() then
                        
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
                    
                    end
                    
                    -- /WHM
                    if system["Player"].sub_job == "WHM" and bpcore:canCast() then
                        
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
                    
                    end
                    
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" and bpcore:canAct() then
                        
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
                    elseif system["Player"].sub_job == "DNC" and bpcore:canAct() then
                    
                        -- HASTE SAMBA.
                        if bpcore:isJAReady(JA["Haste Samba"].recast_id) then
                            helpers["queue"].add(JA["Haste Samaba"], "me")                            
                        end
                    
                    -- /NIN.
                    elseif system["Player"].sub_job == "NIN" and bpcore:canCast() then
                    
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
                    if system["Player"].sub_job == "DNC" and bpcore:canAct() and target then
                    
                        -- STEPS.
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["GEO"]["Steps Timer"] > system["GEO"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers["queue"].add(JA[settings["STEPS"]:current()], "t")                            
                        end
                    
                    end
                
                end
                
                -- DRAINS LOGIC
                if settings["DRAINS"]:current() and bpcore:canCast() then
                    
                    -- DRAIN
                    if bpcore:isMAReady(MA["Drain III"].recast_id) and system["Player"]["vitals"].hpp < system["GEO"]["Drain Threshold"] then
                        helpers["queue"].add(MA["Drain III"], "t")
                        
                    elseif bpcore:isMAReady(MA["Drain II"].recast_id) and system["Player"]["vitals"].hpp < system["GEO"]["Drain Threshold"] then
                        helpers["queue"].add(MA["Drain II"], "t")
                        
                    elseif bpcore:isMAReady(MA["Drain"].recast_id) and system["Player"]["vitals"].hpp < system["GEO"]["Drain Threshold"] then
                        helpers["queue"].add(MA["Drain"], "t")
                    
                    end
                    
                    -- ASPIR
                    if bpcore:isMAReady(MA["Aspir III"].recast_id) and system["Player"]["vitals"].mpp < system["GEO"]["Aspir Threshold"] then
                        helpers["queue"].add(MA["Aspir III"], "t")
                    
                    elseif bpcore:isMAReady(MA["Aspir II"].recast_id) and system["Player"]["vitals"].mpp < system["GEO"]["Aspir Threshold"] then
                        helpers["queue"].add(MA["Aspir II"], "t")
                    
                    elseif bpcore:isMAReady(MA["Aspir"].recast_id) and system["Player"]["vitals"].mpp < system["GEO"]["Aspir Threshold"] then
                        helpers["queue"].add(MA["Aspir"], "t")
                    
                    end
                    
                end
            
            -- PLAYER IS DISENGAGED LOGIC.
            elseif system["Player"].status == 0 then
                
                -- Determine which target is mine.
                local target = helpers["target"].getTarget()
                
                -- SKILLUP LOGIC.
                if settings["SKILLUP"]:current() then
                    
                    for i,v in pairs(system["Skillup"][settings["SKILLS"]:current()].list) do

                        if windower.ffxi.get_spells()[MA[v].id] and bpcore:isMAReady(MA[v].recast_id) then
                            helpers["queue"].add(MA[v], system["Skillup"][settings["SKILLS"]:current()].target)
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
                if settings["ENTRUST"]:current() and bpcore:canCast() and bpcore:canAct() and etarget and not bpcore:buffActive(584) then
                    local entrustspell = MA[settings["ESPELL"]] or false
                    
                    if entrustspell and bpcore:getAvailable("JA", "Entrust") and bpcore:getAvailable("MA", entrustspell.name) and bpcore:isMAReady(MA[entrustspell.name].recast_id) then
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
                            
                            else
                                helpers["queue"].addToFront(MA[geospell.name], gtarget)
                            
                            end
                        
                        else
                            helpers["queue"].addToFront(MA[geospell.name], gtarget)
                            
                        end
                        
                    end
                    
                end
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() then
                    
                    if settings["MOONLIGHT"]:current() and system["Player"]["vitals"].mpp < system["GEO"]["Moonlight Threshold"] and bpcore:getAvailable("WS", "Moonlight") then
                        helpers["queue"].addToFront(WS["Moonlight"], "me")                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- /RDM.
                    if system["Player"].sub_job == "RDM" then
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and bpcore:canAct() and system["Player"]["vitals"].hpp > system["GEO"]["Convert Threshold"].hpp and system["Player"]["vitals"].mpp < system["GET"]["Convert Threshold"].mpp then
                            if bpcore:isJAReady(JA["Convert"].recast_id) then
                                helpers["queue"].add(JA["Convert"], "me")
                            end
                            
                        end
                    
                    end
                    
                    -- /DNC.
                    if system["Player"].sub_job == "DNC" then
                        
                        -- REVERSE FLOURISH.
                        if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) and bpcore:getFinishingMoves() > 4 then
                            helpers["queue"].add(JA["Reverse Flourish"], "me")                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" and bpcore:canAct() and bpcore:canEngage(helpers["target"].getTarget()) then
                        
                        -- PROVOKE.
                        if bpcore:isJAReady(JA["Provoke"].recast_id) and target then
                            helpers["queue"].add(JA["Provoke"], target)
                        end
                        
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" and bpcore:canAct() and bpcore:canEngage(helpers["target"].getTarget()) then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and target then
                            helpers["queue"].add(JA["Animated Flourish"], target)
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    -- /RDM
                    if system["Player"].sub_job == "RDM" and bpcore:canCast() then
                        
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
                    
                    end
                    
                    -- /WHM
                    if system["Player"].sub_job == "WHM" and bpcore:canCast() then
                        
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
                    
                    end
                    
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" and bpcore:canAct() then
                        
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
                    elseif system["Player"].sub_job == "DNC" and bpcore:canAct() then
                    
                        -- HASTE SAMBA.
                        if bpcore:isJAReady(JA["Haste Samba"].recast_id) then
                            helpers["queue"].add(JA["Haste Samaba"], "me")                            
                        end
                    
                    -- /NIN.
                    elseif system["Player"].sub_job == "NIN" and bpcore:canCast() then
                    
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
                    if system["Player"].sub_job == "DNC" and bpcore:canAct() and bpcore:canEngage(helpers["target"].getTarget()) then
                    
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
            
            -- HANDLE ALL CURING.
            if settings["CURES"]:current() == 2 and (player.sub_job == "WHM" or player.sub_job == "RDM" or player.sub_job == "SCH") then
                helpers["cures"].handleParty()
                
            elseif settings["CURES"]:current() == 3 and (player.sub_job == "WHM" or player.sub_job == "RDM" or player.sub_job == "SCH") then
                helpers["cures"].handleParty()
                helpers["cures"].handleAlliance()
            end
            
            -- HANDLE EVERYTHING INSIDE THE QUEUE.
            helpers["queue"].handleQueue()
        
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
    
    self.setSetting = function(setting, value)
        name:setTo(value)
    end
    
    return self
    
end

return core.get()