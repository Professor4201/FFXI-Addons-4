--------------------------------------------------------------------------------
-- Scheduler Commands: All commands in relation to schedule helper.
--------------------------------------------------------------------------------
local schedule = {}
function schedule.run()
    self = {}
    
    -- Private variables.
    local toggle = I{false,true}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local scan = command:sub(1, #command):lower()
            
           if ("on"):match(scan) then
                toggle:next()
                
                local status = tostring(toggle:current()):upper()
                helpers["popchat"]:pop(("SCHEDULING: "..status), system["Popchat Window"])
                
            end
        
        elseif not command then
            toggle:next()
                
            local status = tostring(toggle:current()):upper()
            helpers["popchat"]:pop(("SCHEDULING: "..status), system["Popchat Window"])
            
        end
    
    end
    
    --------------------------------------------------------------------------------------
    -- Handle the return of all current settings.
    --------------------------------------------------------------------------------------
    self.settings = function()
        
        return {
            
            toggle = toggle:current(),
            
        }
    
    end
    
    return self
    
end

return schedule.run()