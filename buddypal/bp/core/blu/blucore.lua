--------------------------------------------------------------------------------
-- BLU Core: Handle all job automation for Blue Mage.
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
    settings["HATE"]                               = I{false,true}
    settings["BUFFS"]                              = I{false,true}
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
    settings["SKILLS"]                             = I{"Blue Magic"}
    
    -- Specialty Settings
    settings["BLU MODE"]                           = I{"DPS","NUKE"}
    settings["MIGHTY GUARD"]                       = I{true,false}
    settings["SANGUINE"]                           = I{false,true}
    settings["CONVERT"]                            = I{false,true}
    settings["DISPEL TIMER"]                       = I{30,60,120,240}
    settings["ENSPELL"]                            = I{"Enfire","Enblizzard","Enaero","Enstone","Enthunder","Enwater"}
    settings["SPIKES"]                             = I{"None","Blaze Spikes","Ice Spikes"}
    settings["DIA"]                                = I{"Dia","Bio"}
    
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
    settings["Magic Burst"]={
        
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
                helpers["queue"].clear()
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
        
        elseif command == "blumode" then
            settings["BLU MODE"]:next()
            helpers['popchat']:pop(("Blue Mage Mode now set to: " .. tostring(settings["BLU MODE"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "mg" then
            settings["MIGHTY GUARD"]:next()
            helpers['popchat']:pop(("Auto-Mighty Guard: " .. tostring(settings["MIGHTY GUARD"]:current())):upper(), system["Popchat Window"])
        
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
            helpers['popchat']:pop(("Allow AOE Spells now: " .. tostring(settings["ALLOW-AOE"]:current())):upper(), system["Popchat Window"])
            
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
            
        elseif command == "rune1" then
            settings["RUNE1"]:next()
            helpers['popchat']:pop(("Rune 1 set to: " .. tostring(settings["RUNE1"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "rune2" then
            settings["RUNE2"]:next()
            helpers['popchat']:pop(("Rune 3 set to: " .. tostring(settings["RUNE2"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "rune3" then
            settings["RUNE3"]:next()
            helpers['popchat']:pop(("Rune 3 set to: " .. tostring(settings["RUNE3"]:current())):upper(), system["Popchat Window"])
        
        elseif command == "steps" then
            settings["STEPS"]:next()
            helpers['popchat']:pop(("Auto-Steps: " .. tostring(settings["STEPS"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "skillup" then
            settings["SKILLUP"]:next()
            helpers['popchat']:pop(("Auto-Skillup: " .. tostring(settings["SKILLUP"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "skills" then
            settings["SKILLS"]:next()
            helpers['popchat']:pop(("Skill-Up Skill now set to: " .. tostring(settings["SKILLS"]:current())):upper(), system["Popchat Window"])
            
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
            
        elseif command == "spikes" then
            settings["SPIKES"]:next()
            helpers['popchat']:pop(("Auto-Spikes now set to: " .. tostring(settings["SPIKES"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "dtimer" then
            settings["DISPEL TIMER"]:next()
            helpers['popchat']:pop(("Dispel Timer now set to: " .. tostring(settings["DISPEL TIMER"]:current())):upper(), system["Popchat Window"])
            
        elseif command == "dia" or command == "bio" then
            settings["DIA"]:next()
            helpers['popchat']:pop(("Dia/Bio Mode now set to: " .. tostring(settings["DIA"]:current())):upper(), system["Popchat Window"])
        
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
                    
                    if bpcore:canCast() and settings["SKILLS"]:current() == "Blue Magic" then
                        
                        -- POLLEN.
                        if bpcore:isMAReady(MA["Pollen"].recast_id) and bpcore:getAvailable("MA", "Pollen") then
                            helpers["queue"].add(MA["Pollen"], "me")
                        
                        -- COCOON.
                        elseif bpcore:isMAReady(MA["Cocoon"].recast_id) and bpcore:getAvailable("MA", "Cocoon") then
                            helpers["queue"].add(MA["Cocoon"], "me")
                            
                        -- HEAD BUTT.
                        elseif bpcore:isMAReady(MA["Head Butt"].recast_id) and bpcore:getAvailable("MA", "Head Butt") then
                            helpers["queue"].add(MA["Head Butt"], "t")
                        
                        -- FOOT KICK
                        elseif bpcore:isMAReady(MA["Foot Kick"].recast_id) and bpcore:getAvailable("MA", "Foot Kick") then
                            helpers["queue"].add(MA["Foot Kick"], "t")
                            
                        -- SPROUT SMACK
                        elseif bpcore:isMAReady(MA["Sprout Smack"].recast_id) and bpcore:getAvailable("MA", "Sprout Smack") then
                            helpers["queue"].add(MA["Sprout Smack"], "t")
                        
                        -- POWER ATTACK.
                        elseif bpcore:isMAReady(MA["Power Attack"].recast_id) and bpcore:getAvailable("MA", "Power Attack") then
                            helpers["queue"].add(MA["Power Attack"], "t")
                        
                        end
                        
                    end
                    
                end
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() then
                    
                    if settings["AM"]:current() then
                        
                        if bpcore:buffActive(272) and system["Player"]["vitals"].tp > settings["TP THRESHOLD"] then
                            
                            if settings["SANGUINE"]:current() and system["Player"]["vitals"].hpp < system["BLU"]["Sanguine Threshold"] and bpcore:getAvailable("WS", "Sanguine Blade") then
                                helpers["queue"].addToFront(WS["Sanguine Blade"], "t")
                            
                            elseif bpcore:getAvailable("WS", settings["WSNAME"]) and system["Player"]["vitals"].tp > settings["TP THRESHOLD"] then
                                helpers["queue"].addToFront(WS[settings["WSNAME"]], "t")
                                
                            end
                        
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Almace" and bpcore:getAvailable("WS", "Chant Du Cygne") then
                            helpers["queue"].addToFront(WS["Chant Du Cygne"], "t")
                        
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Tizona" and bpcore:getAvailable("WS", "Expiacion") then
                            helpers["queue"].addToFront(WS["Expiacion"], "t")
                            
                        elseif not bpcore:buffActive(272) and system["Player"]["vitals"].tp == settings["AM THRESHOLD"] and system["Weapon"].en == "Sequence" and bpcore:getAvailable("WS", "Requiescat") then
                            helpers["queue"].addToFront(WS["Requiescat"], "t")
                            
                        end
                        
                    elseif system["Player"]["vitals"].tp > settings["TP THRESHOLD"] then
                        
                        if settings["SANGUINE"]:current() and system["Player"]["vitals"].hpp < system["BLU"]["Sanguine Threshold"] and bpcore:getAvailable("WS", "Sanguine Blade") then
                            helpers["queue"].addToFront(WS["Sanguine Blade"], "t")
                        
                        elseif bpcore:getAvailable("WS", settings["WSNAME"]) and system["Player"]["vitals"].tp > settings["TP THRESHOLD"] then
                            helpers["queue"].addToFront(WS[settings["WSNAME"]], "t")
                        end
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- BLU/.
                    if system["Player"].main_job == "BLU" then
                        
                        
                    
                    end
                    
                    -- /DNC.
                    if system["Player"].sub_job == "DNC" then
                        
                        -- REVERSE FLOURISH.
                        if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) and bpcore:getFinishingMoves() > 4 then
                            helpers["queue"].add(JA["Reverse Flourish"], "me")                            
                        end
                    
                    -- /RDM.
                    elseif system["Player"].sub_job == "RDM" then
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and system["Player"]["vitals"].hpp > system["BLU"]["Convert Threshold"].hpp and system["Player"]["vitals"].mpp < system["BLU"]["Convert Threshold"].mpp then
                            if bpcore:isJAReady(JA["Convert"].recast_id) and bpcore:getAvailable("JA", "Convert") then
                                helpers["queue"].add(JA["Convert"], "me")
                            end
                            
                        end                        
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" and bpcore:canAct() then
                        
                        -- PROVOKE.
                        if bpcore:isJAReady(JA["Provoke"].recast_id) and bpcore:getAvailable("JA", "Provoke") then
                            helpers["queue"].add(JA["Provoke"], "t")                            
                        end
                        
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and bpcore:getAvailable("JA", "Animated Flourish") then
                            helpers["queue"].add(JA["Animated Flourish"], "t")                            
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    -- HASTE II. (29.98%)
                    if bpcore:canCast() and bpcore:isMAReady(MA["Erratic Flutter"].recast_id) and bpcore:getAvailable("MA", "Erratic Flutter") and not bpcore:buffActive(33) then
                        helpers["queue"].add(MA["Erratic Flutter"], "me")
                    
                    -- HASTE. (15%)
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Animating Wail"].recast_id) and bpcore:getAvailable("MA", "Animating Wail") and not bpcore:buffActive(33) then
                        helpers["queue"].add(MA["Animating Wail"], "me")
                    
                    -- HASTE. (10%)
                    elseif bpcore:canCast() and bpcore:isMAReady(MA["Refueling"].recast_id) and bpcore:getAvailable("MA", "Refueling") and not bpcore:buffActive(33) then
                        helpers["queue"].add(MA["Refueling"], "me")
                        
                    end  
                    
                    -- COCOON.
                    if bpcore:canCast() and bpcore:isMAReady(MA["Cocoon"].recast_id) and bpcore:getAvailable("MA", "Cocoon") and not bpcore:buffActive(116) then
                        helpers["queue"].add(MA["Cocoon"], "me")
                    end
                    
                    -- MAGIC BARRIER.
                    if bpcore:canCast() and bpcore:isMAReady(MA["Magic Barrier"].recast_id) and bpcore:getAvailable("MA", "Magic Barrier") and not bpcore:buffActive(116) then
                        helpers["queue"].add(MA["Magic Barrier"], "me")
                    end
                    
                    -- SALINE COAT.
                    if bpcore:canCast() and bpcore:isMAReady(MA["Saline Coat"].recast_id) and bpcore:getAvailable("MA", "Saline Coat") and not bpcore:buffActive(116) then
                        helpers["queue"].add(MA["Saline Coat"], "me")
                    end
                    
                    -- BARRIER TUSK.
                    if bpcore:canCast() and bpcore:isMAReady(MA["Barrier Tusk"].recast_id) and bpcore:getAvailable("MA", "Barrier Tusk") and not bpcore:buffActive(116) then
                        helpers["queue"].add(MA["Barrier Tusk"], "me")
                    end
                    
                    -- OCCULTATION.
                    if bpcore:canCast() and bpcore:isMAReady(MA["Occultation"].recast_id) and bpcore:getAvailable("MA", "Occultation") and not bpcore:buffActive(116) then
                        helpers["queue"].add(MA["Occultation"], "me")
                    end
                    
                    if settings["BLU MODE"]:current() == "DPS" then
                       
                        -- NATURE'S MEDITATION.
                        if bpcore:canCast() and bpcore:isMAReady(MA["Nature's Meitation"].recast_id) and bpcore:getAvailable("MA", "Nature's Meitation") and not bpcore:buffActive(116) then
                            helpers["queue"].add(MA["Nature's Meitation"], "me")                            
                        end
                        
                    elseif settings["BLU MODE"]:current() == "NUKE" then
                        
                        -- MOMENTO MORI.
                        if bpcore:canCast() and bpcore:isMAReady(MA["Momento Mori"].recast_id) and bpcore:getAvailable("MA", "Momento Mori") and not bpcore:buffActive(116) then
                            helpers["queue"].add(MA["Momento Mori"], "me")
                            
                        -- NATURE'S MEDITATION.
                        elseif bpcore:canCast() and bpcore:isMAReady(MA["Amplification"].recast_id) and bpcore:getAvailable("MA", "Amplification") and not bpcore:buffActive(116) then
                            helpers["queue"].add(MA["Amplification"], "me")
                        
                        end
                        
                    end
                    
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" then
                        
                        -- BERSERK.
                        if bpcore:canAct() and bpcore:isJAReady(JA["Berserk"].recast_id) and bpcore:getAvailable("JA", "Berserk") then
                            helpers["queue"].add(JA["Berserk"], "me")
                        
                        -- AGGRESSOR.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Aggressor"].recast_id) and bpcore:getAvailable("JA", "Aggressor") then
                            helpers["queue"].add(JA["Aggressor"], "me")
                        
                        -- WARCRY.
                        elseif bpcore:canAct() and bpcore:isJAReady(JA["Warcry"].recast_id) and bpcore:getAvailable("JA", "Warcry") then
                            helpers["queue"].add(JA["Warcry"], "me")
                            
                        end
                        
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" then
                    
                        -- HASTE SAMBA.
                        if bpcore:canAct() and bpcore:isJAReady(JA["Haste Samba"].recast_id) and bpcore:getAvailable("JA", "Haste Samba") then
                            helpers["queue"].add(JA["Haste Samaba"], "me")                            
                        end
                    
                    -- /RDM.
                    elseif system["Player"].sub_job == "RDM" then
                        
                        -- PHALANX
                        if bpcore:canCast() and bpcore:isMAReady(MA["Phalanx"].recast_id) and bpcore:getAvailable("MA", "Phalanx") and not bpcore:buffActive(116) then
                            helpers["queue"].add(MA["Phalanx"], "me")                    
                        end
                        
                        -- AQUAVEIL
                        if bpcore:canCast() and bpcore:isMAReady(MA["Aquaveil"].recast_id) and bpcore:getAvailable("MA", "Aquaveil") and not bpcore:buffActive(39) then
                            helpers["queue"].add(MA["Aquaveil"], "me")                    
                        end
                        
                        -- ENSPELLS
                        if bpcore:canCast() and bpcore:isMAReady(MA[settings["ENSPELL"]:current()].recast_id) and bpcore:getAvailable("MA", settings["ENSPELL"]:current()) then
                            if not bpcore:buffActive(94) and not bpcore:buffActive(95) and not bpcore:buffActive(96) and not bpcore:buffActive(97) and not bpcore:buffActive(98) and not bpcore:buffActive(99) then
                                helpers["queue"].add(MA[settings["ENSPELL"]:current()], "me")
                            end                    
                        end
                    
                        -- SPIKES
                        if settings["SPIKES"]:current() ~= "None" then
                            if bpcore:canCast() and bpcore:isMAReady(MA[settings["SPIKES"]:current()].recast_id) and bpcore:getAvailable("MA", settings["SPIKES"]:current()) then
                                if bpcore:isMAReady(MA[settings["SPIKES"]:current()].recast_id) and not bpcore:buffActive(34) and not bpcore:buffActive(35) and not bpcore:buffActive(38) then
                                    helpers["queue"].add(MA[settings["SPIKES"]:current()], "me")
                                end
                            end
                        end
                    
                    -- /RUN.
                    elseif system["Player"].sub_job == "RUN" then
                        
                        -- RUNE 1.
                        if not bpcore:buffActive(system["RUNES"][settings["RUNE1"]:current()]) then
                        
                            if bpcore:canAct() and bpcore:isJAReady(JA[settings["RUNE1"]:current()].recast_id) and bpcore:getAvailable("JA", settings["RUNE1"]:current()) then
                                helpers["queue"].add(JA[settings["RUNE1"]:current()], "me")                    
                            end
                        
                        end
                        
                        -- RUNE 2.
                        if not bpcore:buffActive(system["RUNES"][settings["RUNE2"]:current()]) then
                        
                            if bpcore:canAct() and bpcore:isJAReady(JA[settings["RUNE2"]:current()].recast_id) and bpcore:getAvailable("JA", settings["RUNE2"]:current()) then
                                helpers["queue"].add(JA[settings["RUNE2"]:current()], "me")                    
                            end
                        
                        end
                        
                        -- RUNE 3.
                        if not bpcore:buffActive(system["RUNES"][settings["RUNE3"]:current()]) then
                        
                            if bpcore:canAct() and bpcore:isJAReady(JA[settings["RUNE3"]:current()].recast_id) and bpcore:getAvailable("JA", settings["RUNE3"]:current()) then
                                helpers["queue"].add(JA[settings["RUNE3"]:current()], "me")                    
                            end
                        
                        end
                        
                        -- SPIKES
                        if settings["SPIKES"]:current() ~= "None" then
                            if bpcore:canCast() and bpcore:isMAReady(MA[settings["SPIKES"]:current()].recast_id) and bpcore:getAvailable("MA", settings["SPIKES"]:current()) then
                                if bpcore:isMAReady(MA[settings["SPIKES"]:current()].recast_id) and not bpcore:buffActive(34) and not bpcore:buffActive(35) and not bpcore:buffActive(38) then
                                    helpers["queue"].add(MA[settings["SPIKES"]:current()], "me")
                                end
                            end
                        end
                    
                    -- /NIN.
                    elseif system["Player"].sub_job == "NIN" then
                    
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
                    
                    -- RDM/.
                    if system["Player"].main_job == "BLU" and bpcore:canCast() then
                    
                        -- FRAZZLE II.
                        if bpcore:isMAReady(MA["Frazzle II"].recast_id) and os.clock()-settings["SPELLS"]["Frazzle II"].allowed > settings["SPELLS"]["Frazzle II"].delay and bpcore:getAvailable("MA", "Frazzle II") then
                            helpers["queue"].add(MA["Frazzle II"], "t")
                            settings["SPELLS"]["Frazzle II"].allowed = os.clock()
                            
                        -- FRAZZLE III.
                        elseif bpcore:isMAReady(MA["Frazzle III"].recast_id) and os.clock()-settings["SPELLS"]["Frazzle III"].allowed > settings["SPELLS"]["Frazzle III"].delay and bpcore:getAvailable("MA", "Frazzle II") then
                            helpers["queue"].add(MA["Frazzle III"], "t")
                            settings["SPELLS"]["Frazzle III"].allowed = os.clock()
                            
                        -- DISTRACT III.
                        elseif bpcore:isMAReady(MA["Distract III"].recast_id) and os.clock()-settings["SPELLS"]["Distract III"].allowed > settings["SPELLS"]["Distract III"].delay and bpcore:getAvailable("MA", "Frazzle II") then
                            helpers["queue"].add(MA["Distract III"], "t")
                            settings["SPELLS"]["Distract III"].allowed = os.clock()
                            
                        -- DIA / BIO III.
                        elseif bpcore:getAvailable("MA", settings["DIA"]:current().." III") then
                        
                            if bpcore:isMAReady(MA[settings["DIA"]:current().." III"].recast_id) and os.clock()-settings["SPELLS"][settings["DIA"]:current().." III"].allowed > settings["SPELLS"][settings["DIA"]:current().." III"].delay then
                                helpers["queue"].add(MA[settings["DIA"]:current().." III"], "t")
                                settings["SPELLS"][settings["DIA"]:current().." III"].allowed = os.clock()
                                
                            end
                        
                        -- SILENCE.
                        elseif bpcore:isMAReady(MA["Silence"].recast_id) and os.clock()-settings["SPELLS"]["Silence"].allowed > settings["SPELLS"]["Silence"].delay and bpcore:getAvailable("MA", "Silence") then
                            helpers["queue"].add(MA["Silence"], "t")
                            settings["SPELLS"]["Silence"].allowed = os.clock()
                        
                        -- ADDLE II.
                        elseif bpcore:isMAReady(MA["Addle II"].recast_id) and os.clock()-settings["SPELLS"]["Addle II"].allowed > settings["SPELLS"]["Addle II"].delay and bpcore:getAvailable("MA", "Addle II")  then
                            helpers["queue"].add(MA["Addle II"], "t")
                            settings["SPELLS"]["Addle II"].allowed = os.clock()
                        
                        -- PARALYZE II.
                        elseif bpcore:isMAReady(MA["Paralyze II"].recast_id) and os.clock()-settings["SPELLS"]["Paralyze II"].allowed > settings["SPELLS"]["Paralyze II"].delay and bpcore:getAvailable("MA", "Paralyze II")  then
                            helpers["queue"].add(MA["Paralyze II"], "t")
                            settings["SPELLS"]["Paralyze II"].allowed = os.clock()
                        
                        -- SLOW II.
                        elseif bpcore:isMAReady(MA["Slow II"].recast_id) and os.clock()-settings["SPELLS"]["Slow II"].allowed > settings["SPELLS"]["Slow II"].delay and bpcore:getAvailable("MA", "Slow II") then
                            helpers["queue"].add(MA["Slow II"], "t")
                            settings["SPELLS"]["Slow II"].allowed = os.clock()
                        
                        -- BLIND II.
                        elseif bpcore:isMAReady(MA["Blind II"].recast_id) and os.clock()-settings["SPELLS"]["Blind II"].allowed > settings["SPELLS"]["Blind II"].delay and bpcore:getAvailable("MA", "Blind II") then
                            helpers["queue"].add(MA["Blind II"], "t")
                            settings["SPELLS"]["Blind II"].allowed = os.clock()
                        
                        -- INUNDATION.
                        elseif bpcore:isMAReady(MA["Inundation"].recast_id) and os.clock()-settings["SPELLS"]["Inundation"].allowed > settings["SPELLS"]["Inundation"].delay and bpcore:getAvailable("MA", "Inundation") then
                            helpers["queue"].add(MA["Inundation"], "t")
                            settings["SPELLS"]["Inundation"].allowed = os.clock()
                        
                        -- DISPEL.
                        elseif bpcore:isMAReady(MA["Dispel"].recast_id) and os.clock()-settings["SPELLS"]["Dispel"].allowed > settings["SPELLS"]["Dispel"].delay and bpcore:getAvailable("MA", "Dispel") then
                            helpers["queue"].add(MA["Dispel"], "t")
                            settings["SPELLS"]["Dispel"].allowed = os.clock()
                        
                        end
                    
                    end
                    
                    -- /DNC.
                    if system["Player"].sub_job == "DNC" and bpcore:canAct() then
                    
                        -- STEPS.
                        if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) and os.clock()-system["BLU"]["Steps Timer"] > system["BLU"]["Steps Delay"] and bpcore:getAvailable("JA", settings["STEPS"]:current()) then
                            helpers["queue"].add(JA[settings["STEPS"]:current()], "me")                            
                        end
                    
                    end
                    
                    -- DRAINS LOGIC
                    if settings["DRAINS"]:current() and bpcore:canCast() then
                        
                        -- DRAIN
                        if bpcore:isMAReady(MA["Drain"].recast_id) and system["Player"]["vitals"].mpp < system["BLU"]["Drain Threshold"] and bpcore:getAvailable("MA", "Drain") then
                            helpers["queue"].add(MA["Drain"], "t")
                        end
                        
                        -- ASPIR
                        if bpcore:isMAReady(MA["Aspir"].recast_id) and system["Player"]["vitals"].mpp < system["BLU"]["Aspir Threshold"] and bpcore:getAvailable("MA", "Aspir") then
                            helpers["queue"].add(MA["Aspir"], "t")
                        end
                        
                    end
                    
                end
            
            -- PLAYER IS DISENGAGED LOGIC.
            elseif system["Player"].status == 0 then
                
                -- Determine which target is mine.
                local target = helpers["target"].getTarget()
                
                -- SKILLUP LOGIC.
                if settings["SKILLUP"]:current() then
                    
                    if bpcore:canCast() and settings["SKILLS"]:current() == "Blue Magic" then
                        
                        -- POLLEN.
                        if bpcore:isMAReady(MA["Pollen"].recast_id) and bpcore:getAvailable("MA", "Pollen") then
                            helpers["queue"].add(MA["Pollen"], "me")
                        
                        -- COCOON.
                        elseif bpcore:isMAReady(MA["Cocoon"].recast_id) and bpcore:getAvailable("MA", "Cocoon") then
                            helpers["queue"].add(MA["Cocoon"], "me")
                            
                        -- HEAD BUTT.
                        elseif bpcore:isMAReady(MA["Head Butt"].recast_id) and bpcore:getAvailable("MA", "Head Butt") and bpcore:canEngage(helpers["target"].getTarget()) then
                            helpers["queue"].add(MA["Head Butt"], target)
                        
                        -- FOOT KICK
                        elseif bpcore:isMAReady(MA["Foot Kick"].recast_id) and bpcore:getAvailable("MA", "Foot Kick") and bpcore:canEngage(helpers["target"].getTarget()) then
                            helpers["queue"].add(MA["Foot Kick"], target)
                            
                        -- SPROUT SMACK
                        elseif bpcore:isMAReady(MA["Sprout Smack"].recast_id) and bpcore:getAvailable("MA", "Sprout Smack") and bpcore:canEngage(helpers["target"].getTarget()) then
                            helpers["queue"].add(MA["Sprout Smack"], target)
                        
                        -- POWER ATTACK.
                        elseif bpcore:isMAReady(MA["Power Attack"].recast_id) and bpcore:getAvailable("MA", "Power Attack") and bpcore:canEngage(helpers["target"].getTarget()) then
                            helpers["queue"].add(MA["PowerAttack"], target)
                        
                        end
                        
                    end
                    
                end
                
                -- WEAPON SKILL LOGIC.
                if settings["WS"]:current() and bpcore:canAct() and settings["RA"]:current() and bpcore:canEngage(helpers["target"].getTarget()) then
                    
                    if not settings["AM"]:current() and system["Player"]["vitals"].tp > settings["TP THRESHOLD"] and (system["Ranged"].en == "Kaja Bow" or system["Ranged"].en == "Ullr Bow") then
                        helpers["queue"].addToFront(WS[settings["Empyreal Arrow"]], target)
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- RDM/.
                    if system["Player"].main_job == "BLU" then
                        
                        -- COMPOSURE LOGIC.
                        if settings["COMPOSURE"]:current() and bpcore:isJAReady(JA["Composure"].recast_id) and not bpcore:buffActive(419) and bpcore:getAvailable("JA", "Composure") then
                            helpers["queue"].add(JA["Composure"], "me")                            
                        end
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and system["Player"]["vitals"].hpp > system["BLU"]["Convert Threshold"].hpp and system["Player"]["vitals"].mpp < system["BLU"]["Convert Threshold"].mpp then
                            if bpcore:isJAReady(JA["Convert"].recast_id) and bpcore:getAvailable("JA", "Convert") then
                                helpers["queue"].add(JA["Convert"], "me")
                            end
                            
                        end
                    
                    end
                    
                    -- /DNC.
                    if system["Player"].sub_job == "DNC" and bpcore:canAct() then
                        
                        -- REVERSE FLOURISH.
                        if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) and bpcore:getFinishingMoves() > 4 and bpcore:getAvailable("JA", "Reverse Flourish") then
                            helpers["queue"].add(JA["Reverse Flourish"], "me")                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" and bpcore:canAct() then
                        
                        -- PROVOKE.
                        if bpcore:isJAReady(JA["Provoke"].recast_id) and bpcore:getAvailable("JA", "Provoke") and bpcore:canEngage(helpers["target"].getTarget()) then
                            helpers["queue"].add(JA["Provoke"], target)                            
                        end
                        
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" and bpcore:canAct() then
                        
                        -- ANIMATED FLOURISH.
                        if bpcore:isJAReady(JA["Animated Flourish"].recast_id) and bpcore:getFinishingMoves() > 0 and bpcore:getAvailable("JA", "Animated Flourish") and bpcore:canEngage(helpers["target"].getTarget()) then
                            helpers["queue"].add(JA["Animated Flourish"], target)                            
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    -- RDM/.
                    if system["Player"].main_job == "BLU" and bpcore:canCast() then
                    
                        -- REFRESH III
                        if bpcore:isMAReady(MA["Refresh III"].recast_id) and not bpcore:buffActive(43) and bpcore:getAvailable("MA", "Refresh III") then
                            helpers["queue"].add(MA["Refresh III"], "me")
                        
                        -- REFRESH II
                        elseif bpcore:isMAReady(MA["Refresh II"].recast_id) and not bpcore:buffActive(43) and bpcore:getAvailable("MA", "Refresh II") then
                            helpers["queue"].add(MA["Refresh II"], "me")
                        
                        -- REFRESH I
                        elseif bpcore:isMAReady(MA["Refresh"].recast_id) and not bpcore:buffActive(43)and bpcore:getAvailable("MA", "Refresh") then
                            helpers["queue"].add(MA["Refresh"], "me")
                            
                        end
                        
                        -- HASTE II
                        if bpcore:isMAReady(MA["Haste II"].recast_id) and not bpcore:buffActive(33)and bpcore:getAvailable("MA", "Haste II") then
                            helpers["queue"].add(MA["Haste II"], "me")
                        
                        -- HASTE
                        elseif bpcore:isMAReady(MA["Haste"].recast_id) and not bpcore:buffActive(33)and bpcore:getAvailable("MA", "Haste") then
                            helpers["queue"].add(MA["Haste"], "me")
                            
                        end
                        
                        -- TEMPER II
                        if bpcore:isMAReady(MA["Temper II"].recast_id) and not bpcore:buffActive(432)and bpcore:getAvailable("MA", "Temper II") then
                            helpers["queue"].add(MA["Temper II"], "me")
                        
                        -- TEMPER
                        elseif bpcore:isMAReady(MA["Temper"].recast_id) and not bpcore:buffActive(432)and bpcore:getAvailable("MA", "Temper") then
                            helpers["queue"].add(MA["Temper"], "me")
                            
                        end   
                        
                        -- PHALANX
                        if bpcore:isMAReady(MA["Phalanx"].recast_id) and not bpcore:buffActive(116)and bpcore:getAvailable("MA", "Phalanx") then
                            helpers["queue"].add(MA["Phalanx"], "me")                        
                        end
                        
                        -- AQUAVEIL
                        if bpcore:isMAReady(MA["Aquaveil"].recast_id) and not bpcore:buffActive(39)and bpcore:getAvailable("MA", "Aquaveil") then
                            helpers["queue"].add(MA["Aquaveil"], "me")
                        end
                        
                        -- GAINS
                        if bpcore:isMAReady(MA[settings["GAINS"]:current()].recast_id) and bpcore:getAvailable("MA", settings["GAINS"]:current()) then
                            if not bpcore:buffActive(119) and not bpcore:buffActive(120) and not bpcore:buffActive(121) and not bpcore:buffActive(122) and not bpcore:buffActive(123) and not bpcore:buffActive(124) and not bpcore:buffActive(125) then
                                helpers["queue"].add(MA[settings["GAINS"]:current()], "me")
                            end
                        
                        end
                        
                        -- ENSPELLS
                        if bpcore:isMAReady(MA[settings["ENSPELL"]:current()].recast_id) and bpcore:getAvailable("MA", settings["ENSPELL"]:current()) then
                            if not bpcore:buffActive(94) and not bpcore:buffActive(95) and not bpcore:buffActive(96) and not bpcore:buffActive(97) and not bpcore:buffActive(98) and not bpcore:buffActive(99) then
                                helpers["queue"].add(MA[settings["ENSPELL"]:current()], "me")
                            end
                        
                        end
                        
                        -- SPIKES
                        if settings["SPIKES"]:current() ~= "None" and bpcore:isMAReady(MA[settings["SPIKES"]:current()].recast_id)and bpcore:getAvailable("MA", settings["SPIKES"]:current()) then
                            if not bpcore:buffActive(34) and not bpcore:buffActive(35) and not bpcore:buffActive(38) then
                                helpers["queue"].add(MA[settings["SPIKES"]:current()], "me")
                            end
                        
                        end
                    
                    end
                    
                    -- /WAR.
                    if system["Player"].sub_job == "WAR" and bpcore:canAct() then
                        
                        -- BERSERK.
                        if bpcore:isJAReady(JA["Berserk"].recast_id) and bpcore:getAvailable("JA", "Berserk") then
                            helpers["queue"].add(JA["Berserk"], "me")
                        
                        -- AGGRESSOR.
                        elseif bpcore:isJAReady(JA["Aggressor"].recast_id) and bpcore:getAvailable("JA", "Aggressor") then
                            helpers["queue"].add(JA["Aggressor"], "me")
                        
                        -- WARCRY.
                        elseif bpcore:isJAReady(JA["Warcry"].recast_id) and bpcore:getAvailable("JA", "Warcry") then
                            helpers["queue"].add(JA["Warcry"], "me")
                            
                        end
                        
                    -- /DNC.
                    elseif system["Player"].sub_job == "DNC" and bpcore:canAct() then
                    
                        -- HASTE SAMBA.
                        if bpcore:isJAReady(JA["Haste Samba"].recast_id) and bpcore:getAvailable("JA", "Warcry") then
                            helpers["queue"].add(JA["Haste Samaba"], "me")                            
                        end
                    
                    -- /NIN.
                    elseif system["Player"].sub_job == "NIN" then
                    
                        -- UTSUSEMI
                        if bpcore:findItemByName("Shihei", 0) then
                            
                            if not bpcore:buffActive(444) and not bpcore:buffActive(445) and not bpcore:buffActive(446) and not bpcore:buffActive(36) then
                                
                                if windower.ffxi.get_spells()[MA["Utsusemi: Ni"].id] and bpcore:isMAReady(MA["Utsusemi: Ni"].recast_id) then
                                    helpers["queue"].addToFront(MA["Utsusemi: Ni"], "me")
                                    
                                elseif windower.ffxi.get_spells()[MA["Utsusemi: Ichi"].id] and bpcore:isMAReady(MA["Utsusemi: Ichi"].recast_id) then
                                    helpers["queue"].addToFront(MA["Utsusemi: Ichi"], "me")
                                    
                                end
                            
                            end
                        
                        end
                    
                    end
                    
                end
                
                -- DEBUFF LOGIC.
                if settings["DEBUFFS"]:current() then
                    
                    -- RDM/.
                    if system["Player"].main_job == "BLU" and bpcore:canCast() and bpcore:canEngage(helpers["target"].getTarget()) then
                    
                        -- FRAZZLE II.
                        if bpcore:isMAReady(MA["Frazzle II"].recast_id) and os.clock()-settings["SPELLS"]["Frazzle II"].allowed > settings["SPELLS"]["Frazzle II"].delay and bpcore:getAvailable("MA", "Frazzle II") then
                            helpers["queue"].add(MA["Frazzle II"], target)
                            settings["SPELLS"]["Frazzle II"].allowed = os.clock()
                            
                        -- FRAZZLE III.
                        elseif bpcore:isMAReady(MA["Frazzle III"].recast_id) and os.clock()-settings["SPELLS"]["Frazzle III"].allowed > settings["SPELLS"]["Frazzle III"].delay and bpcore:getAvailable("MA", "Frazzle II") then
                            helpers["queue"].add(MA["Frazzle III"], target)
                            settings["SPELLS"]["Frazzle III"].allowed = os.clock()
                            
                        -- DISTRACT III.
                        elseif bpcore:isMAReady(MA["Distract III"].recast_id) and os.clock()-settings["SPELLS"]["Distract III"].allowed > settings["SPELLS"]["Distract III"].delay and bpcore:getAvailable("MA", "Frazzle II") then
                            helpers["queue"].add(MA["Distract III"], target)
                            settings["SPELLS"]["Distract III"].allowed = os.clock()
                            
                        -- DIA / BIO III.
                        elseif bpcore:getAvailable("MA", settings["DIA"]:current().." III") then
                        
                            if bpcore:isMAReady(MA[settings["DIA"]:current().." III"].recast_id) and os.clock()-settings["SPELLS"][settings["DIA"]:current().." III"].allowed > settings["SPELLS"][settings["DIA"]:current().." III"].delay then
                                helpers["queue"].add(MA[settings["DIA"]:current().." III"], target)
                                settings["SPELLS"][settings["DIA"]:current().." III"].allowed = os.clock()
                                
                            end
                        
                        -- SILENCE.
                        elseif bpcore:isMAReady(MA["Silence"].recast_id) and os.clock()-settings["SPELLS"]["Silence"].allowed > settings["SPELLS"]["Silence"].delay and bpcore:getAvailable("MA", "Silence") then
                            helpers["queue"].add(MA["Silence"], target)
                            settings["SPELLS"]["Silence"].allowed = os.clock()
                        
                        -- ADDLE II.
                        elseif bpcore:isMAReady(MA["Addle II"].recast_id) and os.clock()-settings["SPELLS"]["Addle II"].allowed > settings["SPELLS"]["Addle II"].delay and bpcore:getAvailable("MA", "Addle II") then
                            helpers["queue"].add(MA["Addle II"], target)
                            settings["SPELLS"]["Addle II"].allowed = os.clock()
                        
                        -- PARALYZE II.
                        elseif bpcore:isMAReady(MA["Paralyze II"].recast_id) and os.clock()-settings["SPELLS"]["Paralyze II"].allowed > settings["SPELLS"]["Paralyze II"].delay and bpcore:getAvailable("MA", "Paralyze II") then
                            helpers["queue"].add(MA["Paralyze II"], target)
                            settings["SPELLS"]["Paralyze II"].allowed = os.clock()
                        
                        -- SLOW II.
                        elseif bpcore:isMAReady(MA["Slow II"].recast_id) and os.clock()-settings["SPELLS"]["Slow II"].allowed > settings["SPELLS"]["Slow II"].delay and bpcore:getAvailable("MA", "Slow II") then
                            helpers["queue"].add(MA["Slow II"], target)
                            settings["SPELLS"]["Slow II"].allowed = os.clock()
                        
                        -- BLIND II.
                        elseif bpcore:isMAReady(MA["Blind II"].recast_id) and os.clock()-settings["SPELLS"]["Blind II"].allowed > settings["SPELLS"]["Blind II"].delay and bpcore:getAvailable("MA", "Blind II") then
                            helpers["queue"].add(MA["Blind II"], target)
                            settings["SPELLS"]["Blind II"].allowed = os.clock()
                        
                        -- INUNDATION.
                        elseif bpcore:isMAReady(MA["Inundation"].recast_id) and os.clock()-settings["SPELLS"]["Inundation"].allowed > settings["SPELLS"]["Inundation"].delay and bpcore:getAvailable("MA", "Inundation") then
                            helpers["queue"].add(MA["Inundation"], target)
                            settings["SPELLS"]["Inundation"].allowed = os.clock()
                        
                        -- DISPEL.
                        elseif bpcore:isMAReady(MA["Dispel"].recast_id) and os.clock()-settings["SPELLS"]["Dispel"].allowed > settings["SPELLS"]["Dispel"].delay and bpcore:getAvailable("MA", "Dispel") then
                            helpers["queue"].add(MA["Dispel"], target)
                            settings["SPELLS"]["Dispel"].allowed = os.clock()
                        
                        end
                    
                    end
                
                end
                
                -- DRAINS LOGIC
                if settings["DRAINS"]:current() and bpcore:canCast() and bpcore:canEngage(helpers["target"].getTarget()) then
                    
                    -- DRAIN
                    if bpcore:isMAReady(MA["Drain"].recast_id) and system["Player"]["vitals"].mpp < system["BLU"]["Drain Threshold"] and bpcore:getAvailable("MA", "Drain") then
                        helpers["queue"].add(MA["Drain"], target)
                    end
                    
                    -- ASPIR
                    if bpcore:isMAReady(MA["Aspir"].recast_id) and system["Player"]["vitals"].mpp < system["BLU"]["Aspir Threshold"] and bpcore:getAvailable("MA", "Aspir") then
                        helpers["queue"].add(MA["Aspir"], target)
                    end
                    
                end
                
            end
            
            -- HANDLE EVERYTHING INSIDE THE QUEUE.
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
    
    self.setSetting = function(setting, value)
        name:setTo(value)
    end
    
    self.event = function(name)
        local name = name or false
        
        if name then
            
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