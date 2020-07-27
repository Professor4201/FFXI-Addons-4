--------------------------------------------------------------------------------
-- Megawarp helper: Library of functions handling the warping of all warp NPCs in FFXI.
--------------------------------------------------------------------------------
local megawarp = {}
function megawarp.new()
    local self = {}
    
    -- Private Variables.
    local max_distance = I{false,true}
    local status = false
    local zone_name = ""
    local c = nil
    local o = nil
    
    self.homepoint = function(destination, post)
        local map         = dofile(windower.addon_path .. "bp/helpers/megawarp/homepoints_map.lua")
        local destination = windower.convert_auto_trans(destination or "")
        local post        = post
        
        if destination and post then
            local warp = helpers["megawarp"].findWarp("homepoints", destination)
            
            if warp then
                local destination = helpers["megawarp"].findDestination(destination)
                
                if destination and map[destination.name] and (map[destination.name][tonumber(post)] or map[destination.name][post]) then
                    local options = map[destination.name][tonumber(post)] or map[destination.name][post]
                    c, o, zone_name = warp, options, destination.name
                    
                    helpers["megawarp"].setStatus("homepoints")
                    helpers["actions"].lockPosition(warp.x-0.8, warp.y-0.8, warp.z)
                    coroutine.sleep(0.5)
                    helpers["actions"].doAction(warp, 0, "interact")
                    helpers["actions"].setLocked(false)
                    
                end
            
            end
            
        end
        
    end

    self.survival = function(destination, post)
        local map         = dofile(windower.addon_path .. "bp/helpers/megawarp/survivalguides_map.lua")
        local destination = windower.convert_auto_trans(destination or "")
        local post        = post
        
        if destination then
            local warp = helpers["megawarp"].findWarp("guides", destination)
            local zone = destination
            
            if warp then
                local destination = helpers["megawarp"].findDestination(destination)
                
                if destination and map[destination.name] and (map[destination.name][tonumber(post)] or map[destination.name][post]) then
                    local options = map[destination.name][tonumber(post)] or map[destination.name][post]
                    c, o, zone_name = warp, options, destination.name

                    helpers["megawarp"].setStatus("survivalguides")
                    helpers["actions"].lockPosition(warp.x-0.8, warp.y-0.8, warp.z)
                    coroutine.sleep(0.5)
                    helpers["actions"].doAction(warp, 0, "interact")
                    helpers["actions"].setLocked(false)
                    
                end
            
            end
            
        end
        
    end
    
    self.waypoint = function(destination, post)
        local map         = dofile(windower.addon_path .. "bp/helpers/megawarp/waypoints_map.lua")
        local destination = windower.convert_auto_trans(destination or "")
        local post        = post

        if destination and post then
            local warp = helpers["megawarp"].findWarp("waypoints", destination)
            
            if warp then
                local destination = helpers["megawarp"].findDestination(destination)
                
                if destination and map[destination.name] and (map[destination.name][tonumber(post)] or map[destination.name][post]) then
                    local options = map[destination.name][tonumber(post)] or map[destination.name][post]
                    c, o, zone_name = warp, options, destination.name
                    
                    helpers["megawarp"].setStatus("waypoints")
                    helpers["actions"].lockPosition(warp.x-0.8, warp.y-0.8, warp.z)
                    coroutine.sleep(0.5)
                    helpers["actions"].doAction(warp, 0, "interact")
                    helpers["actions"].setLocked(false)
                    
                end
            
            end
            
        end
    
    end
    
    self.proto = function(destination)
        local map         = dofile(windower.addon_path .. "bp/helpers/megawarp/proto_map.lua")
        local destination = windower.convert_auto_trans(destination or "")
        
        if destination then
            local warp = helpers["megawarp"].findWarp("proto", destination)
            
            if warp then
                local destination = helpers["megawarp"].findDestination(destination)
                
                if destination and map[destination.name] then
                    local options = map[destination.name]
                    c, o, zone_name = warp, options, destination.name
                    
                    helpers["megawarp"].setStatus("proto")
                    helpers["actions"].lockPosition(warp.x+0.8, warp.y+0.8, warp.z)
                    coroutine.sleep(0.5)
                    helpers["actions"].doAction(warp, 0, "interact")
                    helpers["actions"].setLocked(false)
                    
                end
            
            end
            
        end
        
    end
    
    self.eschan = function(destination, post)
        local map         = dofile(windower.addon_path .. "bp/helpers/megawarp/escha_map.lua")
        local destination = windower.convert_auto_trans(destination) or "*"
        local zone        = res['zones'][windower.ffxi.get_info().zone].name or false
        local post        = post
        
        if map and destination and zone and post then
            local warp = helpers["megawarp"].findWarp("escha", destination)
            
            if warp and destination ~= "*" then
                local to_dest = helpers["megawarp"].findDestination(zone) or false
                
                if to_dest and map[to_dest.name] and (map[to_dest.name][tonumber(post)] or map[to_dest.name][post]) then
                    local options = map[to_dest.name][tonumber(post)] or map[to_dest.name][post]
                    c, o, zone_name = warp, options, to_dest.name

                    helpers["megawarp"].setStatus("escha")
                    helpers["actions"].lockPosition(warp.x-0.8, warp.y-0.8, warp.z)
                    coroutine.sleep(0.5)
                    helpers["actions"].doAction(warp, 0, "interact")
                    helpers["actions"].setLocked(false)
                    
                end
            
            elseif warp and destination == "*" then
                c, zone_name = warp, destination
                
                helpers["megawarp"].setStatus("escha")
                helpers["actions"].lockPosition(warp.x-0.8, warp.y-0.8, warp.z)
                coroutine.sleep(0.5)
                helpers["actions"].doAction(warp, 0, "interact")
                helpers["actions"].setLocked(false)
                
            end
            
        end
        
    end
    
    self.voidwatch = function(destination, post)
        local map         = dofile(windower.addon_path .. "bp/helpers/megawarp/voidwatch_map.lua")
        local destination = windower.convert_auto_trans(destination or "")
        local post        = post
        
        if destination then
            local warp = helpers["megawarp"].findWarp("vw", destination)
            local zone = destination
            
            if warp then
                local destination = helpers["megawarp"].findDestination(destination)
                
                if destination and map[destination.name] and (map[destination.name][tonumber(post)] or map[destination.name][post]) then
                    local options = map[destination.name][tonumber(post)] or map[destination.name][post]
                    c, o, zone_name = warp, options, destination.name

                    helpers["megawarp"].setStatus("voidwatch")
                    helpers["actions"].lockPosition(warp.x-0.8, warp.y-0.8, warp.z)
                    coroutine.sleep(0.5)
                    helpers["actions"].doAction(warp, 0, "interact")
                    helpers["actions"].setLocked(false)
                    
                end
            
            end
            
        end
        
    end
    
    self.conflux = function(destination, post)
        local map         = dofile(windower.addon_path .. "bp/helpers/megawarp/conflux_map.lua")
        local destination = windower.convert_auto_trans(destination) or false
        local zone        = res['zones'][windower.ffxi.get_info().zone].name or false
        local post        = post
        
        if map and destination and zone and post then
            local warp = helpers["megawarp"].findWarp("conflux", destination)
            
            if warp and destination ~= "*" then
                local to_dest = helpers["megawarp"].findDestination(zone) or false
                
                if to_dest and map[to_dest.name] and (map[to_dest.name][tonumber(post)] or map[to_dest.name][post]) then
                    local options = map[to_dest.name][tonumber(post)] or map[to_dest.name][post]
                    c, o, zone_name = warp, options, to_dest.name
                    
                    helpers["megawarp"].setStatus("conflux")
                    helpers["actions"].lockPosition(warp.x-0.8, warp.y-0.8, warp.z)
                    coroutine.sleep(0.5)
                    helpers["actions"].doAction(warp, 0, "interact")
                    helpers["actions"].setLocked(false)
                    
                end
                
            end
            
        end
        
    end
    
    self.unity = function(destination, post)
        local map         = dofile(windower.addon_path .. "bp/helpers/megawarp/unity_map.lua")
        local destination = windower.convert_auto_trans(destination or "")
        local post        = post
        
        if destination then
            local warp = helpers["megawarp"].findWarp("unity", destination)
            local zone = destination
            
            if warp then
                local destination = helpers["megawarp"].findDestination(destination)
                
                if destination and map[destination.name] and (map[destination.name][tonumber(post)] or map[destination.name][post]) then
                    local options = map[destination.name][tonumber(post)] or map[destination.name][post]
                    c, o, zone_name = warp, options, destination.name

                    helpers["megawarp"].setStatus("unity")
                    helpers["actions"].lockPosition(warp.x-0.8, warp.y-0.8, warp.z)
                    coroutine.sleep(0.5)
                    helpers["actions"].doAction(warp, 0, "interact")
                    helpers["actions"].setLocked(false)
                    
                end
            
            end
            
        end
        
    end
    
    self.abyssea = function(destination, post)
        local map         = dofile(windower.addon_path .. "bp/helpers/megawarp/abyssea_map.lua")
        local destination = windower.convert_auto_trans(destination or "*")
        local post        = post
        
        if destination then
            local warp = helpers["megawarp"].findWarp("abyssea", destination)
            local zone = destination

            if warp and zone ~= "*" then
                local destination = helpers["megawarp"].findDestination(destination)

                if destination and map[destination.name] and (map[destination.name][tonumber(post)] or map[destination.name][post]) then
                    local options = map[destination.name][tonumber(post)] or map[destination.name][post]
                    c, o, zone_name = warp, options, destination.name

                    helpers["megawarp"].setStatus("abyssea")
                    helpers["actions"].lockPosition(warp.x-0.8, warp.y-0.8, warp.z)
                    coroutine.sleep(0.5)
                    helpers["actions"].doAction(warp, 0, "interact")
                    helpers["actions"].setLocked(false)
                    
                end
            
            elseif warp and zone == "*" then
                c, zone_name = warp, destination
                
                helpers["megawarp"].setStatus("abyssea")
                helpers["actions"].lockPosition(warp.x-0.8, warp.y-0.8, warp.z)
                coroutine.sleep(0.5)
                helpers["actions"].doAction(warp, 0, "interact")
                helpers["actions"].setLocked(false)
                
            end
            
        end
        
    end
    
    self.getStatus = function(destination, post)
        return status
        
    end
    
    self.setStatus = function(value)
        status = value
        
    end
    
    self.findWarp = function(warp_type, destination)
        local zone = windower.ffxi.get_info().zone
        local warp = warps[warp_type]
        local destination = destination or "*"
        
        for _,v in pairs(warp) do
            
            if type(v) == "table" then
                local target = windower.ffxi.get_mob_by_id(v.id) or false
                local coords = (v.x+v.y+v.z)
                
                if target and ((target.distance):sqrt() <= 6 or max_distance) and coords ~= 0 then
                    
                    if warp_type == "homepoints" then
                        
                        if (v.name):match("Home Point") then
                            return v
                        end
                    
                    elseif warp_type == "guides" then
                        
                        if (v.name):match("Guide") then
                            return v
                        end
                        
                    elseif warp_type == "proto" then
                        
                        if (v.name):match("Proto[-]?Waypoint") then
                            return v
                        end
                        
                    elseif warp_type == "unity" then
                        
                        if ((v.name):match("Urbiolaine") or (v.name):match("Igsli") or (v.name):match("Teldro-Kesdrodo") or (v.name):match("Yonolala") or (v.name):match("Nunaarl Bthtrogg")) then
                            return v
                        end
                        
                    elseif warp_type == "vw" then
                        
                        if (target.name):match("Atmacite Refiner") then
                            return v
                        end
                    
                    elseif warp_type == "conflux" then
                        
                        if (v.name):match("Veridical Conflux") then
                            return v
                        end
                    
                    elseif warp_type == "abyssea" then
                        
                        if destination == "*" then
                            
                            if (v.name):match("Cavernous Maw") then
                                return v
                            end
                            
                        elseif ((v.name):match("Ernst") or (v.name):match("Ivan") or (v.name):match("Willis") or (v.name):match("Kierron") or (v.name):match("Vincent") or (v.name):match("Horst")) then
                            return v
                            
                        end
                    
                    elseif warp_type == "escha" then
                        
                        if destination == "*" then
                            
                            if ((v.name):match("Undulating Confluence") or (v.name):match("Dimensional Portal")) then
                                return v
                            end
                            
                        elseif (v.name):match("Eschan Portal") then
                            return v
                            
                        elseif (v.name):match("Ethereal Ingress") then
                            return v
                            
                        end
                    
                    elseif warp_type == "waypoints" then
                        
                        if (v.name):match("Waypoint") then
                            return v
                        end
                    
                    end
                
                end
                
            end
            
        end
        return false
        
    end
    
    self.findDestination = function(name)
        local zones = res.zones
        
        for i,v in pairs(zones) do
            
            if type(v) == "table" then
                
                for ii,vv in pairs(v) do
                    
                    if ii == "en" and vv == name then
                        return v
                    end
                    
                end
                
            end
            
        end
        return false
        
    end
    
    self.getNearest = function()
        return c
    end
    
    self.getOptions = function()
        return o
    end
    
    self.getNextZone = function()
        return zone_name
        
    end
    
    self.clear = function()
        c, o = nil, nil
        helpers["megawarp"].setStatus(false)        
    end
    
    self.toggleDistance = function()
        max_distance:next()
        helpers["popchat"]:pop(string.format("ZONE WIDE WARPING IS NOW: %s", tostring(max_distance:current())):upper(), system["Popchat Window"])
    end
    
    return self
    
end

return megawarp.new()