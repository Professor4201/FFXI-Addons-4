--------------------------------------------------------------------------------
-- WKR Commands: Handles warping account in to a Wildskeeper Reive.
--------------------------------------------------------------------------------
local wkr = {}
function wkr.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function()
        local zone = res['zones'][windower.ffxi.get_info().zone].name
            
        if zone == "Ceizak Battlegrounds" then
            local entrance = windower.ffxi.get_mob_by_id(17846769)
            local packets  = {["Zone"] = 261, ["Menu ID"] = 2008}
            
            if entrance and packets and math.sqrt(entrance.distance) < 20 then
                helpers["actions"].doEntrance(packets, entrance)
            end
            
        elseif zone == "Foret de Henetiel" then
            local entrance = windower.ffxi.get_mob_by_id(17846769)
            local packets  = {["Zone"] = 262, ["Menu ID"] = 2008}
            
            if entrance and packets and math.sqrt(entrance.distance) < 20 then
                helpers["actions"].doEntrance(packets, entrance)
            end
        
        elseif zone == "Yorcia Weald" then
            local entrance = windower.ffxi.get_mob_by_id(17846769)
            local packets  = {["Zone"] = 263, ["Menu ID"] = 2008}
            
            if entrance and packets and math.sqrt(entrance.distance) < 20 then
                helpers["actions"].doEntrance(packets, entrance)
            end
        
        elseif zone == "Morimar Basalt Fields" then
            local entrance = windower.ffxi.get_mob_by_id(17846769)
            local packets  = {["Zone"] = 265, ["Menu ID"] = 2008}
            
            if entrance and packets and math.sqrt(entrance.distance) < 20 then
                helpers["actions"].doEntrance(packets, entrance)
            end
        
        elseif zone == "Marjami Ravine" then
            local entrance = windower.ffxi.get_mob_by_id(17846769)
            local packets  = {["Zone"] = 266, ["Menu ID"] = 2008}
            
            if entrance and packets and math.sqrt(entrance.distance) < 20 then
                helpers["actions"].doEntrance(packets, entrance)
            end
        
        elseif zone == "Kamihr Drifts" then
            local entrance = windower.ffxi.get_mob_by_id(17846769)
            local packets  = {["Zone"] = 267, ["Menu ID"] = 2008}
            
            if entrance and packets and math.sqrt(entrance.distance) < 20 then
                helpers["actions"].doEntrance(packets, entrance)
            end
        
        end
    
    end
    return self
    
end
return wkr.run()