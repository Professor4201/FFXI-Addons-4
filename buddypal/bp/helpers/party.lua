--------------------------------------------------------------------------------
-- Party Helper: Library of functions to help with party manipulation and data.
--------------------------------------------------------------------------------
local party = {}
function party.new()
    local self = {}
    
    self.getMembers = function(alliance)
        local party, alliance = windower.ffxi.get_party() or false, alliance or false
        local members = {}
        
        if party then
            
            if alliance then
        
                for i,v in pairs(party) do
                    
                    if (i:sub(1,1) == "p" or i:sub(1,1) == "a") and tonumber(i:sub(2)) ~= nil and (player.name):lower() == (v.name):lower() then
                        table.insert(members, v)
                    end
                    
                end
                
            elseif not alliance then
                
                for i,v in pairs(party) do
                    
                    if i:sub(1,1) == "p" and tonumber(i:sub(2)) ~= nil and (player.name):lower() == (v.name):lower() then
                        table.insert(members, v)
                    end
                    
                end
                
            end
            
        end
        return members
        
    end
    
    self.getMember = function(player, alliance)
        local player, alliance, party = player or false, alliance or false, windower.ffxi.get_party() or false
        
        if type(player) == "table" then
            player = player
        
        elseif type(player) == "string" then
            player = windower.ffxi.get_mob_by_name(player)
            
        elseif type(player) == "number" then
            player = windower.ffxi.get_mob_by_id(player)
            
        end
        
        if player and party then
            
            if alliance then
        
                for i,v in pairs(party) do
                    
                    if (i:sub(1,1) == "p" or i:sub(1,1) == "a") and tonumber(i:sub(2)) ~= nil and (player.name):lower() == (v.name):lower() then
                        return v
                    end
                    
                end
                
            elseif not alliance then
                
                for i,v in pairs(party) do
                    
                    if i:sub(1,1) == "p" and tonumber(i:sub(2)) ~= nil and (player.name):lower() == (v.name):lower() then
                        return v
                    end
                    
                end
                
            end
            
        end
        return false
        
    end
    
    self.isInParty = function(player, alliance)
        local player, alliance, party = player or false, alliance or false, windower.ffxi.get_party() or false
        
        if type(player) == "table" then
            player = player
        
        elseif type(player) == "string" then
            player = windower.ffxi.get_mob_by_name(player)
            
        elseif type(player) == "number" then
            player = windower.ffxi.get_mob_by_id(player)
            
        end
        
        if player and party then
            
            if alliance then
        
                for i,v in pairs(party) do
                    
                    if (i:sub(1,1) == "p" or i:sub(1,1) == "a") and tonumber(i:sub(2)) ~= nil and (player.name):lower() == (v.name):lower() then
                        return true
                    end
                    
                end
                
            elseif not alliance then
                
                for i,v in pairs(party) do
                    
                    if i:sub(1,1) == "p" and tonumber(i:sub(2)) ~= nil and (player.name):lower() == (v.name):lower() then
                        return true
                    end
                    
                end
                
            end
            
        end
        return false
        
    end
    
    self.membersAreInRange = function(d, alliance)
        local party = windower.ffxi.get_party()
        local player = windower.ffxi.get_player()
        local count = party.party1_count
        local alliance = alliance or false
        local d = d or false
        local pass = 0
        
        if alliance then
            count = (count + party.party2_count + party.party3_count)
                
            for i,v in pairs(party) do
                
                if (i:sub(1,1) == "p" or i:sub(1,1) == "a") and tonumber(i:sub(2)) ~= nil and (player.name):lower() == (v.name):lower() then
                    
                    if v.mob and not v.mob.is_npc and (v.mob.distance):sqrt() <= d then
                        
                        if (v.mob.name):lower() == (player.name):lower() and (v.mob.distance):sqrt() == 0 then
                            pass = (pass + 1)
                            
                        elseif (v.mob.name):lower() ~= (player.name):lower() and (v.mob.distance):sqrt() ~= 0 then
                            pass = (pass + 1)
                        
                        end
                    
                    elseif not d and v.mob then
                        pass = (pass + 1)
                    
                    end
                
                end
                
            end
            
        elseif not alliance then
            
            for i,v in pairs(party) do
                
                if i:sub(1,1) == "p" and tonumber(i:sub(2)) ~= nil then
                    
                    if v.mob and not v.mob.is_npc and (v.mob.distance):sqrt() <= d then
                        
                        if (v.mob.name):lower() == (player.name):lower() and (v.mob.distance):sqrt() == 0 then
                            pass = (pass + 1)
                            
                        elseif (v.mob.name):lower() ~= (player.name):lower() and (v.mob.distance):sqrt() ~= 0 then
                            pass = (pass + 1)
                        
                        end
                    
                    elseif not d and v.mob then
                        pass = (pass + 1)
                    
                    end
                
                end
                
            end
            
        end
        if pass == count then
            return true
        end
        return false
    
    end
    
    return self
    
end
return party.new()
