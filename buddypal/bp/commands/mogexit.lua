--------------------------------------------------------------------------------
-- Mog Exits Command: Handles executing Mog Exit bot.
--------------------------------------------------------------------------------
local mogexit = {}
function mogexit.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function()
        helpers["popchat"]:pop(("Now doing Mog Exit Quests!"):upper(), system["Popchat Window"])
        helpers["events"].register("Quest", "MogExit")
    end
    
    return self
    
end
return mogexit.run()