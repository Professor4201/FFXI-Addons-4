--------------------------------------------------------------------------------
-- WHM Core: Handle all job automation for White Mage.
--------------------------------------------------------------------------------
local core = {}

-- CORE AUTOMATED FUNCTION FOR THIS JOB.
function core.get()
    self = {}
    
    -- Master Settings.
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
    settings["MYRKR"]                              = I{false,true}
    settings["SPIRITS"]                            = T{"Light Spirit","Fire Spirirt","Ice Spirit","Air Spirit","Earth Spirit","Thunder Spirit","Water Spirit","Dark Spirit"}
    settings["SUMMON"]                             = I{"Carbuncle","Cait Sith","Ifrit","Shiva","Garuda","Titan","Ramuh","Leviathan","Fenrir","Diabolos","Siren"}
    settings["BPRAGE"]                             = I{false,true}
    settings["BPWARD"]                             = I{false,true}
    
    settings["SPELLS"]={
        
        ["Dia"]           = {["allowed"]=0,["delay"]=60},  ["Dia II"]      ={["allowed"]=0,["delay"]=120},
        ["Bio"]           = {["allowed"]=0,["delay"]=60},  ["Bio II"]      ={["allowed"]=0,["delay"]=120},
        ["Distract"]      = {["allowed"]=0,["delay"]=120}, ["Dispel"]      ={["allowed"]=0,["delay"]=15}, 
        ["Frazzle"]       = {["allowed"]=0,["delay"]=120}, 
        ["Addle"]         = {["allowed"]=0,["delay"]=120}, 
        ["Blind"]         = {["allowed"]=0,["delay"]=180}, 
        ["Paralyze"]      = {["allowed"]=0,["delay"]=120}, 
        ["Slow"]          = {["allowed"]=0,["delay"]=120}, 
        ["Silence"]       = {["allowed"]=0,["delay"]=120},
        
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
                helpers["queue"].clear()
            end
        
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
            
        elseif command == "cures" then
            settings["CURES"]:next()
            
            if settings["CURES"]:current() == 1 then
                helpers['popchat']:pop(("Now Curing: None"):upper(), system["Popchat Window"])
            
            elseif settings["CURES"]:current() == 2 then
                helpers['popchat']:pop(("Now Curing: Party"):upper(), system["Popchat Window"])
            
            elseif settings["CURES"]:current() == 3 then
                helpers['popchat']:pop(("Now Curing: Alliance"):upper(), system["Popchat Window"])
            
            end
        
        elseif command == "sub" then
            settings["SUBLIMATION"]:next()
            helpers['popchat']:pop(("Auto-Sublimation: " .. tostring(settings["SUBLIMATION"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "hate" then
            settings["HATE"]:next()
            helpers['popchat']:pop(("Auto-Enmity: " .. tostring(settings["HATE"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "buffs" then
            settings["BUFFS"]:next()
            helpers['popchat']:pop(("Auto-Buffing: " .. tostring(settings["BUFFS"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "debuffs" then
            settings["DEBUFFS"]:next()
            helpers['popchat']:pop(("Auto-Debuffing: " .. tostring(settings["DEBUFFS"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "status" then
            settings["STATUS"]:next()
            helpers['popchat']:pop(("Status Removal: " .. tostring(settings["STATUS"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "ws" then
            settings["WS"]:next()
            helpers['popchat']:pop(("Auto-Weapon Skills: " .. tostring(settings["WS"]:current())):upper(), system["Popchat Window"])
            
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
                    local match = res.weapon_skills[v].en:lower():match(("[%a%s%'%:]+"))

                    if weaponskill:sub(1, #weaponskill) == match:sub(1, #weaponskill) then
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
            
            -- Determine how to handle status debuffs.
            if settings["STATUS"]:current() then
                helpers["status"].manangeStatuses()
            end
            
            -- PLAYER IS ENGAGED.
            if player.status == 1 then
                local target = helpers["target"].getTarget() or windower.ffxi.get_mob_by_target("t") or false
                
                -- SKILLUP LOGIC.
                if settings["SKILLUP"]:current() then
                    
                    for i,v in pairs(system["Skillup"][settings["SKILLS"]:current()].list) do

                        if windower.ffxi.get_spells()[MA[v].id] and bpcore:isMAReady(MA[v].recast_id) then
                            helpers["queue"].add(MA[v], system["Skillup"][settings["SKILLS"]:current()].target)
                        end
                        
                    end
                    
                end
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() then
                    
                    if settings["AM"]:current() then
                        
                        if bpcore:buffActive(272) and player["vitals"].tp > 1000 and player["vitals"].tp > settings["TP THRESHOLD"] then
                            
                            if settings["WSNAME"]:current() == "Moonlight" and player["vitals"].mpp < system["WHM"]["Moonlight Threshold"] then
                                helpers["queue"].addToFront(WS["Moonlight"], "me")
                            else
                                helpers["queue"].addToFront(WS[settings["WSNAME"]], "t")
                            end
                            
                        elseif not bpcore:buffActive(272) and player["vitals"].tp > 1000 and system["Weapon"].en == "Excalibur" then
                            helpers["queue"].addToFront(WS["Knights of Round"], "t")
                        
                        elseif not bpcore:buffActive(272) and player["vitals"].tp > 1000 and system["Weapon"].en == "Almace" then
                            helpers["queue"].addToFront(WS["Chant Du Cygne"], "t")
                        
                        elseif not bpcore:buffActive(272) and player["vitals"].tp > 1000 and system["Weapon"].en == "Murgleis" then
                            helpers["queue"].addToFront(WS["Death Blossom"], "t")
                        end
                        
                    elseif not settings["AM"]:current() and player["vitals"].tp > 1000 and player["vitals"].tp > settings["TP THRESHOLD"] then
                        
                        if settings["WSNAME"]:current() == "Moonlight" and player["vitals"].mpp < system["WHM"]["Moonlight Threshold"] then
                            helpers["queue"].addToFront(WS["Moonlight"], "me")
                        else
                            helpers["queue"].addToFront(WS[settings["WSNAME"]], "t")
                        end
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- WHM/.
                    if player.main_job == "WHM" then                        
                        
                        
                    end
                    
                    -- /RDM.
                    if player.sub_job == "RDM" then
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and system["Player"]["vitals"].hpp > system["RDM"]["Convert Threshold"].hpp and system["Player"]["vitals"].mpp < system["RDM"]["Convert Threshold"].mpp then
                            
                            if bpcore:isJAReady(JA["Convert"].recast_id) and bpcore:getAvailable("JA", "Convert") then
                                helpers["queue"].add(JA["Convert"], "me")
                            end
                            
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
                if settings["HATE"]:current() then
                        
                    -- PROVOKE.
                    if bpcore:isJAReady(JA["Provoke"].recast_id) and bpcore:getAvailable("JA", "Provoke") then
                        helpers["queue"].add(JA["Provoke"], "t")
                    end
                        
                    -- /DNC.
                    if player.sub_job == "DNC" then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and bpcore:getAvailable("JA", "Animated Flourish") then
                            helpers["queue"].add(JA["Animated Flourish"], "t")
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    if player.main_job == "WHM" then

                        if bpcore:canCast() and bpcore:isMAReady(MA["Aurorastorm"].recast_id) and bpcore:getAvailable("MA", "Aurorastorm") and (not bpcore:buffActive(184) or not bpcore:buffActive(595)) then
                            helpers["queue"].add(MA["Aurorastorm"], "me")
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
                    
                    -- WHM/.
                    if player.main_job == "WHM" and bpcore:canCast() then
                    
                    end
                    
                    -- /DNC.
                    if player.sub_job == "DNC" and bpcore:canAct() then
                    
                        -- STEPS.
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["WAR"]["Steps Timer"] > system["WAR"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers["queue"].add(JA[settings["STEPS"]:current()], "t")                            
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
            
            -- PLAYER IS DISENGAGED LOGIC.
            elseif player.status == 0 then
                
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
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() then
                    
                    if settings["AM"]:current() then
                        
                        if bpcore:buffActive(272) and player["vitals"].tp > 1000 and player["vitals"].tp > settings["TP THRESHOLD"] then
                            
                            if settings["WSNAME"]:current() == "Moonlight" and player["vitals"].mpp < system["WHM"]["Moonlight Threshold"] then
                                helpers["queue"].addToFront(WS["Moonlight"], "me")
                            
                            elseif target then
                                helpers["queue"].addToFront(WS[settings["WSNAME"]], target)
                            end
                            
                        elseif target and not bpcore:buffActive(272) and player["vitals"].tp > 1000 and system["Weapon"].en == "Excalibur" then
                            helpers["queue"].addToFront(WS["Knights of Round"], "t")
                        
                        elseif target and not bpcore:buffActive(272) and player["vitals"].tp > 1000 and system["Weapon"].en == "Almace" then
                            helpers["queue"].addToFront(WS["Chant Du Cygne"], "t")
                        
                        elseif target and not bpcore:buffActive(272) and player["vitals"].tp > 1000 and system["Weapon"].en == "Murgleis" then
                            helpers["queue"].addToFront(WS["Death Blossom"], "t")
                        end
                        
                    elseif not settings["AM"]:current() and player["vitals"].tp > 1000 and player["vitals"].tp > settings["TP THRESHOLD"] then
                        
                        if settings["WSNAME"]:current() == "Moonlight" and player["vitals"].mpp < system["WHM"]["Moonlight Threshold"] then
                            helpers["queue"].addToFront(WS["Moonlight"], "me")
                        
                        elseif target then
                            helpers["queue"].addToFront(WS[settings["WSNAME"]], "t")
                        end
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- WHM/.
                    if player.main_job == "WHM" then
                        
                    end
                    
                    -- /RDM.
                    if player.sub_job == "RDM" then
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and system["Player"]["vitals"].hpp > system["WHM"]["Convert Threshold"].hpp and system["Player"]["vitals"].mpp < system["WHM"]["Convert Threshold"].mpp then
                            
                            if bpcore:isJAReady(JA["Convert"].recast_id) and bpcore:getAvailable("JA", "Convert") then
                                helpers["queue"].add(JA["Convert"], "me")
                            end
                            
                        end
                        
                    -- /SCH.
                    elseif player.sub_job == "SCH" then
                        
                        -- LIGHT ARTS.
                        if bpcore:isJAReady(JA["Light Arts"].recast_id) and bpcore:getAvailable("JA", "Light Arts") and not bpcore:buffActive(358) then
                            helpers["queue"].addToFront(JA["Light Arts"], "me")
                        end
                        
                        -- SUBLIMATION LOGIC.
                        if bpcore:canAct() and settings["SUBLIMATION"]:current() and player["vitals"].mpp < 15 and bpcore:buffActive(187) and bpcore:isJAReady(JA["Sublimation"].recast_id) and bpcore:getAvailable("JA", "Sublimation") then
                            helpers["queue"].add(JA["Sublimation"], "me")
                            
                        elseif bpcore:canAct() and settings["SUBLIMATION"]:current() and player["vitals"].mpp < 50 and bpcore:buffActive(188) and bpcore:isJAReady(JA["Sublimation"].recast_id) and bpcore:getAvailable("JA", "Sublimation") then
                            helpers["queue"].add(JA["Sublimation"], "me")
                            
                        elseif bpcore:canAct() and settings["SUBLIMATION"]:current() and not bpcore:buffActive(187) and not bpcore:buffActive(188) and bpcore:isJAReady(JA["Sublimation"].recast_id) and bpcore:getAvailable("JA", "Sublimation") then
                            helpers["queue"].add(JA["Sublimation"], "me")
                            
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
                        
                    -- PROVOKE.
                    if bpcore:canAct() and bpcore:isJAReady(JA["Provoke"].recast_id) and bpcore:getAvailable("JA", "Provoke") then
                        helpers["queue"].add(JA["Provoke"], "t")
                    end
                        
                    -- /DNC.
                    if bpcore:canAct() and player.sub_job == "DNC" then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and bpcore:getAvailable("JA", "Animated Flourish") then
                            helpers["queue"].add(JA["Animated Flourish"], "t")
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    if player.main_job == "WHM" then
                        
                        -- HASTE.
                        if bpcore:canCast() and bpcore:isMAReady(MA["Haste"].recast_id) and bpcore:getAvailable("MA", "Haste") and not bpcore:buffActive(33) then
                            helpers["queue"].add(MA["Haste"], "me")
                            
                        end
                        
                    end
                    
                    if player.sub_job == "SCH" then
                        
                        -- AURORASTORM.
                        if bpcore:canCast() and bpcore:isMAReady(MA["Aurorastorm"].recast_id) and bpcore:getAvailable("MA", "Aurorastorm") and not bpcore:buffActive(184) and not bpcore:buffActive(595) then
                            helpers["queue"].add(MA["Aurorastorm"], "me")
                        end
                        
                    elseif player.sub_job == "RDM" then
                    
                    
                    
                    elseif player.sub_job == "WAR" then
                    
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
                    
                    -- WHM/.
                    if player.main_job == "WHM" and bpcore:canCast() then
                            
                        -- DIA / BIO.
                        if bpcore:getAvailable("MA", settings["DIA"]:current()) then
                        
                            if bpcore:isMAReady(MA[settings["DIA"]:current()].recast_id) and os.clock()-settings["SPELLS"][settings["DIA"]:current()].allowed > settings["SPELLS"][settings["DIA"]:current()].delay then
                                helpers["queue"].add(MA[settings["DIA"]:current().." III"], target)
                                settings["SPELLS"][settings["DIA"]:current()].allowed = os.clock()
                                
                            end
                        
                        -- SILENCE.
                        elseif bpcore:isMAReady(MA["Silence"].recast_id) and os.clock()-settings["SPELLS"]["Silence"].allowed > settings["SPELLS"]["Silence"].delay and bpcore:getAvailable("MA", "Silence") then
                            helpers["queue"].add(MA["Silence"], target)
                            settings["SPELLS"]["Silence"].allowed = os.clock()
                        
                        -- ADDLE.
                        elseif bpcore:isMAReady(MA["Addle II"].recast_id) and os.clock()-settings["SPELLS"]["Addle II"].allowed > settings["SPELLS"]["Addle II"].delay and bpcore:getAvailable("MA", "Addle II") then
                            helpers["queue"].add(MA["Addle II"], target)
                            settings["SPELLS"]["Addle II"].allowed = os.clock()
                        
                        -- PARALYZE.
                        elseif bpcore:isMAReady(MA["Paralyze II"].recast_id) and os.clock()-settings["SPELLS"]["Paralyze II"].allowed > settings["SPELLS"]["Paralyze II"].delay and bpcore:getAvailable("MA", "Paralyze II") then
                            helpers["queue"].add(MA["Paralyze II"], target)
                            settings["SPELLS"]["Paralyze II"].allowed = os.clock()
                        
                        -- SLOW.
                        elseif bpcore:isMAReady(MA["Slow II"].recast_id) and os.clock()-settings["SPELLS"]["Slow II"].allowed > settings["SPELLS"]["Slow II"].delay and bpcore:getAvailable("MA", "Slow II") then
                            helpers["queue"].add(MA["Slow II"], target)
                            settings["SPELLS"]["Slow II"].allowed = os.clock()
                        
                        end
                        
                    end
                    
                    -- /DNC.
                    if player.sub_job == "DNC" and bpcore:canAct() then
                    
                        -- STEPS.
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["WAR"]["Steps Timer"] > system["WAR"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers["queue"].add(JA[settings["STEPS"]:current()], target)                            
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
                
            end
            
            -- HANDLE ALL CURING.
            if settings["CURES"]:current() == 2 then
                helpers["cures"].handleParty()
                
            elseif settings["CURES"]:current() == 3 then
                helpers["cures"].handleParty()
                helpers["cures"].handleAlliance()
            end
            
            -- HANDLE EVERYTHING INSIDE THE QUEUE.
            helpers["queue"].handleQueue()
        
        end
        
    end
    
    self.toggleDisplay = function()
        display:next()
    end
    
    self.setSetting = function(setting, value)
        settings[setting]:setTo(value)
    end
    
    self.getSetting = function(setting)
        return settings[setting]:current()
    end
    
    self.handleWindow = function()
        
    end
    
    self.destroy = function()
        window:destroy()
        
    end 
    
    return self
    
end

return core.get()