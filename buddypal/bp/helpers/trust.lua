--------------------------------------------------------------------------------
-- Trust helper: Trust handles automatically calling fourth trust when empty spaces arer available.
--------------------------------------------------------------------------------
local trust = {}
function trust.new()
    self = {}
    
    -- Private Variables.
    local party_size = 0
    local toggle     = I{false,true}
    
    -- Public Variables.
    local max_trust  = 4
    local trust      = {system["Default Trust"].trust1, system["Default Trust"].trust2, system["Default Trust"].trust3, system["Default Trust"].trust4, system["Default Trust"].trust5}
    
    self.toggle = function()
        toggle:next()
        
        if toggle:current() then
            helpers["popchat"]:pop(string.format("Auto-Trust is now: %s.", tostring(toggle:current())):upper(), system["Popchat Window"])
        
        else
            helpers["popchat"]:pop(string.format("Auto-Trust is now: %s.", tostring(toggle:current())):upper(), system["Popchat Window"])
            
        end
        
    end
    
    self.getEnabled = function()
        return toggle:current()
    end
    
    self.setEnabled = function(value)
        local value = value or false
        
        if type(value) == "boolean" then
            return toggle:setTo(value)
        end
        
    end
    
    self.getPartySize = function()
        party_size = system["Party"]["Parties"].count1
        return party_size
    end
    
    self.getMaxTrust = function()
        return max_trust
    end
    
    self.setMaxTrust = function(value)
        
        if tonumber(value) ~= nil then
            max_trust = tonumber(value)
        end
        
    end
    
    self.getTrustExists = function(name)
        local check = false
        
        if name and type(name) == "string" then
            
            for i,_ in pairs(system["Party"]["Players"]) do
                
                if i == name then
                    check = true
                end
                
            end
        
        end
        return check
        
    end
    
    self.getTrust = function(slot)
        
        if slot and tonumber(slot) ~= nil then
            return trust[slot]
        end
        return false
        
    end
    
    self.setTrust = function(slot, name)
        
        if slot and name and tonumber(slot) ~= nil and type(name) == "string" then
            trust[slot] = name
        end
        
    end
    
    self.ping = function()
        local player  = windower.ffxi.get_mob_by_target("me")
        local allowed = 0
        
        if player and toggle:current() and bpcore:canCast() and (player.status == 0 or bpcore:buffActive(603) or bpcore:buffActive(511) or bpcore:buffActive(257) or bpcore:buffActive(267)) then

            for _,v in ipairs(trust) do
                
                if v ~= "" then
                    local true_name = v
                    local party_size = helpers["trust"].getPartySize()
                        true_name = true_name:gsub("[%s+]", "")
                        true_name = true_name:gsub("%(UC%)", "")
                        true_name = true_name:gsub("(II)", "")
                        
                    if not helpers["trust"].getTrustExists(true_name) and party_size ~= 6 and party_size <= max_trust and party_size ~= 0 and allowed < max_trust then
                        
                        if MA[v] and bpcore:isMAReady(MA[v].recast_id) and bpcore:getAvailable("MA", MA[v].en) then
                            helpers["queue"].add(MA[v], "me")
                            allowed = (allowed + 1)
                            
                        end
                        
                    end
                    
                end
                
            end
            
        end
        
    end
    
    return self
    
end
return trust.new()
