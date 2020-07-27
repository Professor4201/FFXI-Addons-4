--------------------------------------------------------------------------------
-- Guilds Commands: Handles unlocking and rebuilding Guild shop NPCs.
--------------------------------------------------------------------------------
local guilds = {}
function guilds.run()
    local self = {}
    
    -- Private Variables
    local status = ""
    
    self.execute = function(params)
        local command = params[2] or false
        
        if command then
            local scan = command:sub(1, #command):lower()
            
            if ("woodworking"):match(scan) then
                local npc = windower.ffxi.get_mob_by_id(17723431)
                
                if npc and math.sqrt(npc.distance) < 10 then
                    commands["guilds"].setStatus("Woodworking")
                    helpers["actions"].doAction(npc, 0, "interact")
                    
                end
                
            elseif ("smithing"):match(scan) then
                local npc = windower.ffxi.get_mob_by_id(17723440) or windower.ffxi.get_mob_by_id(17747969)
                
                if npc and math.sqrt(npc.distance) < 10 then
                    commands["guilds"].setStatus("Smithing")
                    helpers["actions"].doAction(npc, 0, "interact")
                    
                end
                
            elseif ("bonecraft"):match(scan) then
                local npc = windower.ffxi.get_mob_by_id(17764407)
                
                if npc and math.sqrt(npc.distance) < 10 then
                    commands["guilds"].setStatus("Bonecraft")
                    helpers["actions"].doAction(npc, 0, "interact")
                    
                end
                
            elseif ("alchemy"):match(scan) then
                local npc = windower.ffxi.get_mob_by_id(17735715)
                
                if npc and math.sqrt(npc.distance) < 10 then
                    commands["guilds"].setStatus("Alchemy")
                    helpers["actions"].doAction(npc, 0, "interact")
                    
                end
                
            elseif ("goldsmithing"):match(scan) then
                local npc = windower.ffxi.get_mob_by_id(17739788) or windower.ffxi.get_mob_by_id(17797132)
                
                if npc and math.sqrt(npc.distance) < 10 then
                    commands["guilds"].setStatus("Goldsmithing")
                    helpers["actions"].doAction(npc, 0, "interact")
                    
                end
                
            elseif ("leathercraft"):match(scan) then
                local npc = windower.ffxi.get_mob_by_id(17719383)
                
                if npc and math.sqrt(npc.distance) < 10 then
                    commands["guilds"].setStatus("Leathercraft")
                    helpers["actions"].doAction(npc, 0, "interact")
                    
                end
                
            elseif ("clothcraft"):match(scan) then
                local npc = windower.ffxi.get_mob_by_id(17793053) or windower.ffxi.get_mob_by_id(17764400) or windower.ffxi.get_mob_by_id(17797134)
                
                if npc and math.sqrt(npc.distance) < 10 then
                    commands["guilds"].setStatus("Clothcraft")
                    helpers["actions"].doAction(npc, 0, "interact")
                    
                end
                
            elseif ("cooking"):match(scan) then
                local npc = windower.ffxi.get_mob_by_id(17752140)
                
                if npc and math.sqrt(npc.distance) < 10 then
                    commands["guilds"].setStatus("Cooking")
                    helpers["actions"].doAction(npc, 0, "interact")
                    
                end

            end
        
        end
    
    end
    
    self.setStatus = function(value)
        status = value
    end
    
    self.getStatus = function(value)
        return status
    end
    
    self.disableUnlock = function()
        commands["guilds"].setStatus("")
    end    
    return self
    
end
return guilds.run()