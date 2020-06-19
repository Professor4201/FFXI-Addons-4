return {
    
    debug           = true,
    job_check       = windower.ffxi.get_player().jobs.DNC,
    spam_delay      = 0.4,
    zone_delay      = 0,
    last_clock      = 0,
    zone            = res['zones'][windower.ffxi.get_info().zone].id,
    zone_name       = res['zones'][windower.ffxi.get_info().zone].name,
    last_target     = false,
    items           = {},
    text            = {},
    npcs = {
        
        ["Upper Jeuno"] = {
            ["Laila"]        = {["y"]=102.66402435303,["z"]=-0.00017499923706055,["id"]=17776826,["name"]="Laila",["x"]=-55.025505065918,["index"]=186},
            ['Rhea Myuliah'] = {["y"]=102.47007751465,["z"]=-0.00017738342285156,["id"]=17776827,["name"]="Rhea Myuliah",["x"]=-55.263721466064,["index"]=187},
            ['HP#1']         = {["y"]=167.23039245605,["z"]=-4.3690204620361e-05,["id"]=17776727,["name"]="Home Point #1",["x"]=-97.693313598633,["index"]=87},
        },
        
        ["Southern San d'Oria"] = {
            ['HP#1']        = {["y"]=124,["z"]=-2,["id"]=17719433,["name"]="Home Point #3",["x"]=140,["index"]=137},
            ['Valderotaux'] = {["y"]=109.57076263428,["z"]=-5.9604644775391e-08,["id"]=17719501,["name"]="Valderotaux",["x"]=97.212524414063,["index"]=205},
        },
        
        ["Jugner Forest [S]"] = {
            ['Glowing Pebbles'] = {["y"]=441.96801757813,["z"]=5.5645680427551,["id"]=17113884,["name"]="Glowing Pebbles",["x"]=102.80075073242,["index"]=796},
            ['SG#1']            = {["y"]=-496.91876220703,["z"]=-7.1900634765625,["id"]=17114046,["name"]="Survival Guide",["x"]=-196.05610656738,["index"]=958},
        },
        
        ["Bastok Markets"] = {
            ['HP#1'] = {["y"]=-156,["z"]=-10.004083633423,["id"]=17739860,["name"]="Home Point #1",["x"]=-343,["index"]=84},
        },
        
        ["Bastok Mines"] = {
            ['HP#1'] = {["y"]=-42.618000030518,["z"]=0,["id"]=17735748,["name"]="Home Point #1",["x"]=38.188999176025,["index"]=68},
            ['SG#1'] = {["y"]=-114.39964294434,["z"]=0,["id"]=17735991,["name"]="Survival Guide",["x"]=20.165142059326,["index"]=311},
        },
        
    },
    count           = 1,
    npc_count       = 1,
    nav_count       = 0,
    kill_count      = 0,
    status          = 0,
    skip            = "none",
    interacting     = false,
    injecting       = false,
    statuses        = {
        
        [0]  = 'Nothing Completed.',
        [1]  = 'Talk to Rhea Myualiah',
        [2]  = 'Talk to Valderotaux.',
        [3]  = 'Talk to Rhea Myualiah.',
        [4]  = 'Travel to the Glowing Pebbles.',
        [5]  = 'Talk to Laila',
        [6]  = 'Quest Completed.',
        
    },
    
}