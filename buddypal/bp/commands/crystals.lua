--------------------------------------------------------------------------------
-- Crystals commands: Controls all Crystals helper commands.
--------------------------------------------------------------------------------
local crystals = {}
function crystals.run()
    self = {}
    
    -- Private variables.
    local name = {
        
        ["fire"]        = "Fire Crystal",
        ["ice"]         = "Ice Crystal",
        ["wind"]        = "Wind Crystal",
        ["earth"]       = "Earth Cluster",
        ["thunder"]     = "Lightng. Crystal",
        ["lightning"]   = "Lightng. Crystal",
        ["water"]       = "Water Crystal",
        ["light"]       = "Light Crystal",
        ["dark"]        = "Dark Crystal",
    
    }
    
    self.execute = function(commands)
        local crystal  = commands[2] or false
        local quantity = commands[3] or false
        local target   = windower.ffxi.get_mob_by_target("t") or false
        
        if target and crystal and quantity and tostring(crystal) ~= nil and tonumber(quantity) ~= nil then
            
            if name[crystal:lower()] then
                helpers["crystals"].setCrystal(name[crystal:lower()])
                helpers["crystals"].setQuantity(quantity)
                helpers["crystals"].setFlag(true)
                helpers["actions"].poke(target)
                
            end
            
        end
        
    end
    
    return self 

end
return crystals.run()
