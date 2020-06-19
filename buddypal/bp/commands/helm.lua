--------------------------------------------------------------------------------
-- HELM Command: Handles executing HELM helper.
--------------------------------------------------------------------------------
local helm = {}
function helm.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        local target  = windower.ffxi.get_mob_by_target("t") or false
        
        if command then
            local command = command:lower()
            
            if (command == "toggle" or command == "on" or command == "off") then
                helpers["helm"].toggle()
                
                if helpers["helm"].getToggle() then
                    helpers["helm"].setFlag("gathering", false)
                    helpers["helm"].setFlag("success", false)
                    helpers["actions"].setLocked(false)
                
                end
                
            elseif command == "mode" then
                helpers["helm"].setFlag("gathering", false)
                helpers["helm"].setFlag("success", false)
                helpers["actions"].setLocked(false)
                helpers["helm"].setRound(1)
                helpers["helm"].mode()
                
            elseif command == "item" then
                helpers["helm"].item()
                
            elseif command == "buy" and target then
                local quantity = commands[#commands]
                
                if quantity and tonumber(quantity) ~= nil then
                    helpers["helm"].setQuantity(tonumber(quantity))
                    helpers["helm"].setFlag("injecting", true)
                    helpers["actions"].poke(target) 
                    
                elseif quantity and tonumber(quantity) == nil then
                    helpers["helm"].setQuantity(tonumber(1))
                    helpers["helm"].setFlag("injecting", true)
                    helpers["actions"].poke(target) 
                    
                end
                
            end
        
        else
            helpers["helm"].toggle()
            
        end
        
    end
    
    return self
    
end
return helm.run()