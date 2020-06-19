--------------------------------------------------------------------------------
-- Nav helper: Nav handles everything related to creating nav files, and coordinating how navigation files are handled.
--------------------------------------------------------------------------------
local nav = {}
function nav.new()
    self = {}
    
    -- Private Variables.
    local zone       = res.zones[windower.ffxi.get_info().zone] or false
    local dir        = "bp/helpers/nav/"
    local path       = false
    local record     = I{false, true}
    local running    = I{false, true}
    local old_coords = {x=0, y=0, z=0}
    local post       = false
    local reverse    = false
    local first      = true
    local file       = bpcore:fileExists(dir..system["Player"].name.."/"..zone.id..".lua")
    local map
    
    -- Public Variables.
    local pings    = {delay=0.2, last=os.clock()}
    local coords   = {x=0, y=0, z=0}
    local range    = 7
    local mode     = I{"CIRCLE","REVERSE"}
        
    if file then
        map = dofile(windower.addon_path..dir..system["Player"].name.."/"..zone.id..".lua")
    
    elseif not file then
        bpcore:writeSettings(dir..system["Player"].name.."/"..zone.id, {})
        map = {}
        
    end
    
    self.loadPath = function(name)
        local name = name or false
        
        if name and map[name] then
            helpers["popchat"]:pop((string.format("Now loading %s to current map.", name)):upper(), system["Popchat Window"])
            path = map[name]
            
        end
        return false
    
    end
    
    self.list = function()
        local list = ""
        
        if map then
            local temp = {}
            
            for i,v in pairs(map) do
                table.insert(temp, i)
            end
           
            list = table.concat(temp, "; ")
            windower.add_to_chat(10, "Current Paths for this zone are: " .. list)
           
        end
        
    end
    
    self.new = function(name)
        local name = name or false
        
        if name and map then
            map[name:lower()] = {}
            helpers["popchat"]:pop((string.format("Adding %s to current map.", name)):upper(), system["Popchat Window"])
            helpers["nav"].save()
            
        end
        
    end
    
    self.delete = function(name)
        local name = name or false
        local temp = {}
        
        if name and map and map[name] then
            
            for i,v in pairs(map) do
                
                if i ~= name then
                    temp[i] = v
                    
                elseif map == name then
                    helpers["popchat"]:pop((string.format("Now deleting %s from current map.", i)):upper(), system["Popchat Window"])
                    return
                end
                
            end
            
            map = temp
            helpers["nav"].save()
            
        end
        helpers["popchat"]:pop((string.format("{ %s } is not a valid path on this map.", name)):upper(), system["Popchat Window"])
        return false
    end
    
    self.save = function()
        
        if map then
            bpcore:writeSettings(dir..system["Player"].name.."/"..zone.id, map)
            coroutine.sleep(1)
            helpers["nav"].updateMap()
        
        end
    
    end
    
    self.record = function()
        if map and path then
            record:next()
            
            if not record:current() then
                helpers["nav"].save()
            end
            
        end
        
    end
    
    self.recordPath = function()
        
        if record:current() and path ~= nil then
            local pos = helpers["actions"].getCoordinates()
            local old = old_coords
            
            if (math.abs(pos.x-old.x) > range or math.abs(pos.y-old.y) > range) then
                helpers["popchat"]:pop((string.format("Adding new position to path @{ %s %s %s }.", pos.x, pos.y, pos.z)):upper(), system["Popchat Window"])
                table.insert(path, {x=pos.x, y=pos.y, z=pos.z})
                old_coords = {x=pos.x, y=pos.y, z=pos.z}
                
            end
            
        end
        
    end
    
    self.runPath = function()
        
        if map and path and post and running:current() and system["Player"].status == 0 and not helpers["target"].getTarget() then
            
            if first then
                helpers["actions"].moveToPosition(path[post].x, path[post].y)
            end
            
            if helpers["actions"].rangeCheck(path[post].x, path[post].y, 1) and not reverse then
                
                if path[(post+1)] then
                    helpers["actions"].moveToPosition(path[post+1].x, path[post+1].y)
                    post = (post + 1)
                    
                elseif not path[(post+1)] and mode:current() == "CIRCLE" then
                    helpers["actions"].moveToPosition(path[1].x, path[1].y)
                    post = 1
                
                elseif not path[(post+1)] and mode:current() == "REVERSE" then
                    helpers["actions"].moveToPosition(path[(#path - 1)].x, path[(#path - 1)].y)
                    post, reverse = (#path - 1), true
                    
                end
            
            elseif helpers["actions"].rangeCheck(path[post].x, path[post].y, 1) and reverse then
                
                if path[(post-1)] then
                    helpers["actions"].moveToPosition(path[post-1].x, path[post-1].y)
                    post = (post - 1)
                
                elseif not path[(post-1)] and mode:current() == "REVERSE" then
                    helpers["actions"].moveToPosition(path[2].x, path[2].y)
                    post, reverse = 2, false
                    
                end
                
            end
            
        end
        
    end
    
    self.runOnce = function(name)
    end
    
    self.findCoord = function()
        local pos   = helpers["actions"].getCoordinates() or false
        local temp  = {}
        local dist  = 999
        local found
        
        for i,v in ipairs(path) do
            
            if type(v) == "table" then
                local temp = ( ( (v.x-pos.x)^2 + (v.y-pos.y)^2 ) )

                if type(temp) == "number" then
                    temp = temp:abs():sqrt()

                    if temp < dist then
                        found = i
                        dist  = bpcore:round(temp, 3)
                    end
                    
                end
                
            end
        
        end
        
        if dist < 35 then
            return found
        
        else
            helpers["popchat"]:pop(string.format("Closest Node is %s, please find a closer Node.", dist):upper(), system["Popchat Window"])
        
        end
        
    end
    
    self.updateMap = function()
        map = dofile(windower.addon_path..dir..system["Player"].name.."/"..zone.id..".lua")
    end
    
    self.update = function()
        local me = windower.ffxi.get_mob_by_target("me")
        
        if me and (os.clock() - pings.last) > pings.delay then
            helpers["nav"].recordPath()
            
            if system["Player"].status == 0 then
                helpers["nav"].runPath()
            end
            pings.last = os.clock()
            
        end
        
    end    
    
    self.mode = function()
        mode:next()
        helpers["popchat"]:pop(string.format("Pathing Mode is now set to: %s", tostring(mode:current())):upper(), system["Popchat Window"])
    
    end
    
    self.toggle = function()
        running:next()
        
        if path then
            helpers["popchat"]:pop(string.format("Activate Navigation: %s", tostring(running:current())):upper(), system["Popchat Window"])
            
            if not running:current() then
                helpers["actions"].stopMovement()
                post, first = false, true
                
            else
                post = helpers["nav"].findCoord()
                
            end
        
        else
            helpers["popchat"]:pop(("There are no paths currently loaded!!"):upper(), system["Popchat Window"])
            
        end
        
    end
    
    return self
    
end
return nav.new()
