--------------------------------------------------------------------------------
-- Missions Command: Toggle the visibility of the on screen missions.
--------------------------------------------------------------------------------
local missions = {}
function missions.run()
    local self = {}
    
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
                    
                    helpers["popchat"]:pop(("MISSIONS MENU: "..status), system["Popchat Window"])
                    helpers["missions"].update()
                    
                elseif not toggle:current() then
                    local status = tostring(toggle:current()):upper()
                    
                    helpers["popchat"]:pop(("MISSIONS MENU: "..status), system["Popchat Window"])
                    helpers["missions"].update()
                
                end
            
            end
        
        elseif not command then
            toggle:next()
    
            if toggle:current() then
                local status = tostring(toggle:current()):upper()
                
                helpers["popchat"]:pop(("MISSIONS MENU: "..status), system["Popchat Window"])
                helpers["missions"].update()
                
            elseif not toggle:current() then
                local status = tostring(toggle:current()):upper()
                
                helpers["popchat"]:pop(("MISSIONS MENU: "..status), system["Popchat Window"])
                helpers["missions"].update()
            
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
return missions.run()