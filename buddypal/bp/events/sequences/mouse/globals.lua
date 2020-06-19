local globals = {}

--------------------------------------------------------------------------------
-- Mouse Event.
--------------------------------------------------------------------------------
globals[1] = function(type, x, y, delta, blocked)
    local player = windower.ffxi.get_player()
    
    if player then
        
        if helpers["warp"] ~= nil then
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