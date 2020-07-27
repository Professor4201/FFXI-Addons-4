--------------------------------------------------------------------------------
-- Craft helper: Handles craft bot functions.
--------------------------------------------------------------------------------
local craft = {}
function craft.new()
    local self = {}

    self.currentSynth = function(recipe, skill, max)
        local skill = skill or false
        local max   = max or 8
        
        if recipe and skill then
            local temp  = {}
            local level = 0
            
            for i,v in pairs(recipe) do
                
                if i >= (skill-11) and i <= (skill+max) and i > level then
                    
                    if type(v) == "table" then
                        local materials = 0
                        
                        for ii,vv in pairs(v) do
                            
                            if type(vv) == "table" and bpcore:findItemByName(vv.material) then
                                materials = (materials + 1)
                                
                                if materials == v.count then
                                    temp  = recipe[i]
                                    level = i
                                    
                                end
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            end
            return temp                
            
        end
        return false
        
    end
    
    self.getRecipes = function(name)
        local name      = name or false
        local resource  = dofile(windower.addon_path.."bp/resources/recipes/recipes.lua") or false
        
        if resource and name and type(name) == "string" and resource[name] then
            return resource[name]            
            
        end
        return false
        
    end
    
    self.craft = function(skill, name, sign)
        local recipes = helpers["craft"].getRecipes(skill) or false
            
        if recipes then
            local name    = name or false
            local sign    = sign or false
            
            if name and recipes[name] then
                
                if sign then
                    helpers["popchat"]:pop(("ATTEMPTING HQ..."):upper(), system["Popchat Window"])
                    helpers["actions"].synthItem(bpcore:findItemByName(recipes[name].signed), recipes[name].count, unpack(recipes[name].materials))
                    
                else
                    helpers["popchat"]:pop(("ATTEMPTING HQ..."):upper(), system["Popchat Window"])
                    helpers["actions"].synthItem(bpcore:findItemByName(recipes[name].crystal), recipes[name].count, unpack(recipes[name].materials))
                    
                end
            
            end
        
        end
        
    end
    
    return self
    
end
return craft.new()