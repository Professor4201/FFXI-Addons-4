--------------------------------------------------------------------------------
-- Interact Helper: Library of functions to handle different interaction types with npcs.
--------------------------------------------------------------------------------
local interact = {}
function interact.new()
    local self = {}
    
    -- Private Variables
    local display   = {}
    local list      = {}
    local padding   = 3
    local margin    = 25
    local position  = {["x"]=10,["y"]=300}
    local bg        = {["alpha"]=155,["r"]=000,["g"]=000,["b"]=000}
    local flags     = {["right"]=false,["bottom"]=false,["bold"]=false,["draggable"]=false,["italic"]=false}
    local text      = {["size"]=10,["font"]="lucida console",["alpha"]=255,["r"]=245,["g"]=200,["b"]=020}
    local stroke    = {["width"]=001,["alpha"]=255,["r"]=0,["g"]=0,["b"]=0}
    local max       = 15
    local settings  = {
        
        ["pos"]={["x"]=position.x,["y"]=position.y},
        ["bg"]={["alpha"]=bg.alpha,["red"]=bg.r,["green"]=bg.g,["blue"]=bg.b,["visible"]=true},
        ["flags"]={["right"]=flags.right,["bottom"]=flags.bottom,["bold"]=flags.bold,["draggable"]=flags.draggable,["italic"]=flags.italic},
        ["padding"]=padding,
        ["text"]={["size"]=text.size,["font"]=text.font,["fonts"]={},["alpha"]=text.alpha,["red"]=text.r,["green"]=text.g,["blue"]=text.b,
            ["stroke"]={["width"]=stroke.width,["alpha"]=stroke.alpha,["red"]=stroke.r,["green"]=stroke.g,["blue"]=stroke.b}
        },
        
    }
    
    self.find = function(name)
        local count = 1
        
        -- Clear Everything.
        helpers["interact"].clearAll()
        
        for _,v in pairs(npcs) do
            
            if type(v) == "table" and (v.name):match(name) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=text.r, g=text.g, b=text.b})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=text.r, g=text.g, b=text.b})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["homepoints"]) do
            
            if type(v) == "table" and (v.name):match(name) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and (null ~= 0 and null ~= -0.19999992847443) then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif (null ~= 0 and null ~= -0.19999992847443) then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["guides"]) do
            
            if type(v) == "table" and (v.name):match(name) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["escha"]) do
            
            if type(v) == "table" and (v.name):match(name) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["abyssea"]) do
            
            if type(v) == "table" and (v.name):match(name) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["proto"]) do
            
            if type(v) == "table" and (v.name):match(name) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["vw"]) do
            
            if type(v) == "table" and (v.name):match(name) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["conflux"]) do
            
            if type(v) == "table" and (v.name):match(name) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["unity"]) do
            
            if type(v) == "table" and (v.name):match(name) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["waypoints"]) do
            
            if type(v) == "table" and (v.name):match(name) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for i,v in ipairs(list) do
            
            if type(v) == "table" and i <= max then
                display[i] = {}
                display[i] = texts.new(v.name, settings, settings)
                    display[i]:pos(position.x, v.y)
                    display[i]:color(v.r, v.g, v.b)
                    display[i]:visible(true)
                    display[i]:bg_visible(true)
                    display[i]:update()
                    
            end
            
        end
        
    end
    
    self.findIndex = function(index)
        local count = 1
        
        -- Clear Everything.
        helpers["warp"].clearAll()
        
        for _,v in pairs(npcs) do
            
            if type(v) == "table" and (tostring(v.index)):match(index) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=text.r, g=text.g, b=text.b})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=text.r, g=text.g, b=text.b})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["homepoints"]) do
            
            if type(v) == "table" and (tostring(v.index)):match(index) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and (null ~= 0 and null ~= -0.19999992847443) then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif (null ~= 0 and null ~= -0.19999992847443) then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["guides"]) do
            
            if type(v) == "table" and (tostring(v.index)):match(index) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["escha"]) do
            
            if type(v) == "table" and (tostring(v.index)):match(index) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["abyssea"]) do
            
            if type(v) == "table" and (tostring(v.index)):match(index) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["proto"]) do
            
            if type(v) == "table" and (tostring(v.index)):match(index) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["vw"]) do
            
            if type(v) == "table" and (tostring(v.index)):match(index) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["conflux"]) do
            
            if type(v) == "table" and (tostring(v.index)):match(index) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["unity"]) do
            
            if type(v) == "table" and (tostring(v.index)):match(index) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for _,v in pairs(warps["waypoints"]) do
            
            if type(v) == "table" and (tostring(v.index)):match(index) then
                local null = (v.x+v.y+v.z)
                
                if count == 1 and null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=position.y, position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                elseif null ~= 0 then
                    table.insert(list, {name=string.format("** %+25s: %s [%04s] **\n", v.name, v.id, v.index), id=v.id, index=v.index, y=(list[count-1].y+margin), position={x=v.x, y=v.y, z=v.z}, r=53, g=235, b=229})
                    count = (count + 1)
                    
                end
                
            end
        
        end
        
        for i,v in ipairs(list) do
            
            if type(v) == "table" and i <= max then
                display[i] = {}
                display[i] = texts.new(v.name, settings, settings)
                    display[i]:pos(position.x, v.y)
                    display[i]:color(v.r, v.g, v.b)
                    display[i]:visible(true)
                    display[i]:bg_visible(true)
                    display[i]:update()
                    
            end
            
        end
        
    end
    
    self.clearAll = function()
        
        -- Check if there is anything to clear.
        if #display > 0 then
        
            for i,v in pairs(display) do
                
                if i and v then
                    display[i]:destroy()
                end
            end
            
            -- Create new tables after clearing.
            list    = {}
            display = {}
            
        end
        
    end
    
    self.interact = function(target)
        local target = target or false
        if target and type(target) == "table" and target.x and target.y and target.z then
            helpers["actions"].lockPosition(target.x, target.y, target.z)
            coroutine.sleep(0.5)
            helpers["actions"].doAction(target, 0, "interact")
            helpers["actions"].setLocked(false)
        end
    end
    
    self.getDisplays = function()
        return display
    end
    
    self.getList = function()
        return list
    end
    
    return self
    
end
return interact.new()