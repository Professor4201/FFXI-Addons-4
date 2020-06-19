--------------------------------------------------------------------------------
-- Bootstrap to load all includes, and settings.
--------------------------------------------------------------------------------
-- @return settings
local settings = {}
    
--------------------------------------------------------------------------------
-- Initializes all the addons settings.
--------------------------------------------------------------------------------
-- @return
function settings:initializeSettings()
    
    if bpcore:fileExists(string.format("../equipviewer/pets/%s.png", (windower.ffxi.get_player().name):lower())) then
        windower.send_command(string.format("ev %s", (windower.ffxi.get_player().name):lower()))
        
    elseif bpcore:fileExists(string.format("../equipviewer/pets/%s.png", "moogle")) then
        windower.send_command(string.format("ev %s", "moogle"))
        
    end
    
    local system = {}
    local c_settings = nil
    
    -- Check if all neccessary files exist.
    if windower.ffxi.get_player() then
        local name = windower.ffxi.get_player().name
        
        if bpcore:fileExists(string.format("/bp/settings/characters/%s.lua", name)) then
            c_settings = require(string.format("/bp/settings/characters/%s", name))
        
        else
            local new  = files.new(string.format("/bp/settings/characters/%s.lua", name))
            c_settings = require("bp/settings/characters/default")
            
            if new then
                new:write(string.format("return %s", (T(c_settings)):tovstring()))
            end
            
        end

    end

    -- BP Town whitelist.
    system["BP Allowed"]            = {[26]=26,[48]=48,[50]=50,[53]=53,[70]=70,[71]=71,[80]=80,[87]=87,[94]=94,[230]=230,[231]=231,[232]=232,[233]=233,[234]=234,[235]=235,[236]=236,[237]=237,[238]=238,
                                       [239]=239,[240]=240,[241]=241,[242]=242,[243]=243,[244]=244,[245]=245,[246]=246,[247]=247,[248]=248,[249]=249,[250]=250,[252]=252,[256]=256,[257]=257,[280]=280,[281]=281,[284]=284}
    
    system["Shutdown"]              = {[131]=131}
    
    -- Characters Information.
    system["Main Character"]        = c_settings["Main Character"]
    system["Characters"]            = c_settings["Characters"]
    system["Controllers"]           = c_settings["Controllers"]
    system["Auto Join"]             = c_settings["Auto Join"]
    system["Nation"]                = {[0]="Sandoria",[1]="Bastok",[2]="Windurst"}
    
    -- Party Structures
    system["Party Structures"]      = c_settings["Party Structures"]
    
    -- Addon Toggles.  
    system["Use Items"]             = c_settings["Use Items"]
    system["Skill Books"]           = c_settings["Skill Books"]
    system["Rock Cases"]            = c_settings["Rock Cases"]
    
    system["Farmer Toggle"]         = I{false,true}
    system["Movement Correction"]   = I{false,true}
    system["HQ HACK"]               = I{false,true}
                
    -- Addon Colors.
    system["Match Colors"]          = I{true,false}
    system["Font 1"]                = 5
    system["Font 2"]                = 10
    system["Font 3"]                = 15
    system["Font 4"]                = 25
    system["Font 5"]                = 30
                
    -- Player Information.
    system["My Homepoint"]          = c_settings["My Homepoint"]
    system["Teleport Ring"]         = c_settings["Teleport Ring"]
    system["X"]                     = windower.ffxi.get_mob_by_target('me').x
    system["Y"]                     = windower.ffxi.get_mob_by_target('me').y
    system["Z"]                     = windower.ffxi.get_mob_by_target('me').z
    system["Buffer POS"]            = 2
    system["Random POS"]            = 3
    system["Aggro Range"]           = 15
    system["Spell Interrupt"]       = I{true,false}
    system["Speed Rate"]            = c_settings["Speed Rate"]
    system["Casting Multiplier"]    = c_settings["Casting Multiplier"]
    system["Temp Speed"]            = 0
    system["Mount"]                 = c_settings["Mount"]
    system["Player"]                = windower.ffxi.get_player()
    system["Player Target"]         = false
    system["Target Enmity"]         = false
    system["Attacker Enmity"]       = false
    system["Info"]                  = windower.ffxi.get_info()
    system["Zone"]                  = {id=nil, name=nil}
    system["Player Status"]         = {}
    system["Recast"]                = {["Abilities"] = windower.ffxi.get_ability_recasts(), ["Spells"] = windower.ffxi.get_spell_recasts()}
    system["Party"]                 = {["Alliance"]={}, ["Parties"]={}, ["Players"]={}, ["Pets"]={}}
    system["Buffs"]                 = {["Player"]={}, ["Party"]={}}
    system["Stats"]                 = {STR=0,DEX=0,AGI=0,VIT=0,INT=0,MND=0,CHR=0}
    system["Weapon"]                = 0
    system["Ranged"]                = 0
    system["Ammo"]                  = 0
    
    -- Autoload Addons.         
    system["Addons"]                = {"equipviewer"}
    
    -- Addon Settings.          
    system["BP Enabled"]            = I{true,false}
    system["Ping Delay"]            = c_settings["Ping Delay"]
    system["Last Action"]           = {}
    system["Next Allowed"]          = os.clock()
    system["Zone Delay"]            = 15
    system["Last Ping"]             = 0
    system["Last Keyboard"]         = 0
    system["Facing Blocked"]        = false
    system["Core"]                  = {}
    system["Sparks Delay"]          = c_settings["Sparks Delay"]
    system["Screen Size"]           = {x=windower.get_windower_settings().x_res, y=windower.get_windower_settings().y_res}
    
    -- Default Trust.
    system["Default Trust"]         = c_settings["Default Trust"]
    
    -- Job HUD Display Settings.
    system["Job Window X"]          = c_settings["Job Window X"]
    system["Job Window Y"]          = c_settings["Job Window Y"]
    system["Job Font"]              = c_settings["Job Font"]
    system["Job Draggable"]         = c_settings["Job Draggable"]
    system["Job Padding"]           = c_settings["Job Padding"]
    system["Job Stroke"]            = c_settings["Job Stroke"]
    
    -- Distance Display Settings.
    system["Distance Window X"]     = c_settings["Distance Window X"]
    system["Distance Window Y"]     = c_settings["Distance Window Y"]
    system["Distance Font"]         = c_settings["Distance Font"]
    system["Distance Draggable"]    = c_settings["Distance Draggable"]
    system["Distance Padding"]      = c_settings["Distance Padding"]
    system["Distance Stroke"]       = c_settings["Distance Stroke"]
    
    -- Targeting Helper Settings.
    system["Auto Targeting"]        = c_settings["Auto Targeting"]  
    system["Target Window X"]       = c_settings["Target Window X"] 
    system["Target Window Y"]       = c_settings["Target Window Y"] 
    system["Target Font"]           = c_settings["Target Font"]     
    system["Target Draggable"]      = c_settings["Target Draggable"]
    system["Target Padding"]        = c_settings["Target Padding"] 
    system["Target Stroke"]         = c_settings["Job Stroke"]
    
    -- Farmer Helper Settings.
    system["Search Distance"]       = c_settings["Search Distance"] 
    system["Search Delay"]          = c_settings["Search Delay"]

    -- Queue Helper Setting.s
    system["Queue Window"]          = nil
    system["Queue Window X"]        = c_settings["Queue Window X"]   
    system["Queue Window Y"]        = c_settings["Queue Window Y"]   
    system["Queue Max Visible"]     = c_settings["Queue Max Visible"]
    system["Queue Max Width"]       = c_settings["Queue Max Width"]  
    system["Queue Font"]            = c_settings["Queue Font"]       
    system["Queue Font Size"]       = c_settings["Queue Font Size"]  
    system["Queue Draggable"]       = c_settings["Queue Draggable"]  
    system["Queue Padding"]         = c_settings["Queue Padding"]    

    -- Events Helper Settings.
    system["Events Window X"]       = c_settings["Events Window X"] 
    system["Events Window Y"]       = c_settings["Events Window Y"] 
    system["Events Max Width"]      = c_settings["Events Max Width"]
    system["Events Font"]           = c_settings["Events Font"]     
    system["Events Font Size"]      = c_settings["Events Font Size"]
    system["Events Draggable"]      = c_settings["Events Draggable"]
    system["Events Padding"]        = c_settings["Events Padding"]  

    -- Currencies Helper Settings.
    system["Currencies Visible"]    = c_settings["My Currencies"]
    system["Currencies Window X"]   = c_settings["Currencies Window X"]
    system["Currencies Window Y"]   = c_settings["Currencies Window Y"]
    system["Currencies Max Width"]  = c_settings["Currencies Max Width"]
    system["Currencies Font"]       = c_settings["Currencies Font"]
    system["Currencies Font Size"]  = c_settings["Currencies Font Size"]
    system["Currencies Draggable"]  = c_settings["Currencies Draggable"]
    system["Currencies Padding"]    = c_settings["Currencies Padding"]
    system["Currencies Stroke"]     = c_settings["Currencies Stroke"]
    
    -- Missions Helper Settings.
    system["Missions Visible"]      = c_settings["My Missions"]
    system["Missions Window X"]     = c_settings["Missions Window X"] 
    system["Missions Window Y"]     = c_settings["Missions Window Y"] 
    system["Missions Max Width"]    = c_settings["Missions Max Width"]
    system["Missions Font"]         = c_settings["Missions Font"]     
    system["Missions Font Size"]    = c_settings["Missions Font Size"]
    system["Missions Draggable"]    = c_settings["Missions Draggable"]
    system["Missions Padding"]      = c_settings["Missions Padding"]  
    system["Missions Stroke"]       = c_settings["Missions Stroke"]
    
    -- Orders Helpers Settings.
    system["Orders Delay"]          = c_settings["Orders Delay"]
    system["Orders Range"]          = c_settings["Orders Range"]
    
    -- Distance Helpers Settings.
    system["Assist Range"]          = c_settings["Assist Range"]
    
    -- Job Tables.
    system["WAR"] = c_settings["WAR"]
    system["MNK"] = c_settings["MNK"]
    system["WHM"] = c_settings["WHM"]
    system["BLM"] = c_settings["BLM"]
    system["RDM"] = c_settings["RDM"]
    system["THF"] = c_settings["THF"]
    system["PLD"] = c_settings["PLD"]
    system["DRK"] = c_settings["DRK"]
    system["BST"] = c_settings["BST"]
    system["BRD"] = c_settings["BRD"]
    system["RNG"] = c_settings["RNG"]
    system["SAM"] = c_settings["SAM"]
    system["NIN"] = c_settings["NIN"]
    system["DRG"] = c_settings["DRG"]
    system["SMN"] = c_settings["SMN"]
    system["BLU"] = c_settings["BLU"]
    system["COR"] = c_settings["COR"]
    system["PUP"] = c_settings["PUP"]
    system["DNC"] = c_settings["DNC"]
    system["SCH"] = c_settings["SCH"]
    system["GEO"] = c_settings["GEO"]
    system["RUN"] = c_settings["RUN"]
    
    -- Rune Buffs
    system["RUNES"] = {["Ignis"]=523,["Gelus"]=524,["Flabra"]=525,["Tellus"]=526,["Sulpor"]=527,["Unda"]=528,["Lux"]=529,["Tenebrae"]=530}
    
    -- Commands List.
    system["Commands"] = {
        
        {name="reload",         allowed=true},        {name="controls",       allowed=true},
        {name="speed",          allowed=true},        {name="currencies",     allowed=true},
        {name="missions",       allowed=false},       {name="mode",           allowed=true},
        {name="schedule",       allowed=false},       {name="events",         allowed=true},
        {name="items",          allowed=true},        {name="megawarp",       allowed=false},
        {name="menus",          allowed=true},        {name="ciphers",        allowed=true},
        {name="orders",         allowed=true},        {name="follow",         allowed=true},
        {name="party",          allowed=true},        {name="ally",           allowed=true},
        {name="wkr",            allowed=false},       {name="guilds",         allowed=false},
        {name="coalitions",     allowed=false},       {name="items",          allowed=true},
        {name="sparks",         allowed=true},        {name="target",         allowed=true},
        {name="millioncorn",    allowed=true},        {name="zincore",        allowed=true},
        {name="magicmaps",      allowed=true},        {name="jobs",           allowed=true},
        {name="trust",          allowed=true},        {name="shops",          allowed=true},
        {name="mogexit",        allowed=true},        {name="bluspell",       allowed=true},
        {name="interact",       allowed=true},        {name="helm",           allowed=false},
        {name="craft",          allowed=false},       {name="fastcraft",      allowed=true},
        {name="trade",          allowed=true},        {name="clusters",       allowed=false},
        {name="repo",           allowed=false},       {name="moghouse",       allowed=true},
        {name="use_warpring",   allowed=true},        {name="warp",           allowed=false},
        {name="crystals",       allowed=false},       {name="thumb",          allowed=true},
        {name="aeonic",         allowed=false},        
        
    }
    
    -- Helper List.
    system["Helpers"] = {
        
        {name="actions",        allowed=true},        {name="assaults",       allowed=false},
        {name="controls",       allowed=true},        {name="popchat",        allowed=true},
        {name="queue",          allowed=true},        {name="currencies",     allowed=true},
        {name="missions",       allowed=false},       {name="npcupdater",     allowed=false},
        {name="target",         allowed=true},        {name="events",         allowed=true},
        {name="schedule",       allowed=false},       {name="stats",          allowed=true},
        {name="keybinds",       allowed=true},        {name="megawarp",       allowed=false},
        {name="orders",         allowed=true},        {name="guilds",         allowed=false},
        {name="sparks",         allowed=true},        {name="distance",       allowed=true},
        {name="millioncorn",    allowed=true},        {name="zincore",        allowed=true},
        {name="trust",          allowed=true},        {name="shops",          allowed=true},
        {name="bluspell",       allowed=true},        {name="interact",       allowed=true},
        {name="helm",           allowed=false},       {name="craft",          allowed=false},
        {name="fastcraft",      allowed=true},        {name="trade",          allowed=true},
        {name="repo",           allowed=false},       {name="alias",          allowed=true},
        {name="warp",           allowed=false},       {name="crystals",       allowed=false},
        {name="speed",          allowed=true},        {name="chatcommands",   allowed=true},
        {name="notifications",  allowed=true},        {name="thumb",          allowed=true},
        {name="aeonic",         allowed=false},       {name="coalitions",     allowed=false},
        {name="trove",          allowed=false},       {name="songs",          allowed=true},
        {name="rolls",          allowed=true},        {name="runes",          allowed=true},
        {name="ciphers",        allowed=true},        {name="status",         allowed=true},
        {name="cures",          allowed=true},        {name="filter",         allowed=true},
        
    }
    
    -- Autoload Events.
    system["Events"] = {
        "action","action message","load","unload","login","logout","gain buff","lose buff","target change","weather change","status change","prerender",
        "chat message","party invite","zone change","incoming text","outgoing text","incoming chunk","outgoing chunk","keyboard","weather change"}
    
    -- Packet Information
    --I: 0x034
    system["I: 0x034 Menu"]         = false
    
    --I: 0x037
    system["I: 0x037 Data"]         = nil
    system["I: 0x037 Count"]        = 170
    
    --I: 0x00d
    system["I: 0x00d Data"]         = nil
    
    --I: 0x00e
    system["I: 0x00e Debug"]        = I{true,false}
    
    --I: 0x056 -- Mission logs.
    system["I: 0x056 Data"]         = nil
    
    --O: 0x015
    system["New Position"]          = nil
    system["O: 0x015 Data"]         = nil
    system["O: 0x015 Debug"]        = I{false,true}
    system["O: 0x015 Steps"]        = 2
    system["O: 0x015 Timestamp"]    = 0
    
    -- Synthesis
    system["Fast Synth"]            = false
    system["Finsh Synth"]           = false
    system["Synth Quality"]         = nil
    
    --O: 0x01A
    system['poked']                 = false
    
    --O: 0x05B
    system["injected"]              = false
    
    -- Skill-up spells.
    system["Skillup"] = {
        
        ["Divine"]     = {list={"Banish","Flash","Banish II","Enlight","Repose"}, target="t"},
        ["Enhancing"]  = {list={"Barfire","Barblizzard","Baraero","Barstone","Barthunder","Barwater"}, target="me"},
        ["Enfeebling"] = {list={"Bind","Blind","Dia","Poison","Gravity","Slow","Silence"}, target="t"},
        ["Elemental"]  = {list={"Stone"}, target="t"},
        ["Dark"]       = {list={"Aspir","Aspir II","Bio","Bio II","Drain","Drain II"}, target="t"},
        ["Singing"]    = {list={"Mage's Ballad","Mage's Ballad II","Mage's Ballad III"}, target="me"},
        ["Summoning"]  = {list={"Carbuncle"}, target="me"},
        ["Blue"]       = {list={"Cocoon"}, target="me"},
        ["Geomancy"]   = {list={"Indi-Refresh"}, target="me"},
        
        
    }
    
    --IMPORTANT NPCS!
    system["NPCs"] = {
        "Pikini-Mikini","Bki Tbujhja","Mertaire","Song Runes","Brutus","Door","Shallot","Night Flowers","Chocobo","Laila","Naji","Iron Eater","Cid","Karst","Lucius","Gilgamesh","???","Clarion Star","Isakoth","Yahse Wildflower",
        "Octavien","Affi","Dremi","Shiftrix","Task Delegator","Civil Registrar","Runic Portal","Sharin Garin",
    }
    
    -- IMPORTANT ITEMS!
    system["My Items"] = c_settings["My Items"]
    system["Cooldown Items"] = T{
        "Warp Ring","Teleport ring: Dem","Teleport ring: Mea","Teleport ring: Holla","Teleport ring: Vahzl","Teleport ring: Altep","Teleport ring: Yhoat","Empress Band","Emperor Band","Resolution Ring","Chariot Band","Kupofired's Ring",
        "Allied Ring","Caliber Ring","Expertise Ring","Novennial Ring","Anniversary Ring","Decennial Ring","Undecennial Ring","Duodecennial Ring","Echad Ring",
    }
    
    -- RETURN ENTIRE CHARACTER SETTINGS TABLE.
    system["Character Settings"] = c_settings
    
    return system
    
end
return settings
