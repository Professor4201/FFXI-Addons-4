local globals = {}

--------------------------------------------------------------------------------
-- Windower Gain Buff Event.
--------------------------------------------------------------------------------
globals[1] = function(id)
    local player = windower.ffxi.get_player()
    --print(id)
    if player then
        
        if player.main_job == "COR" and id == 309 then
            helpers["rolls"].setRolling(0)
            
        elseif player.main_job == "MNK" and id == 461 then
            system["Core"].value("WSNAME", system["Core"].get("IMPETUS WS"))
            
        elseif player.main_job == "MNK" and id == 406 then
            system["Core"].value("WSNAME", system["Core"].get("FOOTWORK WS"))
            
        end
    
    end

end

return globals