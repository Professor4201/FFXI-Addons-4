--------------------------------------------------------------------------------
-- Interact Helper: Interact with any NPC in the zone.
--------------------------------------------------------------------------------
local interact = {}
function interact.new()
    self = {}
    
    -- Private Variables.
    local interacting = false
    
    self.interact = function(id, delay)
        local locked = helpers["actions"].getLocked()
        local target = npcs[id] or false
        
        if target then
        
            if not locked then
                interacting = true
                helpers["actions"].lockPosition(target.x, target.y, target.z)
                coroutine.sleep(0.5)
                helpers["actions"].doAction(target, 0, "interact")
                
            end
        
        end
        
    end
    
    self.getInteracting = function()
        return interacting
    end
    
    self.setInteracting = function(value)
        if type(value) == "boolean" then
            interacting = false
        end
    end
    
    return self
    
end
return interact.new()
