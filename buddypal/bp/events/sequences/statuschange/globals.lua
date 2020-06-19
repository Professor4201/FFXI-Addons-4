local globals = {}
    
--------------------------------------------------------------------------------
--Status Change Event.
--------------------------------------------------------------------------------
globals[1] = function(new, old)
    
    if new then
        local target = windower.ffxi.get_mob_by_target("t") or false
        
        if system["Farmer Toggle"]:current() and new == 1 then
            helpers['farmer']:setStatus(1)
            
        elseif system["Farmer Toggle"]:current() and new == 0 then
            helpers['farmer']:clearFarmer()
            
        end
    
    end
    
end

return globals