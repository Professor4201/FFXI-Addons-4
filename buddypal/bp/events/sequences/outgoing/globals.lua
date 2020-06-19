local globals = {}

--------------------------------------------------------------------------------
-- Outgoing action packets.
--------------------------------------------------------------------------------
globals[1] = function(id,original,modified,injected,blocked)
    
    if id == 0x01a then
        local p        = packets.parse('outgoing', original) 
        local me       = windower.ffxi.get_mob_by_target('me') or false
        local category = p['Category']
        local param    = p['Param']
            
        if category == 0x02 then
            local target = windower.ffxi.get_mob_by_target(p["Target"]) or windower.ffxi.get_mob_by_target("t") or false
            
            -- Set targets when engaging an enemy.
            if target then
                helpers["target"].setTarget(target)
                
                if helpers["target"].getTargetMode() == 2 then
                    windower.send_command(("bp > R bp target send_id " .. tostring(target.id)))
                end
                
            end
            
        elseif category == 0x0f then
            local target = windower.ffxi.get_mob_by_target(p["Target"]) or windower.ffxi.get_mob_by_target("t") or false
            
            -- Adjust target when a player switches targets.
            if target then
                helpers["target"].setTarget(target)
                
            end
        
        elseif category == 0x04 then
            helpers["target"].clearTargets()
            
        end
    
    end
    
end

--------------------------------------------------------------------------------
-- Lock a players coordinates.
--------------------------------------------------------------------------------
globals[2] = function(id,original,modified,injected,blocked)
    
    -- Standard Client.
    if id == 0x015 then
        
        if blocked then
            return
        end
        
        local locked = helpers["actions"].getLocked()
        
        -- Lock position to coordinates.
        if locked then
            local pos_x  = helpers["actions"].getLockedPOS().x
            local pos_y  = helpers["actions"].getLockedPOS().y
            local pos_z  = helpers["actions"].getLockedPOS().z
            
            return original:sub(1,4)..'f':pack(pos_x)..'f':pack(pos_z)..'f':pack(pos_y)..original:sub(17)
        
        end
        return original
        
    end
    
end

--------------------------------------------------------------------------------
-- Equip an item.
--------------------------------------------------------------------------------
globals[3] = function(id,original,modified,injected,blocked)
    
    -- Item Equipped.
    if id == 0x050 and original then
        
        local inventory  = windower.ffxi.get_items()
        local equipment  = inventory['equipment']
        local wep_id     = windower.ffxi.get_items(equipment[string.format('%s_bag', 'main')],  equipment['main']).id
        local ran_id     = windower.ffxi.get_items(equipment[string.format('%s_bag', 'range')], equipment['range']).id
        local amm_id     = windower.ffxi.get_items(equipment[string.format('%s_bag', 'ammo')],  equipment['ammo']).id
        
        system["Weapon"] = res.items[wep_id]
        system["Ranged"] = res.items[ran_id]
        system["Ammo"]   = res.items[amm_id]
        
    end
    
end

--------------------------------------------------------------------------------
-- Handle Menus.
--------------------------------------------------------------------------------
globals[4] = function(id,original,modified,injected,blocked)
    
    if id == 0x05b and helpers["megawarp"].getStatus() ~= false then
        helpers["megawarp"].clear()
        
    end
    
end

--------------------------------------------------------------------------------
-- NPC Item purchase.
--------------------------------------------------------------------------------
globals[5] = function(id,original,modified,injected,blocked)
    
    if id == 0x083 then
        
    end
    
end

--------------------------------------------------------------------------------
-- End Synthesis.
--------------------------------------------------------------------------------
globals[6] = function(id,original,modified,injected,blocked)
    
    if id == 0x059 then
        
    end

end

return globals