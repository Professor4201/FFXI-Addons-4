local helpers = {}
function helpers.get()
    self = {}
    
    -- Private Resource.
    local res = require("resources")
    
    self.isInParty = function(name)
        local party = windower.ffxi.get_party() or false
        local name  = name or false
        
        for i,v in pairs(party) do
            local slot = tostring((i):sub(2,3))
            
            if slot and tonumber(slot) ~= nil then
                
                if v.name == name then
                    return true
                end
            
            end
            
        end
        return false
        
    end
    
    self.blast = function(target, skill)
        local target , skill = target or false, skill or false
        
        if target and skill and tonumber(skill) ~= nil then
            windower.packets.inject_outgoing(0x01a, ("iIHHHHfff"):pack(0x01a, target.id, target.index, 7, skill, 0, 0, 0, 0))
        end
        
    end
    
    self.set = function(name)
        local name = name or false
        
        if name then
            local skills = windower.ffxi.get_abilities().weapon_skills
            
            for _,v in ipairs(skills) do
                
                if v and res.weapon_skills[v] then
                    local ws = res.weapon_skills[v]
                    
                    if (ws.name):lower():match(name) and (ws.name == "Leaden Salute" or ws.name == "True Flight" or ws.name == "Apex Arrow" or ws.name == "Empyreal Arrow" or ws.name == "Namas Arrow") then
                        return ws.id
                    end
                    
                end
                
            end
            
        end
        return 218
        
    end
    
    return self
    
end
return helpers.get()
