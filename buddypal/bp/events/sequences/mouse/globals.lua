local globals = {}

--------------------------------------------------------------------------------
-- Mouse Event.
--------------------------------------------------------------------------------
globals[1] = function(type, x, y, delta, blocked)
    local player = windower.ffxi.get_player()
    
    if player then
        
        if helpers["warp"] ~= nil and #helpers["warp"].getList() > 0 then
            local warper   = helpers["warp"].getDisplays()
            local list     = helpers["warp"].getList()
    
            if warper and type == 1 then
                
                for i,_ in pairs(warper) do
                    
                    if warper[i]:hover(x, y) then
                        helpers["actions"].reposition(list[i].position.x-0.6, list[i].position.y-0.6, list[i].position.z)
                        return true
                        
                    end
                    
                end
            
            elseif warper and type == 2 then
                
                for i,_ in pairs(warper) do
                    
                    if warper[i]:hover(x, y) then
                        return true
                        
                    end
                    
                end
                
            end
        
        elseif helpers["interact"] ~= nil and #helpers["interact"].getList() > 0 then
            local displays = helpers["interact"].getDisplays()
            local list     = helpers["interact"].getList()
    
            if displays and type == 1 then
                
                for i,_ in pairs(displays) do
                    
                    if displays[i]:hover(x, y) then
                        helpers["interact"].interact({id=list[i].id, index=list[i].index, x=list[i].position.x-0.6, y=list[i].position.y-0.6, z=list[i].position.z})
                        return true
                        
                    end
                    
                end
            
            elseif displays and type == 2 then
                
                for i,_ in pairs(displays) do
                    
                    if displays[i]:hover(x, y) then
                        return true
                        
                    end
                    
                end
                
            end
            
        end
        
        if player.main_job == "BRD" then
            local jukebox  = system["Core"].getJukebox()
            local songlist = system["Core"].getSonglist()
            
            if jukebox and songlist then
                local repeating = system["Core"].getSetting("REPEAT")

                if jukebox:hover(x, y) then
                    system["Core"].updateSonglist(true)
                    
                else
                    system["Core"].updateSonglist(false)
                    
                end
            
            end
        
        end
        
    end
    
end

return globals