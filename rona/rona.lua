_addon.name     = "rona"
_addon.author   = "Elidyr"
_addon.version  = "0.20200409"
_addon.command  = "rona"

require("strings")
require("lists")
require("tables")
require("sets")
require("chat")
require("logger")
require("helpers")


-- ** RESET AFTER THIS MANY EXAMINES ********************************************************
local max = 50


local settings = get_settings("settings", {})
local messages = {
    
    [0]   = "you are now infected with the 'Rona.",
    [1]   = "welcome back for some more 'Rona.",
    [5]   = ", get away with your corona infected ass.",
    [10]  = ", I'm surprised you're not dead.",
    [15]  = "is the source of the corona.",
    [50] =  "f*k off, you got 'rona scum.",
        
}

windower.register_event("examined", function(name, sender)
    local player = windower.ffxi.get_mob_by_target("me") or false
    
    if player then
        local target = windower.ffxi.get_mob_by_index(sender) or false
        local count  = settings[target.name] or 0
        local send
        
        -- Reset count after 50.
        if settings[target.name] == max then
            count = 0
        end
        
        if messages[count] then
            send = string.format("%s %s", target.name, messages[count])
        
        else
            send = string.format("%s %s", target.name, messages[0])
        
        end

        settings[target.name] = count+1
        windower.send_command(string.format("input /say %s", send))
        
        coroutine.sleep(0.3)
        write_settings("settings", settings)
        
    end
    
end)