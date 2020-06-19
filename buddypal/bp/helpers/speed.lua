--------------------------------------------------------------------------------
-- Speed helper: Handles player movemnet speed variables.
--------------------------------------------------------------------------------
local speed = {}
function speed.new()
    self = {}
    
    --Private Variables.
    local toggle = I{false,true}
    local base   = 55
    local speed  = 75
    local data   = nil
    
    self.toggle = function()
        toggle:next()
        
        if toggle:current() and data ~= nil then
            helpers["popchat"]:pop(string.format("MOVEMENT SPEED: %s (%s)", tostring(toggle:current()):upper(), speed), system["Popchat Window"])
            windower.packets.inject_incoming(0x037, data:sub(1,44)..("C"):pack(speed)..data:sub(46, 64) .. ("I"):pack(os.time() - 1009806839) .. data:sub(69))
        
        elseif not toggle:current() and data ~= nil then
            helpers["popchat"]:pop(string.format("MOVEMENT SPEED: %s (%s)", tostring(toggle:current()):upper(), base), system["Popchat Window"])
            windower.packets.inject_incoming(0x037, data:sub(1,44)..("C"):pack(base)..data:sub(46, 64) .. ("I"):pack(os.time() - 1009806839) .. data:sub(69))
        
        elseif toggle:current() and data == nil then
            helpers["popchat"]:pop(("Waiting for an Update Packet to register!"):upper(), system["Popchat Window"])            
            
        end
        
    end
    
    self.setSpeed = function(value)
        local value = value or false
        
        if value and value >= base and value <= 255 then
            speed = value
            helpers["popchat"]:pop(string.format("MOVEMENT SPEED: %s (%s)", tostring(toggle:current()):upper(), speed), system["Popchat Window"])
            
            if toggle:current() and data ~= nil then
                windower.packets.inject_incoming(0x037, data:sub(1,44)..("C"):pack(speed)..data:sub(46, 64) .. ("I"):pack(os.time() - 1009806839) .. data:sub(69))
            end
            
        end
        
    end
    
    self.setData = function(packed)
        local packed = packed or false
        
        if packed then
            data = packed
        end
        
    end        
    
    self.getSpeed = function()
        return speed
    end
    
    self.getData = function()
        return data
    end
    
    self.getEnabled = function()
        return toggle:current()        
    end

    return self
    
end
return speed.new()
