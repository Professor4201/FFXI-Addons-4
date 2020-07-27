--------------------------------------------------------------------------------
-- Reload Command: Reload functionality of the addon.
--------------------------------------------------------------------------------
local menus = {}
function menus.run()
    local self = {}
    
    -- Private variables.
    local toggle = I{false,true}
    local npc    = ""
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function()
        local command = commands[2] or false
        
        if command then
            local scan = command:sub(1, #command):lower()

            if (("toggle"):match(scan) or ("on"):match(scan) or ("off"):match(scan)) then
                toggle:next()
                
                local status = tostring(toggle:current()):upper()
                helpers["popchat"]:pop(("MENU HACKS: "..status), system["Popchat Window"])
                    
            end
        
        elseif not command then
            toggle:next()
            
            local status = tostring(toggle:current()):upper()
            helpers["popchat"]:pop(("MENU HACKS: "..status), system["Popchat Window"])
                    
        end
        
    end
    
    self.setNPC = function(name)
        npc = name
    end
    
    self.getNPC = function()
        return npc
    end
    
    --------------------------------------------------------------------------------------
    -- Handle the return of all current settings.
    --------------------------------------------------------------------------------------
    self.settings = function()
        
        return {
            
            toggle = toggle:current(),
            npc    = npc,
            
        }
    
    end
    
    return self
    
end
return menus.run()