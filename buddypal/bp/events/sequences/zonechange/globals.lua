local globals = {}
    
--------------------------------------------------------------------------------
-- Zone Change Event.
--------------------------------------------------------------------------------
globals[1] = function(new, old)
    npcs   = bpcore:handleSettings("bp/resources/npc/"..new.."/npc", {})
    gather = bpcore:handleSettings("bp/resources/gather/"..new.."/gather", {})
    warps  = {

        ['homepoints'] = bpcore:handleSettings('bp/resources/homepoints/' ..new.. '/homepoints', {}),
        ['guides']     = bpcore:handleSettings('bp/resources/guides/'     ..new.. '/guides',     {}),
        ['escha']      = bpcore:handleSettings('bp/resources/escha/'      ..new.. '/escha',      {}),
        ['abyssea']    = bpcore:handleSettings('bp/resources/abyssea/'    ..new.. '/abyssea',    {}),
        ['proto']      = bpcore:handleSettings('bp/resources/proto/'      ..new.. '/proto',      {}),
        ['vw']         = bpcore:handleSettings('bp/resources/vw/'         ..new.. '/vw',         {}),
        ['conflux']    = bpcore:handleSettings('bp/resources/conflux/'    ..new.. '/conflux',    {}),
        ['unity']      = bpcore:handleSettings('bp/resources/unity/'      ..new.. '/unity',      {}),
        ['waypoints']  = bpcore:handleSettings('bp/resources/waypoints/'  ..new.. '/waypoints',  {}),
    
    }
    
    -- Update nav map.
    if helpers["nav"] ~= nil then
        helpers["nav"].updateMap()
    end
    
    -- Adjust ping when zoning to prevent firing before loading.
    if system["BP Enabled"]:current() then
        bpcore:delayPing(system["Zone Delay"])
    end
    
    -- Clear stuff..
    helpers["queue"].clear()
    helpers["status"].clear()
    helpers["actions"].setMidaction(false)
    
end

return globals