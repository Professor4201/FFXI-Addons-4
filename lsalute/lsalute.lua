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
        local player   = windower.ffxi.get_player()
        local actor    = windower.ffxi.get_mob_by_id(p["Actor"])
        local target   = windower.ffxi.get_mob_by_id(p["Target 1 ID"])
        local category = p["Category"]
        local param    = p["Param"]
        local message  = p["Target 1 Action 1 Message"]
        
        
        if actor and target then
            
            if (category == 11) then
            
                if helpers.isInParty(target.name) and res.monster_abilities[param] then
                    local ability  = res.monster_abilities[param] or false
                    local messages = {[186] = true,[194]=true,[205]=true,[266]=true,[288]=true,[319]=true}
                    local charms   = {
                        
                        ["Charm"]              = true,
                        ["Maiden's Virelai"]   = true,
                        ["Luminous Drape"]     = true,
                        ["Frond Fatale"]       = true,
                        ["Wisecrack"]          = true,
                        ["Danse Macabre"]      = true,
                        ["Gala Macabre"]       = true,
                        ["Brain Jack"]         = true,
                        ["Tainting Breath"]    = true,
                        ["Belly Dance"]        = true,
                        ["Attractant"]         = true,
                        ["Fanatic Dance"]      = true,
                        ["Frog Song"]          = true,
                        ["Frog Chorus"]        = true,
                        ["Floral Bouquet"]     = true,
                        ["Enthrall"]           = true,
                        ["Soothing Aroma"]     = true,
                        ["Seed of Deference"]  = true,
                        ["Luminous Drape"]     = true,
                        ["Nocturnal Servitude"]= true,
                        
                    }
                    
                    if player and ability and charms[ability.name] and messages[message] then
                        local tp = windower.ffxi.get_player()["vitals"].tp
                        local f  = false
                        
                        for _,v in ipairs(player.buffs) do
                            
                            if (v == 14 or v == 17 then)
                                f = true
                            end
                            
                        end
                        
                        if tp > 999 and (target.distance):sqrt() < 21 and not f then
                            coroutine.sleep(1)
                            helpers.blast(target, skill)
                            windower.send_command(string.format("%s, you're it! --> %s", target.name, res.weapon_skills[skill].en))
                            
                        end
                        
                    end
                    
                end
                
            end
            
        end
        
    end
    
end)