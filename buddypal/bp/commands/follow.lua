--------------------------------------------------------------------------------
-- Follow commands: This helper handles IPC messages to other accounts currently running.
--------------------------------------------------------------------------------
local follow = {}
function follow.run()
    local self = {}
    
    -- Private variables.
    local player = windower.ffxi.get_mob_by_target("me")
    
    self.execute = function(commands)
        local command = commands[2] or false

        if command then
            
            if command == "stop" then
                windower.send_command("bp > R bp follow stop_request")
                
            elseif command == "stop_request" then
                windower.send_command("setkey numpad7 down; wait 0.2; setkey numpad7 up")
                
            end            
        
        elseif not command then
            windower.send_command("bp > R follow " .. player.name)
        
        end
        
    end
    
    --------------------------------------------------------------------------------------
    -- Handle the return of all current settings.
    --------------------------------------------------------------------------------------
    self.settings = function()
        
        return {
            
        }
    
    end
    
    return self 

end
return follow.run()
