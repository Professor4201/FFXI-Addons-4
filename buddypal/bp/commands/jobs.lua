--------------------------------------------------------------------------------
-- Jobs Command: Handles all the commands sent for doing job quest bots.
--------------------------------------------------------------------------------
local jobs = {}
function jobs.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local command = windower.convert_auto_trans(command):lower()
            
            if (command == "paladin" or command == "pld") then
                
                helpers["events"].register("Jobs", "PLD")
                
            elseif (command == "darkknight" or command == "drk") then
                helpers["events"].register("Jobs", "DRK")
                
            elseif (command == "beastmaster" or command == "bst") then
                helpers["events"].register("Jobs", "BST")
                
            elseif (command == "bard" or command == "brd") then
                helpers["events"].register("Jobs", "BRD")
                
            elseif (command == "ranger" or command == "rng") then
                helpers["events"].register("Jobs", "RNG")
                
            elseif (command == "summoner" or command == "smn") then
                helpers["events"].register("Jobs", "SMN")
                
            elseif (command == "samurai" or command == "sam") then
                helpers["events"].register("Jobs", "SAM")
                
            elseif (command == "ninja" or command == "nin") then
                helpers["events"].register("Jobs", "NIN")
                
            elseif (command == "dragoon" or command == "drg") then
                helpers["events"].register("Jobs", "DRG")
                
            elseif (command == "bluemage" or command == "blu") then
                helpers["events"].register("Jobs", "BLU")
                
            elseif (command == "corsair" or command == "cor") then
                helpers["events"].register("Jobs", "COR")
                
            elseif (command == "puppetmaster" or command == "pup") then
                helpers["events"].register("Jobs", "PUP")
                
            elseif (command == "dancer" or command == "dnc") then
                helpers["events"].register("Jobs", "DNC")
                
            elseif (command == "scholar" or command == "sch") then
                helpers["events"].register("Jobs", "SCH")
                
            elseif (command == "geomancer" or command == "geo") then
                helpers["events"].register("Jobs", "GEO")
                
            elseif (command == "runefencer" or command == "run") then
                helpers["events"].register("Jobs", "RUN")
                
            end
            
        end
       
    end
    
    return self
    
end
return jobs.run()