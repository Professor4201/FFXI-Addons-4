--------------------------------------------------------------------------------
-- Maintenance Mode Command: Put your character in maintenance mode to move through doors and objects.
--------------------------------------------------------------------------------
local maint = {}
function maint.run()
    self = {}
    
    -- Private variables.
    local maintenance = I{false,true}

    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local scan = command:sub(1, #command):lower()
            
            if ("on"):match(scan) then
                maintenance:next()
                helpers["popchat"]:pop(string.format("MAINTENANCE MODE: %s", tostring(maintenance:current())):upper(), system["Popchat Window"])
                
                if system["I: 0x037 Data"] then
                    windower.packets.inject_incoming(0x037, system["I: 0x037 Data"]:sub(1, 64) .. ("I"):pack(os.time() - 1009806839) .. system["I: 0x037 Data"]:sub(69))
                end
                
            end
        
        elseif not command then
            maintenance:next()
            helpers["popchat"]:pop(string.format("MAINTENANCE MODE: %s", tostring(maintenance:current())):upper(), system["Popchat Window"])
            
            if system["I: 0x037 Data"] then
                windower.packets.inject_incoming(0x037, system["I: 0x037 Data"]:sub(1, 64) .. ("I"):pack(os.time() - 1009806839) .. system["I: 0x037 Data"]:sub(69))
            end
            
        end
        
    end
    
    self.getMode = function()
        return maintenance:current()
    end
    
    return self
    
end
return maint.run()