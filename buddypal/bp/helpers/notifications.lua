--------------------------------------------------------------------------------
-- Notifications helper: Handles notification sounds.
--------------------------------------------------------------------------------
local notifications = {}
function notifications.new()
    self = {}
    
    -- Private Variables.
    local toggle = I{false,true}
    
    self.tell = function(sender)
        local sender = sender or false
        
        if sender then
            
            if toggle:current() and bpcore:fileExists(("/bp/helpers/notifications/%s.wav"):format(sender)) then
                helpers["notifications"].playNotification(sender)
            end
            
        end
        
    end                
    
    self.toggle = function()
        toggle:next()
    end
    
    self.getToggle = function()
        return toggle:current()
    end
    
    self.playNotification = function(name)
        local name = name or false
        
        if name and bpcore:fileExists(("bp/helpers/notifications/%s.wav"):format(name)) then
            windower.play_sound((windower.addon_path.."bp/helpers/notifications/%s.wav"):format(name))
        end
        
    end
    
    return self
    
end
return notifications.new()
