--------------------------------------------------------------------------------
-- Bluspell helper: Functions for handling Blue Mage spell sets.
--------------------------------------------------------------------------------
local bluspell = {}
function bluspell.new()
    self = {}
    
    -- Private Variables
    local spell_sets   = bpcore:handleSettings("bp/helpers/bluspell/"..windower.ffxi.get_player().name:lower())
    local default_set  = spell_sets["Default"] or false
    local current_set  = false

    self.save = function(set)
        local current_spells = windower.ffxi.get_mjob_data().spells or false
        
        if spell_sets and current_set then
            
            for _,v in ipairs(current_spells) do
                table.insert(spell_sets[current_set], v)
            end
            helpers["bluspell"].update()
            helpers['popchat']:pop(string.format("Saving < %s > spell set.", current_set):upper(), system["Popchat Window"])
            
        end
        
    end

    self.list = function()
        local temp  = {}
        local first = true
        
        if spell_sets and current_set and spell_sets[current_set] then
            
            for _,v in ipairs(spell_sets[current_set]) do
                
                if first then
                    table.insert(temp, string.format("[ %s ]", res.spells[v]))
                    
                else
                    table.insert(temp, string.format("[ %s ]", res.spells[v]))
                
                end
                
            end
            windower.add_to_chat(10, table.concat(temp, " "))
            
        end
        
    end

    self.new = function(set)
        
        if set and not spell_sets[set] then
            spell_sets[set] = {}
            helpers["bluspell"].update()
            helpers['popchat']:pop(string.format("Adding < %s > to spell sets.", set):upper(), system["Popchat Window"])
            
        end
        
    end
    
    self.delete = function(set)
        local temp = {}
        
        if set and spell_sets[set] then
            
            for i,v in pairs(spell_sets) do
                
                if not spell_sets[set] then
                    temp[i] = v
                    
                elseif spell_sets[set] then
                    
                    if current_set == set then
                        current_set = false
                    end
                    helpers['popchat']:pop(string.format("Deleting < %s > from spell sets.", set):upper(), system["Popchat Window"])
                    
                end
                
            end
            spell_sets = temp
            helpers["bluspell"].update()
            
        end
        
    end
    
    self.set = function(set)
        local current_spells = windower.ffxi.get_mjob_data().spells or false
        
        if set and spell_sets[set] then            
            current_set = set
            
            if current_spells then
                windower.ffxi.reset_blue_magic_spells()
                helpers['popchat']:pop(string.format("All spells removed, now using < %s >", set):upper(), system["Popchat Window"])
                
            end
            
            if #spell_sets[set] > 0 then
                local count = 0
                local slot  = 1
                
                for _ in pairs(spell_sets[set]) do
                    count = (count + 1)
                end
                
                for i,v in pairs(spell_sets[set]) do
                    
                    if slot == (count + 1) and count ~= 0 then
                        break
                        
                    else
                        windower.ffxi.set_blue_magic_spell(v, slot)
                        slot = (slot + 1)
                        
                    end
                    
                end
                
            end
            helpers['popchat']:pop(string.format("Setting < %s > to current spell set.", set):upper(), system["Popchat Window"])
            
        end
    
    end
    
    self.default = function(set)
        
        if set and spell_sets[set] then
            default_set = set
            helpers['popchat']:pop(string.format("Setting < %s > as default spell set.", set):upper(), system["Popchat Window"])
            
        end
        
    end        
    
    self.update = function(sets)
        bpcore:writeSettings("bp/helpers/bluspell/"..windower.ffxi.get_player().name:lower(), spell_sets)        
    end
    
    return self

end
return bluspell.new()