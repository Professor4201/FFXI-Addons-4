--------------------------------------------------------------------------------
-- Trade Command: Handles all the commands for the Trade helper.
--------------------------------------------------------------------------------
local trade = {}
function trade.run()
    self = {}
    
    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        local target  = windower.ffxi.get_mob_by_target("t") or false
        local item
        
        if command and command == "all" and target then
            local npc    = commands[3] or false

            for i=4, #commands do
                
                if commands[i] then
                    
                    if i == 4 then
                        item = commands[i]
                    else
                        item = (item.." "..commands[i])
                    end
                    
                end
                
            end
            
            if npc and item and bpcore:findItemByName(item) then
                local target = windower.ffxi.get_mob_by_id(npc) or false
                
                if target then
                    helpers["actions"].tradeNPC(target, {bpcore:findItemByName(item), 1})
                end
                
            end
            
        elseif command and command == "*" and target then
            
            for i=3, #commands do
                
                if commands[i] then
                    
                    if i == 3 then
                        item = commands[i]
                    else
                        item = (item.." "..commands[i])
                    end
                    
                end
                
            end
            
            if target and item and bpcore:findItemByName(item) then
                helpers["actions"].tradeNPC(target, {bpcore:findItemByName(item), 1})
                windower.send_command(string.format("bp > @- bp trade all %s %s", target.id, item))
            end
        
        else

            for i=2, #commands do
                
                if commands[i] then
                    
                    if i == 2 then
                        item = commands[i]
                    else
                        item = (item.." "..commands[i])
                    end
                    
                end
                
            end
            
            if target and item and bpcore:findItemByName(item) then
                helpers["actions"].tradeNPC(target, {bpcore:findItemByName(item), 1})
            end
       
        end
       
    end
    
    return self
    
end
return trade.run()