--------------------------------------------------------------------------------
-- Controls helper: Controls handles all settings regarding to how a character acts when a target is found.
--------------------------------------------------------------------------------
local controls = {}
function controls.new()
    self = {}
    
    -- Private Variables
    local delays       = {assist=2, distance=0.3, facing=1}
    local times        = {assist=0, distance=0, facing=0}
    local last         = os.clock()
    local assist_range = system["Assist Range"]
    
    -- Public Variables.
    local toggle   = I{false, true}
    local assist   = I{false, true}
    local distance = I{true, false}
    local facing   = I{true, false}

    self.assist = function()
        local player = windower.ffxi.get_mob_by_target('me') or false
        local target = helpers["target"].getTarget() or false
        local toggle = toggle:current() or false
        local assist = assist:current()
        
        if (os.clock()-times.assist) > delays.assist then
        
            if player and toggle and assist and target then
                local distance = player.distance:sqrt()
                
                if (distance-player.model_size) < assist_range and player.status == 0 then
                    helpers["actions"].doAction(target, 0, "engage")
                    times.assist = os.clock()
                end
                
            end
        
        end
        
    end
    
    self.distance = function()
        local toggle = toggle:current() or false
        local target = helpers["target"].getTarget() or false
        
        if (os.clock()-times.distance) > delays.distance then
        
            if toggle and distance and target then
                local player = windower.ffxi.get_mob_by_target('me') or false
                
                if player and target and player.status == 1 then
                    local size = windower.ffxi.get_mob_by_target('me').model_size
                    local distance = target.distance:sqrt()
                    
                    if distance-size > 3.5 then
                        helpers["actions"].moveToPosition(target.x, target.y, false)
                        times.distance = os.clock()
                        
                    elseif distance < 3.6 and distance > (2.7 + size) then
                        helpers["actions"].stopMovement()
                        times.distance = os.clock()
                        
                    elseif distance < (1.5 + size) then
                        helpers["actions"].stepBackwards()
                        times.distance = os.clock()
                        
                    end
                    
                end
                
            end
        
        end
        
    end
    
    self.face = function()
        local toggle = toggle:current() or false
        local target = helpers["target"].getTarget() or false
        
        if (os.clock()-times.facing) > delays.facing then
        
            if toggle and facing and target then
                helpers["actions"].face(target)
                times.facing = os.clock()
                
            end
            
        end
        
    end
    
    self.up = function()
        helpers["actions"].pressUp()
    end
    
    self.down = function()
        helpers["actions"].pressDown()
    end
    
    self.left = function()
        helpers["actions"].pressLeft()
    end
    
    self.right = function()
        helpers["actions"].pressRight()
    end
    
    self.escape = function()
        helpers["actions"].pressEscape()
    end
    
    self.enter = function()
        helpers["actions"].pressEnter()
    end
    
    self.f8 = function()
        helpers["actions"].pressF8()
    end
    
    self.ping = function()
        helpers["controls"].assist()
        helpers["controls"].distance()
        helpers["controls"].face()
    
    end
    
    self.getEnabled = function()
        return toggle:current()
    end
    
    self.setEnabled = function(value)
        local value = value or false
        
        if type(value) == "boolean" then
            return toggle:setTo(value)
        end
        
    end
    
    self.toggle = function()
        return toggle:next()
    end
    
    self.getAutoAssist = function()
        return assist:current()
    end
    
    self.setAutoAssist = function(value)
        return assist:setTo(value)
    end
    
    self.autoAssist = function()
        return assist:next()
    end
    
    self.getAutoDistance = function()
        return distance:current()
    end
    
    self.setAutoDistance = function(value)
        return distance:setTo(value)
    end
    
    self.autoDistance = function()
        return distance:next()
    end
    
    self.getAutoFacing = function()
        return facing:current()
    end
    
    self.setAutoFacing = function(value)
        return facing:setTo(value)
    end
    
    self.autoFacing = function()
        return facing:next()
    end
    
    return self
    
end
return controls.new()