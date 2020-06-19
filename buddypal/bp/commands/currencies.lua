--------------------------------------------------------------------------------
-- Currencies Command: Toggle the visibility of the on screen currencies menu.
--------------------------------------------------------------------------------
local currencies = {}
function currencies.run()
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
        
                if toggle:current() then
                    local status = tostring(toggle:current()):upper()
                    
                    helpers["popchat"]:pop(("CURRENCY MENU: "..status), system["Popchat Window"])
                    helpers["currencies"].show()
                    
                    -- Inject Currency Packets.
                    windower.packets.inject_outgoing(0x10f,'0000')
                    windower.packets.inject_outgoing(0x115,'0000')
                    
                    -- Update Currency String.
                    helpers["currencies"].update()
                    
                elseif not toggle:current() then
                    local status = tostring(toggle:current()):upper()
                    
                    helpers["popchat"]:pop(("CURRENCY MENU: "..status), system["Popchat Window"])
                    helpers["currencies"].hide()
                end
            
            end
        
        elseif not command then
            toggle:next()
        
            if toggle:current() then
                local status = tostring(toggle:current()):upper()
                
                helpers["popchat"]:pop(("CURRENCY MENU: "..status), system["Popchat Window"])
                helpers["currencies"].show()
                
                -- Inject Currency Packets.
                windower.packets.inject_outgoing(0x10f,'0000')
                windower.packets.inject_outgoing(0x115,'0000')
                
                -- Update Currency String.
                helpers["currencies"].update()
                
            elseif not toggle:current() then
                local status = tostring(toggle:current()):upper()
                
                helpers["popchat"]:pop(("CURRENCY MENU: "..status), system["Popchat Window"])
                helpers["currencies"].hide()
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
return currencies.run()