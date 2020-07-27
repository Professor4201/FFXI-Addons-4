--------------------------------------------------------------------------------
-- BRD Core: Handle all core job automation for Bard.
--------------------------------------------------------------------------------
local core = {}

-- CORE AUTOMATED FUNCTIONS FOR THIS JOB.
function core.get()
    self = {}
    
    -- MASTER SETTINGS.
    local settings = {}
    settings["AM"]                                 = I{false,true}
    settings["AM THRESHOLD"]                       = I{3000,2000,1000}
    settings["1HR"]                                = I{false,true}
    settings["JA"]                                 = I{true,false}
    settings["RA"]                                 = I{false,true}
    settings["CURES"]                              = I{1,2,3}
    settings["SUBLIMATION"]                        = I{true,false}
    settings["HATE"]                               = I{false,true}
    settings["BUFFS"]                              = I{false,true}
    settings["DEBUFFS"]                            = I{true,false}
    settings["STATUS"]                             = I{true,false}
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
    
    settings["SPELLS"]={
        
        ["Foe Requiem VII"] = {["allowed"]=0,["delay"]=120},
        ["Pining Nocturne"] = {["allowed"]=0,["delay"]=120},
        ["Magic Finale"]    = {["allowed"]=0,["delay"]=25},
        ["Silence"]         = {["allowed"]=0,["delay"]=120},
        
    }
    
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
    
    -- PLAYLIST SETTINGS
    local jukebox  = images.new({color={alpha = 255},texture={fit = false},draggable=true})
        jukebox:path(string.format("%sbp/core/brd/icons/jukebox.png", windower.addon_path))
        jukebox:size(64, 64)
        jukebox:transparency(0)
        jukebox:pos_x(275)
        jukebox:pos_y(425)
        jukebox:show()
        
    local songlist = {}
    local songlist_settings = {
        
        ["pos"]={["x"]=jukebox:pos_x(),["y"]=jukebox:pos_y()},
        ["bg"]={["alpha"]=155,["red"]=0,["green"]=0,["blue"]=0,["visible"]=false},
        ["flags"]={["right"]=false,["bottom"]=false,["bold"]=false,["draggable"]=true,["italic"]=false},
        ["padding"]=system["Job Padding"],
        ["text"]={["size"]=system["Job Font"].size,["font"]=system["Job Font"].font,["fonts"]={},["alpha"]=system["Job Font"].alpha,["red"]=system["Job Font"].r,["green"]=system["Job Font"].g,["blue"]=system["Job Font"].b,
        ["stroke"]={["width"]=system["Job Stroke"].width,["alpha"]=system["Job Stroke"].alpha,["red"]=system["Job Stroke"].r,["green"]=system["Job Stroke"].g,["blue"]=system["Job Stroke"].b}
        
        },
    }
    
    songlist = texts.new("", songlist_settings, songlist_settings)
    
    -- HANDLE PARTY CHAT COMMANDS
    self.handleChat = function(message, sender, mode, gm)
        
        if (mode == 3 or mode == 4) then
            local player   = windower.ffxi.get_player() or false
            local accounts = T(system["Controllers"])
            
            if (accounts):contains(sender) then
                local commands = message:split(" ")
                
                if commands[1] and player and player.name:lower():match(commands[1]) then
                    helpers["songs"].handleChat(sender, commands)
                end
                
            else
                
            end
            
        end
        
    end
    
    -- HANDLE ADDON COMMANDS.
    self.handleCommands = function(commands)
         local command = commands[1] or false
        
        if command and type(command) == "string" then
            local command = command:lower()
            local message = ""
        
            if command == "repeat" then
                settings["REPEAT"]:next()
                message = string.format("REPEATING SONGS: %s", tostring(settings["REPEAT"]))
                
            elseif command == "clear" then
                helpers["songs"].clearQueue()
                helpers['popchat']:pop(("Songs Queue has been cleared."):upper(), system["Popchat Window"])
                message = ("SONGS QUEUE HAS BEEN CLEARED")
            
            elseif command == "ambuscade" then
                message = ("AMBUSCADE SETTINGS ENABLED!")
                settings["HATE"]:setTo(false)
                settings["BUFFS"]:setTo(true)
                settings["JA"]:setTo(true)
                settings["WS"]:setTo(true)
                settings["WSNAME"] = "Savage Blade"
                settings["CURES"]:setTo(2)
                settings["STATUS"]:setTo(true)
                settings["DEBUFFS"]:setTo(true)
                helpers["controls"].setEnabled(true)
                
                -- SET SONGS.
                windower.send_command("bp loop march march ballad")
                
                if bpcore:isLeader() and windower.ffxi.get_party().party1_count < 6 then
                    helpers["trust"].setEnabled(true)
                end
                
                
            elseif command == "disable" then
                message = ("SETTINGS DISABLED!")
                settings["HATE"]:setTo(false)
                settings["BUFFS"]:setTo(false)
                settings["JA"]:setTo(false)
                settings["WS"]:setTo(true)
                settings["WSNAME"] = "Savage Blade"
                settings["CURES"]:setTo(1)
                settings["STATUS"]:setTo(false)
                settings["DEBUFFS"]:setTo(false)
                helpers["controls"].setEnabled(true)
                helpers["trust"].setEnabled(false)
                
                -- CLEAR SONGS QUEUE.
                windower.send_command("bp clear")
                
            end
            
            if message ~= "" then
                helpers['popchat']:pop(message:upper() or ("INVALID COMANDS"):upper(), system["Popchat Window"])
            end
            
        end
        
        helpers["songs"].handleCommands(commands)
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
            local singing = false
            
            -- CREATE SEPARATE LOGIC FOR WHEN THE BARD IS CURRENTLY SINGING.
            if current then
                local block  = {"Paeon","Ballad","Minne","Minuet","Madrigal","Prelude","Mambo","Aubade","Pastoral","Fantasia","Operetta","Capriccio","Round","Gavote","March","Etude","Carol","Hymnus","Sirvente","Dirge","Scherzo"}
                
                for _,v in ipairs(block) do
                    
                    if (current.en:lower()):match(v:lower()) then
                        singing = true
                        
                    end
                    
                end                
            
            end
            
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
                            
                            if settings["SANGUINE"]:current() and player["vitals"].hpp > system["BRD"]["Sanguine Threshold"] then
                                helpers["queue"].addToFront(WS["Sanguine Blade"], "t")
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
                        
                    elseif player["vitals"].tp > 1000 then
                        
                        if settings["SANGUINE"]:current() and player["vitals"].hpp > system["BRD"]["Sanguine Threshold"] then
                            helpers["queue"].addToFront(WS["Sanguine Blade"], "t")
                        else
                            helpers["queue"].addToFront(WS[settings["WSNAME"]], "t")
                        end
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- /RDM.
                    if player.main_job == "RDM" then
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and bpcore:canAct() and player["vitals"].hpp > system["BRD"]["Convert Threshold"].hpp and player["vitals"].mpp < system["BRD"]["Convert Threshold"].mpp then
                            if bpcore:isJAReady(JA["Convert"].recast_id) then
                                helpers["queue"].add(JA["Convert"], "me")
                            end
                            
                        end
                    
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                        
                        -- REVERSE FLOURISH.
                        if windower.ffxi.get_abilities()[JA["Reverse Flourish"].id] and bpcore:canAct() and bpcore:getFinishingMoves() > 4 then
                            if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) then
                                helpers["queue"].add(JA["Reverse Flourish"], "me")
                            end
                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    -- /WAR.
                    if player.sub_job == "WAR" then
                        
                        -- PROVOKE.
                        if windower.ffxi.get_abilities()[JA["Provoke"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Provoke"].recast_id) then
                                helpers["queue"].add(JA["Provoke"], "t")
                            end
                            
                        end
                        
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                        
                        -- ANIMATED FLOURISH.
                        if windower.ffxi.get_abilities()[JA["Animated Flourish"].id] and bpcore:canAct() and bpcore:getFinishingMoves() > 0 then
                            if bpcore:isJAReady(JA["Animated Flourish"].recast_id) then
                                helpers["queue"].add(JA["Animated Flourish"], "t")
                            end
                            
                        end
                    
                    end
                    
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then
                    
                    -- /WAR.
                    if player.sub_job == "WAR" then
                        
                        -- BERSERK.
                        if windower.ffxi.get_abilities()[JA["Berserk"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Berserk"].recast_id) then
                                helpers["queue"].add(JA["Berserk"], "me")
                            end
                        
                        -- AGGRESSOR.
                        elseif windower.ffxi.get_abilities()[JA["Aggressor"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Aggressor"].recast_id) then
                                helpers["queue"].add(JA["Aggressor"], "me")
                            end
                        
                        -- WARCRY.
                        elseif windower.ffxi.get_abilities()[JA["Warcry"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Warcry"].recast_id) then
                                helpers["queue"].add(JA["Warcry"], "me")
                            end
                            
                        end
                        
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                    
                        -- HASTE SAMBA.
                        if windower.ffxi.get_abilities()[JA["Haste Samba"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Haste Samba"].recast_id) then
                                helpers["queue"].add(JA["Haste Samaba"], "me")
                            end
                            
                        end
                    
                    -- /NIN.
                    elseif player.sub_job == "NIN" then
                    
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
                if settings["DEBUFFS"]:current() and bpcore:canCast() then
                    
                    -- BRD/.
                    if player.main_job == "BRD" then
                        
                        for i,v in pairs(settings["SPELLS"]) do
                            local spell = MA[i]

                            if (os.clock()-v.allowed) > v.delay and windower.ffxi.get_spells()[spell.id] and bpcore:isMAReady(spell.recast_id) and target then
                                helpers["queue"].add(spell, target)
                                settings["SPELLS"][spell.en].allowed = os.clock()
                                break
                                
                            end
                            
                        end
                        
                    end
                    
                    -- /DNC.
                    if player.sub_job == "DNC" then
                    
                        -- STEPS.
                        if windower.ffxi.get_abilities()[JA[settings["STEPS"]:current()].id] and bpcore:canAct() and os.clock()-system["BRD"]["Steps Timer"] > system["BRD"]["Steps Delay"] then
                            
                            if bpcore:isJAReady(JA[settings["STEPS"]:current()].recast_id) then
                                helpers["queue"].add(JA[settings["STEPS"]:current()], "me")
                            end
                            
                        end
                    
                    end
                    
                    -- DRAINS LOGIC
                    if settings["DRAINS"]:current() and bpcore:canCast() then
                        
                        -- DRAIN
                        if windower.ffxi.get_spells()[MA["Drain"].id] and player["vitals"].mpp < system["BRD"]["Drain Threshold"] then
                            
                            if bpcore:isMAReady(MA["Drain"].recast_id) then
                                helpers["queue"].add(MA["Drain"], "t")
                            end
                            
                        end
                        
                        -- ASPIR
                        if windower.ffxi.get_spells()[MA["Aspir"].id] and player["vitals"].mpp < system["BRD"]["Aspir Threshold"] then
                            
                            if bpcore:isMAReady(MA["Aspir"].recast_id) then
                                helpers["queue"].add(MA["Aspir"], "t")
                            end
                            
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
                if settings["WS"]:current() and bpcore:canAct() and settings["RA"]:current() then
                    
                    if not settings["AM"]:current() and player["vitals"].tp > 1000 and (system["Ranged"].en == "Kaja Bow" or system["Ranged"].en == "Ullr Bow") then
                        helpers["queue"].addToFront(WS[settings["Empyreal Arrow"]], target)
                        
                    end
                    
                end
                
                -- ABILITY LOGIC.
                if settings["JA"]:current() and bpcore:canAct() then
                    
                    -- /RDM.
                    if player.main_job == "RDM" then
                        
                        -- CONVERT LOGIC.
                        if settings["CONVERT"]:current() and bpcore:canAct() and player["vitals"].hpp > system["BRD"]["Convert Threshold"].hpp and player["vitals"].mpp < system["BRD"]["Convert Threshold"].mpp then
                            if bpcore:isJAReady(JA["Convert"].recast_id) then
                                helpers["queue"].add(JA["Convert"], "me")
                            end
                            
                        end
                    
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                        
                        -- REVERSE FLOURISH.
                        if windower.ffxi.get_abilities()[JA["Reverse Flourish"].id] and bpcore:canAct() and bpcore:getFinishingMoves() > 4 then
                            if bpcore:isJAReady(JA["Reverse Flourish"].recast_id) then
                                helpers["queue"].add(JA["Reverse Flourish"], "me")
                            end
                            
                        end
                    
                    end
                    
                end
                
                -- HATE LOGIC.
                if settings["HATE"]:current() then
                    
                    -- /WAR.
                    if player.sub_job == "WAR" then
                        
                        -- PROVOKE.
                        if windower.ffxi.get_abilities()[JA["Provoke"].id] and bpcore:canAct() then
                            if bpcore:isJAReady(JA["Provoke"].recast_id) then
                                helpers["queue"].add(JA["Provoke"], target)
                            end
                            
                        end
                        
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                        
                        -- ANIMATED FLOURISH.
                        if windower.ffxi.get_abilities()[JA["Animated Flourish"].id] and bpcore:canAct() and bpcore:getFinishingMoves() > 0 then
                            if bpcore:isJAReady(JA["Animated Flourish"].recast_id) then
                                helpers["queue"].add(JA["Animated Flourish"], target)
                            end
                            
                        end
                    
                    end
                    
                end
                
                -- SINGING LOGIC.
                if settings["REPEAT"]:current() then

                    -- BRD/.
                    if player.main_job == "BRD" then
                        local playlist = helpers["songs"].getQueued()
                        
                        if bpcore:canCast() and playlist then
                            helpers["songs"].runPlaylist(playlist)
                        end
                    
                    end
                
                end
                
                -- BUFF LOGIC.
                if settings["BUFFS"]:current() then

                    -- BRD/.
                    if player.main_job == "BRD" then
                    
                    end
                    
                    -- /WAR.
                    if player.sub_job == "WAR" then
                        
                        -- BERSERK.
                        if windower.ffxi.get_abilities()[JA["Berserk"].id] and bpcore:canAct() then
                            
                            if bpcore:isJAReady(JA["Berserk"].recast_id) then
                                helpers["queue"].add(JA["Berserk"], "me")
                            end
                        
                        -- AGGRESSOR.
                        elseif windower.ffxi.get_abilities()[JA["Aggressor"].id] and bpcore:canAct() then
                            
                            if bpcore:isJAReady(JA["Aggressor"].recast_id) then
                                helpers["queue"].add(JA["Aggressor"], "me")
                            end
                        
                        -- WARCRY.
                        elseif windower.ffxi.get_abilities()[JA["Warcry"].id] and bpcore:canAct() then
                            
                            if bpcore:isJAReady(JA["Warcry"].recast_id) then
                                helpers["queue"].add(JA["Warcry"], "me")
                            end
                            
                        end
                        
                    -- /DNC.
                    elseif player.sub_job == "DNC" then
                    
                        -- HASTE SAMBA.
                        if windower.ffxi.get_abilities()[JA["Haste Samba"].id] and bpcore:canAct() then
                            
                            if bpcore:isJAReady(JA["Haste Samba"].recast_id) then
                                helpers["queue"].add(JA["Haste Samaba"], "me")
                            end
                            
                        end
                    
                    -- /NIN.
                    elseif player.sub_job == "NIN" then
                    
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
                if settings["DEBUFFS"]:current() and bpcore:canCast() and target then
                    
                    -- BRD/.
                    if player.main_job == "BRD" then
                        
                        for i,v in pairs(settings["SPELLS"]) do
                            local spell = MA[i]

                            if (os.clock()-v.allowed) > v.delay and windower.ffxi.get_spells()[spell.id] and bpcore:isMAReady(spell.recast_id) then
                                helpers["queue"].add(spell, target)
                                settings["SPELLS"][spell.en].allowed = os.clock()
                                break
                                
                            end
                            
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
            
            -- THIS LOGIC IS FOR THINGS TO ADD ONLY DURING INSTANCE WHERE THE BARD IS SINGING!
            elseif singing then
            
                local song       = helpers["queue"].getNextAction() or false
                local songTarget = helpers["queue"].getNextTarget() or false

                if song and songTarget and type(song) == "table" and type(songTarget) == "table" and bpcore:findPartyMember(songTarget.name) and songTarget.name ~= player.name and not bpcore:buffActive(409) then
                    helpers["queue"].addToFront(JA["Pianissimo"], "me")                
                end
            
            end
            
            -- HANDLE EVERYTHING INSIDE THE QUEUE.
            helpers["cures"].handleCuring()
            helpers["buffer"].handleBuffs()
            helpers['queue'].handleQueue()
        
        end
        
    end        
        
    self.updateSonglist = function(show)
        local playlist = helpers["songs"].getQueued()
        local position = {x=jukebox:pos_x(), y=jukebox:pos_y()}
        local res_x    = windower.get_windower_settings().x_res
        local shift    = ( (position.x/res_x)*100 )
        local size     = 0
        local settings = {
            
            ["pos"]={["x"]=(position.x+70),["y"]=(position.y+15)},
            ["bg"]={["alpha"]=155,["red"]=0,["green"]=0,["blue"]=0,["visible"]=false},
            ["flags"]={["right"]=false,["bottom"]=false,["bold"]=false,["draggable"]=true,["italic"]=false},
            ["padding"]=system["Job Padding"],
            ["text"]={["size"]=system["Job Font"].size,["font"]=system["Job Font"].font,["fonts"]={},["alpha"]=system["Job Font"].alpha,["red"]=system["Job Font"].r,["green"]=system["Job Font"].g,["blue"]=system["Job Font"].b,
            ["stroke"]={["width"]=system["Job Stroke"].width,["alpha"]=system["Job Stroke"].alpha,["red"]=system["Job Stroke"].r,["green"]=system["Job Stroke"].g,["blue"]=system["Job Stroke"].b}
            
            },
        }

        if show and not songlist:visible() and #playlist > 0 then
            local target = bpcore:findMemberByName(windower.ffxi.get_player().name, false)
            local temp   = {}
            
            for i,v in ipairs(playlist) do
                local songs = {}
                
                for song=1, #v.command do
                    
                    if song ~= 1 and song ~= #v.command then
                        table.insert(songs, v.command[song])
                    
                    elseif song == #v.command then
                    
                        if type(bpcore:findMemberByName(v.command[song], false)) == "table" then
                            target = bpcore:findMemberByName(v.command[song], false)
                        end
                        
                    end
                    
                end
                
                if #songs > 0 and target then
                    table.insert(temp, string.format("** Singing on: %s **\n %+3s--► Repeating songs: %s.\n\n", target.name, " ", table.concat(songs, " ")):upper())                    
                end
                
                if #temp and #temp[i] > size then
                    size = (#temp[i]*2)
                end
                
            end
            
            if shift <= 50 then
                songlist:pos((position.x+70), (position.y+15))
                
            elseif shift > 50 then
                songlist:pos(position.x-(210+size), position.y+15)

            end
            
            songlist:text(table.concat(temp, ""))
            songlist:bg_visible(true)
            songlist:visible(true)
            songlist:update()
        
        elseif not show and songlist:visible() then
            songlist:bg_visible(false)
            songlist:visible(false)
            songlist:update()
            songlist:hide()
            
        end
        
    end
    
    self.getJukebox = function()
        return jukebox
    end
    
    self.getSonglist = function()
        return songlist
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
        jukebox:destroy()
        songlist:destoy()
        
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