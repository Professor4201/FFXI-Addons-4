--------------------------------------------------------------------------------
-- Repo Command: Handles commands for Repo helper.
--------------------------------------------------------------------------------
local repo = {}
function repo.run()
    self = {}
    
    self.execute = function(commands)
        local x, y, z  = commands[2] or false, commands[3] or false, commands[4] or false
        local me = windower.ffxi.get_mob_by_target("me") or false
        
        if x and y and z and me then
            helpers["actions"].reposition(x, y, z)
            
        else
            windower.send_command(string.format("bp > P bp repo %s %s %s", me.x, me.y, me.z))
            
        end
    
    end
    
    return self
    
end
return repo.run()