--------------------------------------------------------------------------------
-- Runes helper: Library of all Rune Enhancements helper functions.
--------------------------------------------------------------------------------
local runes = {}
function runes.new()
    self = {}
    
    -- Private Variables
    local valid = {523,524,525,526,527,528,529,530}
    local runes = {
        
        ["fire"]     = "Ignis",
        ["ice"]      = "Gelus",
        ["wind"]     = "Flabra",
        ["earth"]    = "Tellus",
        ["thunder"]  = "Sulpor",
        ["water"]    = "Unda",
        ["light"]    = "Lux",
        ["dark"]     = "Tenebrae",
        
    }
    
    -- Returns rune name based on shorthand name tables.
    self.getShort = function(short)
        local short = short or false
        
        if short and type(short) == "string" then
            
            for i,v in pairs(runes) do
                
                if #short > 1 and ((i):sub(1,2):lower()):match((short):sub(1,2):lower()) then
                    return v
                end
                
            end
            
        end
        return false
        
    end
    
    -- Returns resource for rune based on full name, or shorthand name.
    self.getRune = function(name)
        local name = name or false
        
        if name and type(name) == "string" then
            local list = res.job_abilities:type("Rune")
            
            for _,v in pairs(list) do
                
                if v and ((v.en):lower() == (name):lower() or (v.en):lower() == (helpers["runes"].getShort(name)):lower()) then
                    return v
                end
                
            end            
            
        end
        return false
        
    end
    
    -- Returns the number of runes currently active. (Self-buffed only!)
    self.getActive = function()
        local player = windower.ffxi.get_player() or false
    
        if player then
            local buffs, count = player.buffs, 0
            
            for _,v in ipairs(buffs) do
                
                if helpers["runes"].valid(v) then
                    count = count + 1
                end
            
            end
            return count
        
        end
        return false
        
    end
    
    -- Returns true if buff id is a valid Rune Enchantment.
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
    
    return self

end
return runes.new()