--------------------------------------------------------------------------------
-- Miollioncorn Command: Handles executing Millicorn helper.
--------------------------------------------------------------------------------
local millioncorn = {}
function millioncorn.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function()
        helpers["popchat"]:pop(("Now trading Millioncorn!"):upper(), system["Popchat Window"])
        helpers["millioncorn"].tradeCorn()       
    end
    
    return self
    
end
return millioncorn.run()