local globals = {}
    
--------------------------------------------------------------------------------
-- Windower Gain Buff Event.
--------------------------------------------------------------------------------
globals[1] = function(id)
    local player = windower.ffxi.get_player()
    
    if player then
            
        if player.main_job == "COR" and id == 309 then
            helpers["rolls"].setRolling(0)
            
        end
    
    end

end

return globals