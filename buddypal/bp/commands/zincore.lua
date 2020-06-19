--------------------------------------------------------------------------------
-- Zincore Command: Handles executing Zincore helper.
--------------------------------------------------------------------------------
local zincore = {}
function zincore.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function()
        helpers["popchat"]:pop(("Now trading Zinc Ore!"):upper(), system["Popchat Window"])
        helpers["zincore"].tradeOre()       
    end
    
    return self
    
end
return zincore.run()