--------------------------------------------------------------------------------
-- Stats helper: Handles player stats stored on private server.
--------------------------------------------------------------------------------
local stats = {}
function stats.new()
    local self = {}
    
    local name   = windower.ffxi.get_player().name:lower()
    local server = res.servers[windower.ffxi.get_info().server].en:lower()
    local delay  = 15
    local update = os.clock()
    local blank = {
    
        ["Status"]     = {},
        ["Player"]     = {},
        ["Stats"]      = {},
        ["Inventory"]  = {},
        ["Equipment"]  = {},
        ["Currencies"] = {},
    
    }
    
    local data = bpcore:handleSettings("bp/export/"..server.."/"..name, blank)
    
    -- Local equipment fetch function.
    local function fetchEquipment(equipment)
    
        local new_equipment = {
            ["Main"]  = {},
            ["Sub"]   = {},
            ["Range"] = {},
            ["Ammo"]  = {},
            ["Head"]  = {},
            ["Neck"]  = {},
            ["Ear1"]  = {},
            ["Ear2"]  = {},
            ["Body"]  = {},
            ["Hands"] = {},
            ["Ring1"] = {},
            ["Ring2"] = {},
            ["Back"]  = {},
            ["Waist"] = {},
            ["Legs"]  = {},
            ["Feet"]  = {},
        }
        
        if equipment then
            
            if equipment["main"] and equipment["main_bag"] and equipment["main"] ~= 0 then
                local main = windower.ffxi.get_items(equipment["main_bag"], equipment["main"])
                local name = res.items:with('id', main.id).en
                new_equipment["Main"] = {["Id"] = tostring(main.id), ["Slot"] = "Main", ["Name"] = name}
                
                if main.extdata then
                    local augs = extdata.decode(main).augments
                    if type(augs) == "table" then
                        new_equipment["Main"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["sub"] and equipment["sub_bag"] and equipment["sub"] ~= 0 then
                local sub = windower.ffxi.get_items(equipment["sub_bag"], equipment["sub"])
                local name = res.items:with('id', sub.id).en
                new_equipment["Sub"] = {["Id"] = tostring(sub.id), ["Slot"] = "Sub", ["Name"] = name}
                
                if sub.extdata then
                    local augs = extdata.decode(sub).augments
                    if type(augs) == "table" then
                        new_equipment["Sub"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["range"] and equipment["range_bag"] and equipment["range"] ~= 0 then
                local range = windower.ffxi.get_items(equipment["range_bag"], equipment["range"])
                local name = res.items:with('id', range.id).en
                new_equipment["Range"] = {["Id"] = tostring(range.id), ["Slot"] = "Range", ["Name"] = name}
                
                if range.extdata then
                    local augs = extdata.decode(range).augments
                    if type(augs) == "table" then
                        new_equipment["Range"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["ammo"] and equipment["ammo_bag"] and equipment["ammo"] ~= 0 then
                local ammo = windower.ffxi.get_items(equipment["ammo_bag"], equipment["ammo"])
                local name = res.items:with('id', ammo.id).en
                new_equipment["Ammo"] = {["Id"] = tostring(ammo.id), ["Slot"] = "Ammo", ["Name"] = name}
                
                if ammo.extdata then
                    local augs = extdata.decode(ammo).augments
                    if type(augs) == "table" then
                        new_equipment["Ammo"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["head"] and equipment["head_bag"] and equipment["head"] ~= 0 then
                local head = windower.ffxi.get_items(equipment["head_bag"], equipment["head"])
                local name = res.items:with('id', head.id).en
                new_equipment["Head"] = {["Id"] = tostring(head.id), ["Slot"] = "Head", ["Name"] = name}
                
                if head.extdata then
                    local augs = extdata.decode(head).augments
                    if type(augs) == "table" then
                        new_equipment["Head"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["neck"] and equipment["neck_bag"] and equipment["neck"] ~= 0 then
                local neck = windower.ffxi.get_items(equipment["neck_bag"], equipment["neck"])
                local name = res.items:with('id', neck.id).en
                new_equipment["Neck"] = {["Id"] = tostring(neck.id), ["Slot"] = "Neck", ["Name"] = name}
                
                if neck.extdata then
                    local augs = extdata.decode(neck).augments
                    if type(augs) == "table" then
                        new_equipment["Neck"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["left_ear"] and equipment["left_ear_bag"] and equipment["ammo"] ~= 0 then
                local left_ear = windower.ffxi.get_items(equipment["left_ear_bag"], equipment["left_ear"])
                local name = res.items:with('id', left_ear.id).en
                new_equipment["Ear1"] = {["Id"] = tostring(left_ear.id), ["Slot"] = "Ear1", ["Name"] = name}
                
                if left_ear.extdata then
                    local augs = extdata.decode(left_ear).augments
                    if type(augs) == "table" then
                        new_equipment["Ear1"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["right_ear"] and equipment["right_ear_bag"] and equipment["right_ear"] ~= 0 then
                local right_ear = windower.ffxi.get_items(equipment["right_ear_bag"], equipment["right_ear"])
                local name = res.items:with('id', right_ear.id).en
                new_equipment["Ear2"] = {["Id"] = tostring(right_ear.id), ["Slot"] = "Ear2", ["Name"] = name}
                
                if right_ear.extdata then
                    local augs = extdata.decode(right_ear).augments
                    if type(augs) == "table" then
                        new_equipment["Ear2"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["body"] and equipment["body_bag"] and equipment["body"] ~= 0 then
                local body = windower.ffxi.get_items(equipment["body_bag"], equipment["body"])
                local name = res.items:with('id', body.id).en
                new_equipment["Body"] = {["Id"] = tostring(body.id), ["Slot"] = "Body", ["Name"] = name}
                
                if body.extdata then
                    local augs = extdata.decode(body).augments
                    if type(augs) == "table" then
                        new_equipment["Body"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["hands"] and equipment["hands_bag"] and equipment["hands"] ~= 0 then
                local hands = windower.ffxi.get_items(equipment["hands_bag"], equipment["hands"])
                local name = res.items:with('id', hands.id).en
                new_equipment["Hands"] = {["Id"] = tostring(hands.id), ["Slot"] = "Hands", ["Name"] = name}
                
                if hands.extdata then
                    local augs = extdata.decode(hands).augments
                    if type(augs) == "table" then
                        new_equipment["Hands"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["left_ring"] and equipment["left_ring_bag"] and equipment["left_ring"] ~= 0 then
                local left_ring = windower.ffxi.get_items(equipment["left_ring_bag"], equipment["left_ring"])
                local name = res.items:with('id', left_ring.id).en
                new_equipment["Ring1"] = {["Id"] = tostring(left_ring.id), ["Slot"] = "Ring1", ["Name"] = name}
                
                if left_ring.extdata then
                    local augs = extdata.decode(left_ring).augments
                    if type(augs) == "table" then
                        new_equipment["Ring1"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["right_ring"] and equipment["right_ring_bag"] and equipment["right_ring"] ~= 0 then
                local right_ring = windower.ffxi.get_items(equipment["right_ring_bag"], equipment["right_ring"])
                local name = res.items:with('id', right_ring.id).en
                new_equipment["Ring2"] = {["Id"] = tostring(right_ring.id), ["Slot"] = "Ring2", ["Name"] = name}
                
                if right_ring.extdata then
                    local augs = extdata.decode(right_ring).augments
                    if type(augs) == "table" then
                        new_equipment["Ring2"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["back"] and equipment["back_bag"] and equipment["back"] ~= 0 then
                local back = windower.ffxi.get_items(equipment["back_bag"], equipment["back"])
                local name = res.items:with('id', back.id).en
                new_equipment["Back"] = {["Id"] = tostring(back.id), ["Slot"] = "Back", ["Name"] = name}
                
                if back.extdata then
                    local augs = extdata.decode(back).augments
                    if type(augs) == "table" then
                        new_equipment["Back"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["waist"] and equipment["waist_bag"] and equipment["waist"] ~= 0 then
                local waist = windower.ffxi.get_items(equipment["waist_bag"], equipment["waist"])
                local name = res.items:with('id', waist.id).en
                new_equipment["Waist"] = {["Id"] = tostring(waist.id), ["Slot"] = "Waist", ["Name"] = name}
                
                if waist.extdata then
                    local augs = extdata.decode(waist).augments
                    if type(augs) == "table" then
                        new_equipment["Waist"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["legs"] and equipment["legs_bag"] and equipment["legs"] ~= 0 then
                local legs = windower.ffxi.get_items(equipment["legs_bag"], equipment["legs"])
                local name = res.items:with('id', legs.id).en
                new_equipment["Legs"] = {["Id"] = tostring(legs.id), ["Slot"] = "Legs", ["Name"] = name}
                
                if legs.extdata then
                    local augs = extdata.decode(legs).augments
                    if type(augs) == "table" then
                        new_equipment["Legs"]["Augments"] = augs
                    end
                end
                
            end
            
            if equipment["feet"] and equipment["feet_bag"] and equipment["feet"] ~= 0 then
                local feet = windower.ffxi.get_items(equipment["feet_bag"], equipment["feet"])
                local name = res.items:with('id', feet.id).en
                new_equipment["Feet"] = {["Id"] = tostring(feet.id), ["Slot"] = "Feet", ["Name"] = name}
                
                if feet.extdata then
                    local augs = extdata.decode(feet).augments
                    if type(augs) == "table" then
                        new_equipment["Feet"]["Augments"] = augs
                    end
                end
                
            end
            return new_equipment
            
        end
        return false
            
    end
    
    self.buildInventory = function()
        local temp = {}
        for i=0, 12 do
            
            for i,v in ipairs(windower.ffxi.get_items(i)) do
                
                if type(v) == "table" then
                    
                    for name, value in pairs(v) do
                        
                        if name and value and name == "id" and value ~= 0 then
                            local item = res.items[value]
                            
                            if item then
                                temp[item.name] = {}
                                temp[item.name] = {id=item.id, name=item.name}
                            end
                        
                        end
                        
                    end
                    
                end
                
            end
            
        end
        data["Inventory"] = temp
        
    end
    
    self.buildEquipment = function()
        local equipment = windower.ffxi.get_items()["equipment"]
        local gear = fetchEquipment(equipment)
        data["Equipment"] = gear
        
    end
    
    self.buildPlayer = function()

        if windower.ffxi.get_player() then  
            
            for i,v in pairs(windower.ffxi.get_player()) do
                
                if i == "skills" then
                    data["Player"]["Skills"] = {}
                    
                    for ii,vv in pairs(v) do
                        data["Player"]["Skills"][ii] = vv
                    end
                    
                elseif i == "jobs" then
                    data["Player"]["Jobs"] = {}
                    
                    for ii,vv in pairs(v) do
                        data["Player"]["Jobs"][ii] = vv
                    end
                    
                elseif i == "merits" then
                    data["Player"]["Merits"] = {}
                    
                    for ii,vv in pairs(v) do
                        data["Player"]["Merits"][ii] = vv
                    end
                    
                elseif i == "job_points" then
                    data["Player"]["Job Points"] = {}
                    
                    for ii,vv in pairs(v) do
                        
                        if type(vv) == "table" then
                        data["Player"]["Job Points"][ii:upper()] = {}
                        
                            for iii,vvv in pairs(vv) do
                                data["Player"]["Job Points"][ii:upper()][iii] = vvv
                            end
                            
                        end
                        
                    end
                    
                elseif i == "name" then
                    data["Player"]["Name"] = v
                    
                elseif i == "nation" then
                    data["Player"]["Nation"] = res.regions[v].en
                    
                elseif i == "main_job_full" then
                    data["Player"]["Main Job"] = v
                    
                elseif i == "main_job_level" then
                    data["Player"]["Main Level"] = v
                    
                elseif i == "sub_job_full" then
                    data["Player"]["Sub Job"] = v
                    
                elseif i == "sub_job_level" then
                    data["Player"]["Sub Level"] = v
                    
                end
                
            end
            windower.packets.inject_outgoing(0x061,'00000000')
            
        end
        
    end
    
    self.buildStatus = function()
       
        if windower.ffxi.get_info() then
            
            for i,v in pairs(windower.ffxi.get_info()) do
                
                if i == "logged_in" then
                    data["Status"][i] = v
                    
                elseif i == "day" then
                    data["Status"][i] = {}
                    table.insert(data["Status"][i], {["Id"] = v, ["Name"] = res.days[v].en})
                    
                elseif i == "weather" then
                    data["Status"][i] = {}
                    table.insert(data["Status"][i], {["Id"] = v, ["Name"] = res.weather[v].en})
                    
                elseif i == "moon_phase" then
                    data["Status"][i] = {}
                    table.insert(data["Status"][i], {["Id"] = v, ["Name"] = res.moon_phases[v].en})
                    
                elseif i == "zone" then
                    data["Status"][i] = {}
                    table.insert(data["Status"][i], {["Id"] = v, ["Name"] = res.zones[v].en})
                    
                elseif i == "server" then
                    data["Status"][i] = {}
                    table.insert(data["Status"][i], {["Id"] = v, ["Name"] = res.servers[v].en})
                    
                end
                
            end
            
        end
        return false
        
    end
    
    self.buildCurrencies = function()
        local toggle     = commands["currencies"].settings().toggle
        local currencies = helpers["currencies"].getAllCurrency()
        local temp       = {}
        
        if toggle and currencies ~= nil then
        
            for i,v in pairs(currencies) do
                temp[i] = {}
                table.insert(temp[i], tonumber(v))
            
            end
            data["Currencies"] = temp
        end
        
    end
    
    self.buildStats = function(packet)
        local packet = packet or false
        
        if packet then

            if packet["Base STR"] and packet["Added STR"] then
                system["Stats"].STR = (packet["Base STR"] + packet["Added STR"])
            end
            
            if packet["Base DEX"] and packet["Added DEX"] then
                system["Stats"].DEX = (packet["Base DEX"] + packet["Added DEX"])
            end
            
            if packet["Base VIT"] and packet["Added VIT"] then
                system["Stats"].VIT = (packet["Base VIT"] + packet["Added VIT"])
            end
            
            if packet["Base AGI"] and packet["Added AGI"] then
                system["Stats"].AGI = (packet["Base AGI"] + packet["Added AGI"])
            end
            
            if packet["Base INT"] and packet["Added INT"] then
                system["Stats"].INT = (packet["Base INT"] + packet["Added INT"])
            end
            
            if packet["Base MND"] and packet["Added MND"] then
                system["Stats"].MND = (packet["Base MND"] + packet["Added MND"])
            end
            
            if packet["Base CHR"] and packet["Added CHR"] then
                system["Stats"].CHR = (packet["Base CHR"] + packet["Added CHR"])
            end
            
        end
        
    end
    
    self.updateData = function()
        helpers['stats'].buildPlayer()
        helpers['stats'].buildInventory()
        helpers['stats'].buildEquipment()
        helpers['stats'].buildCurrencies()
        helpers['stats'].buildStatus()
        
        local data = helpers['stats'].getData()
        
        -- Write data locally.
        bpcore:writeSettings("bp/export/"..server.."/"..name, data)
        bpcore:writeJSON("bp/export/"..server.."/"..name, data)
    
    end
    
    self.getData = function()
        return data
        
    end
    
    return self
    
end
return stats.new()