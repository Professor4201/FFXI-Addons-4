local globals = {}
    
--------------------------------------------------------------------------------
-- Windower Lose Buff Event.
--------------------------------------------------------------------------------
globals[1] = function(id)
    local player = windower.ffxi.get_player()
    
    if player then
        
        if player.main_job == "GEO" and id == 612 then
            system["Core"].setColure(0)
            
        elseif player.main_job == "COR" and id == 308 then
            helpers["rolls"].setRolling("", 0)
            
        end
    
    end
    
end

return globals