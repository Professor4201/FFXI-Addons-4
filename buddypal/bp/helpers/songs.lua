--------------------------------------------------------------------------------
-- Songs helper: Library of all Song helper functions.
--------------------------------------------------------------------------------
local songs = {}
function songs.new()
    local self = {}
    
    -- Private Variables
    local current = {}
    local saved   = {}
    local valid   = {195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,214,215,216,218,219,220,221,222}
    local default = {

        ["March"]        = {count=1, songs={"Honor March","Victory March","Advancing March"}},
        ["Minuet"]       = {count=1, songs={"Valor Minuet V","Valor Minuet IV","Valor Minuet III","Valor Minuet II","Valor Minuet"}},
        ["Madrigal"]     = {count=1, songs={"Blade Madrigal","Sword Madrigal"}},
        ["Prelude"]      = {count=1, songs={"Archer's Prelude","Hunter's Prelude"}},
        ["Minne"]        = {count=1, songs={"Knight's Minne V","Knight's Minne IV","Knight's Minne III","Knight's Minne II","Knight's Minne"}},
        ["Ballad"]       = {count=1, songs={"Mage's Ballad III","Mage's Ballad II","Mage's Ballad"}},
        ["Mambo"]        = {count=1, songs={"Dragonfoe Mambo","Sheepfoe Mambo"}},
        ["Strength"]     = {count=1, songs={"Herculean Etude","Sinewy Etude"}},
        ["Dexterity"]    = {count=1, songs={"Uncanny Etude","Dextrous Etude"}},
        ["Vitality"]     = {count=1, songs={"Vital Etude","Vivacious Etude"}},
        ["Agility"]      = {count=1, songs={"Swift Etude","Quick Etude"}},
        ["Intelligence"] = {count=1, songs={"Sage Etude","Learned Etude"}},
        ["Mind"]         = {count=1, songs={"Logical Etude","Spirited Etude"}},
        ["Charisma"]     = {count=1, songs={"Bewitching Etude","Enchanting Etude"}},
        ["Fire"]         = {count=1, songs={"Fire Carol II","Fire Carol"}},
        ["Ice"]          = {count=1, songs={"Ice Carol II","Ice Carol"}},
        ["Wind"]         = {count=1, songs={"Wind Carol II","Wind Carol"}},
        ["Earth"]        = {count=1, songs={"Earth Carol II","Earth Carol"}},
        ["Thunder"]      = {count=1, songs={"Thunder Carol II","Thunder Carol"}},
        ["Water"]        = {count=1, songs={"Water Carol II","Water Carol"}},
        ["Light"]        = {count=1, songs={"Light Carol II","Light Carol"}},
        ["Dark"]         = {count=1, songs={"Dark Carol II","Dark Carol"}},

    }

    local songs   = {
        
        ["req1"]      = "Foe Requiem",          ["req2"]     = "Foe Requiem II",      ["req3"]      = "Foe Requiem III",     ["req4"]      = "Foe Requiem IV",        
        ["req5"]      = "Foe Requiem V",        ["req6"]     = "Foe Requiem VI",      ["req7"]      = "Foe Requiem VII",     ["lull1"]     = "Foe Lullaby",
        ["lull2"]     = "Foe Lullaby II",       ["horde1"]   = "Horde Lullaby",       ["horde2"]    = "Horde Lullaby II",    ["army1"]     = "Army's Paeon",  
        ["army2"]     = "Army's Paeon II",      ["army3"]    = "Army's Paeon III",    ["army4"]     = "Army's Paeon IV",
        ["army5"]     = "Army's Paeon V",       ["army6"]    = "Army's Paeon VI",     ["ballad1"]   = "Mage's Ballad",       ["ballad2"]   = "Mage's Ballad II",
        ["ballad3"]   = "Mage's Ballad III",    ["minne1"]   = "Knight's Minne",      ["minne2"]    = "Knight's Minne II",
        ["minne3"]    = "Knight's Minne III",   ["minne4"]   = "Knight's Minne IV",   ["minne5"]    = "Knight's Minne V",
        ["min1"]      = "Valor Minuet",         ["min2"]     = "Valor Minuet II",     ["min3"]      = "Valor Minuet III",    ["min4"]      = "Valor Minuet IV",
        ["min5"]      = "Valor Minuet V",       ["mad1"]     = "Sword Madrigal",      ["mad2"]      = "Blade Madrigal",
        ["lude1"]     = "Hunter's Prelude",     ["lude2"]    = "Archer's Prelude",    ["mambo1"]    = "Sheepfoe Mambo",      ["mambo2"]    = "Dragonfoe Mambo",        
        ["herb1"]     = "Herb Pastoral",        ["shining1"] = "Shining Fantasia",    ["oper1"]     = "Scop's Operetta",     ["oper2"]     = "Puppet's Operetta",
        ["gold1"]     = "Gold Capriccio",       ["round1"]   = "Warding Round",       ["gob1"]      = "Goblin Gavotte",      ["march1"]    = "Advancing March",
        ["march2"]    = "Victory March",        ["elegy1"]   = "Battlefield Elegy",   ["elegy2"]    = "Carnage Elegy",
        ["str1"]      = "Sinewy Etude",         ["str2"]     = "Herculean Etude",     ["dex1"]      = "Dextrous Etude",      ["dex2"]      = "Uncanny Etude",
        ["vit1"]      = "Vivacious Etude",      ["vit2"]     = "Vital Etude",         ["agi1"]      = "Quick Etude",         ["agi2"]      = "Swift Etude",
        ["int1"]      = "Learned Etude",        ["int2"]     = "Sage Etude",          ["mnd1"]      = "Spirited Etude",      ["mnd2"]      = "Logical Etude",
        ["chr1"]      = "Enchanting Etude",     ["chr2"]     = "Bewitching Etude",    ["firec1"]    = "Fire Carol",          ["firec2"]    = "Fire Carol II",
        ["icec1"]     = "Ice Carol",            ["icec2"]    = "Ice Carol II",        ["windc1"]    = "Wind Carol",          ["windc2"]    = "Wind Carol II",
        ["earthc1"]   = "Earth Carol",          ["earthc2"]  = "Earth Carol II",      ["thunderc1"] = "Lightning Carol",     ["thunderc2"] = "Lightning Carol II",
        ["waterc1"]   = "Water Carol",          ["waterc2"]  = "Water Carol II",      ["lightc1"]   = "Light Carol",         ["lightc2"]   = "Light Carol II",
        ["darkc1"]    = "Dark Carol",           ["darkc2"]   = "Dark Carol II",       ["firet1"]    = "Fire Threnody",       ["firet2"]    = "Fire Threnody II",
        ["icet1"]     = "Ice Threnody",         ["icet2"]    = "Ice Threnody II",     ["windt1"]    = "Wind Threnody",       ["windt2"]    = "Wind Threnody II",
        ["eartht1"]   = "Earth Threnody",       ["eartht2"]  = "Earth Threnody II",   ["thundt1"]   = "Lightning Threnody",  ["thundt2"]   = "Lightning Threnody II",
        ["watert1"]   = "Water Threnody",       ["watert2"]  = "Water Threnody II",   ["lightt1"]   = "Light Threnody",      ["lightt2"]   = "Light Threnody II",
        ["darkt1"]    = "Dark Threnody",        ["darkt2"]   = "Dark Threnody II",    ["finale"]    = "Magic Finale",        ["ghym"]      = "Goddess's Hymnus",
        ["scherzo"]   = "Sentinel's Scherzo",   ["pining"]   = "Pining Nocturne",     ["zurka1"]    = "Raptor Mazurka",      ["zurka2"]    = "Chocobo Mazurka",
        
    }
    
    self.runPlaylist = function(queue)
        local queue = queue or false
        local delay = system["BRD"]["Repeat Delay"] or 180
        local troub = bpcore:buffActive(348)
        
        if queue then

            for i,v in ipairs(queue) do
                
                if type(v) == "table" then
                    
                    if (os.clock()-v.time) > delay then
                        windower.send_command(string.format("bp %s", table.concat(v.command, " ")))
                        
                        if troub then
                            helpers["songs"].setTime(saved, (i*2))
                            
                        elseif not troub then
                            helpers["songs"].setTime(saved, (i))
                            
                        end
                    
                    end
                
                end
            
            end
        
        end
    
    end

    self.playSong = function(song, slot, target)
        local allowed = {"March","Minuet","Madrigal","Prelude","Minne","Ballad","Mambo","Strength","Dexterity","Vitality","Agility","Intelligence","Mind","Charisma","Fire","Ice","Wind","Earth","Lightning","Water","Light","Dark"}
        local player  = windower.ffxi.get_player() or false
        local max     = helpers["songs"].getSongMax()
        local target  = target or "me"
        local song    = song or false
        local slot    = slot or false
        
        -- If Clarion Call is in the queue, add an extra song slot.
        if (helpers["queue"].inQueue(JA["Clarion Call"], windower.ffxi.get_mob_by_id(player.id)) or bpcore:buffActive(499) or helpers["songs"].getActive() == 5) then
            max = (max + 1)
        end
        
        if player and song and slot and type(song) == "string" and slot <= max and not helpers["songs"].getShort(song) and player.main_job == "BRD" then
            
            -- If one hours are active then determine if we can use them.
            if bpcore:canAct() and system["Core"].getSetting("1HR") and (target:lower() == "me" or target:lower() == player.name:lower()) then
                
                if helpers["songs"].canOnehour() and helpers["songs"].canNitro() then
                    helpers["queue"].add(JA["Soul Voice"], "me")
                    helpers["queue"].add(JA["Clarion Call"], "me")
                    
                end
            
            end
        
            -- If Job Abilities are active then determine if we can use them.
            if bpcore:canAct() and system["Core"].getSetting("JA") then
                
                if helpers["songs"].canNitro() then
                    helpers["queue"].add(JA["Nightingale"], "me")
                    helpers["queue"].add(JA["Troubadour"], "me")
                end
            
            end
            
            -- Determine the song target.
            if type(target) == "table" and windower.ffxi.get_mob_by_id(target.mob.id) then
                local target = windower.ffxi.get_mob_by_id(target.mob.id)
                
                if target and slot <= max and bpcore:canAct() and bpcore:canCast() and bpcore:isJAReady(JA["Pianissimo"].recast_id) and bpcore:getAvailable("JA", "Pianissimo") then
                    
                    for _,v in ipairs(allowed) do
                
                        if (v:lower()):match(song:lower()) then
                            
                            if song:lower() == "min" and v:lower() == "minuet" then
                                
                                if (max == 3 or max == 4) then
                                    
                                    if slot == 3 then
                                        helpers['queue'].add(MA["Army's Paeon"], target)
                                    
                                    elseif slot == 4 then
                                        helpers['queue'].add(MA["Army's Paeon II"], target)
                                        
                                    end
                                    
                                elseif max == 5 then
                                    
                                    if slot == 4 then
                                        helpers['queue'].add(MA["Army's Paeon"], target)
                                    
                                    elseif slot == 5 then
                                        helpers['queue'].add(MA["Army's Paeon II"], target)
                                        
                                    end
                                    
                                end
                                
                                helpers['queue'].add(MA[default[v].songs[default[v].count]], target)
                                default[v].count = (default[v].count + 1)
                                
                            elseif song:lower() == "minne" and v:lower() == "minne" then
                                
                                if (max == 3 or max == 4) then
                                    
                                    if slot == 3 then
                                        helpers['queue'].add(MA["Army's Paeon"], target)
                                    
                                    elseif slot == 4 then
                                        helpers['queue'].add(MA["Army's Paeon II"], target)
                                        
                                    end
                                    
                                elseif max == 5 then
                                    
                                    if slot == 4 then
                                        helpers['queue'].add(MA["Army's Paeon"], target)
                                    
                                    elseif slot == 5 then
                                        helpers['queue'].add(MA["Army's Paeon II"], target)
                                        
                                    end
                                    
                                end
                                
                                helpers['queue'].add(MA[default[v].songs[default[v].count]], target)
                                default[v].count = (default[v].count + 1)
                                
                            elseif song:lower() ~= "min" and song:lower() ~= "minne" then
                                
                                if (max == 3 or max == 4) then
                                    
                                    if slot == 3 then
                                        helpers['queue'].add(MA["Army's Paeon"], target)
                                    
                                    elseif slot == 4 then
                                        helpers['queue'].add(MA["Army's Paeon II"], target)
                                        
                                    end
                                    
                                elseif max == 5 then
                                    
                                    if slot == 4 then
                                        helpers['queue'].add(MA["Army's Paeon"], target)
                                    
                                    elseif slot == 5 then
                                        helpers['queue'].add(MA["Army's Paeon II"], target)
                                        
                                    end
                                    
                                end
                                
                                if song:lower() == "march" and v:lower() == "march" and helpers["songs"].hasAeonic() then
                                    helpers['queue'].add(MA[default[v].songs[default[v].count]], target)
                                    default[v].count = (default[v].count + 1)
                                    
                                elseif song:lower() == "march" and v:lower() == "march" and not helpers["songs"].hasAeonic() then
                                    helpers['queue'].add(MA[default[v].songs[default[v].count+1]], target)
                                    default[v].count = (default[v].count + 1)
                                    
                                else
                                    helpers['queue'].add(MA[default[v].songs[default[v].count]], target)
                                    default[v].count = (default[v].count + 1)
                                    
                                end
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            elseif type(target) == "string" then
                
                for _,v in ipairs(allowed) do
                    
                    if (v:lower()):match(song:lower()) and bpcore:canCast() then
                        
                        if song:lower() == "min" and v:lower() == "minuet" then
                            
                            if (max == 3 or max == 4) then
                                    
                                if slot == 3 then
                                    helpers['queue'].add(MA["Army's Paeon"], target)
                                
                                elseif slot == 4 then
                                    helpers['queue'].add(MA["Army's Paeon II"], target)
                                    
                                end
                                
                            elseif max == 5 then
                                
                                if slot == 4 then
                                    helpers['queue'].add(MA["Army's Paeon"], target)
                                
                                elseif slot == 5 then
                                    helpers['queue'].add(MA["Army's Paeon II"], target)
                                    
                                end
                                
                            end
                            
                            helpers['queue'].add(MA[default[v].songs[default[v].count]], target)
                            default[v].count = (default[v].count + 1)
                            
                        elseif song:lower() == "minne" and v:lower() == "minne" then
                            
                            if (max == 3 or max == 4) then
                                    
                                if slot == 3 then
                                    helpers['queue'].add(MA["Army's Paeon"], target)
                                
                                elseif slot == 4 then
                                    helpers['queue'].add(MA["Army's Paeon II"], target)
                                    
                                end
                                
                            elseif max == 5 then
                                
                                if slot == 4 then
                                    helpers['queue'].add(MA["Army's Paeon"], target)
                                
                                elseif slot == 5 then
                                    helpers['queue'].add(MA["Army's Paeon II"], target)
                                    
                                end
                                
                            end
                            
                            helpers['queue'].add(MA[default[v].songs[default[v].count]], target)
                            default[v].count = (default[v].count + 1)
                            
                        elseif song:lower() ~= "min" and song:lower() ~= "minne" then
                            
                            if (max == 3 or max == 4) then
                                    
                                if slot == 3 then
                                    helpers['queue'].add(MA["Army's Paeon"], target)
                                
                                elseif slot == 4 then
                                    helpers['queue'].add(MA["Army's Paeon II"], target)
                                    
                                end
                                
                            elseif max == 5 then
                                
                                if slot == 4 then
                                    helpers['queue'].add(MA["Army's Paeon"], target)
                                
                                elseif slot == 5 then
                                    helpers['queue'].add(MA["Army's Paeon II"], target)
                                    
                                end
                                
                            end
                            
                            if song:lower() == "march" and v:lower() == "march" and helpers["songs"].hasAeonic() then
                                helpers['queue'].add(MA[default[v].songs[default[v].count]], target)
                                default[v].count = (default[v].count + 1)
                                
                            elseif song:lower() == "march" and v:lower() == "march" and not helpers["songs"].hasAeonic() then
                                helpers['queue'].add(MA[default[v].songs[default[v].count+1]], target)
                                default[v].count = (default[v].count + 1)
                                
                            else
                                helpers['queue'].add(MA[default[v].songs[default[v].count]], target)
                                default[v].count = (default[v].count + 1)
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            end
            
        elseif player and song and slot and type(song) == "string" and slot <= max and helpers["songs"].getShort(song) and player.main_job == "BRD" then
            
            -- If one hours are active then determine if we can use them.
            if bpcore:canAct() and system["Core"].getSetting("1HR") and (target:lower() == "me" or target:lower() == player.name:lower()) then
                
                if helpers["songs"].canOnehour() and helpers["songs"].canNitro() then
                    helpers["queue"].add(JA["Soul Voice"], "me")
                    helpers["queue"].add(JA["Clarion Call"], "me")

                end
            
            end
        
            -- If Job Abilities are active then determine if we can use them.
            if bpcore:canAct() and system["Core"].getSetting("JA") then
                
                if helpers["songs"].canNitro() then
                    helpers["queue"].add(JA["Nightingale"], "me")
                    helpers["queue"].add(JA["Troubadour"], "me")
                    
                end
            
            end
            
            helpers['queue'].add(MA[helpers["songs"].getShort(song)], target)
            
        end
        
    end
    
    self.canNitro = function()
        
        if bpcore:isJAReady(JA["Nightingale"].recast_id) and bpcore:isJAReady(JA["Troubadour"].recast_id) and bpcore:getAvailable("JA", "Nightingale") and bpcore:getAvailable("JA", "Troubadour") then
            return true
        end
        return false
        
    end
    
    self.canOnehour = function()
        
        if bpcore:isJAReady(JA["Soul Voice"].recast_id) and bpcore:isJAReady(JA["Clarion Call"].recast_id) and bpcore:getAvailable("JA", "Soul Voice") and bpcore:getAvailable("JA", "Clarion Call") then
            return true
        end
        return false
    
    end
    
    self.getShort = function(short)
        local short = short or false
        
        if short and type(short) == "string" and songs[short] then
            return songs[short]
        end
        return false
        
    end
    
    self.getSong = function(name)
        local name = name or false
        
        if name and type(name) == "string" then
            local list = res.spells:type("BardSong")
            
            for _,v in pairs(list) do
                
                if v and ((v.en):lower() == (name):lower() or (v.en):lower() == (helpers["songs"].getShort(name)):lower()) then
                    return v
                end
                
            end            
            
        end
        return false
        
    end
    
    self.getActive = function()
        local player = windower.ffxi.get_player() or false
    
        if player then
            local buffs, count = player.buffs, 0
            
            for _,v in ipairs(buffs) do
                
                if helpers["songs"].valid(v) then
                    count = count + 1
                end
            
            end
            return count
        
        end
        return false
        
    end
    
    self.valid = function(id)
        local id = id or false
        
        if id then
            
            for _,v in ipairs(valid) do
                
                if v == id then
                    return true
                end
                
            end
            
        end
        return false
        
    end
    
    self.queueSongs = function(commands)
        local commands = commands or false
        
        if commands and type(commands) == "table" then
            
            if commands[1] == "loop" then
                commands[1] = "songs"
                table.insert(saved, {time=os.clock(), command=commands})
                
            elseif commands[2] == "loop" then
                commands[2] = "songs"
                table.insert(saved, {time=os.clock(), command=commands})
            end
            
        end
        
    end
    
    self.getQueued = function()
        
        if saved then
            return saved
        end
        return false
        
    end
    
    self.clearQueue = function()
        saved = {}
    end
    
    self.setTime = function(queue, index)
        local queue = queue or false
        
        if queue then
            queue[index].time = os.clock()
        end
        
    end
    
    self.resetCounts = function()
        
        for _,v in pairs(default) do
            v.count = 1
        end
        
    end
    
    self.getSongMax = function()
        
        if (bpcore:findItemByName("Daurdabla", 0) or bpcore:findItemByName("Daurdabla", 8) or bpcore:findItemByName("Daurdabla", 10) or bpcore:findItemByName("Daurdabla", 11) or bpcore:findItemByName("Daurdabla", 12)) then
            return 4
            
        elseif (bpcore:findItemByName("Terpander", 0) or bpcore:findItemByName("Terpander", 8) or bpcore:findItemByName("Terpander", 10) or bpcore:findItemByName("Terpander", 11) or bpcore:findItemByName("Terpander", 12)) then
            return 3
        
        elseif (bpcore:findItemByName("Blurred harp +1", 0) or bpcore:findItemByName("Blurred harp +1", 8) or bpcore:findItemByName("Blurred harp +1", 10) or bpcore:findItemByName("Blurred harp +1", 11) or bpcore:findItemByName("Blurred harp +1", 12)) then
            return 3
        
        else
            return 2
            
        end
        
    end
    
    self.hasAeonic = function()
        
        if (bpcore:findItemByName("Marsyas", 0) or bpcore:findItemByName("Marsyas", 8) or bpcore:findItemByName("Marsyas", 10) or bpcore:findItemByName("Marsyas", 11) or bpcore:findItemByName("Marsyas", 12)) then
            return true
        end
        return false
        
    end
    
    self.handleChat = function(sender, commands)
        local player = windower.ffxi.get_player()
        
        if not system["BP Allowed"][windower.ffxi.get_info().zone] then
            
            if player and commands[1] and commands[2] and (player.name):sub(1, #commands[1]):lower():match((commands[1]):sub(1, #commands[1]):lower()) and (commands[2] == "songs" or commands[2] == "loop") then
                local max  = helpers["songs"].getSongMax()
                local slot = 1
    
                if commands[2] == "loop" then
                    helpers["songs"].queueSongs(commands)
                    
                    if not system["Core"].getSetting("REPEAT") then
                        system["Core"].set("REPEAT", true)
                    end
                    
                end
                
                for i=3, #commands do
                    local piano = bpcore:findPartyMember(commands[#commands]) or false
                    
                    if piano then
                    
                        if commands[i] and i ~= #commands then
                            helpers["songs"].playSong(commands[i], slot, piano)
                            slot = (slot + 1)
                            
                        end
                    
                    elseif commands[i] then
                        helpers["songs"].playSong(commands[i], slot)
                        slot = (slot + 1)
                        
                    end
                    
                end
                helpers["songs"].resetCounts()
                
            elseif player and (commands[1] == "songs" or commands[1] == "loop") then
                local max = helpers["songs"].getSongMax()
                local slot = 1
                
                if commands[1] == "loop" then
                    helpers["songs"].queueSongs(commands)
    
                    if not system["Core"].getSetting("REPEAT") then
                        system["Core"].set("REPEAT", true)
                    end
                    
                end
                
                for i=2, #commands do
                    local piano = bpcore:findPartyMember(commands[#commands]) or false
                    
                    if piano then
                    
                        if commands[i] and i ~= #commands then
                            helpers["songs"].playSong(commands[i], slot, piano)
                            slot = (slot + 1)
                            
                        end
                    
                    elseif commands[i] then
                        helpers["songs"].playSong(commands[i], slot)
                        slot = (slot + 1)
                                            
                    end
                    
                end
                helpers["songs"].resetCounts()
                
            end
            
        end
        
    end
    
    -- Handles incoming commands for songs.
    self.handleCommands = function(commands)
        local player = windower.ffxi.get_player()

        if not system["BP Allowed"][windower.ffxi.get_info().zone] then
        
            if player and commands[1] and commands[2] and (player.name):sub(1, #commands[1]):lower():match((commands[1]):sub(1, #commands[1]):lower()) and (commands[2] == "songs" or commands[2] == "loop") then
                local max  = helpers["songs"].getSongMax()
                local slot = 1
    
                if commands[2] == "loop" then
                    helpers["songs"].queueSongs(commands)
                    
                    if not system["Core"].getSetting("REPEAT") then
                        system["Core"].set("REPEAT", true)
                    end
                    
                end
                
                for i=3, #commands do
                    local piano = bpcore:findPartyMember(commands[#commands], true) or false
                    
                    if piano then
                        
                        if commands[i] and i ~= #commands then
                            helpers["songs"].playSong(commands[i], slot, piano)
                            slot = (slot + 1)
                            
                        end
                    
                    elseif commands[i] then
                        helpers["songs"].playSong(commands[i], slot)
                        slot = (slot + 1)
                        
                    end
                    
                end
                helpers["songs"].resetCounts()
                
            elseif player and (commands[1] == "songs" or commands[1] == "loop") then
                local max = helpers["songs"].getSongMax()
                local slot = 1
                
                if commands[1] == "loop" then
                    helpers["songs"].queueSongs(commands)
    
                    if not system["Core"].getSetting("REPEAT") then
                        system["Core"].set("REPEAT", true)
                    end
                    
                end
                
                for i=2, #commands do
                    local piano = bpcore:findPartyMember(commands[#commands], true) or false
                    
                    if piano then
                    
                        if commands[i] and i ~= #commands then
                            helpers["songs"].playSong(commands[i], slot, piano)
                            slot = (slot + 1)
                            
                        end
                    
                    elseif commands[i] then
                        helpers["songs"].playSong(commands[i], slot)
                        slot = (slot + 1)
                                            
                    end
                    
                end
                helpers["songs"].resetCounts()
                
            end
            
        end
        
    end
    
    return self

end
return songs.new()