--------------------------------------------------------------------------------
-- Keybinds helper: Library of functions to handle the creation of all keybinds for the addon.
--------------------------------------------------------------------------------
local keybinds = {}
function keybinds.new()
    local self = {}
    
    -- Private BP Binds.
    local binds = {
        
        ["@B"]      = "@B bp on",
        ["@]"]      = "@] bp speed",
        ["@["]      = "@[ bp > @ bp speed",
        ["@F"]      = "@F bp follow",
        ["@S"]      = "@S bp follow stop",
        ["@I"]      = "@I bp party invite",
        ["@C"]      = "@C bp > @ bp currencies",
        ["@M"]      = "@M bp > @ bp missions",
        ["@R"]      = "@R bp repo",
        ["@J"]      = "@J bp display",
        ["@T"]      = "@T bp target me",
        ["@P"]      = "@P bp target pt",
        ["@,"]      = "@, bp target gtarget",
        ["@."]      = "@. bp target etarget",
        ["@up"]     = "@up bp > P bp controls up",
        ["@down"]   = "@down bp > P bp controls down",
        ["@left"]   = "@left bp > P bp controls left",
        ["@right"]  = "@right bp > P bp controls right",
        ["@escape"] = "@escape bp > P bp controls escape",
        ["@enter"]  = "@enter bp > P bp controls enter",
        ["^!@f8"]   = "^!@f8 bp > P bp controls f8",
        ["^!@f6"]   = "^!@f6 ibruh bigpoke",
        
    }
    
    self.register = function(bind)
        local bind = bind or binds
        
        if bind and type(bind) == "table" then
            
            for _,v in pairs(bind) do
                
                if type(v) == "string" then
                    windower.send_command("bind " .. v)
                end
            
            end
            
        end        
        
    end
    
    self.unregister = function(bind)        
        local bind = bind or binds
        
        if bind and type(bind) == "table" then
            
            for i,_ in pairs(bind) do
                windower.send_command("unbind " .. i)
            
            end
            
        end  
    
    end

    return self
    
end
return keybinds.new()
