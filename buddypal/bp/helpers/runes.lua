--------------------------------------------------------------------------------
-- Runes helper: Library of all Rune Enhancements helper functions.
--------------------------------------------------------------------------------
local runes = {}
function runes.new()
    local self = {}
    
    -- Private Variables
    local valid  = {523,524,525,526,527,528,529,530}
    local active = Q{}
    local runes  = {
        
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
            local name = name:lower()
            
            for _,v in pairs(list) do
                
                if v and (v.en):lower() == (name):lower() then
                    return v
                    
                elseif v and (v.en):lower() == helpers["runes"].getShort(name) then
                    return v
                    
                end
                
            end            
            
        end
        return false
        
    end
    
    -- Returns the rune buff by name.
    self.getBuff = function(name)
        local name = name or false
        
        if name and type(name) == "string" then
            local name = name:lower()
            
            for _,v in pairs(valid) do
                local buff = res.buffs[v]
                
                if buff and (buff.en):lower() == (name):lower() then
                    return buff                    
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
                    count = (count + 1)
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
    
    -- Add rune to active runes queue for players.
    self.add = function(id)
        local id = id or false
        
        if id and tonumber(id) ~= nil and helpers["runes"].valid(id) then
            
            if active:length() == 0 then
                active:push({id=id,name=res.buffs[id].en,position=1})
                
            elseif active:length() > 0 and active:length() < 3 then
                local last = active[active:length()]
                
                if last.position == 1 then
                    active:push({id=id,name=res.buffs[id].en,position=2})
                    
                elseif last.position == 2 then
                    active:push({id=id,name=res.buffs[id].en,position=3})
                    
                elseif last.position == 3 then
                    active:push({id=id,name=res.buffs[id].en,position=1})
                    
                end
                
            end
                
        end
        
    end
    
    -- Remove the last rune you lost from the table.
    self.remove = function()
        
        if active:length() > 0 then
            active:remove(1)
        end
        
    end
    
    self.getRunes = function()
        return active
    end
    
    return self

end
return runes.new()