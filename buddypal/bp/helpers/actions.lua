--------------------------------------------------------------------------------
-- This is all of the core action functions for buddypal.
--------------------------------------------------------------------------------
local actions = {}
function actions.new()
    local self = {}
    
    -- Private Variables
    local player     = windower.ffxi.get_player()
    local x          = 0
    local y          = 0
    local z          = 0
    local moving     = false
    local midaction  = false
    local injected   = false
    local locked     = false
    local locked_x   = 0
    local locked_y   = 0
    local locked_z   = 0
    local random     = 3
    local buffer     = 3
    local categories = {[6]="JobAbility",[7]="WeaponSkill",[8]="Magic",[9]="Item",[12]="Ranged",[13]="JobAbility",[14]="JobAbility",[15]="JobAbility"}
    local types      = {["Magic"]={res="spells"},["Trust"]={res="spells"},["JobAbility"]={res="job_abilities"},["WeaponSkill"]={res="weapon_skills"},["Item"]={res="items"},["Ranged"]={res="none"}}
    local ranges     = {[0]=255,[1]=1.7,[2]=3.4,[3]=5.1,[4]=6.8,[5]=8.5,[6]=10.2,[7]=11.9,[8]=13.6,[9]=15.3,[10]=17.0,[11]=18.7,[12]=20.4,[13]=22.1,[14]=23.8,[15]=25.5}
    local actions    = {
        
        ["interact"]        = 0,          ["engage"]          = 2,          ["/magic"]          = 3,          ["magic"]           = 3,          ["/mount"] = 26,
        ["disengage"]       = 4,          ["/help"]           = 5,          ["help"]            = 5,          ["/weaponskill"]    = 7,
        ["weaponskill"]     = 7,          ["/jobability"]     = 9,          ["jobability"]      = 9,          ["return"]          = 11,
        ["/assist"]         = 12,         ["assist"]          = 12,         ["acceptraise"]     = 13,         ["/fish"]           = 14,
        ["fish"]            = 14,         ["switchtarget"]    = 15,         ["/range"]          = 16,         ["range"]           = 16,
        ["/dismount"]       = 18,         ["dismount"]        = 18,         ["zone"]            = 20,         ["accepttractor"]   = 19,
        ["mount"]           = 26,
        
    }
    
    -- Action Delays
    local delays = {
        
        ["Misc"]            = 1.5,        ["WeaponSkill"]     = 0.6,        ["Item"]            = 1.5,        ["JobAbility"]      = 0.6,
        ["CorsairRoll"]     = 0.6,        ["CorsairShot"]     = 0.6,        ["Samba"]           = 0.6,        ["Waltz"]           = 0.6,
        ["Jig"]             = 0.6,        ["Step"]            = 0.6,        ["Flourish1"]       = 0.6,        ["Flourish2"]       = 0.6,
        ["Flourish3"]       = 0.6,        ["Scholar"]         = 0.6,        ["Effusion"]        = 0.6,        ["Rune"]            = 0.6,
        ["Ward"]            = 0.6,        ["BloodPactRage"]   = 0.6,        ["BloodPactWard"]   = 0.6,        ["PetCommand"]      = 0.6,
        ["Monster"]         = 1.0,        ["Dismount"]        = 1.0,        ["Ranged"]          = 0.6,        ["WhiteMagic"]      = 1.5,
        ["BlackMagic"]      = 1.5,        ["BardSong"]        = 1.5,        ["Ninjutsu"]        = 1.5,        ["SummonerPact"]    = 1.5,
        ["BlueMagic"]       = 1.5,        ["Geomancy"]        = 1.5,        ["Trust"]           = 1.5,
        
    }
    
    -- Custom Action Resource
    local template = {
        ["Interact"] = {id=65534,en="Interact",element=-1,prefix="/interact",type="Interact", range=6},
        ["Movement"] = {id=65535,en="Movement",element=-1,prefix="/move",type="Movement", range=255},
        ["Ranged"]   = {id=65536,en="Ranged",element=-1,prefix="/ra",type="Ranged", range=14},
    }
    
    --------------------------------------------------------------------------------
    -- Command player to do an outgoing action.
    --------------------------------------------------------------------------------
    self.doAction = function(target, param, action)
        local midaction = midaction
        
        if target and action and not midaction then
            local param = param or 0
            if actions[action] and bpcore:checkReady() and not midaction then
                windower.packets.inject_outgoing(0x01a, ("iIHHHHfff"):pack(0x00001A00, target.id, target.index, actions[action], param, 0, 0, 0, 0))                
            end
        
        end
    
    end
    
    --------------------------------------------------------------------------------
    -- Reposition player.
    --------------------------------------------------------------------------------
    self.reposition = function(x, y, z)
        local player = windower.ffxi.get_player()
        if x and y and z and player then
            windower.packets.inject_incoming(0x065, ("ifffIHCCCC"):pack(0x00006500, (x+0.321), z, (y+0.321), player.id, player.index, 1, 0, 0, 0))        
            helpers["actions"].setMidaction(false)
        end
    
    end
    
    --------------------------------------------------------------------------------
    -- Jump to coordinates in front of a position.
    --------------------------------------------------------------------------------
    self.jumpTo = function(target)
        local player = windower.ffxi.get_player()
        local target = target or false
        
        if target then
            local facing = math.floor(target.facing or 0)
            local position = {x=0,y=0,z=0}
            
            if facing == 0 then
                position = {x=(target.x+1), y=(target.y-1), z=target.z}
                
            elseif facing == 1 then
                position = {x=target.x, y=(target.y-1), z=target.z}
                
            elseif facing == 2 then
                position = {x=(target.x-1), y=(target.y-1), z=target.z}
                
            elseif (facing == 3 or facing == -4) then
                position = {x=(target.x-1), y=target.y, z=target.z}
                
            elseif (facing == -3 or facing == 4) then
                position = {x=(target.x-1), y=(target.y+1), z=target.z}
                
            elseif facing == -2 then
                position = {x=target.x, y=(target.y+1), z=target.z}
            
            elseif (facing == -1 or facing == 5) then
                position = {x=(target.x+1), y=(target.y+1), z=target.z}
                
            end

            if position.x ~= 0 and position.y ~= 0 and position.z ~= 0 then                
                windower.packets.inject_incoming(0x065, ("ifffIHCCCC"):pack(0x00006500, position.x, position.z, position.y, player.id, player.index, 1, 0, 0, 0))        
            end
            
        end
    
    end
    
    --------------------------------------------------------------------------------
    -- Jump to coordinates in front of a position.
    --------------------------------------------------------------------------------
    self.jumpBehind = function(target)
        local player = windower.ffxi.get_player()
        local target = target or false
        
        if target then
            local facing = math.floor(target.facing)
            local position = {x=0,y=0,z=0}
            
            if facing == 0 then
                position = {x=(target.x-1), y=(target.y+1), z=target.z}
                
            elseif facing == 1 then
                position = {x=target.x, y=(target.y+1), z=target.z}
                
            elseif facing == 2 then
                position = {x=(target.x+1), y=(target.y+1), z=target.z}
                
            elseif (facing == 3 or facing == -4) then
                position = {x=(target.x+1), y=target.y, z=target.z}
                
            elseif (facing == -3 or facing == 4) then
                position = {x=(target.x+1), y=(target.y-1), z=target.z}
                
            elseif facing == -2 then
                position = {x=target.x, y=(target.y-1), z=target.z}
            
            elseif (facing == -1 or facing == 5) then
                position = {x=(target.x-1), y=(target.y-1), z=target.z}
                
            end

            if position.x ~= 0 and position.y ~= 0 and position.z ~= 0 then                
                windower.packets.inject_incoming(0x065, ("ifffIHCCCC"):pack(0x00006500, position.x, position.z, position.y, player.id, player.index, 1, 0, 0, 0))        
            end
            
        end
    
    end
    
    --------------------------------------------------------------------------------
    -- Ping a mob from anywhere in the zone to receive a update packet.
    --------------------------------------------------------------------------------
    self.pingMob = function(index)
        local index = index or false
        if index then
            packets.inject(packets.new("outgoing", 0x016, {["Target Index"]=index}))
        end            
    end
    
    --------------------------------------------------------------------------------
    -- Command player to use an item.
    --------------------------------------------------------------------------------
    self.useItem = function(item, target, bag)
        local target    = target or windower.ffxi.get_mob_by_target("me")
        local midaction = midaction
        local bag       = bag or 0
        
        if target and item and bpcore:checkReady() and not midaction then
            local temp   = bpcore:findItemByName(item)
            local index  = select(1, bpcore:findItemById(temp.id))
            
            if type(index) == "number" then
                windower.packets.inject_outgoing(0x037, ("iIIHCCCCCC"):pack(0x00003700, target.id, 1, target.index, index, bag, 0, 0, 0, 0))                
            end
        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Command player to synthesize an item.
    --------------------------------------------------------------------------------
    self.synthItem = function(crystal, ingredients, ...)
        local crystal     = crystal or false
        local ingredients = ingredients or 1
        local materials   = T{...}
        
        if crystal and materials and not midaction and bpcore:checkReady() then
            local id, index = {}, {}
            
            for i,v in pairs(materials) do
                
                if type(v) == "table" then
                    
                    for ii,vv in pairs(v) do
                        index[i] = bpcore:findItemIndexByName(materials[i].name)
                        id[i]    = materials[i].id
                    
                    end
                
                end
            
            end
            
            id[1],    id[2],    id[3],    id[4]    = id[1] or 0,    id[2] or 0,    id[3] or 0,    id[4] or 0
            id[5],    id[6],    id[7],    id[8]    = id[5] or 0,    id[6] or 0,    id[7] or 0,    id[8] or 0
            index[1], index[2], index[3], index[4] = index[1] or 0, index[2] or 0, index[3] or 0, index[4] or 0
            index[5], index[6], index[7], index[8] = index[5] or 0, index[6] or 0, index[7] or 0, index[8] or 0
            
            -- Build _unknown1 packet data.
            local c  = ((crystal.id % 6506) % 4238) % 4096
            local m  = (c + 1) * 6 + 77
            local b  = (c + 1) * 42 + 31
            local m2 = (8 * c + 26) + (id[1] - 1) * (c + 35)
            
            local synth = packets.new("outgoing", 0x096, {
                ["_unknown1"]          = ((m * id[1] + b + m2 * (ingredients - 1)) % 127),
                ["_unknown2"]          = 0,
                ["Crystal"]            = crystal.id,
                ["Crystal Index"]      = bpcore:findItemIndexByName(crystal.name),
                ["Ingredient count"]   = ingredients,
                ["Ingredient 1"]       = id[1], ["Ingredient 2"] = id[2], ["Ingredient 3"] = id[3], ["Ingredient 4"] = id[4],
                ["Ingredient 5"]       = id[5], ["Ingredient 6"] = id[6], ["Ingredient 7"] = id[7], ["Ingredient 8"] = id[8],
                ["Ingredient Index 1"] = index[1], ["Ingredient Index 2"] = index[2], ["Ingredient Index 3"] = index[3], ["Ingredient Index 4"] = index[4],
                ["Ingredient Index 5"] = index[5], ["Ingredient Index 6"] = index[6], ["Ingredient Index 7"] = index[7], ["Ingredient Index 8"] = index[8],
            })
            packets.inject(synth)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Command player to use a ring.
    --------------------------------------------------------------------------------
    self.useRing = function(name, target)
        local target = target or windower.ffxi.get_mob_by_target("me")
        local midaction = midaction
        local bag = bpcore:findBag(name) or 0
    
        if name and bag and bpcore:findItemByName(name, bag) and bpcore:checkReady() and not midaction then
            local temp   = bpcore:findItemByName(name)
            local index  = select(1, bpcore:findItemById(temp.id))
            
            if type(index) == "number" then
                windower.packets.inject_outgoing(0x037, ("iIIHCCCCCC"):pack(0x00003700, target.id, 1, target.index, index, bag, 0, 0, 0, 0))            
            end
        
        end
        
    end

    --------------------------------------------------------------------------------
    -- Equip a item in a inventory slot.
    --------------------------------------------------------------------------------
    self.equipItem = function(name, slot)
        local midaction = midaction
        
        if name and not midaction then
            local bag = bpcore:findBag(name)
        
            if bag and slot and type(slot) == "number" then
                local temp   = bpcore:findItemByName(name, bag)
                local bags   = {0,8,10,11,12}
                local bag, item
                
                for i,v in ipairs(bags) do
                    
                    if bpcore:findItemById(temp.id, v) then
                        item, bag = bpcore:findItemById(temp.id, v), v
                    end
                        
                end

                if type(select(1, item)) == "number" then
                    windower.packets.inject_outgoing(0x050, ("iCCCC"):pack(0x00005000, select(1, item), slot, bag, 0))                    
                end
                
            end
        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Force player to open a shop menu.
    --------------------------------------------------------------------------------
    self.openShop = function(shop)
        windower.packets.inject_incoming(0x03e, ("iCCCC"):pack(0x00003e08, shop or 13, 0, 16, 01))        
    end
    
    --------------------------------------------------------------------------------
    -- Force player to query items price in a shop.
    --------------------------------------------------------------------------------
    self.priceItem = function(item)
        local item = item or false
        
        if item and bpcore:findItemIndexByName(item.en) then
            windower.packets.inject_outgoing(0x084, ("iIHCC"):pack(0x00008408, 1, item.id, bpcore:findItemIndexByName(item.en), 0))        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Force player to sell an item at a shop.
    --------------------------------------------------------------------------------
    self.sellItem = function(item)
        local items   = windower.ffxi.get_items(0) or false
        local current = bpcore:findItemByName(item.en) or false
        
        if items and current then
            local count = 0
            
            for i,v in ipairs(items) do
                
                if i and v and type(v) == "table" then
                    local found = bpcore:findItemByIndex(i)
                    
                    if found and found["id"] and found["id"] == current.id then
                        count = (count + 1)
                    end
                    
                end
            
            end
            
            for i=0, count do

                if bpcore:findItemById(current.id) then
                    local index, quantity, id = bpcore:findItemById(current.id)

                    if id and index and quantity then
                        local price = ("iIHCC"):pack(0x00008400, quantity, id, index ,0)
                        local sell  = ("iCCCC"):pack(0x00008500, 1, 0, 0, 0)
                        
                        windower.packets.inject_outgoing(0x084, price)
                        windower.packets.inject_outgoing(0x085, sell)
                        coroutine.sleep(1)
                        
                    end
                    
                end
                
            end
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Force a menu injection during npc interaction.
    --------------------------------------------------------------------------------
    self.injectMenu = function(id, index, zone, option, menuid, automated, _u1, _u2)
        local _u1, _u2 = _u1 or 0, _u2 or 0
        if id and index and option and zone and menuid and (automated or not automated) then
            windower.packets.inject_outgoing(0x05b, ("iIHHHBCHH"):pack(0x05b, id, option, _u1, index, automated, _u2, zone, menuid))            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Get advanced synth support from the NPC.
    --------------------------------------------------------------------------------
    self.injectSynthSupport = function()
        windower.packets.inject_incoming(0x03e, ("iCC3"):pack(0x00003e00, 43, 0, 0, 0))        
    end
    
    --------------------------------------------------------------------------------
    -- Get Crystals from Ephemeral Moogle
    --------------------------------------------------------------------------------
    self.getCrystals = function(target, quantity, type)
        local zone     = {id=res['zones'][windower.ffxi.get_info().zone].id, name=res['zones'][windower.ffxi.get_info().zone].name}
        local menus    = {[17723846]={menu=913},[17723847]={menu=914},[17740211]={menu=617},[17736015]={menu=617},[17719925]={menu=3549},[17752529]={menu=1098},[17764826]={menu=895},[17764827]={menu=896}}
        local crystals = {
            
            ["Fire Crystal"]        = {unknown1=16385},
            ["Ice Crystal"]         = {unknown1=16386},
            ["Wind Crystal"]        = {unknown1=16387},
            ["Earth Crystal"]       = {unknown1=16388},
            ["Lightng. Crystal"]    = {unknown1=16389},
            ["Water Crystal"]       = {unknown1=16390},
            ["Light Crystal"]       = {unknown1=16391},
            ["Dark Crystal"]        = {unknown1=16392},
            
        }

        if target and quantity and type and zone and crystals[type] and menus[target.id] and helpers["currencies"].getCurrency(string.format("%ss", type)) >= tonumber(quantity) then
            windower.packets.inject_outgoing(0x05b, ("iIHHHBCHH"):pack(0x00005b00, target.id, quantity, crystals[type].unknown1, target.index, false, 0, zone.id, menus[target.id].menu))
            helpers["popchat"]:pop(string.format("Pulling %s of %s %ss.", quantity, helpers["currencies"].getCurrency(string.format("%ss", type)), type), system["Popchat Window"])
            
        else
            helpers["actions"].injectMenu(target.id, target.index, zone.id, 1, menus[target.id].menu, false,  0, 0)
            helpers["popchat"]:pop(string.format("Unable to get crystals. Attempting to pull %s of %s %ss.", quantity, helpers["currencies"].getCurrency(string.format("%ss", type)), type), system["Popchat Window"])
        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Inject a NPC generic entrance.
    --------------------------------------------------------------------------------
    self.doEntrance = function(packets, target)
        local player = windower.ffxi.get_mob_by_target("me")
        local zone   = windower.ffxi.get_info().zone or false
        
        if packets and target and zone then

            if target.name == "Dimensional Portal" and (zone == 108 or zone == 117 or zone == 102 or zone == 36) then
                helpers["popchat"]:pop(("Hold your Balls; Entering! ----> " .. target.name .. "!"), system["Popchat Window"])
                helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 0, packets["Menu ID"], true,  0, 0)
                helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 2, packets["Menu ID"], false,  0, 0)
                
            else
                helpers["popchat"]:pop(("Hold your Balls; Entering! ----> " .. target.name .. "!"), system["Popchat Window"])
                helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 0, packets["Menu ID"], true,  0, 0)
                helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 1, packets["Menu ID"], false,  0, 0)
                
            end
            
        else
            helpers["actions"].doExitMenu(packets, target)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Inject a Home Point warp.
    --------------------------------------------------------------------------------
    self.doHomepoint = function(packets, target, option)
        local player = windower.ffxi.get_mob_by_target("me")
        
        if packets and target and option then
            helpers["popchat"]:pop(("Hold your Balls! Mega Warping! ----> " .. helpers["megawarp"].getNextZone() .. "!"), system["Popchat Window"])
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 8, packets["Menu ID"], true,  0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 2, packets["Menu ID"], true,  option, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 2, packets["Menu ID"], false, option, 0)
            
        else

            helpers["actions"].doExitMenu(packets, target)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Inject a Survival Guide warp.
    --------------------------------------------------------------------------------
    self.doSurvivalguide = function(packets, target, option)
        local player = windower.ffxi.get_mob_by_target("me")
        
        if packets and target and option then
            helpers["popchat"]:pop(("Hold your Balls! Mega Warping! ----> " .. helpers["megawarp"].getNextZone() .. "!"), system["Popchat Window"])
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 7, packets["Menu ID"], true,  0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 1, packets["Menu ID"], true,  0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 1, packets["Menu ID"], false, option, 0)
            
        else

            helpers["actions"].doExitMenu(packets, target)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Inject a Unity warp.
    --------------------------------------------------------------------------------
    self.doUnity = function(packets, target, option)
        local player = windower.ffxi.get_mob_by_target("me")
        
        if packets and target and option then
            helpers["popchat"]:pop(("Hold your Balls! Mega Warping! ----> " .. helpers["megawarp"].getNextZone() .. "!"), system["Popchat Window"])
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 10, packets["Menu ID"], true,  0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 07, packets["Menu ID"], true,  0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], option, packets["Menu ID"], false, 0, 0)
            
        else

            helpers["actions"].doExitMenu(packets, target)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Inject Waypoint warp.
    --------------------------------------------------------------------------------
    self.doWaypoint = function(packets, target, x, y, z, option, zone)
        local player = windower.ffxi.get_mob_by_target("me")
        local warp   = "ifffIIHHHC":pack(0x00005c00, x, z, y, target.id, 0, packets["Zone"], packets["Menu ID"], target.index, 1)
        local update = "iHH":pack(0x00001600, player.index, 0)
        
        if packets and target and x and y and z and option and zone then
        
            if packets["Zone"] == zone then
                helpers["popchat"]:pop(("Hold your Balls! Mega Warping! ----> " .. helpers["megawarp"].getNextZone() .. "!"), system["Popchat Window"])
                helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], option, packets["Menu ID"], true, 0, 0)
                windower.packets.inject_outgoing(0x05c, warp)
                helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 0, packets["Menu ID"], false, 0, 0)
                windower.packets.inject_outgoing(0x016, update)
                
            else
                helpers["popchat"]:pop(("Hold your Balls! Mega Warping! ----> " .. helpers["megawarp"].getNextZone() .. "!"), system["Popchat Window"])
                helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 0, packets["Menu ID"], true, 0, 0)
                helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], option, packets["Menu ID"], false, 0, 0)
                
            end
        
        else
            helpers["actions"].doExitMenu(packets, target)
        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Inject Proto Waypoint warp.
    --------------------------------------------------------------------------------
    self.doProtoWP = function(packets, target, option)
        local player = windower.ffxi.get_mob_by_target("me")
        
        if packets and target and option then
            helpers["popchat"]:pop(("Hold your Balls! Mega Warping! ----> " .. helpers["megawarp"].getNextZone() .. "!"), system["Popchat Window"])
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 0, packets["Menu ID"], true, 0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], option, packets["Menu ID"], false, 0, 0)
        
        else
            helpers["actions"].doExitMenu(packets, target)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Inject a voidwatch warp.
    --------------------------------------------------------------------------------
    self.doVoidwatch = function(packets, target, option)
        local player = windower.ffxi.get_mob_by_target("me")
        
        if packets and target and option then
            helpers["popchat"]:pop(("Hold your Balls! Mega Warping! ----> " .. helpers["megawarp"].getNextZone() .. "!"), system["Popchat Window"])
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 2, packets["Menu ID"], false, option, 0)
            
        else

            helpers["actions"].doExitMenu(packets, target)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Inject a Abyssea warp.
    --------------------------------------------------------------------------------
    self.doAbyssea = function(packets, target, option)
        local player = windower.ffxi.get_mob_by_target("me")
        
        if packets and target and option then
            helpers["popchat"]:pop(("Hold your Balls; Mega Warping! ----> " .. helpers["megawarp"].getNextZone() .. "!"), system["Popchat Window"])
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 10, packets["Menu ID"], true,  0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 07, packets["Menu ID"], true,  0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], option, packets["Menu ID"], false, 0, 0)
            
        else

            helpers["actions"].doExitMenu(packets, target)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Inject conflux warp.
    --------------------------------------------------------------------------------
    self.doConflux = function(packets, target, x, y, z, option, zone)
        local player = windower.ffxi.get_mob_by_target("me")
        local warp   = ("ifffIIHHHC"):pack(0x00005c00, x, z, y, target.id, 0, packets["Zone"], packets["Menu ID"], target.index, 1)
        local update = ("iHH"):pack(0x00001600, player.index, 0)
        
        if packets and target and x and y and z and option and zone then
        
            if packets["Zone"] == zone then
                helpers["popchat"]:pop(("Hold your Balls! Mega Warping!"), system["Popchat Window"])
                helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 1, packets["Menu ID"], true, option, 0)
                windower.packets.inject_outgoing(0x05c, warp)
                helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 1, packets["Menu ID"], false, 0, 0)
                windower.packets.inject_outgoing(0x016, update)
                
            end
        
        else
            helpers["actions"].doExitMenu(packets, target)
        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Inject escha warp.
    --------------------------------------------------------------------------------
    self.doEscha = function(packets, target, x, y, z, option, zone)
        local player = windower.ffxi.get_mob_by_target("me")
        local warp   = "ifffIIHHHC":pack(0x00005c00, x, z, y, target.id, 0, packets["Zone"], packets["Menu ID"], target.index, 1)
        local update = "iHH":pack(0x00001600, player.index, 0)
        
        if packets and target and x and y and z and option and zone then
        
            if packets["Zone"] == zone then
                helpers["popchat"]:pop(("Hold your Balls! Mega Warping!"), system["Popchat Window"])
                helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 1, packets["Menu ID"], true, option, 0)
                windower.packets.inject_outgoing(0x05c, warp)
                helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 2, packets["Menu ID"], false, 0, 0)
                windower.packets.inject_outgoing(0x016, update)
                
            else
                helpers["popchat"]:pop(("Hold your Balls! Mega Warping!"), system["Popchat Window"])
                helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 1, packets["Menu ID"], true, option, 0)
                helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 2, packets["Menu ID"], false, 0, 0)
                
            end
        
        else
            helpers["actions"].doExitMenu(packets, target)
        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Get Imperial Tag.
    --------------------------------------------------------------------------------
    self.getTags = function(packets, target)
        local packets = packets or false
        local target  = target or false
        
        if packets and target then
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 1, packets["Menu ID"], false,  0, 0)
        else
            helpers["actions"].doExitMenu(packets, target)
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Get Assault Orders.
    --------------------------------------------------------------------------------
    self.getOrders = function(packets, target, rank)
        local packets = packets or false
        local target  = target or false
        local menu    = helpers["assaults"].getMenu(target.id, rank) or false
        
        if packets and target and menu then
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], menu.option, packets["Menu ID"], false,  menu._u1, menu._u2)
            
        else
            helpers["actions"].doExitMenu(packets, target)
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Enter Runic Portal.
    --------------------------------------------------------------------------------
    self.enterRunic = function(packets, target, option)
        local packets = packets or false
        local target  = target or false
        
        if packets and target then
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], option, packets["Menu ID"], false,  0, 0)
        else
            helpers["actions"].doExitMenu(packets, target)
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Get Assault Armband.
    --------------------------------------------------------------------------------
    self.getArmband = function(packets, target)
        local packets, target = packets or false, target or false
        
        if packets and target then
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 1, packets["Menu ID"], false,  0, 0)
        else
            helpers["actions"].doExitMenu(packets, target)
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Reserve Assault.
    --------------------------------------------------------------------------------
    self.reserveAssault = function(packets, target, option, _u1, _u2)
        local packets, target, option = packets or false, target or false, option or false
        local _u1, _u2 = _u1 or 0, _u2 or 0
        
        if packets and target and option then
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], option, packets["Menu ID"], true, _u1, _u2)
        else
            helpers["actions"].doExitMenu(packets, target)
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Enter Assault Reservation.
    --------------------------------------------------------------------------------
    self.enterAssault = function(packets, target, option, _u1, _u2)
        local packets, target, option = packets or false, target or false, option or false
        local _u1, _u2 = _u1 or 0, _u2 or 0
        
        if packets and target and option then
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], option, packets["Menu ID"], false, _u1, _u2)
        else
            helpers["actions"].doExitMenu(packets, target)
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Use Rune of Release.
    --------------------------------------------------------------------------------
    self.assaultRelease = function(packets, target)
        local packets, target = packets or false, target or false
        
        if packets and target then
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 1, packets["Menu ID"], false,  0, 0)
        else
            helpers["actions"].doExitMenu(packets, target)
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Reserve Ambuscade.
    --------------------------------------------------------------------------------
    self.reserveAmbuscade = function(packets, target, option)
        local packets, target, option = packets or false, target or false, option or false
        
        if packets and target and option then
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], option, packets["Menu ID"], true, 0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], option, packets["Menu ID"], false, 0, 0)
        else
            helpers["actions"].doExitMenu(packets, target)
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Reserve Ambuscade.
    --------------------------------------------------------------------------------
    self.enterAmbuscade = function(packets, target)
        local packets, target = packets or false, target or false
        
        if packets and target then
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 1, packets["Menu ID"], true, 0, 0)
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], 2, packets["Menu ID"], false, 0, 0)
        else
            helpers["actions"].doExitMenu(packets, target)
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Buy Orb (BCNM).
    --------------------------------------------------------------------------------
    self.buyOrb = function(packets, target, name)
        local packets, target, name = packets or false, target or false, name or ""
        local orbs = {
            
            ["Bia Orb"] = {option=13, u1=0, u2=0},
            
        }
        
        if packets and target and orbs[name] then
            helpers["actions"].injectMenu(target.id, target.index, packets["Zone"], orbs[name].option, packets["Menu ID"], false,  orbs[name].u1, orbs[name].u2)
        else
            helpers["actions"].doExitMenu(packets, target)
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Force a menu exit during npc interaction.
    --------------------------------------------------------------------------------
    self.doExitMenu = function(packets, target)
        if packets then
            windower.packets.inject_outgoing(0x05b, ("iIHHHBCHH"):pack(0x00005b00, target.id, 0, 16384, target.index, false, 0, packets["Zone"], packets["Menu ID"]))            
        end        
    end

    --------------------------------------------------------------------------------
    -- Trade an item to an NPC.
    --------------------------------------------------------------------------------
    self.tradeNPC = function(npc, ...)
        local items = T{...}
        local count = #items
        
        if npc and items then
            local quantity, index = {}, {}
            
            for i,v in pairs(items) do
                if type(v) == "table" then
                    for ii,vv in pairs(v) do
                        index[i]    = bpcore:findItemIndexByName(items[i][1].name)
                        quantity[i] = items[i][2]
                    end
                end
            end
            
            quantity[1], quantity[2], quantity[3], quantity[4] = quantity[1] or 0, quantity[2] or 0, quantity[3] or 0, quantity[4] or 0
            quantity[5], quantity[6], quantity[7], quantity[8] = quantity[5] or 0, quantity[6] or 0, quantity[7] or 0, quantity[8] or 0
            index[1],    index[2],    index[3],    index[4]    = index[1] or 0,    index[2] or 0,    index[3] or 0,    index[4] or 0
            index[5],    index[6],    index[7],    index[8]    = index[5] or 0,    index[6] or 0,    index[7] or 0,    index[8] or 0
            
            local trade = packets.new('outgoing', 0x036, {
                ['Target'] = npc.id,
                ['Item Count 1'] = quantity[1], ['Item Count 2'] = quantity[2], ['Item Count 3'] = quantity[3], ['Item Count 4'] = quantity[4],
                ['Item Count 5'] = quantity[5], ['Item Count 6'] = quantity[6], ['Item Count 7'] = quantity[7], ['Item Count 8'] = quantity[8],
                ['Item Count 9'] = 0,
                
                ['Item Index 1'] = index[1], ['Item Index 2'] = index[2], ['Item Index 3'] = index[3], ['Item Index 4'] = index[4],
                ['Item Index 5'] = index[5], ['Item Index 6'] = index[6], ['Item Index 7'] = index[7], ['Item Index 8'] = index[8],
                ['Item Index 9'] = 0,
                
                ['Target Index'] = npc.index,
                ['Number of Items'] = count,
            })
            packets.inject(trade)
            
        end
        return false
        
    end

    --------------------------------------------------------------------------------
    -- Buy an item from an NPC.
    --------------------------------------------------------------------------------
    self.buyItem = function(shop_slot, quantity)
        local midaction = midaction
        local quantity = quantity or 1
            
        if quantity and shop_slot and bpcore:checkReady() and not midaction then
            windower.packets.inject_outgoing(0x083, ("iIHCCI"):pack(0x00008308, quantity, 0, shop_slot, 0, 0))                
        end
            
    end

    --------------------------------------------------------------------------------
    -- Make a player walk to coordinates.
    --------------------------------------------------------------------------------
    self.moveToPosition = function(pos_x, pos_y, random)
        local me = windower.ffxi.get_mob_by_target("me")
        local random = random or false
        
        if me and not random then
            windower.ffxi.run(pos_x-me.x, pos_y-me.y)
        
        elseif me and random then
            
            local px = math.abs(bpcore:round(pos_x, 3)-bpcore:round(me.x, 3))
            local py = math.abs(bpcore:round(pos_y, 3)-bpcore:round(me.y, 3))
            local rx = math.random(1, random) + math.random()
            local ry = math.random(1, random) + math.random()
            windower.ffxi.run(bpcore:round((pos_x-me.x)+rx, 3), bpcore:round((pos_y-me.y)+ry, 3))           
            
        end
        return false
        
    end

    --------------------------------------------------------------------------------
    -- Make a player walk to coordinates. (Wanted to thank Ivaar for some issues with the windower function itself.)
    --------------------------------------------------------------------------------
    self.move = function(x, y)
        local me = windower.ffxi.get_mob_by_target("me") or false
        
        if me then
            windower.ffxi.turn(-math.atan2(y-me.y, x-me.x))
            windower.ffxi.run(-math.atan2(y-me.y, x-me.x))
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Face away from the current mob.
    --------------------------------------------------------------------------------
    self.turn = function(x, y)
        local me = windower.ffxi.get_mob_by_target("me") or false
        
        if me then
            windower.ffxi.turn(-math.atan2(y-me.y, x-me.x))
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Force a zone update to another zone.
    --------------------------------------------------------------------------------
    self.zone = function(zone, u2, u3, type)
        local zone, u2, u3, type = zone or false, u2 or 0, u3 or 0, type or 0
        if zone then
            windower.packets.inject_outgoing(0x05e, ("iII3HCC"):pack(0x00005e00, zone, 0, 0, 0, u2, u3, type))
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Set a players position using packets
    --------------------------------------------------------------------------------
    self.lockPosition = function(pos_x, pos_y, pos_z, random)
        local random = random or false
        local pos_z  = pos_z or 1

        if windower.ffxi.get_player() and not random then
            helpers["actions"].setLockedPOS(pos_x, pos_y, pos_z)
            helpers["actions"].setLocked(true)
        
        elseif windower.ffxi.get_player() and random then
            local px = math.abs(bpcore:round(pos_x, buffer))
            local py = math.abs(bpcore:round(pos_y, buffer))
            local rx = math.random() + math.random(1, random)
            local ry = math.random() + math.random(1, random)
                
            helpers["actions"].setLockedPOS(bpcore:round((pos_x)+rx, 3), bpcore:round((pos_y)+ry, 3), pos_z)
            helpers["actions"].setLocked(true)
            
        end
        
    end

    --------------------------------------------------------------------------------
    -- Unlock position locking.
    --------------------------------------------------------------------------------
    self.setLocked = function(value)
        locked = value
    end
    
    --------------------------------------------------------------------------------
    -- Get position locked status.
    --------------------------------------------------------------------------------
    self.getLocked = function()
        return locked
    end
    
    --------------------------------------------------------------------------------
    -- Get position locked status.
    --------------------------------------------------------------------------------
    self.setLockedPOS = function(x, y, z)
        locked_x, locked_y, locked_z = x, y, z
    end
    
    --------------------------------------------------------------------------------
    -- Get locked coordinates.
    --------------------------------------------------------------------------------
    self.getLockedPOS = function()
        return {x=locked_x, y=locked_y, z=locked_z}
    end
    
    ---------------------------------------------------------------------------
    -- Check if you are near a position.
    ---------------------------------------------------------------------------
    self.atPosition = function(x, y)
        local me = windower.ffxi.get_mob_by_target("me")
        local x  = x or false
        local y  = y or false
    
        if x and y then
        
            if math.abs(bpcore:round(me.x, 3)-bpcore:round(x, 3)) < buffer and math.abs(bpcore:round(me.y, 3)-bpcore:round(y, 3)) < buffer then
                return true
            end
        
        end
        return false
        
    end
    
    ---------------------------------------------------------------------------
    -- Determine if you are inside or outside a specific circumference.
    ---------------------------------------------------------------------------
    self.rangeCheck = function(x, y, r, outside)
        local pos     = helpers["actions"].getCoordinates()
        local outside = outside or false
        local x       = x or false
        local y       = y or false
        
        if x and y then
            
            if (( (pos.x-x)^2 + (pos.y-y)^2) < r^2) and not outside then
                return true
                
            elseif (( (pos.x-x)^2 + (pos.y-y)^2) > r^2) and outside then
                return true
                
            end
        
        end
        return false
        
    end
    
    --------------------------------------------------------------------------------
    -- Calculate player steps.
    --------------------------------------------------------------------------------
    self.getSteps = function(pos_x, pos_y)
        
        if pos_x > pos_y then
            return (pos_x*17)
        
        elseif pos_x < pos_y then
            return (pos_y*17) 
        
        end
        return false
        
    end
    
    --------------------------------------------------------------------------------
    -- Press Escape.
    --------------------------------------------------------------------------------
    self.pressEscape = function()
        windower.send_command("setkey escape down; wait 0.2; setkey escape up")
    end
    
    --------------------------------------------------------------------------------
    -- Press Enter.
    --------------------------------------------------------------------------------
    self.pressEnter = function()
        windower.send_command("setkey enter down; wait 0.2; setkey enter up")
    end
    
    --------------------------------------------------------------------------------
    -- Press Up.
    --------------------------------------------------------------------------------
    self.pressUp = function()
        windower.send_command("setkey up down; wait 0.2; setkey up up")
    end
    
    --------------------------------------------------------------------------------
    -- Press Down.
    --------------------------------------------------------------------------------
    self.pressDown = function()
        windower.send_command("setkey down down; wait 0.2; setkey down up")
    end
    
    --------------------------------------------------------------------------------
    -- Press Left.
    --------------------------------------------------------------------------------
    self.pressLeft = function()
        windower.send_command("setkey left down; wait 0.2; setkey left up")
    end
    
    --------------------------------------------------------------------------------
    -- Press Right.
    --------------------------------------------------------------------------------
    self.pressRight = function()
        windower.send_command("setkey right down; wait 0.2; setkey right up")
    end
    
    --------------------------------------------------------------------------------
    -- Press F8.
    --------------------------------------------------------------------------------
    self.pressF8 = function()
        windower.send_command("setkey f8 down; wait 0.2; setkey f8 up")
    end
    
    --------------------------------------------------------------------------------
    -- Step backwards.
    --------------------------------------------------------------------------------
    self.stepBackwards = function()
        windower.send_command("setkey numpad2 down; wait 0.2; setkey numpad2 up")
    end
    
    --------------------------------------------------------------------------------
    -- Step sidestep.
    --------------------------------------------------------------------------------
    self.sidestep = function()
        windower.send_command("setkey numpad4 down; wait 0.2; setkey numpad4 up")
    end
    
    --------------------------------------------------------------------------------
    -- Stop autorun movement.
    --------------------------------------------------------------------------------
    self.stopMovement = function()
        windower.ffxi.run(false)
    end
    
    --------------------------------------------------------------------------------
    -- Face the current mob.
    --------------------------------------------------------------------------------
    self.face = function(mob)
        local me = windower.ffxi.get_mob_by_target("me")
        if mob then
            windower.ffxi.turn(((math.atan2((mob.y - me.y), (mob.x - me.x))*180/math.pi)*-1):radian())
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Accept raise.
    --------------------------------------------------------------------------------
    self.acceptRaise = function()
        windower.packets.inject_outgoing(0x01a, ("iIHHHHfff"):pack(0x1A0E3C0A, player.id, player.index, 13, 0, 0, 0, 0, 0))
    end
    
    --------------------------------------------------------------------------------
    -- Warp out by any means.
    --------------------------------------------------------------------------------
    self.tryWarping = function()
        local me = windower.ffxi.get_mob_by_target("me")
        
        if player.main_job == "BLM" or player.sub_job == "BLM" then
            
            if windower.ffxi.get_spells()[MA["Warp"].id] and bpcore:isMAReady(MA["Warp"].recast_id) and bpcore:canCast() then
                helpers["queue"].addToFront(MA["Warp"], "me")
                
            elseif windower.ffxi.get_spells()[MA["Warp II"].id] and bpcore:isMAReady(MA["Warp II"].recast_id) and bpcore:canCast() then
                helpers["queue"].addToFront(MA["Warp II"], "me")
            
            end
            
        elseif bpcore:checkTimestamp("Warp Ring", "minute", 10) then
            helpers["actions"].equipItem("Warp Ring", 13)
            helpers["queue"].addToFront(IT["Warp Ring"], "me")
            system["Next Allowed"] = (os.clock() + 13)
            
        elseif bpcore:findItemByName("Instant Warp", 0) then
            helpers["queue"].addToFront(IT["Instant Warp"], "me")
            
        else
            windower.send_command(string.format("p < %s > : Warps not available yet.", me.name))
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Interact with a target.
    --------------------------------------------------------------------------------
    self.poke = function(target)
        local target = target or false
        if target then
            packets.inject(packets.new("outgoing", 0x1a, {["Target"]=target.id,["Target Index"]=target.index,}))
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Set midaction status.
    --------------------------------------------------------------------------------
    self.setMidaction = function(value)
        midaction = value    
    end
    
    --------------------------------------------------------------------------------
    -- Get midaction status.
    --------------------------------------------------------------------------------
    self.getMidaction = function()
        return midaction
    end
    
    --------------------------------------------------------------------------------
    -- Set moving status.
    --------------------------------------------------------------------------------
    self.setMoving = function()
        local me = windower.ffxi.get_mob_by_target("me") or false
        
        if me then
            
            if me.x ~= x or me.y ~= y then
                --helpers["actions"].setMidaction(false)
                moving, x, y, z = true, me.x, me.y, me.z
            else
                moving, x, y, z = false, me.x, me.y, me.z            
            end
        
        else
            --helpers["actions"].setMidaction(false)
            moving, x, y, z = true, 0, 0, 0
        end
    
    end
    
    --------------------------------------------------------------------------------
    -- Get moving status.
    --------------------------------------------------------------------------------
    self.getMoving = function()
        return moving
    end
    
    --------------------------------------------------------------------------------
    -- Get current coordinates.
    --------------------------------------------------------------------------------
    self.getCoordinates = function()
        return {x=x,y=y,z=z}
    end
    
    --------------------------------------------------------------------------------
    -- Get positioning buffer.
    --------------------------------------------------------------------------------
    self.getBuffer = function()
        return buffer
    end
    
    --------------------------------------------------------------------------------
    -- Get action ranges.
    --------------------------------------------------------------------------------
    self.getRanges = function()
        return ranges
    end
    
    --------------------------------------------------------------------------------
    -- Get max random positioning.
    --------------------------------------------------------------------------------
    self.getRandom = function()
        return random
    end
    
    self.getDelays = function()
        return delays
    end
    
    self.getTemplate = function(name)
        local name = name or false
        
        if name and template and template[name] then
            return template[name]
        end
        return nil
    
    end
    
    --------------------------------------------------------------------------------
    -- Return all the action settings
    --------------------------------------------------------------------------------
    self.settings = function()
        
        return {
            
            player     = player,
            x          = x,
            y          = y,
            z          = z,
            moving     = moving,
            midaction  = midaction,
            locked     = locked,
            categories = categories,
            types      = types,
            actions    = actions,
            delays     = delays,
            
        }
        
    end
    
    return self
    
end
return actions.new()