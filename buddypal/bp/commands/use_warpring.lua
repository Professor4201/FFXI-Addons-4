local use_warpring = {}
function use_warpring.run()
    self = {}
    
    self.execute = function()

        if bpcore:checkTimestamp("Warp Ring", "minute", 10) then
            system["Next Allowed"] = (os.clock() + 12)
            helpers['actions'].equipItem("Warp Ring", 13)
            helpers["queue"].add(IT["Warp Ring"], "me")
            
        end
        
    end
    
    return self 

end
return use_warpring.run()
