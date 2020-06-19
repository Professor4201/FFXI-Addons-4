local globals = {}
    
--------------------------------------------------------------------------------
-- Incoming Text Event.
--------------------------------------------------------------------------------
globals[1] = function(main_id, main_level, sub_id, sub_level)
    local player = windower.ffxi.get_player() or false
    
    if player then
        system["Core"] = {}
        system["Core"] = require(string.format("bp/core/%s/%score", (player.main_job):lower(), (player.main_job):lower()))
        
    end
    
end

return globals