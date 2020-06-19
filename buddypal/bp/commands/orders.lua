--------------------------------------------------------------------------------
-- Orders commands: Handles all commands for the Orders helper.
--------------------------------------------------------------------------------
local orders = {}
function orders.run()
    self = {}
    
    -- Private variables.
    local legend = {
    
        ["all"]      = "@",
        ["others"]   = "O",
        ["range"]    = "R",
        ["allrange"] = "R*",
        ["party"]    = "P",
        ["zone"]     = "Z",
    
    }
    
    self.execute = function(commands)
        
        if commands[2] then

            if (commands[2] == legend.all or commands[2] == (legend.all.."-")) then
                local command = helpers["orders"].buildCommand(commands, 3)
                
                if commands[2] == legend.all then
                    helpers["orders"].orderAll(command, false)
                
                elseif commands[2] == (legend.all.."-") then
                    helpers["orders"].orderAll(command, true)
                    
                end
            
            elseif (commands[2] == legend.others or commands[2] == (legend.others.."-")) then
                local command = helpers["orders"].buildCommand(commands, 3)
                
                if commands[2] == legend.others then
                    helpers["orders"].orderOthers(command, false)
                
                elseif commands[2] == (legend.others.."-") then
                    helpers["orders"].orderOthers(command, true)
                    
                end
            
            elseif (commands[2] == legend.range or commands[2] == (legend.range.."-")) then
                local command = helpers["orders"].buildCommand(commands, 3)
                
                if commands[2] == legend.range then
                    helpers["orders"].orderInRange(command, false)
                
                elseif commands[2] == (legend.range.."-") then
                    helpers["orders"].orderInRange(command, true)
                    
                end
                
            elseif (commands[2] == legend.allrange or commands[2] == (legend.allrange.."-")) then
                local command = helpers["orders"].buildCommand(commands, 3)
                
                if commands[2] == legend.allrange then
                    helpers["orders"].orderAllInRange(command,  false)
                
                elseif commands[2] == (legend.allrange.."-") then
                    helpers["orders"].orderAllInRange(command, true)
                    
                end
            
            elseif (commands[2] == legend.party or commands[2] == (legend.party.."-")) then
                local command = helpers["orders"].buildCommand(commands, 3)
                
                if commands[2] == legend.party then
                    helpers["orders"].orderInParty(command, false)
                
                elseif commands[2] == (legend.party.."-") then
                    helpers["orders"].orderInParty(command, true)
                    
                end 
            
            elseif commands[2] == "help" then
                
            
            end
            
        end
    
    end
    
    --------------------------------------------------------------------------------------
    -- Handle the return of all current settings.
    --------------------------------------------------------------------------------------
    self.settings = function()
        
        return {
            
        }
    
    end
    
    return self 

end
return orders.run()
