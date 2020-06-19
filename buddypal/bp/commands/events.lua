--------------------------------------------------------------------------------
-- Events Commands: Handles commands for the loading of addon events.
--------------------------------------------------------------------------------
local events = {}
function events.run()
    self = {}
    
    self.execute = function(commands)        
        local commands = commands or false
        
        if commands then
            local map      = helpers["events"].getMap()
            local sequence = commands[2]
            local event    = commands[3]
            
            if sequence and event and map[sequence] and T(map[sequence]):contains(event) then
                helpers["events"].register(sequence, event)
                
            end
        
        end
    
    end

    return self
    
end
return events.run()