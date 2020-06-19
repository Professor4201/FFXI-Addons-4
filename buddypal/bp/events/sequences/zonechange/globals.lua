local globals = {}
    
--------------------------------------------------------------------------------
-- Zone Change Event.
--------------------------------------------------------------------------------
globals[1] = function(new, old)
    local zone = windower.ffxi.get_info().zone
    
    npcs   = bpcore:handleSettings("bp/resources/npc/"..zone.."/npc", {})
    gather = bpcore:handleSettings("bp/resources/gather/"..zone.."/gather", {})
    warps  = {

        ['homepoints'] = bpcore:handleSettings('bp/resources/homepoints/' ..zone.. '/homepoints', {}),
        ['guides']     = bpcore:handleSettings('bp/resources/guides/'     ..zone.. '/guides',     {}),
        ['escha']      = bpcore:handleSettings('bp/resources/escha/'      ..zone.. '/escha',      {}),
        ['abyssea']    = bpcore:handleSettings('bp/resources/abyssea/'    ..zone.. '/abyssea',    {}),
        ['proto']      = bpcore:handleSettings('bp/resources/proto/'      ..zone.. '/proto',      {}),
        ['vw']         = bpcore:handleSettings('bp/resources/vw/'         ..zone.. '/vw',         {}),
        ['conflux']    = bpcore:handleSettings('bp/resources/conflux/'    ..zone.. '/conflux',    {}),
        ['unity']      = bpcore:handleSettings('bp/resources/unity/'      ..zone.. '/unity',      {}),
        ['waypoints']  = bpcore:handleSettings('bp/resources/waypoints/'  ..zone.. '/waypoints',  {}),
    
    }
    
    -- Adjust ping when zoning to prevent firing before loading.
    if system["BP Enabled"]:current() then
        bpcore:delayPing(system["Zone Delay"])
    end
    
    -- Clear stuff..
    helpers["queue"].clear()
    helpers["status"].clear()
    
end

return globals