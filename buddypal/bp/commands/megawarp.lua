--------------------------------------------------------------------------------
-- Megawarp Command: Handles Megawarp commands for using any type of warp in the entire zone.
--------------------------------------------------------------------------------
local megawarp = {}
function megawarp.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local commands    = commands or false
        local command     = commands[2] or false
        local destination = {}
        local post        = commands[#commands] or false

        for i=3, #commands do

            if tonumber(commands[i]) ~= nil then
                post = tonumber(commands[i])
                
            elseif tonumber(commands[i]) == nil then
                table.insert(destination, commands[i])
            
            end
            
        end
        
        if tonumber(post) == nil then
            post = 1
        end
        
        if command and destination and post then
            local destination = table.concat(destination, " ")
            local scan        = command:sub(1, #command):lower()
            
            if (("homepoint"):match(scan) or command == "hp") then
                helpers["megawarp"].homepoint(destination, post)
                
            elseif (("survival"):match(scan) or command == "sg") then
                helpers["megawarp"].survival(destination, post)
               
            elseif (("eschan"):match(scan) or command == "ew") then
                helpers["megawarp"].eschan(destination, post)
               
            elseif (("abyssea"):match(scan) or command == "ab") then
                helpers["megawarp"].abyssea(destination, post)
               
            elseif (("proto"):match(scan) or command == "pr") then
                helpers["megawarp"].proto(destination)
               
            elseif (("voidwatch"):match(scan) or command == "vw") then
                helpers["megawarp"].voidwatch(destination, post)
               
            elseif (("conflux"):match(scan) or command == "fl") then
                helpers["megawarp"].conflux(destination, post)
               
            elseif (("unity"):match(scan) or command == "un") then
                helpers["megawarp"].unity(destination, post)
               
            elseif (("waypoint"):match(scan) or command == "wp") then
                helpers["megawarp"].waypoint(destination, post)
               
            end
            
        end
        
    end
    return self
    
end
return megawarp.run()