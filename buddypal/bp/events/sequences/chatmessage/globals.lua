local globals = {}
    
--------------------------------------------------------------------------------
-- Incoming Chat Message Event.
--------------------------------------------------------------------------------
globals[1] = function(message, sender, mode, gm)
    local message = message or false
    local sender  = sender or false
    local job     = windower.ffxi.get_player().main_job
    local sub     = windower.ffxi.get_player().sub_job
    
    if message and sender and (mode == 3 or mode == 4) then
        helpers["chatcommands"].common(message, sender)
        helpers["chatcommands"][job:lower()](message, sender)
        helpers["chatcommands"][sub:lower()](message, sender)
    
    end
    
    if system["Core"] then
        system["Core"].handleChat(message, sender, mode, gm)        
    end
    
    if helpers["notifications"].getToggle() and mode == 3 then
        helpers["notifications"].playNotification(sender)
    end
    
end

return globals