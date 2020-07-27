--------------------------------------------------------------------------------
-- Kits Commands: Handles commands for purchasing crafting kits from the NPC.
--------------------------------------------------------------------------------
local kits = {}
function kits.run()
    local self = {}

    self.execute = function(commands)
        local target   = windower.ffxi.get_mob_by_target("t") or false
        local commands = commands or false
        
        if commands and target then
            local kit, quantity = tonumber(commands[2]) or false, tonumber(commands[3]) or false
            
            if kit and quantity and tonumber(kit) ~= nil and tonumber(quantity) ~= nil and quantity >= 0 and quantity <= 12 and helpers["kits"].verify(target, kit) then
                helpers["kits"].setKit(kit)
                helpers["kits"].setQuantity(quantity)
                helpers["kits"].setInjecting(true)
                helpers["actions"].doAction(target, 0, "interact")
            end
            
        end
    
    end

    return self
    
end
return kits.run()