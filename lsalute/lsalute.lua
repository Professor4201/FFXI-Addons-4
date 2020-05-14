_addon.name     = "lsalute"
_addon.author   = "Elidyr"
_addon.version  = "0.20200514b"
_addon.command  = "salute"

-- Addon is in Beta!!
-- Have fun in dynamis and delve for the rest of your days friends!

local enabled = false
local skill   = 218
local color   = 12
local helpers = require("helpers")
local res     = require("resources")
local packets = require("packets")
                require("strings")
                require("lists")
                require("tables")
                require("chat")
                require("logger")
                require("pack")
                
windower.register_event("addon command", function(...)
    
    local a = T{...}
    local c = a[1] or false
    
    if c and c:lower() then
        skill = helpers.set(c)
        windower.add_to_chat(color, string.format("Weapon Skill now set to: %s", res.weapon_skills[skill].en))
        
    elseif not c and enabled then
        enabled = false
        windower.send_command("p Wild Weaponskills Disabled!")
            
    elseif not c and not enabled then
        enabled = true
        windower.send_command("p Wild Weaponskills Enabled!")
        
    end
    
end)

windower.register_event("incoming chunk", function(id,original,modified,injected,blocked)
    
    -- Incoming Action Event.
    if id == 0x028  then
        local p        = packets.parse("incoming", original)
        local actor    = windower.ffxi.get_mob_by_id(p["Actor"])
        local target   = windower.ffxi.get_mob_by_id(p["Target 1 ID"])
        local category = p["Category"]
        local param    = p["Param"]
        local message  = p["Target 1 Action 1 Message"]
        
        
        if actor and target then
            
            if (category == 11) then
            
                if helpers.isInParty(target.name) and res.monster_abilities[param] then
                    
                    if res.monster_abilities[param].en == "Charm" and message == 186 then
                        local tp = windower.ffxi.get_player()["vitals"].tp
                        
                        if tp > 999 then
                            coroutine.sleep(1)
                            helpers.blast(target, skill)
                            
                        end
                        
                    end
                    
                end
                
            end
            
        end
        
    end
    
end)