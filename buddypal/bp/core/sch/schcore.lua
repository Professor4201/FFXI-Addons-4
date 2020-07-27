--------------------------------------------------------------------------------
-- RDM Core: Handle all job automation for Red Mage.
--------------------------------------------------------------------------------
local core = {}

-- CORE AUTOMATED FUNCTION FOR THIS JOB.
function core.get()
    self = {}
    
    -- Red Mage Master Settings
    local settings = {}
    settings["ON"]                                 = I{false,true}
    settings["AM"]                                 = I{false,true}
    settings["1HR"]                                = I{false,true}
    settings["JA"]                                 = I{false,true}
    settings["RA"]                                 = I{false,true}
    settings["HATE"]                               = I{false,true}
    settings["BUFFS"]                              = I{false,true}
    settings["DEBUFFS"]                            = I{false,true}
    settings["WS"]                                 = I{false,true}
    settings["WSNAME"]                             = "Savage Blade"
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
    settings["STEPS"]                              = I{"Quickstep","Box Step","Stutter Step"}
    settings["SKILLUP"]                            = I{false,true}
    settings["SKILLS"]                             = I{"Enhancing","Elemental","Enfeebling","Dark","Divine"}
    
    -- Specialty Settings
    settings["SANGUINE"]                           = I{false,true}
    settings["COMPOSURE"]                          = I{true,false}
    settings["CONVERT"]                            = I{true,false}
    settings["ENSPELL"]                            = I{"Enfire","Enblizzard","Enaero","Enstone","Enthunder","Enwater"}
    settings["GAINS"]                              = I{"Gain-DEX","Gain-STR","Gain-MND","Gain-INT","Gain-AGI","Gain-VIT","Gain-CHR"}
    settings["SPIKES"]                             = I{"None","Blaze Spikes","Ice Spikes","Shock Spikes"}
    settings["DIA"]                                = I{"Dia","Bio"}
    
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
    
    settings["Magic Burst"]={
        
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
    
    self.handleChat = function(message, sender, mode, gm)
        
        if mode == 3 or mode == 4 then
            
            if system["Controllers"]:contains(sender) then
                
            else
                
            end
            
        end
        
    end
    
    self.handleCommands = function(commands)
        local command = commands[1]:lower() or false
        
        if command == "on" or command == "toggle" or command == "off" then
            settings["ON"]:next()
            helpers['popchat']:pop(("Automation: " .. tostring(settings["ON"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "am" then
            settings["AM"]:next()
            helpers['popchat']:pop(("Auto-Aftermath: " .. tostring(settings["AM"]:current())):upper(), system["Popchat Window"])
        
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
            
        elseif command == "ws" then
            settings["WS"]:next()
            helpers['popchat']:pop(("Auto-Weapon Skills: " .. tostring(settings["WS"]:current())):upper(), system["Popchat Window"])
            
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
            
        elseif command == "sanguine" then
            settings["SANGUINE"]:next()
            helpers['popchat']:pop(("Auto-Sanguine Blade: " .. tostring(settings["SANGUINE"]:current())):upper(), system["Popchat Window"])
            
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
            
        elseif command == "steps" then
            settings["STEPS"]:next()
            helpers['popchat']:pop(("Auto-Steps: " .. tostring(settings["STEPS"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "skillup" then
            settings["SKILLUP"]:next()
            helpers['popchat']:pop(("Auto-Skillup: " .. tostring(settings["SKILLUP"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "skills" then
            settings["SKILLS"]:next()
            helpers['popchat']:pop(("Skill-Up Skill now set to: " .. tostring(settings["SKILLS"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "composure" then
            settings["COMPOSURE"]:next()
            helpers['popchat']:pop(("Auto-Composure: " .. tostring(settings["COMPOSURE"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "convert" then
            settings["CONVERT"]:next()
            helpers['popchat']:pop(("Auto-Convert: " .. tostring(settings["CONVERT"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "enspell" then
            local enspell = windower.convert_auto_trans(commands[2]):sub(1,3):lower() or false
            if enspell then

                for _,v in pairs(settings["ENSPELL"]) do

                    if v and type(v) == 'string' and enspell == v:sub(1,3):lower() then
                        settings["ENSPELL"]:setTo(v)
                        helpers['popchat']:pop(("Auto-Enspell now set to: " .. tostring(settings["ENSPELL"]:current())):upper(), system["Popchat Window"])    
                    end
                    
                end
                
            end
        
        elseif command == "gains" then
            local gain = windower.convert_auto_trans(commands[2]):lower() or false
            if gain then

                for _,v in pairs(settings["GAINS"]) do

                    if v and type(v) == 'string' and gain == v:lower() then
                        settings["GAINS"]:setTo(v)
                        helpers['popchat']:pop(("Auto-Gain now set to: " .. tostring(settings["GAINS"]:current())):upper(), system["Popchat Window"])    
                    end
                    
                end
                
            end
            
        elseif command == "spikes" then
            settings["SPIKES"]:next()
            helpers['popchat']:pop(("Auto-Spikes now set to: " .. tostring(settings["SPIKES"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "dia" or command == "bio" then
            settings["DIA"]:next()
            helpers['popchat']:pop(("Dia/Bio Mode now set to: " .. tostring(settings["DIA"]:current())):upper(), system["Popchat Window"])
        
        end
        
    end
    
    self.handleItems = function()
        
        if command then
            
        end
        
    end
    
    self.handleAutomation = function()
        
        if bpcore:checkReady() and not system["Moving"] and settings["ON"]:current() then
            
            -- Determine which target is mine.
            local target = helpers["target"]:getTarget()
            
            -- PLAYER IS ENGAGED.
            if system["Player"].status == 1 then
                
                -- SKILLUP LOGIC.
                if settings["SKILLUP"]:current() then
                    
                    if settings["SKILLS"]:current() == "Enhancing" then
                        
                        -- BARFIRE.
                        if windower.ffxi.get_spells()[MA["Barfire"].id] and bpcore:isMAReady(MA["Barfire"].recast_id) then
                            helpers['queue'].add(MA["Barfire"], "me")
                        
                        -- BARWATER.
                        elseif windower.ffxi.get_spells()[MA["Barwater"].id] and bpcore:isMAReady(MA["Barwater"].recast_id) then
                            helpers['queue'].add(MA["Barwater"], "me")
                            
                        -- BARTHUNDER.
                        elseif windower.ffxi.get_spells()[MA["Barthunder"].id] and bpcore:isMAReady(MA["Barthunder"].recast_id) then
                            helpers['queue'].add(MA["Barthunder"], "me")
                        
                        -- BARSTONE
                        elseif windower.ffxi.get_spells()[MA["Barstone"].id] and bpcore:isMAReady(MA["Barstone"].recast_id) then
                            helpers['queue'].add(MA["Barstone"], "me")
                            
                        -- BARAERO
                        elseif windower.ffxi.get_spells()[MA["Baraero"].id] and bpcore:isMAReady(MA["Baraero"].recast_id) then
                            helpers['queue'].add(MA["Baraero"], "me")
                        
                        -- BARBLIZZARD.
                        elseif windower.ffxi.get_spells()[MA["Barblizzard"].id] and bpcore:isMAReady(MA["Barblizzard"].recast_id) then
                            helpers['queue'].add(MA["Barblizzard"], "me")
                        
                        end
                        
                    elseif settings["SKILLS"]:current() == "Elemental" then
                        
                        -- STONE.
                        if windower.ffxi.get_spells()[MA["Stone"].id] and bpcore:isMAReady(MA["Stone"].recast_id) then
                            helpers['queue'].add(MA["Stone"], "me")
                        end
                        
                    elseif settings["SKILLS"]:current() == "Enfeebling" then
                        
                        -- DIA.
                        if windower.ffxi.get_spells()[MA["Dia"].id] and bpcore:isMAReady(MA["Dia"].recast_id) then
                            helpers['queue'].add(MA["Dia"], "me")
                        
                        -- BLIND.
                        elseif windower.ffxi.get_spells()[MA["Blind"].id] and bpcore:isMAReady(MA["Blind"].recast_id) then
                            helpers['queue'].add(MA["Blind"], "me")
                            
                        -- GRAVITY.
                        elseif windower.ffxi.get_spells()[MA["Gravity"].id] and bpcore:isMAReady(MA["Gravity"].recast_id) then
                            helpers['queue'].add(MA["Gravity"], "me")
                        
                        -- POISON
                        elseif windower.ffxi.get_spells()[MA["Poison"].id] and bpcore:isMAReady(MA["Poison"].recast_id) then
                            helpers['queue'].add(MA["Poison"], "me")
                            
                        -- PARALYZE
                        elseif windower.ffxi.get_spells()[MA["Paralyze"].id] and bpcore:isMAReady(MA["Paralyze"].recast_id) then
                            helpers['queue'].add(MA["Paralyze"], "me")
                        
                        end
                        
                    elseif settings["SKILLS"]:current() == "Dark" then
                        
                        -- BIO.
                        if windower.ffxi.get_spells()[MA["Bio"].id] and bpcore:isMAReady(MA["Bio"].recast_id) then
                            helpers['queue'].add(MA["Bio"], "me")
                        
                        -- DRAIN.
                        elseif windower.ffxi.get_spells()[MA["Drain"].id] and bpcore:isMAReady(MA["Drain"].recast_id) then
                            helpers['queue'].add(MA["Drain"], "me")
                            
                        -- ASPIR.
                        elseif windower.ffxi.get_spells()[MA["Aspir"].id] and bpcore:isMAReady(MA["Aspir"].recast_id) then
                            helpers['queue'].add(MA["Aspir"], "me")
                        
                        end
                        
                    elseif settings["SKILLS"]:current() == "Divine" then
                        
                        -- BIO.
                        if windower.ffxi.get_spells()[MA["Bio"].id] and bpcore:isMAReady(MA["Bio"].recast_id) then
                            helpers['queue'].add(MA["Bio"], "me")
                        
                        -- BANISH.
                        elseif windower.ffxi.get_spells()[MA["Banish"].id] and bpcore:isMAReady(MA["Banish"].recast_id) then
                            helpers['queue'].add(MA["Banish"], "me")
                            
                        -- REPOSE.
                        elseif windower.ffxi.get_spells()[MA["Repose"].id] and bpcore:isMAReady(MA["Repose"].recast_id) then
                            helpers['queue'].add(MA["Repose"], "me")
                        
                        end
                        
                    end
                    
                end
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() then
                    
                    if settings["AM"]:current() then
                        
                        if bpcore:buffActive(272) and system["Player"]["vitals"].tp > 1000 then
                            
                            if settings["SANGUINE"]:current() and system["Player"]["vitals"].hpp > system["RDM"]["Sanguine Threshold"] then
                                helpers['queue'].addToFront(WS["Sanguine Blade"], "t")
                            else
                                helpers['queue'].addToFront(WS[settings["WSNAME"]], "t")
                            end
                            
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp > 1000 and system["Weapon"].en == "Excalibur" then
                            helpers['queue'].addToFront(WS["Knights of Round"], "t")
                        
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp > 1000 and system["Weapon"].en == "Almace" then
                            helpers['queue'].addToFront(WS["Chant Du Cygne"], "t")
                        
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp > 1000 and system["Weapon"].en == "Murgleis" then
                            helpers['queue'].addToFront(WS["Death Blossom"], "t")
                        end
                        
                    elseif system["Player"]["vitals"].tp > 1000 then
                        
                        if settings["SANGUINE"]:current() and system["Player"]["vitals"].hpp > system["RDM"]["Sanguine Threshold"] then
                            helpers['queue'].addToFront(WS["Sanguine Blade"], "t")
                        else
                            helpers['queue'].addToFront(WS[settings["WSNAME"]], "t")
                        end
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- RDM/.
                    if system["Player"].main_job == "RDM" then
                        
                        -- COMPOSURE LOGIC.
                        if settings["COMPOSURE"]:current() and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Composure"].recast_id) and not bpcore:buffActive(419) then
                                helpers['queue'].add(JA["Composure"], "me")
                            end
                            
                        end
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and bpcore:canAct() and system["Player"]["vitals"].hpp > system["RDM"]["Convert Threshold"].hpp and system["Player"]["vitals"].mpp < system["RDM"]["Convert Threshold"].mpp then
                            if bpcore:isJAReady(JA["Convert"].recast_id) then
                                helpers['queue'].add(JA["Convert"], "me")
                            end
                            
                        end
                    
                    end
                    
                    -- /DNC.
                    if system["Player"].sub_job == "DNC" then
                        
                        -- REVERSE FLOURISH.
                        if windower.ffxi.get_abilities()[JA["Reverse Flourish"].id] and bpcore:canAct() and bpcore:getFinishingMoves() > 4 then
                            if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) then
                                helpers['queue'].add(JA["Reverse Flourish"], "me")
                            end
                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" then
                        
                        -- PROVOKE.
                        if windower.ffxi.get_abilities()[JA["Provoke"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Provoke"].recast_id) then
                                helpers['queue'].add(JA["Provoke"], "t")
                            end
                            
                        end
                        
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" then
                        
                        -- ANIMATED FLOURISH.
                        if windower.ffxi.get_abilities()[JA["Animated Flourish"].id] and bpcore:canAct() and bpcore:getFinishingMoves() > 0 then
                            if bpcore:isJAReady(JA["Animated Flourish"].recast_id) then
                                helpers['queue'].add(JA["Animated Flourish"], "t")
                            end
                            
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() and bpcore:canCast() then
                    
                    -- REFRESH III
                    if windower.ffxi.get_spells()[MA["Refresh III"].id] then
                        if bpcore:isMAReady(MA["Refresh III"].recast_id) and not bpcore:buffActive(43) then
                            helpers['queue'].add(MA["Refresh III"], "me")
                        end
                    
                    -- REFRESH II
                    elseif windower.ffxi.get_spells()[MA["Refresh II"].id] then
                        if bpcore:isMAReady(MA["Refresh II"].recast_id) and not bpcore:buffActive(43) then
                            helpers['queue'].add(MA["Refresh II"], "me")
                        end
                    
                    -- REFRESH I
                    elseif windower.ffxi.get_spells()[MA["Refresh"].id] then
                        if bpcore:isMAReady(MA["Refresh"].recast_id) and not bpcore:buffActive(43) then
                            helpers['queue'].add(MA["Refresh"], "me")
                        end
                        
                    end
                    
                    -- HASTE II
                    if windower.ffxi.get_spells()[MA["Haste II"].id] and system["Player"]["jobs"].RDM > 95 then
                        if bpcore:isMAReady(MA["Haste II"].recast_id) and not bpcore:buffActive(33) then
                            helpers['queue'].add(MA["Haste II"], "me")
                        end
                    
                    -- HASTE
                    elseif windower.ffxi.get_spells()[MA["Haste"].id] and system["Player"]["jobs"].RDM < 96 then
                        if bpcore:isMAReady(MA["Haste"].recast_id) and not bpcore:buffActive(33) then
                            helpers['queue'].add(MA["Haste"], "me")
                        end
                        
                    end
                    
                    -- TEMPER II
                    if windower.ffxi.get_spells()[MA["Temper II"].id] then
                        if bpcore:isMAReady(MA["Temper II"].recast_id) and not bpcore:buffActive(432) then
                            helpers['queue'].add(MA["Temper II"], "me")
                        end
                    
                    -- TEMPER
                    elseif windower.ffxi.get_spells()[MA["Temper"].id] then
                        if bpcore:isMAReady(MA["Temper"].recast_id) and not bpcore:buffActive(432) then
                            helpers['queue'].add(MA["Temper"], "me")
                        end
                        
                    end   
                    
                    -- PHALANX
                    if windower.ffxi.get_spells()[MA["Phalanx"].id] then
                        if bpcore:isMAReady(MA["Phalanx"].recast_id) and not bpcore:buffActive(116) then
                            helpers['queue'].add(MA["Phalanx"], "me")
                        end
                    
                    end
                    
                    -- AQUAVEIL
                    if windower.ffxi.get_spells()[MA["Aquaveil"].id] then
                        if bpcore:isMAReady(MA["Aquaveil"].recast_id) and not bpcore:buffActive(39) then
                            helpers['queue'].add(MA["Aquaveil"], "me")
                        end
                    
                    end
                    
                    -- GAINS
                    if windower.ffxi.get_spells()[MA[settings["GAINS"]:current()].id] and bpcore:isMAReady(MA[settings["GAINS"]:current()].recast_id) then
                        if not bpcore:buffActive(119) and not bpcore:buffActive(120) and not bpcore:buffActive(121) and not bpcore:buffActive(122) and not bpcore:buffActive(123) and not bpcore:buffActive(124) and not bpcore:buffActive(125) then
                            helpers['queue'].add(MA[settings["GAINS"]:current()], "me")
                        end
                    
                    end
                
                    -- SPIKES
                    if windower.ffxi.get_spells()[MA[settings["SPIKES"]:current()].id] and settings["SPIKES"]:current() ~= "None" then
                        if bpcore:isMAReady(MA[settings["SPIKES"]:current()].recast_id) and not bpcore:buffActive(34) and not bpcore:buffActive(35) and not bpcore:buffActive(38) then
                            helpers['queue'].add(MA[settings["SPIKES"]:current()], "me")
                        end
                    
                    end
                    
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" then
                        
                        -- BERSERK.
                        if windower.ffxi.get_abilities()[JA["Berserk"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Berserk"].recast_id) then
                                helpers['queue'].add(JA["Berserk"], "me")
                            end
                        
                        -- AGGRESSOR.
                        elseif windower.ffxi.get_abilities()[JA["Aggressor"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Aggressor"].recast_id) then
                                helpers['queue'].add(JA["Aggressor"], "me")
                            end
                        
                        -- WARCRY.
                        elseif windower.ffxi.get_abilities()[JA["Warcry"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Warcry"].recast_id) then
                                helpers['queue'].add(JA["Warcry"], "me")
                            end
                            
                        end
                        
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" then
                    
                        -- HASTE SAMBA.
                        if windower.ffxi.get_abilities()[JA["Haste Samba"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Haste Samba"].recast_id) then
                                helpers['queue'].add(JA["Haste Samaba"], "me")
                            end
                            
                        end
                    
                    -- /NIN.
                    elseif system["Player"].sub_job == "NIN" then
                    
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
                if settings["DEBUFFS"]:current() and bpcore:canCast() then
                    
                    -- RDM/.
                    if system["Player"].main_job == "RDM" then
                    
                        -- FRAZZLE II.
                        if windower.ffxi.get_spells()[MA["Frazzle II"].id] and bpcore:isMAReady(MA["Frazzle II"].recast_id) and os.clock()-settings["SPELLS"]["Frazzle II"].delay > settings["SPELLS"]["Frazzle II"].allowed then
                            helpers['queue'].add(MA["Frazzle II"], "t")
                            settings["SPELLS"]["Frazzle II"].allowed = os.clock()
                            
                        -- FRAZZLE III.
                        elseif windower.ffxi.get_spells()[MA["Frazzle III"].id] and bpcore:isMAReady(MA["Frazzle III"].recast_id) and os.clock()-settings["SPELLS"]["Frazzle III"].delay > settings["SPELLS"]["Frazzle III"].allowed then
                            helpers['queue'].add(MA["Frazzle III"], "t")
                            settings["SPELLS"]["Frazzle III"].allowed = os.clock()
                            
                        -- DISTRACT III.
                        elseif windower.ffxi.get_spells()[MA["Distract III"].id] and bpcore:isMAReady(MA["Distract III"].recast_id) and os.clock()-settings["SPELLS"]["Distract III"].delay > settings["SPELLS"]["Distract III"].allowed then
                            helpers['queue'].add(MA["Distract III"], "t")
                            settings["SPELLS"]["Distract III"].allowed = os.clock()
                            
                        -- DIA / BIO III.
                        elseif windower.ffxi.get_spells()[MA[settings["DIA"]:current().." III"].id] then
                        
                            if bpcore:isMAReady(MA[settings["DIA"]:current().." III"].recast_id) and os.clock()-settings["SPELLS"][settings["DIA"]:current().." III"].delay > settings["SPELLS"][settings["DIA"]:current().." III"].allowed then
                                helpers['queue'].add(MA[settings["DIA"]:current().." III"], "t")
                                settings["SPELLS"][settings["DIA"]:current().." III"].allowed = os.clock()
                                
                            end
                        
                        -- SILENCE.
                        elseif windower.ffxi.get_spells()[MA["Silence"].id] and bpcore:isMAReady(MA["Silence"].recast_id) and os.clock()-settings["SPELLS"]["Silence"].delay > settings["SPELLS"]["Silence"].allowed then
                            helpers['queue'].add(MA["Silence"], "t")
                            settings["SPELLS"]["Silence"].allowed = os.clock()
                        
                        -- ADDLE II.
                        elseif windower.ffxi.get_spells()[MA["Addle II"].id] and bpcore:isMAReady(MA["Addle II"].recast_id) and os.clock()-settings["SPELLS"]["Addle II"].delay > settings["SPELLS"]["Addle II"].allowed then
                            helpers['queue'].add(MA["Addle II"], "t")
                            settings["SPELLS"]["Addle II"].allowed = os.clock()
                        
                        -- PARALYZE II.
                        elseif windower.ffxi.get_spells()[MA["Paralyze II"].id] and bpcore:isMAReady(MA["Paralyze II"].recast_id) and os.clock()-settings["SPELLS"]["Paralyze II"].delay > settings["SPELLS"]["Paralyze II"].allowed then
                            helpers['queue'].add(MA["Paralyze II"], "t")
                            settings["SPELLS"]["Paralyze II"].allowed = os.clock()
                        
                        -- SLOW II.
                        elseif windower.ffxi.get_spells()[MA["Slow II"].id] and bpcore:isMAReady(MA["Slow II"].recast_id) and os.clock()-settings["SPELLS"]["Slow II"].delay > settings["SPELLS"]["Slow II"].allowed then
                            helpers['queue'].add(MA["Slow II"], "t")
                            settings["SPELLS"]["Slow II"].allowed = os.clock()
                        
                        -- BLIND II.
                        elseif windower.ffxi.get_spells()[MA["Blind II"].id] and bpcore:isMAReady(MA["Blind II"].recast_id) and os.clock()-settings["SPELLS"]["Blind II"].delay > settings["SPELLS"]["Blind II"].allowed then
                            helpers['queue'].add(MA["Blind II"], "t")
                            settings["SPELLS"]["Blind II"].allowed = os.clock()
                        
                        -- INUNDATION.
                        elseif windower.ffxi.get_spells()[MA["Inundation"].id] and bpcore:isMAReady(MA["Inundation"].recast_id) and os.clock()-settings["SPELLS"]["Inundation"].delay > settings["SPELLS"]["Inundation"].allowed then
                            helpers['queue'].add(MA["Inundation"], "t")
                            settings["SPELLS"]["Inundation"].allowed = os.clock()
                        
                        -- DISPEL.
                        elseif windower.ffxi.get_spells()[MA["Dispel"].id] and bpcore:isMAReady(MA["Dispel"].recast_id) and os.clock()-settings["SPELLS"]["Dispel"].delay > settings["SPELLS"]["Dispel"].allowed then
                            helpers['queue'].add(MA["Dispel"], "t")
                            settings["SPELLS"]["Dispel"].allowed = os.clock()
                        
                        end
                    
                    end
                    
                    -- /DNC.
                    if system["Player"].sub_job == "DNC" then
                    
                        -- STEPS.
                        if windower.ffxi.get_abilities()[JA[settings["STEPS"]:current()].id] and bpcore:canAct() and os.clock()-system["RDM"]["Steps Timer"] > system["RDM"]["Steps Delay"] then
                            if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) then
                                helpers['queue'].add(JA[settings["STEPS"]:current()], "me")
                            end
                            
                        end
                    
                    end
                    
                    -- DRAINS LOGIC
                    if settings["DRAINS"]:current() and bpcore:canCast() then
                        
                        -- DRAIN
                        if windower.ffxi.get_spells()[MA["Drain"].id] and system["Player"]["vitals"].mpp < system["RDM"]["Drain Threshold"] then
                            if bpcore:isMAReady(MA["Drain"].recast_id) then
                                helpers['queue'].add(MA["Drain"], "t")
                            end
                        end
                        
                        -- ASPIR
                        if windower.ffxi.get_spells()[MA["Aspir"].id] and system["Player"]["vitals"].mpp < system["RDM"]["Aspir Threshold"] then
                            if bpcore:isMAReady(MA["Aspir"].recast_id) then
                                helpers['queue'].add(MA["Aspir"], "t")
                            end
                        end
                        
                    end
                    
                end
            
            -- PLAYER IS DISENGAGED LOGIC.
            elseif system["Player"].status == 0 then
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() and settings["RA"]:current() then
                    
                    if not settings["AM"]:current() and system["Player"]["vitals"].tp > 1000 and (system["Ranged"].en == "Kaja Bow" or system["Ranged"].en == "Ullr Bow") then
                        helpers['queue'].addToFront(WS[settings["Empyreal Arrow"]], target)
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- RDM/.
                    if system["Player"].main_job == "RDM" then
                    
                        -- COMPOSURE LOGIC.
                        if settings["COMPOSURE"]:current() and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Composure"].recast_id) and not bpcore:buffActive(419) then
                                helpers['queue'].add(JA["Composure"], "me")
                            end
                            
                        end
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and bpcore:canAct() and system["Player"]["vitals"].hpp > system["RDM"]["Convert Threshold"].hpp and system["Player"]["vitals"].mpp < system["RDM"]["Convert Threshold"].mpp then
                            if bpcore:isJAReady(JA["Convert"].recast_id) then
                                helpers['queue'].add(JA["Convert"], "me")
                            end
                            
                        end
                    
                    end
                    
                    -- /DNC.
                    if system["Player"].sub_job == "DNC" then
                        
                        -- REVERSE FLOURISH.
                        if windower.ffxi.get_abilities()[JA["Reverse Flourish"].id] and bpcore:canAct() and bpcore:getFinishingMoves() > 4 then
                            if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) then
                                helpers['queue'].add(JA["Reverse Flourish"], "me")
                            end
                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" then
                        
                        -- PROVOKE.
                        if windower.ffxi.get_abilities()[JA["Provoke"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Provoke"].recast_id) then
                                helpers['queue'].add(JA["Provoke"], target)
                            end
                            
                        end
                        
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" then
                        
                        -- ANIMATED FLOURISH.
                        if windower.ffxi.get_abilities()[JA["Animated Flourish"].id] and bpcore:canAct() and bpcore:getFinishingMoves() > 0 then
                            if bpcore:isJAReady(JA["Animated Flourish"].recast_id) then
                                helpers['queue'].add(JA["Animated Flourish"], target)
                            end
                            
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() and bpcore:canCast() then
                    
                    -- RDM/.
                    if system["Player"].main_job == "RDM" then
                    
                        -- REFRESH III
                        if windower.ffxi.get_spells()[MA["Refresh III"].id] then
                            if bpcore:isMAReady(MA["Refresh III"].recast_id) and not bpcore:buffActive(43) then
                                helpers['queue'].add(MA["Refresh III"], "me")
                            end
                        
                        -- REFRESH II
                        elseif windower.ffxi.get_spells()[MA["Refresh II"].id] then
                            if bpcore:isMAReady(MA["Refresh II"].recast_id) and not bpcore:buffActive(43) then
                                helpers['queue'].add(MA["Refresh II"], "me")
                            end
                        
                        -- REFRESH I
                        elseif windower.ffxi.get_spells()[MA["Refresh"].id] then
                            if bpcore:isMAReady(MA["Refresh"].recast_id) and not bpcore:buffActive(43) then
                                helpers['queue'].add(MA["Refresh"], "me")
                            end
                            
                        end
                        
                        -- HASTE II
                        if windower.ffxi.get_spells()[MA["Haste II"].id] and system["Player"]["jobs"].RDM > 95 then
                            if bpcore:isMAReady(MA["Haste II"].recast_id) and not bpcore:buffActive(33) then
                                helpers['queue'].add(MA["Haste II"], "me")
                            end
                        
                        -- HASTE
                        elseif windower.ffxi.get_spells()[MA["Haste"].id] and system["Player"]["jobs"].RDM < 96 then
                            if bpcore:isMAReady(MA["Haste"].recast_id) and not bpcore:buffActive(33) then
                                helpers['queue'].add(MA["Haste"], "me")
                            end
                            
                        end
                        
                        -- TEMPER II
                        if windower.ffxi.get_spells()[MA["Temper II"].id] then
                            if bpcore:isMAReady(MA["Temper II"].recast_id) and not bpcore:buffActive(432) then
                                helpers['queue'].add(MA["Temper II"], "me")
                            end
                        
                        -- TEMPER
                        elseif windower.ffxi.get_spells()[MA["Temper"].id] then
                            if bpcore:isMAReady(MA["Temper"].recast_id) and not bpcore:buffActive(432) then
                                helpers['queue'].add(MA["Temper"], "me")
                            end
                            
                        end   
                        
                        -- PHALANX
                        if windower.ffxi.get_spells()[MA["Phalanx"].id] then
                            if bpcore:isMAReady(MA["Phalanx"].recast_id) and not bpcore:buffActive(116) then
                                helpers['queue'].add(MA["Phalanx"], "me")
                            end
                        
                        end
                        
                        -- AQUAVEIL
                        if windower.ffxi.get_spells()[MA["Aquaveil"].id] then
                            if bpcore:isMAReady(MA["Aquaveil"].recast_id) and not bpcore:buffActive(39) then
                                helpers['queue'].add(MA["Aquaveil"], "me")
                            end
                        
                        end
                        
                        -- GAINS
                        if windower.ffxi.get_spells()[MA[settings["GAINS"]:current()].id] and bpcore:isMAReady(MA[settings["GAINS"]:current()].recast_id) then
                            if not bpcore:buffActive(119) and not bpcore:buffActive(120) and not bpcore:buffActive(121) and not bpcore:buffActive(122) and not bpcore:buffActive(123) and not bpcore:buffActive(124) and not bpcore:buffActive(125) then
                                helpers['queue'].add(MA[settings["GAINS"]:current()], "me")
                            end
                        
                        end
                    
                        -- SPIKES
                        if windower.ffxi.get_spells()[MA[settings["SPIKES"]:current()].id] then
                            if bpcore:isMAReady(MA[settings["SPIKES"]:current()].recast_id) and not bpcore:buffActive(34) and not bpcore:buffActive(35) and not bpcore:buffActive(38) then
                                helpers['queue'].add(MA[settings["SPIKES"]:current()], "me")
                            end
                        
                        end
                    
                    end
                    
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" then
                        
                        -- BERSERK.
                        if windower.ffxi.get_abilities()[JA["Berserk"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Berserk"].recast_id) then
                                helpers['queue'].add(JA["Berserk"], "me")
                            end
                        
                        -- AGGRESSOR.
                        elseif windower.ffxi.get_abilities()[JA["Aggressor"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Aggressor"].recast_id) then
                                helpers['queue'].add(JA["Aggressor"], "me")
                            end
                        
                        -- WARCRY.
                        elseif windower.ffxi.get_abilities()[JA["Warcry"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Warcry"].recast_id) then
                                helpers['queue'].add(JA["Warcry"], "me")
                            end
                            
                        end
                        
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" then
                    
                        -- HASTE SAMBA.
                        if windower.ffxi.get_abilities()[JA["Haste Samba"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Haste Samba"].recast_id) then
                                helpers['queue'].add(JA["Haste Samaba"], "me")
                            end
                            
                        end
                    
                    -- /NIN.
                    elseif system["Player"].sub_job == "NIN" then
                    
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
                if settings["DEBUFFS"]:current() and bpcore:canCast() then
                    
                    -- RDM/.
                    if system["Player"].main_job == "RDM" then
                        
                        -- FRAZZLE II.
                        if windower.ffxi.get_spells()[MA["Frazzle II"].id] and bpcore:isMAReady(MA["Frazzle II"].recast_id) and os.clock()-settings["SPELLS"]["Frazzle II"].delay > settings["SPELLS"]["Frazzle II"].allowed then
                            helpers['queue'].add(MA["Frazzle II"], target)
                            settings["SPELLS"]["Frazzle II"].allowed = os.clock()
                            
                        -- FRAZZLE III.
                        elseif windower.ffxi.get_spells()[MA["Frazzle III"].id] and bpcore:isMAReady(MA["Frazzle III"].recast_id) and os.clock()-settings["SPELLS"]["Frazzle III"].delay > settings["SPELLS"]["Frazzle III"].allowed then
                            helpers['queue'].add(MA["Frazzle III"], target)
                            settings["SPELLS"]["Frazzle III"].allowed = os.clock()
                            
                        -- DISTRACT III.
                        elseif windower.ffxi.get_spells()[MA["Distract III"].id] and bpcore:isMAReady(MA["Distract III"].recast_id) and os.clock()-settings["SPELLS"]["Distract III"].delay > settings["SPELLS"]["Distract III"].allowed then
                            helpers['queue'].add(MA["Distract III"], target)
                            settings["SPELLS"]["Distract III"].allowed = os.clock()
                            
                        -- DIA / BIO III.
                        elseif windower.ffxi.get_spells()[MA[settings["DIA"]:current().." III"].id] then
                        
                            if bpcore:isMAReady(MA[settings["DIA"]:current().." III"].recast_id) and os.clock()-settings["SPELLS"][settings["DIA"]:current().." III"].delay > settings["SPELLS"][settings["DIA"]:current().." III"].allowed then
                                helpers['queue'].add(MA[settings["DIA"]:current().." III"], target)
                                settings["SPELLS"][settings["DIA"]:current().." III"].allowed = os.clock()
                                
                            end
                        
                        -- SILENCE.
                        elseif windower.ffxi.get_spells()[MA["Silence"].id] and bpcore:isMAReady(MA["Silence"].recast_id) and os.clock()-settings["SPELLS"]["Silence"].delay > settings["SPELLS"]["Silence"].allowed then
                            helpers['queue'].add(MA["Silence"], target)
                            settings["SPELLS"]["Silence"].allowed = os.clock()
                        
                        -- ADDLE II.
                        elseif windower.ffxi.get_spells()[MA["Addle II"].id] and bpcore:isMAReady(MA["Addle II"].recast_id) and os.clock()-settings["SPELLS"]["Addle II"].delay > settings["SPELLS"]["Addle II"].allowed then
                            helpers['queue'].add(MA["Addle II"], target)
                            settings["SPELLS"]["Addle II"].allowed = os.clock()
                        
                        -- PARALYZE II.
                        elseif windower.ffxi.get_spells()[MA["Paralyze II"].id] and bpcore:isMAReady(MA["Paralyze II"].recast_id) and os.clock()-settings["SPELLS"]["Paralyze II"].delay > settings["SPELLS"]["Paralyze II"].allowed then
                            helpers['queue'].add(MA["Paralyze II"], target)
                            settings["SPELLS"]["Paralyze II"].allowed = os.clock()
                        
                        -- SLOW II.
                        elseif windower.ffxi.get_spells()[MA["Slow II"].id] and bpcore:isMAReady(MA["Slow II"].recast_id) and os.clock()-settings["SPELLS"]["Slow II"].delay > settings["SPELLS"]["Slow II"].allowed then
                            helpers['queue'].add(MA["Slow II"], target)
                            settings["SPELLS"]["Slow II"].allowed = os.clock()
                        
                        -- BLIND II.
                        elseif windower.ffxi.get_spells()[MA["Blind II"].id] and bpcore:isMAReady(MA["Blind II"].recast_id) and os.clock()-settings["SPELLS"]["Blind II"].delay > settings["SPELLS"]["Blind II"].allowed then
                            helpers['queue'].add(MA["Blind II"], target)
                            settings["SPELLS"]["Blind II"].allowed = os.clock()
                        
                        -- INUNDATION.
                        elseif windower.ffxi.get_spells()[MA["Inundation"].id] and bpcore:isMAReady(MA["Inundation"].recast_id) and os.clock()-settings["SPELLS"]["Inundation"].delay > settings["SPELLS"]["Inundation"].allowed then
                            helpers['queue'].add(MA["Inundation"], target)
                            settings["SPELLS"]["Inundation"].allowed = os.clock()
                        
                        -- DISPEL.
                        elseif windower.ffxi.get_spells()[MA["Dispel"].id] and bpcore:isMAReady(MA["Dispel"].recast_id) and os.clock()-settings["SPELLS"]["Dispel"].delay > settings["SPELLS"]["Dispel"].allowed then
                            helpers['queue'].add(MA["Dispel"], target)
                            settings["SPELLS"]["Dispel"].allowed = os.clock()
                        
                        end
                    
                    end
                    
                end
                
                -- DRAINS LOGIC
                if settings["DRAINS"]:current() and bpcore:canCast() then
                    
                    -- DRAIN
                    if windower.ffxi.get_spells()[MA["Drain"].id] and system["Player"]["vitals"].mpp < system["RDM"]["Drain Threshold"] then
                        if bpcore:isMAReady(MA["Drain"].recast_id) then
                            helpers['queue'].add(MA["Drain"], target)
                        end
                    end
                    
                    -- ASPIR
                    if windower.ffxi.get_spells()[MA["Aspir"].id] and system["Player"]["vitals"].mpp < system["RDM"]["Aspir Threshold"] then
                        if bpcore:isMAReady(MA["Aspir"].recast_id) then
                            helpers['queue'].add(MA["Aspir"], target)
                        end
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
        
    end
    
    return self
    
end

return core.get()