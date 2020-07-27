--------------------------------------------------------------------------------
-- Trust helper: Trust handles automatically calling fourth trust when empty spaces arer available.
--------------------------------------------------------------------------------
local trust = {}
function trust.new()
    local self = {}
    
    -- Private Variables.
    local party_size = 0
    local max        = 5
    local toggle     = I{false,true}
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
        return windower.ffxi.get_party().party1_count
    end
    
    self.getMaxTrust = function()
        return max
    end
    
    self.setMaxTrust = function(value)
        local value = value or 4
        if tonumber(value) ~= nil then
            max = tonumber(value)
        end
        
    end
    
    self.getTrustExists = function(name)
        
        if name and type(name) == "string" then
            
            for i,v in pairs(windower.ffxi.get_party()) do
                
                if (i):sub(1,1) == "p" and #i == 2 then
                    
                    if v.name == name then
                        return true
                    end
                    
                end
                
            end
        
        end
        return false
        
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
        
        if player and toggle:current() and bpcore:canCast() and (player.status == 0 or bpcore:buffActive(603) or bpcore:buffActive(511) or bpcore:buffActive(257) or bpcore:buffActive(267)) then

            for _,v in ipairs(trust) do
                local size = helpers["trust"].getPartySize()
                
                if v ~= "" then
                    local true_name = v
                        true_name = true_name:gsub("[%s+]", "")
                        true_name = true_name:gsub("%(UC%)", "")
                        true_name = true_name:gsub("(II)", "")

                    if not helpers["trust"].getTrustExists(true_name) and size <= 6  then
                        
                        if MA[v] and bpcore:isMAReady(MA[v].recast_id) and bpcore:getAvailable("MA", MA[v].en) then
                            helpers["queue"].add(MA[v], "me")
                            break
                        end
                        
                    end
                    
                end
                
            end
            
        end
        
    end
    
    return self
    
end
return trust.new()
