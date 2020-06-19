-------------------------------------------------------------------------------------
-- This is all of the core functions for buddypal.
-------------------------------------------------------------------------------------
local bpcore = {}

-------------------------------------------------------------------------------------
-- Check if file exists.
-------------------------------------------------------------------------------------
function bpcore:fileExists(name)
    local f = io.open(windower.addon_path .. name, "r")
    if f ~= nil then 
        io.close(f) return true else return false
    end
    return false
end

-------------------------------------------------------------------------------------
-- Write data to a new file.
-------------------------------------------------------------------------------------
function bpcore:handleSettings(file, data)
    local s
    local f = files.new(file .. ".lua")
    local data = data or {}
    if not f:exists() then
        f:write('return ' .. T(data):tovstring())
        s = require(file)
        return s
    else
        s = require(file)
        return s
    end
    return false
end

-------------------------------------------------------------------------------------
-- Write data to a new file.
-------------------------------------------------------------------------------------
function bpcore:writeSettings(file, data)
    local f = files.new(file .. ".lua")
    if f:exists() then
        f:write('return ' .. T(data):tovstring())
    elseif not f:exists() then
        f:write('return ' .. T(data):tovstring())
    end
    return false
end

-------------------------------------------------------------------------------------
-- Write data to a json new file.
-------------------------------------------------------------------------------------
function bpcore:writeJSON(file, data)
    local f = files.new(file .. ".json")
    if f:exists() then
        f:write(JSON:encode(data))
    elseif not f:exists() then
        f:write(JSON:encode(data))
    end
    return false
end

-------------------------------------------------------------------------------------
-- Autoload all addon events.
-------------------------------------------------------------------------------------
function bpcore:initializeEvents(events)
    local dir = "bp/events/"
    if events then
        for _,v in pairs(events) do
            if v and type(v) == "string" then
                local f = io.open(windower.addon_path .. dir .. v .. ".lua", "r")
                if f then
                    io.close(f)
                    require(dir .. v)
                end
            end
        end        
    end
end

-------------------------------------------------------------------------------------
-- Autoload all addon helpers.
-------------------------------------------------------------------------------------
function bpcore:initializeHelpers(helpers)
    local dir = "bp/helpers/"
    local new = {}
    
    if helpers then
        
        for _,v in ipairs(helpers) do
            
            if v and type(v) == "table" and v.allowed then
                local f   = io.open(windower.addon_path .. dir .. v.name .. ".lua", "r")
                
                if f then
                    io.close(f)
                    new[v.name] = require(dir .. v.name)
                end
                
            end
            
        end
        return new
        
    end
    return false
    
end

-------------------------------------------------------------------------------------
-- Autoload all addon commands.
-------------------------------------------------------------------------------------
function bpcore:initializeCommands(commands)
    local dir = "bp/commands/"
    local new = {}
    
    if commands then
        
        for _,v in pairs(commands) do
            
            if v and type(v) == "table" and v.allowed then
                local f = io.open(windower.addon_path .. dir .. v.name .. ".lua", "r")
                
                if f then
                    io.close(f)
                    new[v.name] = require(dir .. v.name)
                end
                
            end
            
        end
        return new
        
    end
    return false
    
end

-------------------------------------------------------------------------------------
-- Autoload all addon navs.
-------------------------------------------------------------------------------------
function bpcore:initializeNavs()
    local dir = "bp/resources/navs/"
    local zones = res.zones
    local navs = {}
    if zones then
        for i,v in pairs(zones) do
            if v and type(v) == 'table' then
                local f = io.open(windower.addon_path .. dir .. i .. ".lua", "r")
                if f then
                    io.close(f)
                    navs[i] = require(dir .. i)
                end
            end
        end
        return navs
    end
    return false
end

-------------------------------------------------------------------------------------
-- Get all addon special events.
-------------------------------------------------------------------------------------
function bpcore:initializeSpecialEvents(events)
    local dir = "bp/events/special/"
    local new_events = {}
    if events then
        for _,v in pairs(events) do
            if v and type(v) == "string" then
                local f = io.open(windower.addon_path .. dir .. v .. ".lua", "r")
                if f then
                    io.close(f)
                    new_events[v] = require(dir .. v)
                end
            end
        end
        return new_events
    end
    return false
end

-------------------------------------------------------------------------------------
-- Playe a sound file.
-------------------------------------------------------------------------------------
function bpcore:playSound(name)
    local name = name or false
    
    if name and bpcore:fileExists(("bp/resources/sounds/%s.wav"):format(name)) then
        windower.play_sound((windower.addon_path.."bp/resources/sounds/%s.wav"):format(name))
        
    end
    
end

-------------------------------------------------------------------------------------
-- Build Addon specific resources.
-------------------------------------------------------------------------------------
function bpcore:buildResources()
    local temp = {["Spells"]={}, ["Abilities"]={}, ["Items"]={}, ["Weapon Skills"]={}}
    
    -- CONVERT RESOURCES TO NAMES.
    for _,v in pairs(res.spells) do
        if v["en"] ~= nil and temp["Spells"].en == nil then
            temp["Spells"][v["en"]] = v
        end
    end
    
    for _,v in pairs(res.job_abilities) do
        if v["en"] ~= nil and temp["Abilities"].en == nil then
            temp["Abilities"][v["en"]] = v
        end
    end
    
    for _,v in pairs(res.items) do
        if v["en"] ~= nil and temp["Items"].en == nil then
            temp["Items"][v["en"]] = v
        end
    end
    
    for _,v in pairs(res.weapon_skills) do
        if v["en"] ~= nil and temp["Weapon Skills"].en == nil then
            temp["Weapon Skills"][v["en"]] = v
        end
    end
    
    return temp["Spells"], temp["Abilities"], temp["Items"], temp["Weapon Skills"]
    
end

-------------------------------------------------------------------------------------
-- Colorize a string with RGB.
-------------------------------------------------------------------------------------
function bpcore:colorize(string, color)
    if string and color then
        return "\\cs(" .. color .. ")" .. string .. "\\cr"
    end
    return false
end

-------------------------------------------------------------------------------------
-- Convert a number to hexidecimal representation.
-------------------------------------------------------------------------------------
function bpcore:numberToHex(number)
    return string.format("%x", number * 256)
end

-------------------------------------------------------------------------------------
-- Convert a string to hexidecimal representation.
-------------------------------------------------------------------------------------
function bpcore:stringToHex(string)
    local hex = ''
    
    while #string > 0 do
        local hb = bpcore:numberToHex(string.byte(string, 1, 1))
        
        if #hb < 2 then hb = '0' .. hb end
        hex = hex .. hb
        string = string.sub(string, 2)
        
    end
    return hex
end

-------------------------------------------------------------------------------------
-- Round a number by number of decimal places.
-------------------------------------------------------------------------------------
function bpcore:round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
  
end

-------------------------------------------------------------------------------------
-- Build alliance data.
-------------------------------------------------------------------------------------
function bpcore:buildPartyData()
    local alliance = windower.ffxi.get_party() or false
    system["Party"]["Players"] = {}
    
    if alliance then
    
        for i,v in pairs(alliance) do
            
            if i == "alliance_leader" then
                system["Party"]["Parties"]["leader"] = v
                
            elseif i == "alliance_count" then
                system["Party"]["Parties"]["count"] = v
                
            elseif i == "party1_leader" then
                system["Party"]["Parties"]["leader1"] = v
                
            elseif i == "party2_leader" then
                system["Party"]["Parties"]["leader2"] = v
                
            elseif i == "party3_leader" then
                system["Party"]["Parties"]["leader3"] = v
                
            elseif i == "party1_count" then
                system["Party"]["Parties"]["count1"] = v
                
            elseif i == "party2_count" then
                system["Party"]["Parties"]["count2"] = v
                
            elseif i == "party3_count" then
                system["Party"]["Parties"]["count3"] = v 
                
            elseif type(v) == 'table' then
                system["Party"]["Players"][v.name] = {}
                
                for ii,vv in pairs(v) do
                    
                    if type(vv) == 'table' then
                        
                        for iii,vvv in pairs(vv) do
                            system["Party"]["Players"][v.name][iii] = vvv
                            
                            if iii == 'pet_index' then
                                
                                if windower.ffxi.get_mob_by_index(vvv) then
                                    local pet = windower.ffxi.get_mob_by_index(vvv)
                                    system["Party"]["Pets"][pet.name] = {[iii]=vvv}
                                
                                end
                            
                            end
                        
                        end
                    
                    elseif system["Party"]["Players"][v.name] then
                        system["Party"]["Players"][v.name][ii] = vv
                    
                    end
                
                end
                    
                
            end
            
        end
    
    end
    
end

-------------------------------------------------------------------------------------
-- Determine if a target is a valid target that a player can engage.
-------------------------------------------------------------------------------------
function bpcore:canEngage(mob)
    
    if mob and mob.spawn_type == 16 and not mob.charmed then
        local player = windower.ffxi.get_mob_by_target("me") or false
        
        if player then
            
            if ( mob.claim_id == 0 or bpcore:isInParty(windower.ffxi.get_mob_by_id(mob.claim_id)) or bpcore:buffActive(603) or bpcore:buffActive(511) or bpcore:buffActive(257) or bpcore:buffActive(267) ) then
                return true
                
            else
                
                for _,v in pairs(system["Party"]["Players"]) do
                    
                    if type(v) == "table" and v.id == mob.claim_id then
                        return true
                    
                    else
                        return false
                    
                    end
                
                end
            
            end
        
        end
        
    end
    return false
    
end

-------------------------------------------------------------------------------------
-- Determine if a target is in your alliance.
-------------------------------------------------------------------------------------
function bpcore:isInParty(player, party_only)
    local player, party_only = player or false, party_only or false
    local alliance = windower.ffxi.get_party() or false
    
    if player and alliance then
        
        if not party_only then
        
            for i,v in pairs(alliance) do
                
                if (i:sub(1,1) == "p" or i:sub(1,1) == "a") and tonumber(i:sub(2)) ~= nil and player.name == v.name then
                    return true
                end
                
            end
            
        elseif party_only then
            
            for i,v in pairs(alliance) do
                
                if i:sub(1,1) == "p" and tonumber(i:sub(2)) ~= nil and player.name == v.name then
                    return true
                end
                
            end
            
        end
        
    end
    return false
    
end

-------------------------------------------------------------------------------------
-- Determine if a target is in your alliance.
-------------------------------------------------------------------------------------
function bpcore:getParty(player, party_only)
    local player, party_only = player or false, party_only or false
    local alliance = windower.ffxi.get_party() or false
    
    if player and alliance then
        
        if not party_only then
        
            for i,v in pairs(alliance) do
                
                if (i:sub(1,1) == "p" or i:sub(1,1) == "a") and tonumber(i:sub(2)) ~= nil and player.name == v.name then
                    return true
                end
                
            end
            
        elseif party_only then
            
            for i,v in pairs(alliance) do
                
                if i:sub(1,1) == "p" and tonumber(i:sub(2)) ~= nil and player.name == v.name then
                    return true
                end
                
            end
            
        end
        
    end
    return false
    
end

-------------------------------------------------------------------------------------
-- Determine if a target is in your alliance.
-------------------------------------------------------------------------------------
function bpcore:findPartyMember(name, party_only)
    local name, party_only = name or false, party_only or false
    local alliance = windower.ffxi.get_party() or false
    
    if name and alliance then
        
        if not party_only then
        
            for i,v in pairs(alliance) do
                
                if (i:sub(1,1) == "p" or i:sub(1,1) == "a") and tonumber(i:sub(2)) ~= nil and name == v.name then
                    return v
                end
                
            end
            
        elseif party_only then
            
            for i,v in pairs(alliance) do
                
                if i:sub(1,1) == "p" and tonumber(i:sub(2)) ~= nil and name == v.name then
                    return v
                end
                
            end
            
        end
        
    end
    return false
    
end

-------------------------------------------------------------------------------------
-- Find party member in party.
-------------------------------------------------------------------------------------
function bpcore:findMemberByName(name, party_only)
    local name, party_only = name or false, party_only or false
    local alliance = windower.ffxi.get_party() or false
    
    if name and alliance then
        
        if not party_only then
        
            for i,v in pairs(alliance) do
                
                if i:sub(1,1) == "p" and tonumber(i:sub(2)) ~= nil and (v.name:lower()):match(name:lower()) then
                    return v
                end
                
            end
            
        elseif party_only then
            
            for i,v in pairs(alliance) do
                
                if i:sub(1,1) == "p" and tonumber(i:sub(2)) ~= nil and (v.name:lower()):match(name:lower()) then
                    return v
                end
                
            end
            
        end
        
    end
    return false
    
end

-------------------------------------------------------------------------------------
-- Count the number of active rolls on the player.
-------------------------------------------------------------------------------------
function bpcore:rollsActive(player)
    local player = player or false
    
    if player then
        local buffs = player.buffs
        local count = 0
        
        for _,v in ipairs(buffs) do
            
            if v >= 310 and v <= 339 or v == 600 then
                count = count + 1
            end
        
        end
        return count
    
    else
        return false
    
    end

end

-------------------------------------------------------------------------------------
-- Count the number of active runes on the player.
-------------------------------------------------------------------------------------
function bpcore:runesActive(player)
    local player = player or false
    
    if player then
        local buffs = player.buffs
        local count = 0
        
        for _,v in ipairs(buffs) do
            
            if v >= 523 and v <= 530 then
                count = count + 1
            end
        
        end
        return count
    
    else
        return false
    
    end

end

-------------------------------------------------------------------------------------
-- Delay the next ping ping by [n] amount.
-------------------------------------------------------------------------------------
function bpcore:delayPing(number)
    system["Last Ping"] = os.clock() + number
end

-------------------------------------------------------------------------------------
-- Determine if a buff is active.
-------------------------------------------------------------------------------------
function bpcore:buffActive(buffId)
    
    for _,v in ipairs(system["Buffs"].Player) do
        
        if v == buffId then
            return true
        end
    
    end
    return false
    
end

-------------------------------------------------------------------------------------
-- Determine if an ability is ready.
-------------------------------------------------------------------------------------
function bpcore:isJAReady(id)
    if system["Recast"]["Abilities"][id] and system["Recast"]["Abilities"][id] < 1 then
        return true
    end
    return false

end

-------------------------------------------------------------------------------------
-- Determine if a spell is ready.
-------------------------------------------------------------------------------------
function bpcore:isMAReady(id)
    if system["Recast"]["Spells"][id] and system["Recast"]["Spells"][id] < 1 then
        return true
    end
    return false

end

-------------------------------------------------------------------------------------
-- Determine if a player can cast a spell.
-------------------------------------------------------------------------------------
function bpcore:canCast()
    local moving = helpers["actions"].getMoving()
    local player = windower.ffxi.get_player() or false
    local ready  = {[0]=0,[1]=1}
    
    if player and ready[player.status] and not moving then
        
        if system["Buffs"].Player then
            
            local bad = T{[0]=0,[1]=1,[2]=2,[6]=6,[7]=7,[10]=10,[14]=14,[17]=17,[19]=19,[22]=22,[28]=28,[29]=29,[193]=193,[252]=252}
            
            for i,v in ipairs(system["Buffs"].Player) do
                
                if bad[v] then
                    return false
                end
                
            end        
        
        end
        
    end
    return true
end

-------------------------------------------------------------------------------------
-- Determine if a player can perform an action.
-------------------------------------------------------------------------------------
function bpcore:canAct()
    local player = windower.ffxi.get_player()
    local ready = {[0]=0,[1]=1}
    
    if player and ready[player.status] then
    
        if system["Buffs"].Player then
            local bad = T{[0]=0,[1]=1,[2]=2,[7]=7,[10]=10,[14]=14,[16]=16,[17]=17,[19]=19,[22]=22,[193]=193,[252]=252}
            
            for i,v in ipairs(system["Buffs"].Player) do
                
                if bad[v] then
                    return false
                end
            
            end
        
        end
        
    end
    return true

end

-------------------------------------------------------------------------------------
-- Determine if a player can use an item.
-------------------------------------------------------------------------------------
function bpcore:canItem()
    local moving = helpers["actions"].getMoving()
    local player = windower.ffxi.get_player() or false
    local ready  = {[0]=0,[1]=1}
    
    if player and ready[player.status] and not moving then
        
        if system["Buffs"].Player then
            local bad = T{[473]=473,[252]=252}
            
            for i,v in ipairs(system["Buffs"].Player) do
                
                if bad[v] then
                    return false
                end
                
            end
        
        end
    
    end
    return true

end

-------------------------------------------------------------------------------------
-- Determine if a player can move.
-------------------------------------------------------------------------------------
function bpcore:canMove()
    local player = windower.ffxi.get_player() or false
    local ready  = {[0]=0,[1]=1,[10]=10,[11]=11,[85]=85}
    
    if player and ready[player.status] then
        
        if system["Buffs"].Player then
            local bad = T{[0]=0,[1]=1,[2]=2,[7]=7,[11]=11,[14]=14,[17]=17,[19]=19,[22]=22,[193]=193,[252]=252}
            
            for i,v in ipairs(system["Buffs"].Player) do
                
                if bad[v] then
                    return false
                end
                
            end
        
        end
    
    end
    return true

end

-------------------------------------------------------------------------------------
-- Get Player debuffs.
-------------------------------------------------------------------------------------
function bpcore:getMyDebuffs()
    local player = windower.ffxi.get_player() or false
    local party  = system["Buffs"].Party
    local ready  = {[0]=0,[1]=1,[10]=10,[11]=11,[85]=85}
            
    if player and ready[player.status] then
        
        if system["Buffs"].Player then
            local debuffs  = {[1]={},[2]={},[3]={},[4]={},[5]={},[6]={}}
            local erase    = T{
                
                [11]=11,        [12]=12,        [13]=13,        [21]=21,
                [128]=128,      [129]=129,      [130]=130,      [131]=131,
                [132]=132,      [133]=133,      [134]=134,      [135]=135,
                [136]=136,      [137]=137,      [138]=138,      [139]=139,
                [140]=140,      [141]=141,      [142]=142,      [144]=144,
                [145]=145,      [146]=146,      [147]=147,      [148]=148,
                [149]=149,      [167]=167,      [174]=174,      [175]=175,
                [186]=186,      [189]=189,      [192]=192,      [194]=194,
                [557]=557,      [558]=558,      [559]=559,      [560]=560,
                [561]=561,      [562]=562,      [563]=563,      [564]=564,
                [565]=565,      [566]=566,      [567]=567,      [540]=540,
                
            }
            local sleep    = T{[14]=14,[17]=17,[193]=193}
            local na       = T{[3]=3,[4]=4,[5]=5,[6]=6,[7]=7,[8]=8,[9]=9,[15]=15,[31]=31}
            local priority = {
        
                [1] = {[15]=15},
                [2] = {[6]=6,[149]=149,[167]=167,[7]=7,[9]=9,[20]=20,[144]=144},
                [3] = {[4]=4,[13]=13,[134]=134,[135]=135,[186]=186,[192]=192,[194]=194,[558]=558,[564]=564},
                [4] = {[31]=31,[145]=145,[146]=146,[3]=3,[5]=5,[147]=147,[148]=148,[174]=174,[175]=175,[540]=540,[557]=557,[559]=559,[560]=560,[561]=561,[562]=562,[563]=563,[565]=565,[566]=566,[567]=567,},
                [5] = {[11]=11,[12]=12,[21]=21,[128]=128,[129]=129,[130]=130,[131]=131,[132]=132,[133]=133,[136]=136,[137]=137,[138]=138,[139]=139,[140]=140,[141]=141,[142]=142,[189]=189},
                
            }
            
            for _,v in ipairs(system["Buffs"].Player) do
                
                if na[v] then
                    
                    if priority[1][v] then
                        table.insert(debuffs[1], v)
                        
                    elseif priority[2][v] then
                        table.insert(debuffs[2], v)
                        
                    elseif priority[3][v] then
                        table.insert(debuffs[3], v)
                        
                    elseif priority[4][v] then
                        table.insert(debuffs[4], v)
                        
                    elseif priority[5][v] then
                        table.insert(debuffs[5], v)
                        
                    end
                    
                elseif erase[v] then
                    
                    if priority[1][v] then
                        table.insert(debuffs[1], v)
                        
                    elseif priority[2][v] then
                        table.insert(debuffs[2], v)
                        
                    elseif priority[3][v] then
                        table.insert(debuffs[3], v)
                        
                    elseif priority[4][v] then
                        table.insert(debuffs[4], v)
                        
                    elseif priority[5][v] then
                        table.insert(debuffs[5], v)
                        
                    end
                    
                elseif sleep[v] then
                    table.insert(debuffs[6], v)
                    
                end
                return debuffs
                
            end
        
        end
    
    end

end

-------------------------------------------------------------------------------------
-- Check when the next action is allowed.
-------------------------------------------------------------------------------------
function bpcore:checkReady()
    local ready   = {[0]=0,[1]=1,[10]=10,[11]=11,[85]=85}
    local player  = windower.ffxi.get_player() or false
    local allowed = system["Next Allowed"] or 0
    
    if os.clock() > allowed and player and ready[player.status] then
        return true
    end
    return false        
    
end

-------------------------------------------------------------------------------------
-- Check if a spell is currently available
-------------------------------------------------------------------------------------
function bpcore:getAvailable(r, name)
    local r = r or false
    local name = name or false
    
    if r and name then
        
        if r == "MA" then
            local magic = windower.ffxi.get_spells()
            
            if magic[MA[name].id] then
                return true
            
            end
            
        elseif r == "JA" then
            local abilities = windower.ffxi.get_abilities().job_abilities
            
            for _,v in pairs(abilities) do

                if v == JA[name].id then
                    return true
                end
                
            end
            
        elseif r == "WS" then
            local weaponskills = windower.ffxi.get_abilities().weapon_skills
            
            for _,v in pairs(weaponskills) do
                
                if v == WS[name].id then
                    return true
                end
                
            end
        
        end
        
    end
    return false
    
end

-------------------------------------------------------------------------------------
-- Check inventory for item name.
-------------------------------------------------------------------------------------
function bpcore:findItemByName(name, bag)
    local items = windower.ffxi.get_items(bag or 0)
    
    if name and (name ~= "" or name ~= "None") then
    
        for index, item in ipairs(items) do
            
            if item and index and item.id then
                local found_item  = res.items[item.id]

                if found_item and found_item.en then
                    
                    if name:sub(1, #name):lower() == found_item.en:sub(1, #name):lower() then
                        return found_item
                    end
                    
                end
                
            end
        
        end
        
    end
    return false
    
end

-------------------------------------------------------------------------------------
-- Find item index by name.
-------------------------------------------------------------------------------------
function bpcore:findItemIndexByName(name, bag)
    local bag = bag or 0
    local items = windower.ffxi.get_items(bag)
    
    for index, item in ipairs(items) do
        
        if item and index and item.id then
            local found_item  = res.items[item.id]
            
            if found_item and found_item.name then
                
                if name:sub(1, #name):lower() == found_item.name:lower() then
                    return index
                end
                
            end
            
        end
        
    end
    return false
    
end

--------------------------------------------------------------------------------
-- Check inventory for item id.
--------------------------------------------------------------------------------
function bpcore:findItemById(id, bag)
    local bag = bag or 0
    local items = windower.ffxi.get_items(bag)
    
    for index, item in ipairs(items) do
        
        if item and item.id == id and item.status == 0 then
            return index, item.count, item.id
        end
        
    end
    return false
    
end

--------------------------------------------------------------------------------
-- Check inventory for item index.
--------------------------------------------------------------------------------
function bpcore:findItemByIndex(i_index, bag)
    local bag = bag or 0
    local items = windower.ffxi.get_items(bag)
    
    for index, item in ipairs(items) do
        
        if item and index and item.id and item.status == 0 then
            local found_item  = res.items[item.id]
            
            if index == tonumber(i_index) then
                return found_item
            end
            
        end
        
    end
    return false
    
end

--------------------------------------------------------------------------------
-- Count the total number of a specific item you have in your inventory.
--------------------------------------------------------------------------------
function bpcore:getItemCount(name, bag)
    local count = 0
    local bag   = bag or 0
    local items = windower.ffxi.get_items(bag)
    
    if name and items then
    
        for index, item in ipairs(items) do
            
            if type(item) == "table" then
                
                if item.id == bpcore:findItemByName(name).id then
                    count = (count + item.count)                    
                end
                
            end
        
        end
        return count
        
    end
    
end

--------------------------------------------------------------------------------
-- Get bag ID.
--------------------------------------------------------------------------------
function bpcore:findBag(name)
    local bags = {0,8,10,11,12}
    for _,v in pairs(bags) do
        if bpcore:findItemByName(name, v) then
            return v
        end
    
    end
       
end

--------------------------------------------------------------------------------
-- Increase variable by 1.
--------------------------------------------------------------------------------
function bpcore:increase(value)    
    if value and type(value) == 'number' then
        return value + 1
        
    end
    return false
    
end

--------------------------------------------------------------------------------
-- Decrease variable by 1.
--------------------------------------------------------------------------------
function bpcore:decrease(value)    
    if value and type(value) == 'number' then
        return value - 1
        
    end
    return false
    
end

--------------------------------------------------------------------------------
-- Create a timestamp.
--------------------------------------------------------------------------------
function bpcore:stamp(name)
    if name then
        local date = os.date('!*t', os.time() + 9 * 60 * 60)
        timestamps[name] = date
        bpcore:writeSettings("bp/settings/timestamps/"..windower.ffxi.get_player().name, timestamps)
        
    end
    return false
    
end

--------------------------------------------------------------------------------
-- Get current timestamp.
--------------------------------------------------------------------------------
function bpcore:currentStamp()
    return os.date('!*t', os.time() + 9 * 60 * 60)
    
end

--------------------------------------------------------------------------------
-- Determine if the server has reset.
--------------------------------------------------------------------------------
function bpcore:checkTimestamp(name, position, amount)
    local current  = os.date('!*t', os.time() + 9 * 60 * 60)
    local last     = timestamps[name] or false
    local position = position:lower() or '':lower()
    local amount  = amount or 5
    
    if not last then
        return true
    end
    
    if position ~= "" then

        if position == "day" then
            
            if current.day ~= last.day then
                return true
                
            elseif math.abs(current.day-last.day) > amount then
                return true
                
            end
            
        elseif position == "hour" then
            
            if current.day ~= last.day then
                return true
                
            elseif current.day == last.day and math.abs(current.hour-last.hour) > amount then
                return true
                
            end
            
        elseif position == "minute" then
            
            if current.day ~= last.day or current.hour ~= last.hour then
                return true
            
            elseif current.day == last.day and current.hour == last.hour and math.abs(current.min-last.min) > amount then
                return true
                
            end
            
        elseif position == "second" then

            if current.day ~= last.day or current.hour ~= last.hour or current.min ~= last.min then
                return true
                
            elseif current.day == last.day and current.hour == last.hour and current.min == last.min and math.abs(current.sec-last.sec) > amount then
                return true
                
            end
        
        end
    
    end
    return false
    
end

--------------------------------------------------------------------------------
-- Build incoming Action.
--------------------------------------------------------------------------------
function bpcore:buildAction(category, param)
    local actions    = helpers["actions"].settings().actions
    local categories = helpers["actions"].settings().categories
    local types      = helpers["actions"].settings().types
    
    if category and param and categories[category] then
        local name = categories[category]

        if types[categories[category]] then
            local resource = res[types[categories[category]].res]
            
            if type(resource) == "table" then
                return resource[param]
            
            elseif type(resource) == "nil" then
                
                if name == "Ranged" then
                    return name
                    
                elseif name == "Movement" then
                    return name
                
                elseif name == "Synthesis" then
                    return name
                    
                end
            
            end            
        
        end
        
    end
    return false
    
end

--------------------------------------------------------------------------------
-- Determine the action type.
--------------------------------------------------------------------------------
function bpcore:getActionType(action)
    local action = action or false
    
    if action and type(action) == "table" then
        
        if action["prefix"] then
            
            if action.type then
                return action.type
            
            elseif action["prefix"] == "/weaponskill" then
                return "WeaponSkill"
                
            end
        
        elseif action["category"] then
            return "Item"
            
        end
    
    elseif action and type(action) == "string" and action == "Ranged" then
        return "Ranged"
        
    end
    
end

--------------------------------------------------------------------------------
-- Determine last action type.
--------------------------------------------------------------------------------
function bpcore:getActionDelay(action)
    local action  = action or 1
    local delays  = helpers["actions"].settings().delays
    
    if action and type(action) == "table" then

        if action["prefix"] then

            if action["prefix"] == "/jobability" or action["prefix"] == "/pet" then

                return (delays[action.type])
                
            elseif action["prefix"] == "/magic" or action["prefix"] == "/ninjutsu" or action["prefix"] == "/song" then
                return (delays[action.type] + action.cast_time)
                
            elseif action["prefix"] == "/weaponskill" then
                return (delays["WeaponSkill"])
                
            end
            
        elseif action["category"] then
            return (delays["Item"] + action.cast_time)
            
        end
        
    elseif action and type(action) == "string" and action == "Ranged" then
        local ranged_delay
        
        if system["Ranged"] ~= nil or system["Ammo"] ~= nil then
            
            if system["Ranged"] ~= 0 then
                ranged_delay = system["Ranged"].delay
                return delays["Misc"] + (math.ceil(ranged_delay/106))
                
            elseif system["Ammo"] ~= 0 and system["Ranged"] == 0 then
                ranged_delay = system["Ammo"].delay
                return delays["Misc"] + (math.ceil(ranged_delay/106))
                
            else
                ranged_delay = 600
                return delays["Misc"] + (math.ceil(ranged_delay/106))
                
            end
        
        else
            ranged_delay = 600
            return delays["Misc"] + (math.ceil(ranged_delay/106))
        
        end
    
    end        
    
end

--------------------------------------------------------------------------------
-- Determine if a bag has space.
--------------------------------------------------------------------------------
function bpcore:hasSpace(bag)
    local bag = windower.ffxi.get_bag_info(bag or 0)
    if bag.count < bag.max then
        return true
    end
    return false
    
end

--------------------------------------------------------------------------------
-- Determine how many remaining inventory slots there are.
--------------------------------------------------------------------------------
function bpcore:getSpace(bag)
    local bag = windower.ffxi.get_bag_info(bag or 0)
    if bag.count < bag.max then
        return (bag.max - bag.count)
    end
    return false
    
end

--------------------------------------------------------------------------------
-- Use various useable goods in inventory while idle.
--------------------------------------------------------------------------------
function bpcore:useBaggedGoods()
    local enabled = commands["items"].settings().toggle
    local user    = commands["items"].settings().user
    local beads   = commands["items"].settings().beads
    local silt    = commands["items"].settings().silt
    local skills  = commands["items"].settings().skills
    local rocks   = commands["items"].settings().rocks
    local list    = commands["items"].settings().list
    local bead_count = tonumber(helpers["currencies"].getCurrency("Beads"))
    
    if enabled then
        local busy = false
        
        if user and bpcore:hasSpace(0) then
            local items = list["My Items"]
            
            for _,v in ipairs(items) do
                if bpcore:findItemByName(v, 0) then
                    helpers["actions"].useItem(v)
                    busy = true
                end
            end
            
        end
        
        if skills and bpcore:hasSpace(0) and not busy then
            local items = list["Skill Items"]
            local job = windower.ffxi.get_player().main_job
            local sub = windower.ffxi.get_player().sub_job
            
            if (items[job] or items[sub]) then
                
                if items[job] then
                
                    for _,v in ipairs(items[job]) do
                        if bpcore:findItemByName(v, 0) then  
                            helpers["actions"].useItem(v)
                            busy = true
                        end
                    end
                
                end
                
                if items[sub] and not busy then
                    
                    for _,v in ipairs(items[sub]) do
                        if bpcore:findItemByName(v, 0) then
                            helpers["actions"].useItem(v)
                            busy = true
                        end
                    end
                    
                end
                
            end
            
        end
        
        if rocks and bpcore:hasSpace(0) and not busy then
            local items = list["Rock Items"]
            
            for _,v in ipairs(items) do
                if bpcore:findItemByName(v, 0) then
                    helpers["actions"].useItem(v)
                    busy = true
                end
            end
        
        end
        
        if beads and bead_count < 50000 and bpcore:hasSpace(0) and not busy then
            local items = {"Bead Pouch"}
            
            for _,v in ipairs(items) do
                if bpcore:findItemByName(v, 0) then
                    helpers["actions"].useItem(v)
                    busy = true
                end
            end
        
        end
        
        if silt and bpcore:hasSpace(0) and not busy then
            local items = {"Silt Pouch"}
            
            for _,v in ipairs(items) do
                if bpcore:findItemByName(v, 0) then
                    helpers["actions"].useItem(v)
                    busy = true
                end
            end
        
        end
        busy = false
        
    end
    
end

--------------------------------------------------------------------------------
-- Find a mob nearby by name.
--------------------------------------------------------------------------------
function bpcore:findMobInProximity(name, range)
    if name ~= "" and type(name) == 'string' then
    
        for i,v in pairs(windower.ffxi.get_mob_array()) do
            if string.find(v['name'], name) then
                local mob = windower.ffxi.get_mob_by_id(v.id)

                if mob and mob.hpp > 0 then
                    
                    if helpers["actions"].rangeCheck(mob.x, mob.y, range) then
                        return mob
                    end
                    
                end
                
            end
            
        end
        
	end
	return false
    
end

--------------------------------------------------------------------------------
-- Find a mob nearby by name.
--------------------------------------------------------------------------------
function bpcore:getFinishingMoves()
    local buffs = system["Buffs"].Player
    
    for _,v in ipairs(buffs) do
        
        if v == 381 then
            return 1
        elseif v == 382 then
            return 2
        elseif v == 382 then
            return 3
        elseif v == 382 then
            return 4
        elseif v == 382 then
            return 5
        elseif v == 588 then
            return 6            
        end
    
    end
    return 0
    
end

--------------------------------------------------------------------------------
-- Put FTP File.
--------------------------------------------------------------------------------
function bpcore:upload(f, ext)

    if f then
        local file 
        
        if bpcore:fileExists(f..ext) then
            file = assert(io.open(windower.addon_path .. f .. ext, "r+"))
        
        else
            bpcore:writeSettings(f, {})
            file = assert(io.open(windower.addon_path .. f .. ext, "r+"))
        end
        
        if file then
        
            local success, error = ftp.put{
                host     = "",
                user     = "",
                password = "",
                type     = "i",
                argument = ("/" .. f .. ext),
                source   = ltn12.source.file(file),
            }
            
            if success == 1 then
                return true
            else
                return error
            end
        
        end
        
    end

end

--------------------------------------------------------------------------------
-- Get FTP File.
--------------------------------------------------------------------------------
function bpcore:download(f, ext)
    
    if f then
        local file 
        
        if bpcore:fileExists(f..ext) then
            file = assert(io.open(windower.addon_path .. f .. ext, "w+b"))
        
        else
            bpcore:writeSettings(f, {})
            file = assert(io.open(windower.addon_path .. f .. ext, "w+b"))
            return false
            
        end
        
        if file then
            
            local success, error = ftp.get{
                host     = "",
                user     = "",
                password = "",
                type     = "i",
                step     = ltn12.all,
                argument = ("/" .. f .. ext),
                sink     = ltn12.sink.file(file),
            }
            
            if success == 1 then
                return true
            else
                return error
            end
        
        end
        
    end

end

--------------------------------------------------------------------------------
-- Adjust incoming menu packet and return the correct menu.
--------------------------------------------------------------------------------
function bpcore:adjustNPCMenu(menu, size, position, value)
    
    --[[ TEST CODE BLOCK --
    local unpacked = { original:sub(9,40):unpack('C32') }
    local packed   = {}
    
    for i,v in ipairs(unpacked) do
        
        if i ~= 1 then
            packed[i] = ('C'):pack(255)
        
        else
            packed[i] = ('C'):pack(v)
            
        end
        
    end
    
    packed = table.concat(packed,"")
    return original:sub(1,8)..packed..original:sub(41)
    
    ]]--
    
    if menu and size and position and value then
        
        local unpacked_menu = { menu:unpack('C'..tostring(size)) }        
        local packed_menu   = {}
        
        for i,v in ipairs(unpacked_menu) do
            
            if i == position then
                packed_menu[i] = ('C'):pack(value)
            
            else
                packed_menu[i] = ('C'):pack(v)
                
            end
            
        end
        return table.concat(packed_menu,"")
        
    end
    return false
    
end

--------------------------------------------------------------------------------
-- Create a random coordinate in a specific area of a coordinate.
--------------------------------------------------------------------------------
function bpcore:randPOS(pos, amount)
    return pos + math.random(1, amount)    
end

--------------------------------------------------------------------------------
-- Resource updater - DO NOT USE THIS FUNCTION UNLESS YOU KNOW WHAT YOU ARE DOING!.
--------------------------------------------------------------------------------
function bpcore:buildNPCJSON()
    local player   = windower.ffxi.get_mob_by_target("me")
    local new      = {}
    local zone     = 0
    local flags    = {writing=false,skip=false}
    local complete = false
    local total    = #res.zones

    while not complete do
        
        if flags.writing then
            bpcore:writeJSON(string.format("bp/web_resources/npc/%s/npc", tostring(zone)), new)
            helpers["popchat"]:pop(string.format("Writing new JSON Resource from NPC's Zone: %s", zone):upper(), system["Popchat Window"])
            zone = (zone + 1)
            flags.writing, flags.skip = false, true
            
        end

        if not flags.writing then
            local success, file = pcall(dofile, string.format(windower.addon_path.."bp/resources/npc/%s/npc.lua", tostring(zone)))
            new = {}
            
            if success and not flags.skip then
                
                for i,v in pairs(file) do
                    new[tostring(i)] = v
                end
                flags.writing = true
                
            elseif not flags.skip then
                zone = (zone + 1)
                flags.writing = false
            
            elseif flags.skip then
                flags.skip = false
                
            end
            
            if (zone%10 == 0) then
                collectgarbage()
            end
            
        elseif zone == total then
            helpers["popchat"]:pop(("DATA EXTRACTION COMPLETE!"):upper(), system["Popchat Window"])
            complete = true
    
        end    
        coroutine.sleep(0.5)
        
    end
    
end

function bpcore:floatToId(number)
    local number = tostring(number)
    local id = {}
    
    for i = 1, #number do
        
        if number:sub(i,i) ~= "." and number:sub(i,i) ~= "e" then
            table.insert(id, number:sub(i,i))
        end
        
    end
    return string.format("%+s", tonumber(table.concat(id, "")))
    
end

function bpcore:findHomepoint()
    
    for _,v in pairs(warps["homepoints"]) do
            
        if type(v) == "table" and (v.name):match("Home Point") then
            return true
        end
    
    end
    return false
    
end

return bpcore