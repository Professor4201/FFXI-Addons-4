local globals = {}
    
--------------------------------------------------------------------------------
-- Windower Party Invite Event
--------------------------------------------------------------------------------
globals[1] = function(sender, id)
    local whitelist = T(system["Auto Join"]) or false

    if whitelist and (whitelist):contains(sender) then
        windower.send_command:schedule(0.6, 'input /join')
        
    end
    
end

return globals