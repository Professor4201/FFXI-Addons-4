--------------------------------------------------------------------------------
-- Rolls helper: Library of all Corsair roll helper functions.
--------------------------------------------------------------------------------
local rolls = {}
function rolls.new()
    self = {}
    
    -- Private Variables.
    local rolling = {name="", dice=0}
    local valid   = {310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,319,330,331,332,333,334,335,336,337,338,339,600}
    local rolls   = {
        
        ["sam"]     = "Samurai Roll",       ["stp"]   = "Samurai Roll",
        ["att"]     = "Chaos Roll",         ["at"]    = "Chaos Roll",
        ["atk"]     = "Chaos Roll",         ["da"]    = "Fighter's Roll",
        ["dbl"]     = "Fighter's Roll",     ["sc"]    = "Allies' Roll",
        ["acc"]     = "Hunter's Roll",      ["mab"]   = "Wizard's Roll",
        ["matk"]    = "Wizard's Roll",      ["macc"]  = "Warlock's Roll",
        ["regain"]  = "Tactician's Roll",   ["tp"]    = "Tactician's Roll",
        ["mev"]     = "Runeist's Roll",     ["meva"]  = "Runeist's Roll",
        ["mdb"]     = "Magus's Roll",       ["patt"]  = "Beast Roll",
        ["patk"]    = "Beast Roll",         ["pacc"]  = "Drachen Roll",
        ["pmab"]    = "Puppet Roll",        ["pmatk"] = "Puppet Roll",
        ["php"]     = "Companion's Roll",   ["php+"]  = "Companion's Roll",
        ["pregen"]  = "Companion's Roll",   ["comp"]  = "Companion's Roll",
        ["refresh"] = "Evoker's Roll",      ["mp"]    = "Evoker's Roll",
        ["mp+"]     = "Evoker's Roll",      ["xp"]    = "Corsair's Roll",
        ["exp"]     = "Corsair's Roll",     ["cp"]    = "Corsair's Roll",
        ["crit"]    = "Rogue's Roll",       ["def"]   = "Gallant's Roll",
        
    }
    
    local lucky = {
        
        ["Samurai Roll"]   = 2,     ["Chaos Roll"]       = 4,
        ["Hunter's Roll"]  = 4,     ["Fighter's Roll"]   = 5,
        ["Wizard's Roll"]  = 5,     ["Tactician's Roll"] = 5,
        ["Runeist's Roll"] = 5,     ["Beast Roll"]       = 4,
        ["Puppet Roll"]    = 3,     ["Corsair's Roll"]   = 5,
        ["Evoker's Roll"]  = 5,     ["Companion's Roll"] = 2,
        ["Warlock's Roll"] = 4,     ["Magus's Roll"]     = 2,
        ["Drachen Roll"]   = 4,     ["Allies' Roll"]     = 3,
        ["Rogue's Roll"]   = 5,     ["Gallant's Roll"]   = 3,
        
    }
    
    -- Returns roll name based on shorthand name tables.
    self.getShort = function(short)
        local short = short or false
        
        if short and type(short) == "string" and rolls[short] then
            return rolls[short]
        end
        return false
        
    end
    
    -- Returns the lucky digit using full roll name, or shorthand name.
    self.getLucky = function(name)
        local name = name or false
        
        if name and type(name) == "string" and lucky[name] then
            return lucky[name]
            
        elseif name and type(name) == "string" and lucky[helpers["rolls"].getShort(name)] then
            return lucky[helpers["rolls"].getShort(name)]
        
        end
        return false
        
    end
    
    -- Returns resource for roll based on full name, or shorthand name.
    self.getRoll = function(name)
        local name = name or false
        
        if name and type(name) == "string" then
            local list = res.job_abilities:type("CorsairRoll")
            
            for _,v in pairs(list) do
                
                if v and ((v.en):lower() == (name):lower() or (v.en):lower() == (helpers["rolls"].getShort(name)):lower()) then
                    return v
                end
                
            end            
            
        end
        return false
        
    end
    
    self.setRolling = function(name, value)
        local name  = name or false
        local value = value or false
        
        if name and value and type(name) == "string" and tonumber(value) ~= nil then
            rolling.name, rolling.dice = name, value
        end
        
    end
    
    self.getRolling = function()
        return rolling
    end
    
    -- Returns the number of rolls currently active.
    self.getActive = function()
        local player = windower.ffxi.get_player() or false
    
        if player then
            local buffs, count = player.buffs, 0
            
            for _,v in ipairs(buffs) do
                
                if helpers["rolls"].valid(v) then
                    count = count + 1
                end
            
            end
            return count
        
        end
        return false
        
    end
    
    -- Returns true if buff id is a valid roll.
    self.valid = function(id)
        local id = id or false
        
        if id then
            
            for _,v in ipairs(valid) do
                
                if v == id then
                    return true
                end
                
            end
            
        end
        return false
        
    end
    
    -- Returns true if buff id is a valid roll.
    self.findBuff = function(name)
        local player = windower.ffxi.get_player() or false
        local name   = name or false
        
        if player and name and type(name) == "string" then
            
            for _,v in ipairs(player.buffs) do
                
                if res.buffs[v] and type(res.buffs[v]) == "table" then
                    
                    if (res.buffs[v].en):match(name) then
                        return res.buffs[v].id
                    end
                    
                end
                
            end
            
        end
        return false
        
    end
    
    return self

end
return rolls.new()