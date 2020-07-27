--------------------------------------------------------------------------------
-- Nav Helper: Library of functions to handle BP Navigation system.
--------------------------------------------------------------------------------
local nav = {}
function nav.load()
    local f = files.new(string.format("/bp/resources/maps/%s.lua", windower.ffxi.get_info().zone))
    
    if f:exists() then
        return dofile(string.format("%sbp/resources/maps/%s.lua", windower.addon_path, windower.ffxi.get_info().zone))
    
    elseif not f:exists() then
        f:write("return " .. T({}):tovstring())
        return {}
    
    end

end

function nav.new()
    local self = {}
    
    -- Private Variables.
    local record = I{false,true}
    local map    = nav.load()
    local path   = {}
    local index  = 1
    local range  = 6
    local math   = math
    
    self.calculatePath = function(x, y)
        local x, y = x or false, y or false
        local map  = map
        local path = {}
        
        if x and y then
            local player   = windower.ffxi.get_mob_by_target("me")
            local start    = {x=player.x, y=player.y}
            local current  = {x=player.x, y=player.y}
            local attempts = {count=0, failed=false}
            local complete = false
            local temp     = nil

            while (not complete or not attempts.failed) do
                
                for i,v in ipairs(map) do

                    if helpers["nav"].distance(v.x, current.x, v.y, current.y, range+2) and (helpers["nav"].getDistance(current.x, x, current.y, y) or temp == nil) then
                        temp = helpers["nav"].getDistance(current.x, x, current.y, y)
                        attempts.count = 0
                        table.remove(map, i)
                        table.insert(path, v)
                        current = {x=v.x, y=v.y}
                        
                        if helpers["nav"].distance(x, current.x, y, current.y, 6) then
                            complete = true
                        end
                    
                    end
                
                end
                
                if not attempts.attemped then
                    attempts.count = (attempts.count + 1)
                    
                    if attempts.count > 5 then
                        attempts.failed = true
                    end
                    
                end
                
            end
            
        end
        return path
        
    end
    
    self.distance = function(x1, x2, y1, y2, r, outside)
        local x1, x2, y1, y2 = x1 or false, x2 or false, y1 or false, y2 or false
        local outside = outside or false
        
        if x1 and x2 and y1 and y2 then
            
            if (( (x1-x2)^2 + (y1-y2)^2) < r^2) and not outside then
                return true
                
            elseif (( (x1-x2)^2 + (y1-y2)^2) > r^2) and outside then
                return true
                
            end
        
        end
        return false
        
    end
    
    self.getDistance = function(x1, x2, y1, y2)
        return ( ((x1-x2)^2) + ((y1-y2)^2) ):sqrt()
    end
    
    self.buildMap = function()        
        local player = windower.ffxi.get_mob_by_target("me") or false
            
        if player and record:current() then
            local current = string.format("%s|%s", bpcore:round(player.x, 2), bpcore:round(player.y, 2)):gsub("%.", "")
            
            if #map > 0 then
                local pass = true
                
                for _,v in ipairs(map) do
                    
                    if helpers["actions"].rangeCheck(v.x, v.y, range) then
                        pass = false
                    end
                        
                end
                
                if pass then
                    table.insert(map, {x=player.x, y=player.y, z=player.z})
                end
                
            else
                table.insert(map, {x=player.x, y=player.y, z=player.z})
            
            end
        end
        
    end
    
    self.updateMap = function()
        map = nav.load()
    end
    
    self.saveMap = function()
        local f = files.new(string.format("/bp/resources/maps/%s.lua", windower.ffxi.get_info().zone))
    
        if f:exists() then
            f:write("return " .. T(map):tovstring())
            helpers["popchat"]:pop(("CURRENT MAP COORDINATES SAVED!"):upper(), system["Popchat Window"])
        end
    
    end
    
    self.record = function()
        record:next()
        helpers["popchat"]:pop(string.format("NAVIGATION RECORDING: %s", tostring(record:current())):upper(), system["Popchat Window"])
        
        if not record:current() then
            helpers["nav"].saveMap()
        end
        
    end
    
    self.handlePath = function()

        if #path > 0 then
            local move = helpers["actions"].getTemplate("Movement")
            
            if helpers["actions"].rangeCheck(path[index].x, path[index].y, 2) and index ~= 1 then
                
                if index < #path then
                    helpers["queue"].add(move, {name="Movement", x=path[index].x, y=path[index].y})
                    index = (index + 1)
                
                elseif index == #path then
                    helpers["actions"].stopMovement()
                    helpers["nav"].setPath({})
                
                end
                
            elseif index == 1 then
                helpers["queue"].add(move, {name="Movement", x=path[index].x, y=path[index].y})                                
                index = (index + 1)
                
            end
            
        end            
        --helpers["queue"].add(move, {name="Movement", x=v.x, y=v.y})
        
    end
    
    self.setPath = function(t)
        local t = t or false
        if type(t) == "table" then
            index = 1
            path  = t
        end
        
    end
    
    self.getPath = function()
        return path
    end
    
    return self
    
end
return nav.new()
