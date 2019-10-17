_addon.name     = 'empytool'
_addon.author   = 'Elidyr'
_addon.version  = '1.10142019'
_addon.command  = 'etool'

-- Required libraries.
res         = require 'resources'
packets     = require 'packets'
files       = require 'files'
texts       = require 'texts'
              require 'strings'
              require 'actions'
              require 'tables'
              require 'sets'
              require 'chat'
              require 'pack'
              require 'logger'

last_ph      = os.clock()
last_zone    = os.clock()
last_respawn = os.clock()
trial_set    = false
timer        = 0
repsawn      = 0
ph_delay     = 0
zone_delay   = 0
last_spam    = 0
last_sound   = 0
last_update  = 0

empy_window = {}

local window_settings = {
    ['pos'] = {
        ['x'] = 100,
        ['y'] = 300,
    },
    ['bg'] = {
        ['alpha']   = 155,
        ['red']     = 000,
        ['green']   = 000,
        ['blue']    = 000,
        ['visible'] = true,
    },
    ['flags'] = {
        ['right']       = false,
        ['bottom']      = false,
        ['bold']        = false,
        ['draggable']   = true,
        ['italic']      = false,
    },
    ['padding'] = 10,
    ['text']    = {
        ['size']        = 10,
        ['font']        = 'lucida console',
        ['fonts']       = {},
        ['alpha']       = 255,
        ['red']         = 245,
        ['green']       = 200,
        ['blue']        = 020,
        ['stroke']      = {
            ['width']   = 001,
            ['alpha']   = 255,
            ['red']     = 0,
            ['green']   = 0,
            ['blue']    = 0,
        },
    },
}

-- Load Display.
empy_window = texts.new("", window_settings, window_settings)
empy_window:hide()

-- Load settings from file.
if windower.ffxi.get_player() then 
 
    player        = windower.ffxi.get_player()
    weapons_file  = files.new(player.name .. '_Weapons.lua')
        
        if not weapons_file:exists() then
            windower.add_to_chat(2,'Creating new empyrean weaponss data...')
            
            local weapons = {
                ["Current Weapon"] ="",
                ["Current Trial"]  = {},
                ["Current NM"]     = "",
                ["Chat Delay"]     = 5,
                ["Sound Delay"]    = 60,
                ["Update Delay"]   = 1.5,
                ["Chat Color"]     = 3,
                
                ["Verethragna"] =
                    {["Tumbling Truffle"]       = {["count"]=0,["max"]=3,["trial_weapon"]="Puglists",     ["number"]=68,    ["NM_id"]={"FB"},               ["PH_id"]={"F8"},                   ["PH_delay"]=300,           ["zone"]="La Theine Plateau"},
                    ["Helldiver"]               = {["count"]=0,["max"]=3,["trial_weapon"]="Simian Fists", ["number"]=69,    ["NM_id"]={"16B"},              ["PH_id"]={"16A"},                  ["PH_delay"]=300,           ["zone"]="Buburimu Peninsula"},
                    ["Orctrap"]                 = {["count"]=0,["max"]=3,["trial_weapon"]="Simian Fists", ["number"]=70,    ["NM_id"]={"10C"},              ["PH_id"]={"10B"},                  ["PH_delay"]=300,           ["zone"]="Carpenters' Landing"},
                    ["Intulo"]                  = {["count"]=0,["max"]=4,["trial_weapon"]="Simian Fists", ["number"]=71,    ["NM_id"]={"8E"},               ["PH_id"]={"8D"},                   ["PH_delay"]=300,           ["zone"]="Bibiki Bay"},
                    ["Ramponneau"]              = {["count"]=0,["max"]=4,["trial_weapon"]="Mantis",       ["number"]=72,    ["NM_id"]={"171"},              ["PH_id"]={"16D"},                  ["PH_delay"]=300,           ["zone"]="West Sarutabaruta [S]"},
                    ["Keeper of Halidom"]       = {["count"]=0,["max"]=4,["trial_weapon"]="Mantis",       ["number"]=73,    ["NM_id"]={"92"},               ["PH_id"]={"91"},                   ["PH_delay"]=300,           ["zone"]="The Sanctuary of Zi'Tah"},
                    ["Shoggoth"]                = {["count"]=0,["max"]=6,["trial_weapon"]="Mantis",       ["number"]=74,    ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Farruca Fly"]             = {["count"]=0,["max"]=6,["trial_weapon"]="Mantis",       ["number"]=75,    ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Chesma"]                  = {["count"]=0,["max"]=8,["trial_weapon"]="Mantis",       ["number"]=1138,  ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""}},
                                                
                ["Twashtar"] =                                                                  
                    {["Nocuous Weapon"]         = {["count"]=0,["max"]=3,["trial_weapon"]="Peeler",       ["number"]=2,     ["NM_id"]={"99"},               ["PH_id"]={"95","97"},              ["PH_delay"]=300,           ["zone"]="Inner Horutoto Ruins"},
                    ["Black Triple Stars"]      = {["count"]=0,["max"]=3,["trial_weapon"]="Renegade",     ["number"]=3,     ["NM_id"]={"D8"},               ["PH_id"]={"D4","C0"},              ["PH_delay"]=300,           ["zone"]="Rolanberry Fields"},
                    ["Serra"]                   = {["count"]=0,["max"]=3,["trial_weapon"]="Renegade",     ["number"]=4,     ["NM_id"]={"2E"},               ["PH_id"]={"2D"},                   ["PH_delay"]=300,           ["zone"]="Bibiki Bay"},
                    ["Bugbear Strongman"]       = {["count"]=0,["max"]=4,["trial_weapon"]="Renegade",     ["number"]=5,     ["NM_id"]={"97","9B"},          ["PH_id"]={"95","9A"},              ["PH_delay"]=0,             ["zone"]="Oldton Movalpolos"},
                    ["La Velue"]                = {["count"]=0,["max"]=4,["trial_weapon"]="Kartika",      ["number"]=6,     ["NM_id"]={"128"},              ["PH_id"]={"112"},                  ["PH_delay"]=300,           ["zone"]="Batallia Downs [S]"},
                    ["Hovering Hotpot"]         = {["count"]=0,["max"]=4,["trial_weapon"]="Kartika",      ["number"]=7,     ["NM_id"]={"D4"},               ["PH_id"]={"D2","D0"},              ["PH_delay"]=300,           ["zone"]="Garlaige Citadel"},
                    ["Yacumama"]                = {["count"]=0,["max"]=6,["trial_weapon"]="Kartika",      ["number"]=8,     ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Feuerunke"]               = {["count"]=0,["max"]=6,["trial_weapon"]="Kartika",      ["number"]=9,     ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Tammuz"]                  = {["count"]=0,["max"]=8,["trial_weapon"]="Kartika",      ["number"]=1092,  ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""}},
                                                    
                ["Almace"] =                                                                        
                    {["Serpopard Ishtar"]       = {["count"]=0,["max"]=3,["trial_weapon"]="Side-Sword",   ["number"]=150,   ["NM_id"]={"73","F2"},          ["PH_id"]={"70","EE"},              ["PH_delay"]=300,           ["zone"]="Tahrongi Canyon"},
                    ["Tottering Toby"]          = {["count"]=0,["max"]=3,["trial_weapon"]="Schiavona",    ["number"]=151,   ["NM_id"]={"B4"},               ["PH_id"]={"99"},                   ["PH_delay"]=300,           ["zone"]="Batallia Downs"},
                    ["Drooling Daisy"]          = {["count"]=0,["max"]=3,["trial_weapon"]="Schiavona",    ["number"]=152,   ["NM_id"]={"1CC"},              ["PH_id"]={"1CB"},                  ["PH_delay"]=300,           ["zone"]="Rolanberry Fields"},
                    ["Gargantua"]               = {["count"]=0,["max"]=4,["trial_weapon"]="Schiavona",    ["number"]=153,   ["NM_id"]={"CF"},               ["PH_id"]={"CE"},                   ["PH_delay"]=300,           ["zone"]="Beaucedine Glacier"},
                    ["Megalobugard"]            = {["count"]=0,["max"]=4,["trial_weapon"]="Nobilis",      ["number"]=154,   ["NM_id"]={"DD"},               ["PH_id"]={"BF","C8","DB"},         ["PH_delay"]=300,           ["zone"]="Lufaise Meadows"},
                    ["Ratatoskr"]               = {["count"]=0,["max"]=4,["trial_weapon"]="Nobilis",      ["number"]=155,   ["NM_id"]={},                   ["PH_id"]={"28"},                   ["PH_delay"]=300,           ["zone"]="Fort Karugo-Narugo [S]"},
                    ["Jyeshtha"]                = {["count"]=0,["max"]=6,["trial_weapon"]="Nobilis",      ["number"]=156,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Capricornus"]             = {["count"]=0,["max"]=6,["trial_weapon"]="Nobilis",      ["number"]=157,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Tammuz"]                  = {["count"]=0,["max"]=8,["trial_weapon"]="Nobilis",      ["number"]=1200,  ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""}},
                                        
                ["Caladbolg"] =                                                             
                    {["Bloodpool Vorax"]        = {["count"]=0,["max"]=3,["trial_weapon"]="Break Blade",  ["number"]=216,   ["NM_id"]={"153"},              ["PH_id"]={"14E"},                  ["PH_delay"]=300,           ["zone"]="Pashhow Marshlands"},
                    ["Golden Bat"]              = {["count"]=0,["max"]=3,["trial_weapon"]="Sunblade",     ["number"]=217,   ["NM_id"]={"1CC"},              ["PH_id"]={"1CB","1CA","1AB"},      ["PH_delay"]=300,           ["zone"]="Valkurm Dunes"},
                    ["Slippery Sucker"]         = {["count"]=0,["max"]=3,["trial_weapon"]="Sunblade",     ["number"]=218,   ["NM_id"]={"4D"},               ["PH_id"]={"40","41","42","44"},    ["PH_delay"]=300,           ["zone"]="Qufim Island"},
                    ["Seww the Squidlimbed"]    = {["count"]=0,["max"]=4,["trial_weapon"]="Sunblade",     ["number"]=219,   ["NM_id"]={"BD"},               ["PH_id"]={"BA"},                   ["PH_delay"]=300,           ["zone"]="Sea Serpent Grotto"},
                    ["Ankabut"]                 = {["count"]=0,["max"]=4,["trial_weapon"]="Albion",       ["number"]=220,   ["NM_id"]={"29"},               ["PH_id"]={"25"},                   ["PH_delay"]=300,           ["zone"]="North Gustaberg [S]"},
                    ["Okyupete"]                = {["count"]=0,["max"]=4,["trial_weapon"]="Albion",       ["number"]=221,   ["NM_id"]={"E7"},               ["PH_id"]={"DF"},                   ["PH_delay"]=300,           ["zone"]="Misareaux Coast"},
                    ["Urd"]                     = {["count"]=0,["max"]=6,["trial_weapon"]="Albion",       ["number"]=222,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Lamprey Lord"]            = {["count"]=0,["max"]=6,["trial_weapon"]="Albion",       ["number"]=223,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Chesma"]                  = {["count"]=0,["max"]=8,["trial_weapon"]="Albion",       ["number"]=1246,  ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""}},
                                                
                ["Farsha"] =                                                                    
                    {["Panzer Percival"]        = {["count"]=0,["max"]=3,["trial_weapon"]="Chopper",      ["number"]=282,   ["NM_id"]={"181","1BA"},        ["PH_id"]={"17D","1B5"},            ["PH_delay"]=300,           ["zone"]="Jugner Forest"},
                    ["Ge'Dha Evileye"]          = {["count"]=0,["max"]=3,["trial_weapon"]="Splinter",     ["number"]=283,   ["NM_id"]={"7A"},               ["PH_id"]={"77"},                   ["PH_delay"]=600,           ["zone"]="Beadeaux"},
                    ["Bashe"]                   = {["count"]=0,["max"]=3,["trial_weapon"]="Splinter",     ["number"]=284,   ["NM_id"]={"34"},               ["PH_id"]={"2E"},                   ["PH_delay"]=300,           ["zone"]="Sauromugue Champaign"},
                    ["Intulo"]                  = {["count"]=0,["max"]=4,["trial_weapon"]="Splinter",     ["number"]=285,   ["NM_id"]={"8E"},               ["PH_id"]={"8D"},                   ["PH_delay"]=300,           ["zone"]="Bibiki Bay"},
                    ["Ramponneau"]              = {["count"]=0,["max"]=4,["trial_weapon"]="Bonebiter",    ["number"]=286,   ["NM_id"]={"171"},              ["PH_id"]={"16D"},                  ["PH_delay"]=300,           ["zone"]="West Sarutabaruta [S]"},
                    ["Keeper of Halidom"]       = {["count"]=0,["max"]=4,["trial_weapon"]="Bonebiter",    ["number"]=287,   ["NM_id"]={"92"},               ["PH_id"]={"91"},                   ["PH_delay"]=300,           ["zone"]="The Sanctuary of Zi'Tah"},
                    ["Shoggoth"]                = {["count"]=0,["max"]=6,["trial_weapon"]="Bonebiter",    ["number"]=288,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Farruca Fly"]             = {["count"]=0,["max"]=6,["trial_weapon"]="Bonebiter",    ["number"]=289,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Tammuz"]                  = {["count"]=0,["max"]=8,["trial_weapon"]="Bonebiter",    ["number"]=1292,  ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""}},
                                
                ["Ukonvasara"] =                                                                    
                    {["Hoo Mjuu the Torrent"]   = {["count"]=0,["max"]=3,["trial_weapon"]="Lumberjack",   ["number"]=364,   ["NM_id"]={"17B"},              ["PH_id"]={"179"},                  ["PH_delay"]=480,           ["zone"]="Giddeus"},
                    ["Daggerclaw Dracos"]       = {["count"]=0,["max"]=3,["trial_weapon"]="Sagaris",      ["number"]=365,   ["NM_id"]={"B2"},               ["PH_id"]={"AF"},                   ["PH_delay"]=300,           ["zone"]="Meriphataud Mountains"},
                    ["Namtar"]                  = {["count"]=0,["max"]=3,["trial_weapon"]="Sagaris",      ["number"]=366,   ["NM_id"]={"48"},               ["PH_id"]={"42","47"},              ["PH_delay"]=300,           ["zone"]="Sea Serpent Grotto"},
                    ["Gargantua"]               = {["count"]=0,["max"]=4,["trial_weapon"]="Sagaris",      ["number"]=367,   ["NM_id"]={"CF"},               ["PH_id"]={"CE"},                   ["PH_delay"]=300,           ["zone"]="Beaucedine Glacier"},
                    ["Megalobugard"]            = {["count"]=0,["max"]=4,["trial_weapon"]="Bonesplitter", ["number"]=368,   ["NM_id"]={"DD"},               ["PH_id"]={"BF","C8","DB"},         ["PH_delay"]=300,           ["zone"]="Lufaise Meadows"},
                    ["Ratatoskr"]               = {["count"]=0,["max"]=4,["trial_weapon"]="Bonesplitter", ["number"]=369,   ["NM_id"]={"2B"},               ["PH_id"]={"28"},                   ["PH_delay"]=300,           ["zone"]="Fort Karugo-Narugo [S]"},
                    ["Jyeshtha"]                = {["count"]=0,["max"]=6,["trial_weapon"]="Bonesplitter", ["number"]=370,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Capricornus"]             = {["count"]=0,["max"]=6,["trial_weapon"]="Bonesplitter", ["number"]=371,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Chesma"]                  = {["count"]=0,["max"]=8,["trial_weapon"]="Bonesplitter", ["number"]=1354,  ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""}},
                    
                ["Redemption"] =                                                            
                    {["Barbastelle"]            = {["count"]=0,["max"]=3,["trial_weapon"]="Farmhand",     ["number"]=512,   ["NM_id"]={"109"},              ["PH_id"]={},                       ["PH_delay"]=0,             ["zone"]="King Ranperre's Tomb"},
                    ["Ah Puch"]                 = {["count"]=0,["max"]=3,["trial_weapon"]="Stigma",       ["number"]=513,   ["NM_id"]={"3F"},               ["PH_id"]={"58"},                   ["PH_delay"]=300,           ["zone"]="Outer Horutoto Ruins"},
                    ["Donggu"]                  = {["count"]=0,["max"]=3,["trial_weapon"]="Stigma",       ["number"]=514,   ["NM_id"]={"39"},               ["PH_id"]={"35"},                   ["PH_delay"]=300,           ["zone"]="Ordelle's Caves"},
                    ["Bugbear Strongman"]       = {["count"]=0,["max"]=4,["trial_weapon"]="Stigma",       ["number"]=515,   ["NM_id"]={"97","9B"},          ["PH_id"]={"95","9A"},              ["PH_delay"]=0,             ["zone"]="Oldton Movalpolos"},
                    ["La Velue"]                = {["count"]=0,["max"]=4,["trial_weapon"]="Ultimatum",    ["number"]=516,   ["NM_id"]={"128"},              ["PH_id"]={"112"},                  ["PH_delay"]=300,           ["zone"]="Batallia Downs [S]"},
                    ["Hovering Hotpot"]         = {["count"]=0,["max"]=4,["trial_weapon"]="Ultimatum",    ["number"]=517,   ["NM_id"]={"D4"},               ["PH_id"]={"D2","D0"},              ["PH_delay"]=300,           ["zone"]="Garlaige Citadel"},
                    ["Yacumama"]                = {["count"]=0,["max"]=6,["trial_weapon"]="Ultimatum",    ["number"]=518,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Feuerunke"]               = {["count"]=0,["max"]=6,["trial_weapon"]="Ultimatum",    ["number"]=519,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Tammuz"]                  = {["count"]=0,["max"]=8,["trial_weapon"]="Ultimatum",    ["number"]=1462,  ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""}},
                                        
                ["Rhongomiant"] =                                                                           
                    {["Slendlix Spindlethumb"]  = {["count"]=0,["max"]=3,["trial_weapon"]="Ranseur",      ["number"]=430,   ["NM_id"]={"89"},               ["PH_id"]={"87","6E"},              ["PH_delay"]=300,           ["zone"]="Inner Horutoto Ruins"},
                    ["Herbage Hunter"]          = {["count"]=0,["max"]=3,["trial_weapon"]="Copperhead",   ["number"]=431,   ["NM_id"]={"184"},              ["PH_id"]={"183"},                  ["PH_delay"]=300,           ["zone"]="Tahrongi Canyon"},
                    ["Kirata"]                  = {["count"]=0,["max"]=3,["trial_weapon"]="Copperhead",   ["number"]=432,   ["NM_id"]={"AC"},               ["PH_id"]={"AB"},                   ["PH_delay"]=300,           ["zone"]="Beaucedine Glacier"},
                    ["Intulo"]                  = {["count"]=0,["max"]=4,["trial_weapon"]="Copperhead",   ["number"]=433,   ["NM_id"]={"8E"},               ["PH_id"]={"8D"},                   ["PH_delay"]=300,           ["zone"]="Bibiki Bay"},
                    ["Ramponneau"]              = {["count"]=0,["max"]=4,["trial_weapon"]="Oathkeeper",   ["number"]=434,   ["NM_id"]={"171"},              ["PH_id"]={"16D"},                  ["PH_delay"]=300,           ["zone"]="West Sarutabaruta [S]"},
                    ["Keeper of Halidom"]       = {["count"]=0,["max"]=4,["trial_weapon"]="Oathkeeper",   ["number"]=435,   ["NM_id"]={"92"},               ["PH_id"]={"91"},                   ["PH_delay"]=300,           ["zone"]="The Sanctuary of Zi'Tah"},
                    ["Shoggoth"]                = {["count"]=0,["max"]=6,["trial_weapon"]="Oathkeeper",   ["number"]=436,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Farruca Fly"]             = {["count"]=0,["max"]=6,["trial_weapon"]="Oathkeeper",   ["number"]=437,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Chesma"]                  = {["count"]=0,["max"]=8,["trial_weapon"]="Oathkeeper",   ["number"]=1400,  ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""}},
                                            
                ["Kannagi"] =                                                                               
                    {["Zi'Ghi Boneeater"]       = {["count"]=0,["max"]=3,["trial_weapon"]="Kibashiri",    ["number"]=578,   ["NM_id"]={"108"},              ["PH_id"]={"105"},                  ["PH_delay"]=480,           ["zone"]="Palborough Mines"},
                    ["Lumbering Lambert"]       = {["count"]=0,["max"]=3,["trial_weapon"]="Koruri",       ["number"]=579,   ["NM_id"]={"135"},              ["PH_id"]={"134"},                  ["PH_delay"]=300,           ["zone"]="La Theine Plateau"},
                    ["Deadly Dodo"]             = {["count"]=0,["max"]=3,["trial_weapon"]="Koruri",       ["number"]=580,   ["NM_id"]={"73"},               ["PH_id"]={"71","72"},              ["PH_delay"]=300,           ["zone"]="Sauromugue Champaign"},
                    ["Gargantua"]               = {["count"]=0,["max"]=4,["trial_weapon"]="Koruri",       ["number"]=581,   ["NM_id"]={"CF"},               ["PH_id"]={"CE"},                   ["PH_delay"]=300,           ["zone"]="Beaucedine Glacier"},
                    ["Megalobugard"]            = {["count"]=0,["max"]=4,["trial_weapon"]="Mozu",         ["number"]=582,   ["NM_id"]={"DD"},               ["PH_id"]={"BF","C8","DB"},         ["PH_delay"]=300,           ["zone"]="Lufaise Meadows"},
                    ["Ratatoskr"]               = {["count"]=0,["max"]=4,["trial_weapon"]="Mozu",         ["number"]=583,   ["NM_id"]={"2B"},               ["PH_id"]={"28"},                   ["PH_delay"]=300,           ["zone"]="Fort Karugo-Narugo [S]"},
                    ["Jyeshtha"]                = {["count"]=0,["max"]=6,["trial_weapon"]="Mozu",         ["number"]=584,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Capricornus"]             = {["count"]=0,["max"]=6,["trial_weapon"]="Mozu",         ["number"]=585,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Tammuz"]                  = {["count"]=0,["max"]=8,["trial_weapon"]="Mozu",         ["number"]=1508,  ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""}},
                                                                
                ["Masamune"] =                                                                                  
                    {["Vuu Puqu the Beguller"]  = {["count"]=0,["max"]=3,["trial_weapon"]="Donto",        ["number"]=644,   ["NM_id"]={"1BA"},              ["PH_id"]={"1B9"},                  ["PH_delay"]=480,           ["zone"]="Giddeus"},
                    ["Buburimboo"]              = {["count"]=0,["max"]=3,["trial_weapon"]="Shirodachi",   ["number"]=645,   ["NM_id"]={"1CB"},              ["PH_id"]={"1CA"},                  ["PH_delay"]=300,           ["zone"]="Buburimu Peninsula"},
                    ["Zo'Khu Blackcloud"]       = {["count"]=0,["max"]=3,["trial_weapon"]="Shirodachi",   ["number"]=646,   ["NM_id"]={"EC"},               ["PH_id"]={"EA"},                   ["PH_delay"]=720,           ["zone"]="Beadeaux"},
                    ["Seww the Squidlimbed"]    = {["count"]=0,["max"]=4,["trial_weapon"]="Shirodachi",   ["number"]=647,   ["NM_id"]={"BD"},               ["PH_id"]={"BA"},                   ["PH_delay"]=300,           ["zone"]="Sea Serpent Grotto"},
                    ["Ankabut"]                 = {["count"]=0,["max"]=4,["trial_weapon"]="Radennotachi", ["number"]=648,   ["NM_id"]={"29"},               ["PH_id"]={"25"},                   ["PH_delay"]=300,           ["zone"]="North Gustaberg [S]"},
                    ["Okyupete"]                = {["count"]=0,["max"]=4,["trial_weapon"]="Radennotachi", ["number"]=649,   ["NM_id"]={"E7"},               ["PH_id"]={"DF"},                   ["PH_delay"]=300,           ["zone"]="Misareaux Coast"},
                    ["Urd"]                     = {["count"]=0,["max"]=6,["trial_weapon"]="Radennotachi", ["number"]=650,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Lamprey Lord"]            = {["count"]=0,["max"]=6,["trial_weapon"]="Radennotachi", ["number"]=651,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Chesma"]                  = {["count"]=0,["max"]=8,["trial_weapon"]="Radennotachi", ["number"]=1554,  ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""}},
                                                        
                ["Gambanteinn"] =                                                                                       
                    {["Stray Mary"]             = {["count"]=0,["max"]=3,["trial_weapon"]="Stenz",        ["number"]=710,   ["NM_id"]={"D3","15D"},         ["PH_id"]={"158","CF"},             ["PH_delay"]=300,           ["zone"]="Konschtat Highlands"},
                    ["Hawkeyed Dnatbat"]        = {["count"]=0,["max"]=3,["trial_weapon"]="Rageblow",     ["number"]=711,   ["NM_id"]={"2F"},               ["PH_id"]={"26","28","2B"},         ["PH_delay"]=0,             ["zone"]="Davoi"},
                    ["Dune Widow"]              = {["count"]=0,["max"]=3,["trial_weapon"]="Rageblow",     ["number"]=712,   ["NM_id"]={"EC"},               ["PH_id"]={"EB"},                   ["PH_delay"]=300,           ["zone"]="Eastern Altepa Desert"},
                    ["Seww the Squidlimbed"]    = {["count"]=0,["max"]=4,["trial_weapon"]="Rageblow",     ["number"]=713,   ["NM_id"]={"BD"},               ["PH_id"]={"BA"},                   ["PH_delay"]=300,           ["zone"]="Sea Serpent Grotto"},
                    ["Ankabut"]                 = {["count"]=0,["max"]=4,["trial_weapon"]="Culacula",     ["number"]=714,   ["NM_id"]={"29"},               ["PH_id"]={"25"},                   ["PH_delay"]=300,           ["zone"]="North Gustaberg [S]"},
                    ["Okyupete"]                = {["count"]=0,["max"]=4,["trial_weapon"]="Culacula",     ["number"]=715,   ["NM_id"]={"E7"},               ["PH_id"]={"DF"},                   ["PH_delay"]=300,           ["zone"]="Misareaux Coast"},
                    ["Urd"]                     = {["count"]=0,["max"]=6,["trial_weapon"]="Culacula",     ["number"]=716,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Lamprey Lord"]            = {["count"]=0,["max"]=6,["trial_weapon"]="Culacula",     ["number"]=717,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Tammuz"]                  = {["count"]=0,["max"]=8,["trial_weapon"]="Culacula",     ["number"]=1600,  ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""}},
                                                        
                ["Hverglmir"] =                                                                                         
                    {["Teporingo"]              = {["count"]=0,["max"]=3,["trial_weapon"]="Crook",        ["number"]=776,   ["NM_id"]={"20"},               ["PH_id"]={"1F"},                   ["PH_delay"]=300,           ["zone"]="Dangruf Wadi"},
                    ["Valkurm Emperor"]         = {["count"]=0,["max"]=3,["trial_weapon"]="Shillelagh",   ["number"]=777,   ["NM_id"]={"14E"},              ["PH_id"]={"14A"},                  ["PH_delay"]=300,           ["zone"]="Valkurm Dunes"},
                    ["Hyakume"]                 = {["count"]=0,["max"]=3,["trial_weapon"]="Shillelagh",   ["number"]=778,   ["NM_id"]={"54"},               ["PH_id"]={"4D"},                   ["PH_delay"]=300,           ["zone"]="Ranguemont Pass"},
                    ["Gloomanita"]              = {["count"]=0,["max"]=4,["trial_weapon"]="Shillelagh",   ["number"]=779,   ["NM_id"]={"9D"},               ["PH_id"]={"9C"},                   ["PH_delay"]=300,           ["zone"]="North Gustaberg [S]"},
                    ["Mischievous Micholas"]    = {["count"]=0,["max"]=4,["trial_weapon"]="Slaine",       ["number"]=780,   ["NM_id"]={"7D"},               ["PH_id"]={"7C"},                   ["PH_delay"]=300,           ["zone"]="Yuhtunga Jungle"},
                    ["Cactuar Cantautor"]       = {["count"]=0,["max"]=4,["trial_weapon"]="Slaine",       ["number"]=781,   ["NM_id"]={"158"},              ["PH_id"]={"156","157"},            ["PH_delay"]=300,           ["zone"]="Western Altepa Desert"},
                    ["Erebus"]                  = {["count"]=0,["max"]=6,["trial_weapon"]="Slaine",       ["number"]=782,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Skuld"]                   = {["count"]=0,["max"]=6,["trial_weapon"]="Slaine",       ["number"]=783,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Chesma"]                  = {["count"]=0,["max"]=8,["trial_weapon"]="Slaine",       ["number"]=1646,  ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""}},
                                            
                ["Gandiva"] =                                                                           
                    {["Be'Hya Hundredwall"]     = {["count"]=0,["max"]=3,["trial_weapon"]="Sparrow",      ["number"]=941,   ["NM_id"]={"13A"},              ["PH_id"]={"138","139"},            ["PH_delay"]=600,           ["zone"]="Palborough Mines"},
                    ["Jolly Green"]             = {["count"]=0,["max"]=3,["trial_weapon"]="Kestrel",      ["number"]=942,   ["NM_id"]={"D1"},               ["PH_id"]={"D0"},                   ["PH_delay"]=300,           ["zone"]="Pashhow Marshlands"},
                    ["Trembler Tabitha"]        = {["count"]=0,["max"]=3,["trial_weapon"]="Kestrel",      ["number"]=943,   ["NM_id"]={"36"},               ["PH_id"]={"FB"},                   ["PH_delay"]=300,           ["zone"]="Maze of Shakhrami"},
                    ["Seww the Squidlimbed"]    = {["count"]=0,["max"]=4,["trial_weapon"]="Kestrel",      ["number"]=944,   ["NM_id"]={"BD"},               ["PH_id"]={"BA"},                   ["PH_delay"]=300,           ["zone"]="Sea Serpent Grotto"},
                    ["Ankabut"]                 = {["count"]=0,["max"]=4,["trial_weapon"]="Astrild",      ["number"]=945,   ["NM_id"]={"29"},               ["PH_id"]={"25"},                   ["PH_delay"]=300,           ["zone"]="North Gustaberg [S]"},
                    ["Okyupete"]                = {["count"]=0,["max"]=4,["trial_weapon"]="Astrild",      ["number"]=946,   ["NM_id"]={"E7"},               ["PH_id"]={"DF"},                   ["PH_delay"]=300,           ["zone"]="Misareaux Coast"},
                    ["Urd"]                     = {["count"]=0,["max"]=6,["trial_weapon"]="Astrild",      ["number"]=947,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Lamprey Lord"]            = {["count"]=0,["max"]=6,["trial_weapon"]="Astrild",      ["number"]=948,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Chesma"]                  = {["count"]=0,["max"]=8,["trial_weapon"]="Astrild",      ["number"]=1788,  ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""}},
                                            
                ["Armageddon"] =                                                                            
                    {["Desmodont"]              = {["count"]=0,["max"]=3,["trial_weapon"]="Thunderstick", ["number"]=891,   ["NM_id"]={"1E"},               ["PH_id"]={"1C"},                   ["PH_delay"]=300,           ["zone"]="Outer Horutoto Ruins"},
                    ["Moo Ouzi the Swiftblade"] = {["count"]=0,["max"]=3,["trial_weapon"]="Blue Steel",   ["number"]=892,   ["NM_id"]={"68"},               ["PH_id"]={"65"},                   ["PH_delay"]=600,           ["zone"]="Castle Oztroja"},
                    ["Ni'Zho Bladebender"]      = {["count"]=0,["max"]=3,["trial_weapon"]="Blue Steel",   ["number"]=893,   ["NM_id"]={"117"},              ["PH_id"]={"6D","3C"},              ["PH_delay"]=300,           ["zone"]="Pashhow Marshlands"},
                    ["Bugbear Strongman"]       = {["count"]=0,["max"]=4,["trial_weapon"]="Blue Steel",   ["number"]=894,   ["NM_id"]={"97","9B"},          ["PH_id"]={"95","9A"},              ["PH_delay"]=0,             ["zone"]="Oldton Movalpolos"},
                    ["La Velue"]                = {["count"]=0,["max"]=4,["trial_weapon"]="Magnatus",     ["number"]=895,   ["NM_id"]={"128"},              ["PH_id"]={"112"},                  ["PH_delay"]=300,           ["zone"]="Batallia Downs (S)"},
                    ["Hovering Hotpot"]         = {["count"]=0,["max"]=4,["trial_weapon"]="Magnatus",     ["number"]=896,   ["NM_id"]={"D4"},               ["PH_id"]={"D2","D0"},              ["PH_delay"]=300,           ["zone"]="Garlaige Citadel"},
                    ["Yacumama"]                = {["count"]=0,["max"]=6,["trial_weapon"]="Magnatus",     ["number"]=897,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Feuerunke"]               = {["count"]=0,["max"]=6,["trial_weapon"]="Magnatus",     ["number"]=898,   ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""},
                    ["Tammuz"]                  = {["count"]=0,["max"]=8,["trial_weapon"]="Magnatus",     ["number"]=1758,  ["NM_id"]={0},                  ["PH_id"]={0},                      ["PH_delay"]=0,             ["zone"]=""}},
                
            }
            
            weapons_file:write('return ' .. T(weapons):tovstring())
        
        end
    
    -- Set the resource variable.
    weapons = require(player.name .. '_Weapons')


end

--------------------------------------------------------------------------------
-- Command Handler.
--------------------------------------------------------------------------------
function handle_command(command, ...)
    
    local cmd       = (command) and (command):lower()
    local args      = {...}
    
    if cmd then
        
        if cmd == "reload" or cmd == "r" then
            windower.send_command('lua reload empytool')
            
        elseif cmd == "show" then
            empy_window:show()
            
        elseif cmd == "hide" then
            empy_window:hide()
            
        elseif cmd == "test" then
            
            
        end
    
    else
        error("Unknown command.")
    
    end

end

windower.register_event('addon command', handle_command)

--------------------------------------------------------------------------------
-- Time Change Handler.
--------------------------------------------------------------------------------
windower.register_event('prerender', function()
    
    local clock = os.clock()
    local zone  = res.zones[windower.ffxi.get_info().zone]
    local inventory  = windower.ffxi.get_items()
    local equipment  = inventory['equipment']
    local wep_id     = windower.ffxi.get_items(equipment[string.format('%s_bag', 'main')], equipment['main']).id
    local wep_name   = res.items[wep_id].name
    
    if zone then
        
        local clock_update = os.clock()
        respawn            = round((clock_update-last_respawn)/60,2)
        
        if next(weapons["Current Trial"]) ~= nil and getTrialCurrentZone(weapons["Current Trial"]) == zone.name and clock-last_update > weapons["Update Delay"] + zone_delay then
            
            local ph_ids    = weapons["Current Trial"].PH_id
            local nm_ids    = weapons["Current Trial"].NM_id
            local p
            
            -- Reset zone delay.
            zone_delay = 0
            
            -- Scan for Notorius Monsters.
            for i,v in pairs(nm_ids) do
                local index = hexString2number(v)
                
                if (v ~= nil or v ~= "") then
                    p = packets.new('outgoing', 0x016, {
                        ['Target Index'] = index})
                    
                    packets.inject(p)
                end
                
            end
            
            -- Scan for Placeholders.
            for i,v in pairs(ph_ids) do
                local index = hexString2number(v)
                
                if (v ~= nil or v ~= "") then
                    p = packets.new('outgoing', 0x016, {
                        ['Target Index'] = index})
                    
                    packets.inject(p)
                end
                
            end
            last_update = os.clock()
        
        end
       
    end
    
end)

--------------------------------------------------------------------------------
-- Incoming Chunck Handler.
--------------------------------------------------------------------------------
windower.register_event("incoming chunk", function(id, data)

    local clock = os.clock()
    local zone  = res.zones[windower.ffxi.get_info().zone]

    if id == 0x029 and windower.ffxi.get_player() and next(weapons["Current Trial"]) ~= nil then
        
        local packet = packets.parse('incoming', data)
        local player = windower.ffxi.get_player()
        local actor  = windower.ffxi.get_mob_by_id(packet['Actor'])
        local mob    = windower.ffxi.get_mob_by_id(packet['Target'])
        local ph_ids = weapons["Current Trial"].PH_id
        local nm_ids = weapons["Current Trial"].NM_id
        local msg    = packet['Message']
        
        
        if player and actor and mob then
            
            -- Trial update.
            if (player.id == packet['Actor'] or actor.in_party == true) and mob and msg == 583 then
                
                local inventory = windower.ffxi.get_items()
                local equipment = inventory['equipment']
                local wep_id    = windower.ffxi.get_items(equipment[string.format('%s_bag', 'main')], equipment['main']).id
                local wep_name  = res.items[wep_id].name
                
                if nm_ids[1] then
                    
                    for i,v in pairs(nm_ids) do
                        print("Trial Update! - 583")
                        if v:upper() == num2hex(mob.index):upper() then
                            print(v)
                            local current_count = getTrialCount(weapons)
                            local current_max   = getTrialCountMax(weapons)
                            local current_weapon = getTrialWeapon(weapons)
                            
                            if current_count < current_max and current_weapon == wep_name then
                                
                                local updated_count = current_count + 1
                                local remaining     = current_max - current_count
                                
                                -- Update trial data.
                                updateCount(weapons, updated_count)
                                
                                -- Update the display.
                                updateDisplay(empy_window, weapons, "Trial [ " .. tostring(weapons["Current Trial"].number) .. " ] has " .. remaining .. " kills.")
                                empy_window:show()                                
                                
                            else
                                windower.add_to_chat(weapons["Chat Color"], "Make sure that you have not completed this trial already, or that you have the correct weapon equipped.")
                                
                            end
                            
                        end
                    
                    end
                
                end
                
            -- Trial complete.
            elseif (player.id == packet['Actor'] or actor.in_party == true) and mob and msg == 584 then
                
                local inventory = windower.ffxi.get_items()
                local equipment = inventory['equipment']
                local wep_id    = windower.ffxi.get_items(equipment[string.format('%s_bag', 'main')], equipment['main']).id
                local wep_name  = res.items[wep_id].name
                
                if nm_ids[1] then
                    
                    for i,v in pairs(nm_ids) do
                        print("Trial Complete! - 584")
                        if v:upper() == num2hex(mob.index):upper() then
                            print(v)
                            local current_count = getTrialCount(weapons)
                            local current_max   = getTrialCountMax(weapons)
                            local current_weapon = getTrialWeapon(weapons)
                            
                            if current_count == current_max and current_weapon == wep_name then
                                
                                local updated_count = current_count + 1
                                local remaining     = current_max - current_count
                                
                                -- Update trial data.
                                updateCount(weapons, updated_count)
                                
                                -- Update display.
                                updateDisplay(empy_window, weapons, "Trial completed!")
                                empy_window:show()
                                
                            else
                                windower.add_to_chat(weapons["Chat Color"], "Make sure that you have not completed this trial already, or that you have the correct weapon equipped.")
                            end
                            
                        end
                    
                    end
                
                end
            
            elseif (player.id == packet['Actor'] or actor.in_party == true) and mob and msg == 6 then
                
                local inventory = windower.ffxi.get_items()
                local equipment = inventory['equipment']
                local wep_id    = windower.ffxi.get_items(equipment[string.format('%s_bag', 'main')], equipment['main']).id
                local wep_name  = res.items[wep_id].name
                
                for i,v in pairs(ph_ids) do
                    
                    if v:upper() == num2hex(mob.index):upper() then
                        ph_delay = ph_delay + weapons["Current Trial"].PH_delay - 1
                        last_ph  = os.clock()
                        timer    = tostring(math.round(ph_delay/60))
                        windower.add_to_chat(weapons["Chat Color"]+2, "Placeholder [" .. v .. "] defeated, next placeholder spawn in about: '" .. tostring(math.round(ph_delay/60)) .. "'~ minutes.")
                        last_respawn = os.clock()
                        found = false
                        
                        -- Update the display.
                        updateDisplay(empy_window, weapons, "Waiting for respawn...")
                        empy_window:show()
                    end
                    
                end
                
                for i,v in pairs(nm_ids) do
                    
                    if v:upper() == num2hex(mob.index):upper() then
                        
                        ph_delay = ph_delay + weapons["Current Trial"].PH_delay - 1
                        last_ph  = os.clock()
                        timer    = tostring(math.round(ph_delay/60))
                        windower.add_to_chat(weapons["Chat Color"]+2, "NM [" .. v .. "] defeated, next placeholder spawn in about: '" .. tostring(math.round(ph_delay/60)) .. "'~ minutes.")
                        last_respawn = os.clock()
                        found = false
                        
                        -- Update the display.
                        updateDisplay(empy_window, weapons, "Waiting for respawn...")
                        empy_window:show()
                    end
                    
                end
                
            end
        
        end
        
    elseif id == 0x0E and next(weapons["Current Trial"]) ~= nil and weapons["Current NM"] ~= "" and type(weapons["Current Trial"]) == "table" and windower.ffxi.get_player() and getTrialCurrentZone(weapons["Current Trial"]) == zone.name then
        
        if clock-last_ph > ph_delay then
        
            local packet     = packets.parse('incoming', data)
            local mob_index  = packet["Index"]
            local mob_status = packet["Status"]
            local mob_life   = packet["HP %"]
            local ph_ids     = weapons["Current Trial"].PH_id
            local nm_ids     = weapons["Current Trial"].NM_id
            local inventory  = windower.ffxi.get_items()
            local equipment  = inventory['equipment']
            local wep_id     = windower.ffxi.get_items(equipment[string.format('%s_bag', 'main')], equipment['main']).id
            local wep_name   = res.items[wep_id].name
                ph_delay   = 0
            
            for i,v in pairs(nm_ids) do
                
                if v:upper() == num2hex(mob_index):upper() and mob_life > 50 then
                    
                    local mob_id = packet["NPC"]
                    
                    if mob_id ~= nil then
                    
                        local mob      = windower.ffxi.get_mob_by_id(mob_id)
                        local distance = math.sqrt(mob.distance)
                        
                        if mob and mob.valid_target == true and mob.hpp ~= 0 and mob.status ~= 1 and clock-last_spam > weapons["Chat Delay"] then
                            
                            if fileExists(player.name .. "_NM") and clock-last_sound > weapons["Sound Delay"] then
                                playSound(player.name .. "_NM")
                                last_sound = os.clock()
                            end
                            
                            -- Update the display.
                            updateDisplay(empy_window, weapons, "\\cs(190,240,225)NM [" .. v .. "] Popped! Distance: " .. math.ceil(distance) .. "~\\cr")
                            empy_window:show()
                            last_spam = os.clock()
                            
                        elseif clock-last_spam > weapons["Chat Delay"] and mob_life > 99 then
                            
                            -- Update the display.
                            updateDisplay(empy_window, weapons, "\\cs(190,240,225)NM [" .. v .. "] Popped out of range!\\cr")
                            empy_window:show()
                            last_spam = os.clock()
                            
                        end
                        
                    end
                
                end
            
            end
            
            for i,v in pairs(ph_ids) do
                
                if v:upper() == num2hex(mob_index):upper() and mob_life > 50 then
                    
                    local mob_id   = packet["NPC"]
                    
                    if mob_id ~= nil then
                        
                        local mob      = windower.ffxi.get_mob_by_id(mob_id)
                        local distance = math.sqrt(mob.distance)
                        
                        if mob and mob.valid_target == true and mob.hpp ~= 0 and mob.status ~= 1 and clock-last_spam > weapons["Chat Delay"] then
                        
                            if fileExists(player.name .. "_PH") and clock-last_sound > weapons["Sound Delay"] then
                                playSound(player.name .. "_PH")
                                last_sound = os.clock()
                            end
                            
                            -- Update the display.
                            updateDisplay(empy_window, weapons, "\\cs(190,240,225)PH [" .. v .. "] Popped! Distance: " .. math.ceil(distance) .. "~\\cr")
                            empy_window:show()
                            last_spam = os.clock()
                            
                        elseif clock-last_spam > weapons["Chat Delay"] and mob_life > 99 then
                            
                            -- Update the display.
                            updateDisplay(empy_window, weapons, "\\cs(190,240,225)PH [" .. v .. "] Popped out of range!\\cr")
                            empy_window:show()
                            last_spam = os.clock()
                            
                        end
                        
                    end
                
                end
            
            end
            
        else
            
            updateDisplay(empy_window, weapons, "Waiting for respawn...")
            empy_window:show()
            
        end
        
    elseif id == 0x050 then
        
        local packet = packets.parse('incoming', data)
        
        if packet["Equipment Slot"] == 0 then
            
            local inventory  = windower.ffxi.get_items()
            local equipment  = inventory['equipment']
            local wep_id     = windower.ffxi.get_items(equipment[string.format('%s_bag', 'main')], equipment['main']).id
            local wep_name   = res.items[wep_id].name
            
            if wep_name == "Gil" then
                weapons["Current Trial"] = {}
                
                -- Update the display.
                updateDisplay(empy_window, weapons, "")
                empy_window:hide()
                updateEmpyData(weapons)
                
            else
                updateTrial(weapons, wep_name)
                updateDisplay(empy_window, weapons, "Waiting for respawn...")
                empy_window:show()
                
            end
            
        end            
    
    end
    
end)

-- Zone Change Handler.
windower.register_event('zone change', function(new, old)
    
    if new then
        zone_delay = 10
        
    end
    
end)

-- Get the Empyrean weapon name.
-- return string
function getEmpyreanName(weapons_table, emp_name)
    
    local empyrean
    
    for i,v in pairs(weapons_table) do
        
        if emp_name:lower() == i:lower() then
            empyrean = i
            return empyrean
        end
        
    end
    return false

end

-- Get the trial number based on empyrean weapon.
-- return string
function getTrialMonsterName(empyrean, trial_num)
    
    local name
    
    for i,v in pairs(empyrean) do
        
        if type(v) == "table" then
            
            for ii,vv in pairs(v) do
                
                if ii == "number" and vv == tonumber(trial_num) then
                    return i
                end
                
            end
        
        end
        
    end
    return false    

end

-- Get the name of the zone for the current trial.
-- return string
function getTrialCurrentZone(current_trial)
    
    if current_trial then
        return current_trial["zone"]
    end
    return false

end

function getTrialCount(weapons_table)
    local count = weapons_table[weapons_table["Current Weapon"]][weapons_table["Current NM"]].count
    return count

end

function getTrialCountMax(weapons_table)
    local count = weapons_table[weapons_table["Current Weapon"]][weapons_table["Current NM"]].max
    return count

end

function getTrialWeapon(weapons_table)
    local count = weapons_table[weapons_table["Current Weapon"]][weapons_table["Current NM"]].trial_weapon
    return count

end

function updateTrial(weapons_table, weapon_name)
    
    local zone = res.zones[windower.ffxi.get_info().zone]
    
    for i,v in pairs (weapons_table) do
        
        if type(v) == "table" then
            
            for ii,vv in pairs(v) do
                
                if type(vv) == "table" then
                    
                    if vv["trial_weapon"] == weapon_name and vv["zone"] == zone.name then                        
                        weapons["Current Weapon"] = i
                        weapons["Current Trial"]  = vv
                        weapons["Current NM"]     = ii
                        updateEmpyData(weapons)

                        
                    end
                    
                end
                
            end
        
        end
        
    end 
    return false
    
end

-- Get current trial information based on empyrean weapon.
-- return trial table.
function getTrial(empyrean, trial_num)
    
    local trial
    
    for i,v in pairs(empyrean) do
        
        if type(v) == "table" then
            
            for ii,vv in pairs(v) do

                if ii == "number" and vv == tonumber(trial_num) then
                    trial = v
                    return trial
                end
                
            end
            
        end
        
    end
    return false
    
end

function updateCount(weapons_table, count)
    weapons_table[weapons_table["Current Weapon"]][weapons_table["Current NM"]].count = count
    updateEmpyData(weapons)
    
end

--- Returns HEX representation of num.
function num2hex(num)
    local hexstr = '0123456789abcdef'
    local s = ''
    while num > 0 do
        local mod = math.fmod(num, 16)
        s = string.sub(hexstr, mod+1, mod+1) .. s
        num = math.floor(num / 16)
    end
    if s == '' then s = '0' end
    return s
end

-- Return number representation of HEX string value.
function hexString2number(hexString)
    if hexString ~= nil and type(hexString) == "string" then
        local convert = tonumber(hexString, 16)
        return convert
    end
    return false
end

-- Save data_table as data.
function updateEmpyData(data_table)
    weapons_file:write('return ' .. T(data_table):tovstring())
end

-- Round a number
function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

-- Play Sound File.
function playSound(file_name)
    windower.play_sound(windower.addon_path .. "sounds/" .. file_name .. ".wav")
end

-- Check if file exists.
function fileExists(name)
    local f = io.open(windower.addon_path .. "sounds/" .. name .. ".wav", "r")
    if f ~= nil then 
        io.close(f) return true else return false
    end
end

function math.sign(v)
	return (v >= 0 and 1) or -1
end

function math.round(v, bracket)
	bracket = bracket or 1
	return math.floor(v/bracket + math.sign(v) * 0.5) * bracket
end

function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
  
end

function updateDisplay(window, weapons_table, updateString)
    
    local weapon = weapons_table["Current Weapon"] or ""
    local NM     = weapons_table["Current NM"] or ""
    local trial  = weapons_table["Current Trial"] or ""
    local zone   = weapons_table["Current Trial"]["zone"] or ""
    local time
    
    if respawn == nil then
        time = 0
    else
        time = timer-respawn
        
        if time < 0 then
            time = 0
        end
        
    end
    
    local message = 
        "Current Weapon: ":rpad(' ',18) .. weapon .. "\n" ..
        "Current NM: ":rpad(' ',18) .. NM .. "\n" ..
        "Current Trial: ":rpad(' ',18) .. tostring(trial.number) .. "\n" ..
        "Zone: ":rpad(' ',18) .. zone .. "\n" ..
        "Respawn: ":rpad(' ',18) .. tostring(time) .. " minutes. \n" ..
        "Status: ":rpad(' ',18) .. updateString
    
    window:text(message)
    window:update()
    
end