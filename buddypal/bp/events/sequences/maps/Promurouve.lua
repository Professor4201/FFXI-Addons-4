local buymaps  = {}
local settings = {
    
    map_vendors     = {[17780860] = {id=17780860, index=124, menuid=10000, maps=100}},
    
}

buymaps['buy maps'] = function(id,original,modified,injected,blocked)
    
    if id == 0x032 or id == 0x034 then
        local p = packets.parse('incoming', original)                           
        local target = windower.ffxi.get_mob_by_id(p['NPC'])
        local vendor = settings.map_vendors
        
        if target and vendor[target.id] and math.sqrt(target.distance) < 6 then
            
            for i=0, vendor[target.id].maps do
                
                local map = packets.new('outgoing', 0x05b, {
                    ['Target']            = target.id,
                    ['Option Index']      = 1,
                    ['_unknown1']         = i,
                    ['Target Index']      = target.index,
                    ['Automated Message'] = true,
                    ['Zone']              = windower.ffxi.get_info().zone,
                    ['Menu ID']           = vendor[target.id].menuid,
                })
                packets.inject(map)
                
                if i == vendor[target.id].maps then
                
                    local exit = packets.new('outgoing', 0x05b, {
                        ['Target']            = target.id,
                        ['Option Index']      = 0,
                        ['_unknown1']         = 16384,
                        ['Target Index']      = target.index,
                        ['Automated Message'] = false,
                        ['Zone']              = windower.ffxi.get_info().zone,
                        ['Menu ID']           = vendor[target.id].menuid,
                    })
                    packets.inject(exit)
                    helpers['events'].finishEvent("Basic")
                    
                end
                
            end
        
        else
        
            helpers['popchat']:pop("Unable to find a map vendor.", system["Popchat Window"])
            local exit = packets.new('outgoing', 0x05b, {
                ['Target']            = target.id,
                ['Option Index']      = 0,
                ['_unknown1']         = 16384,
                ['Target Index']      = target.index,
                ['Automated Message'] = false,
                ['Zone']              = windower.ffxi.get_info().zone,
                ['Menu ID']           = vendor[target.id].menuid,
            })
            packets.inject(exit)
            helpers['events'].finishEvent("Basic")
                
        end
        
    end
    return true
    
end

buymaps['registry'] = {
    ['buy maps'] = "incoming chunk",
}

return buymaps