--------------------------------------------------------------------------------
-- Default settings table. [ DO NOT MODIFY THIS DATA! ]
-- This is specifically a default backup incase a settings file does not exist.
-- The addon will build a file based upon a characters name when loaded!
--------------------------------------------------------------------------------

return {
    
    -- Characters Information.
    ["Main Character"]           = "",
    ["Characters"]               = T{},
    ["Controllers"]              = T{},
    ["Auto Join"]                = T{},
    
    -- Pinger Settings.
    ["Ping Delay"]               = 0.6,
    
    -- Party Structures
    ["Party Structures"]         = {
        
        ["Dirtydupes"] = {},
        
    },
    
    -- Default Trust
    ["Default Trust"]            = {
        
        trust1 = "Amchuchu",
        trust2 = "Mihli Aliapoh",
        trust3 = "Koru-Moru",
        trust4 = "Joachim",
        trust5 = "Selh\'teus"
    
    },
    
    -- Player Information.
    ["My Homepoint"]             = "Bastok Markets 1",
    ["Teleport Ring"]            = "",
    ["Speed Rate"]               = 75,
    ["Casting Multiplier"]       = 0.15,
    ["Mount"]                    = "Raptor",
    
    -- Job HUD Display Settings.
    ["Job Window X"]             = 725,
    ["Job Window Y"]             = 860,
    ["Job Font"]                 = {size=9,font="lucida console",alpha=255,r=245,g=200,b=20},
    ["Job Draggable"]            = false,
    ["Job Padding"]              = 7,
    ["Job Stroke"]               = {width=1,alpha=255,r=0,g=0,b=0},
    
    -- SMN HUD Display Settings.
    ["Pet Window X"]             = 0,
    ["Pet Window Y"]             = 0,
    ["Pet Font"]                 = {size=9,font="lucida console",alpha=255,r=245,g=200,b=20},
    ["Pet Padding"]              = 7,
    ["Pet Stroke"]               = {width=1,alpha=255,r=0,g=0,b=0},
    
    ["Rage Window X"]            = 0,
    ["Rage Window Y"]            = 0,
    ["Rage Font"]                = {size=9,font="lucida console",alpha=255,r=245,g=200,b=20},
    ["Rage Padding"]             = 7,
    ["Rage Stroke"]              = {width=1,alpha=255,r=0,g=0,b=0},
    
    ["Ward Window X"]            = 0,
    ["Ward Window Y"]            = 0,
    ["Ward Font"]                = {size=9,font="lucida console",alpha=255,r=245,g=200,b=20},
    ["Ward Padding"]             = 7,
    ["Ward Stroke"]              = {width=1,alpha=255,r=0,g=0,b=0},
    
    -- Distance Display Settings.
    ["Distance Window X"]        = 0,
    ["Distance Window Y"]        = 0,
    ["Distance Font"]            = {size=9,font="lucida console",alpha=255,r=245,g=200,b=20},
    ["Distance Draggable"]       = false,
    ["Distance Padding"]         = 7,
    ["Distance Stroke"]          = {width=1,alpha=255,r=0,g=0,b=0},
    
    -- Targeting Helper Settings.
    ["Target Window X"]          = 725,
    ["Target Window Y"]          = (860 - 30),
    ["Target Font"]              = {size=9,font="lucida console",alpha=255,r=245,g=200,b=20},
    ["Target Draggable"]         = false,
    ["Target Padding"]           = 7,
    ["Target Stroke"]            = {width=1,alpha=255,r=0,g=0,b=0},
    
    -- Farmer Helper Settings.
    ["Search Distance"]          = 15,
    ["Search Delay"]             = 0,
    
    -- Queue Helper Settings.
    ["Queue Window X"]           = 500,
    ["Queue Window Y"]           = 65,
    ["Queue Max Visible"]        = 10,
    ["Queue Max Width"]          = 40,
    ["Queue Font"]               = "lucida console",
    ["Queue Font Size"]          = 8,
    ["Queue Draggable"]          = false,
    ["Queue Padding"]            = 3,
    
    -- Events Helper Settings.
    ["Events Window X"]          = 225,
    ["Events Window Y"]          = 740,
    ["Events Font"]              = "lucida console",
    ["Events Font Size"]         = 8,
    ["Events Draggable"]         = false,
    ["Events Padding"]           = 3,
    
    -- Currencies Helper Settings.
    ["Currencies Window X"]      = 0,
    ["Currencies Window Y"]      = 1065,
    ["Currencies Font"]          = {size=9,font='lucida console',alpha=255,r=0,g=235,b=255},
    ["Currencies Draggable"]     = false,
    ["Currencies Padding"]       = 2,
    ["Currencies Stroke"]        = {width=001,alpha=255,r=0,g=0,b=0},
    ["My Currencies"]            = {
        
        ["Sparks"]          = true, 
        ["Accolades"]       = true, 
        ["Ichor"]           = true, 
        ["Tokens"]          = true,
        ["Voidstones"]      = true,
        ["Bayld"]           = true,
        ["Zeni"]            = false,
        ["Plasm"]           = false, 
        ["Imps"]            = true, 
        ["Beads"]           = true, 
        ["Silt"]            = false,
        ["Potpourri"]       = true, 
        ["Hallmarks"]       = true, 
        ["Gallantry"]       = true, 
        ["Crafter"]         = true, 
        ["Silver Vouchers"] = false,
        ["Canteens"]        = true, 
        ["XP"]              = false, 
        ["CP"]              = false, 
        ["JP"]              = false,
        
    },
    
    -- Missions Helper Settings.
    ["Missions Window X"]        = 0,
    ["Missions Window Y"]        = 1,
    ["Missions Font"]            = {size=9,font='lucida console',alpha=255,r=245,g=200,b=20},
    ["Missions Draggable"]       = false,
    ["Missions Padding"]         = 2,
    ["Missions Stroke"]          = {width=1,alpha=255,r=0,g=0,b=0},
    ["My Missions"]              = {
        
        ["NATION"] = true,
        ["ROZ"]    = true,
        ["COP"]    = true,
        ["TOAU"]   = true,
        ["WOTG"]   = true,
        ["SOA"]    = true,
        ["ROV"]    = true,
        
    },
    
    -- Orders Helper Settings.
    ["Orders Delay"]            = 1,
    ["Orders Range"]            = 25,
    
    -- Distance Helper Settings
    ["Assist Range"]            = 15,
    
    -- Useable Goods.
    ["Use Items"]               = I{false,false},
    ["Skill Books"]             = I{true,true},
    ["Rock Cases"]              = I{false,true},
    ["Sparks Delay"]            = 1,
    
    -- list of useable items that will be used in town.
    ["My Items"]                = T{"Bead Pouch","Silt Pouch"},
    
    -- Job Tables.
    ["WAR"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Sanguine Threshold"]  = 50,
        ["Convert Threshold"]   = {hpp=35,mpp=15},
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["MNK"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Chakra Threshold"]    = 50,
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["WHM"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Moonlight Threshold"] = 50,
        ["Convert Threshold"]   = {hpp=35,mpp=15},
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["BLM"] = {
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Myrkr Threshold"]     = 50,
        ["Convert Threshold"]   = {hpp=35,mpp=15},
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["RDM"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Sanguine Threshold"]  = 50,
        ["Myrkr Threshold"]     = 45,
        ["Convert Threshold"]   = {hpp=35,mpp=15},
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    }, 
    ["THF"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Convert Threshold"]   = {hpp=35,mpp=15},
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["PLD"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Hate Delay"]          = 10,
        ["Hate Timer"]          = os.clock(),
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Chivalry Threshold"]  = 35,
        ["Sanguine Threshold"]  = 50,
        ["Convert Threshold"]   = {hpp=35,mpp=15},
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["DRK"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Sanguine Threshold"]  = 50,
        ["Convert Threshold"]   = {hpp=35,mpp=15},
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["BST"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Convert Threshold"]   = {hpp=35,mpp=15},
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["BRD"] = {
        ["Repeat Delay"]        = 205,
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Convert Threshold"]   = {hpp=35,mpp=15},
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["RNG"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Convert Threshold"]   = {hpp=35,mpp=15},
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["SAM"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["NIN"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Sanguine Threshold"]  = 50,
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["DRG"] = {
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["SMN"] = {
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Myrkr Threshold"]     = 40,
        ["Convert Threshold"]   = {hpp=35,mpp=15},
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["BLU"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Sanguine Threshold"]  = 50,
        ["Convert Threshold"]   = {hpp=35,mpp=15},
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["COR"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["PUP"] = {
        ["Repair Threshold"]    = 25,
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["DNC"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["SCH"] = {
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Myrkr Threshold"]     = 45,
        ["Convert Threshold"]   = {hpp=35,mpp=15},
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["GEO"] = {
        ["Drain Threshold"]     = 40,
        ["Aspir Threshold"]     = 65,
        ["Moonlight Threshold"] = 65,
        ["Convert Threshold"]   = {hpp=35,mpp=15},
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    ["RUN"] = {
        ["Steps Delay"]         = 30,
        ["Steps Timer"]         = os.clock(),
        ["Hate Delay"]          = 10,
        ["Hate Timer"]          = os.clock(),
        ["Sanguine Threshold"]  = 50,
        ["Buff Exclusion"]      = T{"Glassy Gorger","Yakshi"},
    },
    
    -- HUD Settings.
    ["BP Window Settings"] = {
        ['pos']={['x']=001,['y']=225},
        ['bg']={['alpha']=155,['red']=000,['green']=000,['blue']=000,['visible']=false},
        ['flags']={['right']=false,['bottom']=false,['bold']=false,['draggable']=true,['italic']=false},
        ['padding']=15,
        ['text']={['size']=10,['font']='lucida console',['fonts']={},['alpha']=255,['red']=245,['green']=200,['blue']=020,
        ['stroke']={['width']=001,['alpha']=255,['red']=0,['green']=0,['blue']=0},
        },
    },
    
}