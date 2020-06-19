local globals = {}
    
--------------------------------------------------------------------------------
-- Day Change Events.
--------------------------------------------------------------------------------
globals[1] = function(new, old)
    
    if new then
        
        -- Check next scheduled event.
        if helpers['schedule'] ~= nil then
            helpers['schedule'].checkSchedule()
        end
        
    end
    
end

return globals