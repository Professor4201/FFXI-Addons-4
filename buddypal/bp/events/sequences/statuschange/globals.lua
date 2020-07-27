local globals = {}
    
--------------------------------------------------------------------------------
--Status Change Event.
--------------------------------------------------------------------------------
globals[1] = function(new, old)
    
    if new then
        local status = new
        local target = windower.ffxi.get_mob_by_target("t") or false
        
        -- Set targets when engaging an enemy.
        if helpers["target"] ~= nil and target and status == 1 then
            helpers["target"].setTarget(target)

            if helpers["target"].getTargetMode() == 2 then
                windower.send_command(("bp > R bp target send_id " .. tostring(target.id)))
            end
        
        elseif helpers["target"] ~= nil and (status == 0 or status == 2 or status == 3) then
            helpers["target"].clearTargets()
            
        end
    
    end
    
end

return globals