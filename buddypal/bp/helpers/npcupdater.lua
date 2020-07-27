--------------------------------------------------------------------------------
-- NPCUpdater helper: This handles incoming string values of incoming 0x00E update packet.
--------------------------------------------------------------------------------
local npcupdater = {}
event = 0
function npcupdater:build(raw_data, extra)
    local e = extra or false
    
    if raw_data then
        
        local data = {
            
            header      = raw_data:unpack('i', 0x00+1),
            npc         = raw_data:unpack('I', 0x04+1),
            index       = raw_data:unpack('H', 0x08+1),
            rotation    = raw_data:unpack('C', 0x0b+1),
            x           = raw_data:unpack('f', 0x0c+1),
            z           = raw_data:unpack('f', 0x10+1),
            y           = raw_data:unpack('f', 0x14+1),
            walk_count  = raw_data:unpack('I', 0x18+1),
            hpp         = raw_data:unpack('C', 0x1e+1),
            status      = raw_data:unpack('C', 0x1f+1),
            claimer     = raw_data:unpack('I', 0x2c+1),
            name        = raw_data:unpack('z', 0x34+1),
            event       = 0,
            mbits       = "",
            ubits       = {[1]="",[2]="",[3]="",[4]="",[5]=""},
            model       = raw_data:unpack('H', 0x32+1),
            mhex        = bit.tohex(raw_data:byte(0x0a+1),2),
            uhex1_1     = bit.tohex(raw_data:byte(0x1a+1),2),
            uhex1_2     = bit.tohex(raw_data:byte(0x1b+1),2),
            uhex2_1     = bit.tohex(raw_data:byte(0x20+1),2), 
            uhex2_2     = bit.tohex(raw_data:byte(0x21+1),2), 
            uhex2_3     = bit.tohex(raw_data:byte(0x22+1),2), 
            uhex2_4     = bit.tohex(raw_data:byte(0x23+1),2),
            uhex3_1     = bit.tohex(raw_data:byte(0x24+1),2), 
            uhex3_2     = bit.tohex(raw_data:byte(0x25+1),2),
            uhex3_3     = bit.tohex(raw_data:byte(0x26+1),2), 
            uhex3_4     = bit.tohex(raw_data:byte(0x27+1),2),
            uhex4_1     = bit.tohex(raw_data:byte(0x28+1),2),
            uhex4_2     = bit.tohex(raw_data:byte(0x29+1),2),
            uhex4_3     = bit.tohex(raw_data:byte(0x2a+1),2), 
            uhex4_4     = bit.tohex(raw_data:byte(0x2b+1),2),
            uhex5       = bit.tohex(raw_data:byte(0x30+1),2),
        }
        
        for i=1, 8, +1 do
            data.mbits = data.mbits .. raw_data:unpack('b', 0x0a+1, i)
        end
        
        for i=1, 16, +1 do
            if i % 8 == 0 then
                data.ubits[1] = data.ubits[1] .. raw_data:unpack('b', 0x1a+1, i) .. " "
            else
                data.ubits[1] = data.ubits[1] .. raw_data:unpack('b', 0x1a+1, i+1)
            end
        end
        
        for i=1, 32, +1 do
            if i % 8 == 0 then
                data.ubits[2] = data.ubits[2] .. raw_data:unpack('b', 0x20+1, i) .. " "
            else
                data.ubits[2] = data.ubits[2] .. raw_data:unpack('b', 0x20+1, i)
            end
        end
        
        for i=1, 32, +1 do
            if i % 8 == 0 then
                data.ubits[3] = data.ubits[3] .. raw_data:unpack('b', 0x24+1, i) .. " "
            else
                data.ubits[3] = data.ubits[3] .. raw_data:unpack('b', 0x24+1, i)
            end
        end
        
        for i=1, 32, +1 do
            if i % 8 == 0 then
                data.ubits[4] = data.ubits[4] .. raw_data:unpack('b', 0x28+1, i) .. " "
            else
                data.ubits[4] = data.ubits[4] .. raw_data:unpack('b', 0x28+1, i)
            end
        end
        
        for i=1, 8, +1 do
            data.ubits[5] = data.ubits[5] .. raw_data:unpack('b', 0x30+1, i)
        end
        
        if type(e) == 'string' then
        
            if tostring(e) == tostring(data.npc) then
                local mob = windower.ffxi.get_mob_by_name(e)
                
                print("-----------------------------------------")
                print("[ " .. mob.name .. " ] [ Event# "..tostring(event).." ] [ Status: "..tostring(mob.status).." ] [ Distance: "..tostring(math.sqrt(mob.distance)).." ]")
                print("` ":rpad(" ",5))
                print("Mask: ":lpad(" ",11).."Hex [ "..data.mhex:rpad(" ",11).." ] "..data.mbits)
                print("_unknown1: Hex [ "..data.uhex1_1.." "..data.uhex1_2:rpad(" ",8).." ] "..data.ubits[1])
                print("_unknown2: Hex [ "..data.uhex2_1.." "..data.uhex2_2.." "..data.uhex2_3.." "..data.uhex2_4.." ] "..data.ubits[2])
                print("_unknown3: Hex [ "..data.uhex3_1.." "..data.uhex3_2.." "..data.uhex3_3.." "..data.uhex3_4.." ] "..data.ubits[3])
                print("_unknown4: Hex [ "..data.uhex4_1.." "..data.uhex4_2.." "..data.uhex4_3.." "..data.uhex4_4.." ] "..data.ubits[4])
                print("_unknown5: Hex [ "..data.uhex5:rpad(" ",11).." ] "..data.ubits[5])
                print("Model: ":lpad(" ",11).."Hex [ "..bit.tohex(raw_data:byte(0x32+1),2).." "..bit.tohex(raw_data:byte(0x33+1),2):rpad(" ",8).." ] "..data.model)
                print("-----------------------------------------")
                event = event+1
                
                if event > 499 then
                    event = 0
                end
                
            end
            
        elseif type(e) == 'number' then
            
            if tonumber(e) == tonumber(data.npc) then
                local mob = windower.ffxi.get_mob_by_id(e)
                
                print("-----------------------------------------")
                print("[ " .. mob.name .. " ] [ Event# "..tostring(event).." ] [ Status: "..tostring(mob.status).." ] [ Distance: "..tostring(math.sqrt(mob.distance)).." ]")
                print("` ":rpad(" ",5))
                print("Mask: ":lpad(" ",11).."Hex [ "..data.mhex:rpad(" ",11).." ] "..data.mbits)
                print("_unknown1: Hex [ "..data.uhex1_1.." "..data.uhex1_2:rpad(" ",8).." ] "..data.ubits[1])
                print("_unknown2: Hex [ "..data.uhex2_1.." "..data.uhex2_2.." "..data.uhex2_3.." "..data.uhex2_4.." ] "..data.ubits[2])
                print("_unknown3: Hex [ "..data.uhex3_1.." "..data.uhex3_2.." "..data.uhex3_3.." "..data.uhex3_4.." ] "..data.ubits[3])
                print("_unknown4: Hex [ "..data.uhex4_1.." "..data.uhex4_2.." "..data.uhex4_3.." "..data.uhex4_4.." ] "..data.ubits[4])
                print("_unknown5: Hex [ "..data.uhex5:rpad(" ",11).." ] "..data.ubits[5])
                print("Model: ":lpad(" ",11).."Hex [ "..bit.tohex(raw_data:byte(0x32+1),2).." "..bit.tohex(raw_data:byte(0x33+1),2):rpad(" ",8).." ] "..data.model)
                print("-----------------------------------------")
                event = event+1
                
                if event > 499 then
                    event = 0
                end
                
            end
        
        end
        return data
        
    end
    return nil
    
end
--[[
function npcupdater:newUpdate(original)
    
    if original then
        
        local header, npc, index, mask, rotation, x, z, y, walk_count, _u1, hpp, status, _u2, _u3, _u4, claimer, _u5, model, name
        
        header      = original:unpack('i', 0x00+1),,
            npc         = original:unpack('I', 0x04+1),
            index       = original:unpack('H', 0x08+1),
            rotation    = original:unpack('C', 0x0b+1),
            x           = original:unpack('f', 0x0c+1),
            z           = original:unpack('f', 0x10+1),
            y           = original:unpack('f', 0x14+1),
            walk_count  = original:unpack('I', 0x18+1),
            hpp         = original:unpack('C', 0x1e+1),
            status      = original:unpack('C', 0x1f+1),
            claimer     = original:unpack('I', 0x2c+1),
            name        = original:unpack('z', 0x34+1),
            mbits       = "",
            ubits       = {[1]="",[2]="",[3]="",[4]="",[5]=""},
            model       = original:unpack('H', 0x32+1),
        
        local update = 'iIHCCfffIHCCIIIIHHz':pack(header, npc, index, mask, rotation, x, z, y, walk_count, _u1, hpp, status, _u2, _u3, _u4, claimer, _u5, model, name)
        
            local inject = 'iIHHHHfff':pack(header, target.id, target.index, system["Actions"][action], param.id, 0, 0, 0, 0)
            --string.char(0x1A,0x08,0,0)..'I':pack(target.id)..'H':pack(index)..string.char(0x0F,0,0,0,0,0)..string.char(0):rep(12)
            windower.packets.inject_outgoing(0x01a, inject)
            return true
            
    
    end
    return false
    
end

local st = {[0]=true,[2]=true,[3]=true}
if mask_bits:sub(1,4) ~= '1111' then
                    
    model_set[mob.id] = {}
    
    local pack_mask = 0x0f
    local pack1_1   = 0x0001 
    local pack2_1   = 0x00000000 -- 1d07, 0d07, 0507, 0107
    local pack3_1   = 0x00000000
    local pack4_1   = 0x00000000
    local pack5_1   = 0x0000
    local model1    = 0x0201
    
    
    return original:sub(1,10).. --1 -10
    'C':pack(pack_mask)..       --11
    original:sub(12,28)..       --12 
    'H':pack(pack1_1)..         --13-14
    'C':pack(0x75)..
    original:sub(32,32)..       --15-16
    'I':pack(pack2_1)..         --17-18-19-20
    'I':pack(pack3_1)..         --21-22-23-24
    'I':pack(pack4_1)..         --25-26-27-28
    original:sub(45,48)..       --29-32
    'H':pack(pack5_1)..         --33-34
    'H':pack(model1)..          --51-52 (37)
    original:sub(53)

end
--]]

return npcupdater