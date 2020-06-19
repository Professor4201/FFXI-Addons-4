--------------------------------------------------------------------------------
-- Maintenance Mode Command: Put your character in maintenance mode to move through doors and objects.
--------------------------------------------------------------------------------
local maint = {}
function maint.run()
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
                helpers["popchat"]:pop(("Maintenance Mode: " .. status), system["Popchat Window"])
                
                if system["I: 0x037 Data"] then
                    local original = system["I: 0x037 Data"]
                    windower.packets.inject_incoming(0x037, system["I: 0x037 Data"]:sub(1, 64) .. 'I':pack(os.time() - 1009806839) .. system["I: 0x037 Data"]:sub(69))
                end
                
            end
        
        elseif not command then
            toggle:next()
            
            local status = tostring(toggle:current()):upper()
            helpers["popchat"]:pop(("Maintenance Mode: " .. status), system["Popchat Window"])
            
            if system["I: 0x037 Data"] then
                local original = system["I: 0x037 Data"]
                windower.packets.inject_incoming(0x037, system["I: 0x037 Data"]:sub(1, 64) .. 'I':pack(os.time() - 1009806839) .. system["I: 0x037 Data"]:sub(69))
            end
            
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
return maint.run()