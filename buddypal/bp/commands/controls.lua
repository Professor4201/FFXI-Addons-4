--------------------------------------------------------------------------------
-- Controls Command: Handles character movement and positiong during combat..
--------------------------------------------------------------------------------
local controls = {}
function controls.run()
    self = {}
    
    -- Private variables.
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local scan = command:sub(1, #command):lower()
            
            if (scan == "on" or scan == "off" or ("toggle"):match(scan)) then
                helpers["controls"].toggle()
                helpers["popchat"]:pop(("CONTROLS HELPER: " .. tostring(helpers["controls"].getEnabled()):upper()), system["Popchat Window"])
            
            elseif ("assist"):match(scan) then
                helpers["controls"].autoAssist()
                helpers["popchat"]:pop(("Auto-Assist: " .. tostring(helpers["controls"].getAutoAssist()):upper()), system["Popchat Window"])
            
            elseif ("distance"):match(scan) then
                helpers["controls"].autoDistance()
                helpers["popchat"]:pop(("Auto-Distancing: " .. tostring(helpers["controls"].getAutoDistance()):upper()), system["Popchat Window"])
            
            elseif ("facing"):match(scan) then
                helpers["controls"].autoFacing()
                helpers["popchat"]:pop(("Auto-Facing: " .. tostring(helpers["controls"].getAutoFacing()):upper()), system["Popchat Window"])
            
            elseif command == "all" and commands[3] then
                local key   = commands[3]:lower()
                local input = string.format("bp > @ bp controls %s", key)
                local keys  = {["up"]=true,["down"]=true,["left"]=true,["right"]=true,["escape"]=true,["enter"]=true,}
                
                if keys[key] then
                    windower.send_command(input)
                end
            
            elseif command == "up" then
                helpers["controls"].up()
                
            elseif command == "down" then
                helpers["controls"].down()
                
            elseif command == "left" then
                helpers["controls"].left()
                
            elseif command == "right" then
                helpers["controls"].right()
                
            elseif command == "escape" then
                helpers["controls"].escape()
                
            elseif command == "enter" then
                helpers["controls"].enter()
                
            elseif command == "f8" then
                helpers["controls"].f8()
                
            elseif command == "release" then
                helpers["actions"].setLocked(false)
                
            end
            
        else
            helpers["controls"].toggle()
            helpers["popchat"]:pop(("CONTROLS HELPER: " .. tostring(helpers["controls"].getEnabled()):upper()), system["Popchat Window"])
            
        end
    
    end

    return self
    
end
return controls.run()