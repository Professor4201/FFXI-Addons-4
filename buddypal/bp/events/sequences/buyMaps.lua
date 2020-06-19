-- Custom Events.
local buyMaps = function(id, data)
    
    if id == 0x032 or id == 0x034 then        
        
        local p = packets.parse('incoming', data)                           
        local npcs = {[17780860] = {id=17780860, index=124, menuid=10000, maps=255}}
        local target = windower.ffxi.get_mob_by_id(p['NPC'])
        
        if target and npcs[target.id] and math.sqrt(target.distance) < 6 then
            
            for i=40, npcs[target.id].maps do
                
                local map = packets.new('outgoing', 0x05b, {
                    ['Target']            = target.id,
                    ['Option Index']      = 1,
                    ['_unknown1']         = i,
                    ['Target Index']      = target.index,
                    ['Automated Message'] = true,
                    ['Zone']              = windower.ffxi.get_info().zone,
                    ['Menu ID']           = npcs[target.id].menuid,
                })
                packets.inject(map)
                
                if i == npcs[target.id].maps then
                
                    local exit = packets.new('outgoing', 0x05b, {
                        ['Target']            = target.id,
                        ['Option Index']      = 0,
                        ['_unknown1']         = 16384,
                        ['Target Index']      = target.index,
                        ['Automated Message'] = false,
                        ['Zone']              = windower.ffxi.get_info().zone,
                        ['Menu ID']           = npcs[target.id].menuid,
                    })
                    packets.inject(exit)
                    coroutine.sleep(1)
                    helpers['events']:unregister('buyMaps')
                    
                end
                
            end
            return true
            
        end        
        
        helpers['popchat']:pop("Unable to find a map vendor.", system["Popchat Window"])
        local exit = packets.new('outgoing', 0x05b, {
            ['Target']            = target.id,
            ['Option Index']      = 0,
            ['_unknown1']         = 16384,
            ['Target Index']      = target.index,
            ['Automated Message'] = false,
            ['Zone']              = windower.ffxi.get_info().zone,
            ['Menu ID']           = npcs[target.id].menuid,
        })
        packets.inject(exit)
        helpers['events']:unregister('buyMaps')
        return true
        
    end
    
end
return buyMaps