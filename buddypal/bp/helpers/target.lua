--------------------------------------------------------------------------------
-- Target helper: Handles how the addon determines players targets.
--------------------------------------------------------------------------------
local target = {}
function target.new()
    local self = {}
    
    -- Private Variables
    local targets       = {["player"]=false,["party"]=false,["luopan"]=false,["entrust"]=false,["enmity"]=false}
    local distances     = {}
    local stats         = {}
    local mode          = I{1,2}
    local string        = ""
    local font          = system["Target Font"]
    local draggable     = system["Target Draggable"]
    local padding       = system["Target Padding"]
    local stroke        = system["Target Stroke"]
    local update        = os.clock()
    local settings = {
        ['pos']={['x']=system["Target Window X"],['y']=system["Target Window Y"]},
        ['bg']={['alpha']=200,['red']=0,['green']=0,['blue']=0,['visible']=false},
        ['flags']={['right']=false,['bottom']=false,['bold']=false,['draggable']=draggable,['italic']=false},
        ['padding']=padding,
        ['text']={['size']=font.size,['font']=font.font,['fonts']={},['alpha']=font.alpha,['red']=font.r,['green']=font.g,['blue']=font.b,
            ['stroke']={['width']=stroke.width,['alpha']=stroke.alpha,['red']=stroke.r,['green']=stroke.g,['blue']=stroke.b}
        },
    }
    
    local display   = texts.new("", settings, settings)
    local extra     = texts.new("", settings, settings)
        extra:pos(system["Target Window X"], system["Target Window Y"]-50)
    
    self.setTarget = function(target)
        local target = target or false
        
        if target then
        
            if type(target) == "number" then
                target = windower.ffxi.get_mob_by_id(target) or false
            
            elseif type(target) == "table" then
                target = windower.ffxi.get_mob_by_id(target.id) or false
                
            elseif windower.ffxi.get_mob_by_target("t") then
                target = windower.ffxi.get_mob_by_target("t")
                
            else
                target = false
                
            end
        
        end
        
        -- If player is the target then clear.
        if target and target.id == windower.ffxi.get_player().id then
            helpers["target"].clearTargets()
            return false
            
        end
        
        
        if helpers["target"].getTargetMode() == 1 and target and bpcore:canEngage(target) then
            
            if target.distance:sqrt() < 35 then
                targets.player = target
                helpers["popchat"]:pop(("Setting current target to: " .. target.name .. "."), system["Popchat Window"])                
            end
            
        elseif helpers["target"].getTargetMode() == 2 and target and bpcore:canEngage(target) then
            
            if target.distance:sqrt() < 35 then
                targets.party = target
                helpers["popchat"]:pop(("Setting current party target to: " .. target.name .. "."), system["Popchat Window"])
            end
            
        end   
        
    end
    
    self.setPlayerTarget = function(target)
        local target = target or false
        
        if target then
        
            if type(target) == "number" then
                target = windower.ffxi.get_mob_by_id(target) or false
            
            elseif type(target) == "table" then
                target = windower.ffxi.get_mob_by_id(target.id) or false
                
            elseif windower.ffxi.get_mob_by_target("t") then
                target = windower.ffxi.get_mob_by_target("t")
                
            else
                target = false
                
            end
        
        end
        
        -- If player is the target then clear.
        if target and target.id == windower.ffxi.get_player().id then
            helpers["target"].clearTargets()
            return false
            
        end
        
        if target and bpcore:canEngage(target) then
            
            if math.sqrt(target.distance) < 35 then
                targets.player = target
                helpers["popchat"]:pop(("Setting current target to: " .. target.name .. "."), system["Popchat Window"])                
            end
        
        end
    
    end
    
    self.setPartyTarget = function(target)
        local target = target or false
        
        if target then
        
            if type(target) == "number" then
                target = windower.ffxi.get_mob_by_id(target) or false
            
            elseif type(target) == "table" then
                target = windower.ffxi.get_mob_by_id(target.id) or false
                
            elseif windower.ffxi.get_mob_by_target("t") then
                target = windower.ffxi.get_mob_by_target("t")
                
            else
                target = false
                
            end
        
        end
        
        -- If player is the target then clear.
        if target and target.id == windower.ffxi.get_player().id then
            helpers["target"].clearTargets()
            return false
            
        end
        
        if target and bpcore:canEngage(target) then
            
            if math.sqrt(target.distance) < 35 then
                targets.party = target
                helpers["popchat"]:pop(("Setting current party target to: " .. target.name .. "."), system["Popchat Window"])
                
            end
        
        end
    
    end
    
    self.setLuopanTarget = function(target)
        local target = target or false
        
        if target then
        
            if type(target) == "number" then
                target = windower.ffxi.get_mob_by_id(target) or false
            
            elseif type(target) == "table" then
                target = windower.ffxi.get_mob_by_id(target.id) or false
                
            elseif type(target) == "string" and windower.ffxi.get_mob_by_name(target) then
                target = windower.ffxi.get_mob_by_name(target) or false
                
            elseif windower.ffxi.get_mob_by_target("t") then
                target = windower.ffxi.get_mob_by_target("t")
                
            else
                target = false
                
            end
        
        end
        
        if target then
            
            if (target.distance):sqrt() < 22 then
                targets.luopan = target                
            end
        
        end
    
    end
    
    self.setEntrustTarget = function(target)
        local target = target or false
        local new_target
        
        if target and target ~= "" then
        
            if type(target) == "number" then
                new_target = windower.ffxi.get_mob_by_id(target) or false
            
            elseif type(target) == "table" then
                new_target = windower.ffxi.get_mob_by_id(target.id) or false
                
            elseif type(target) == "string" and windower.ffxi.get_mob_by_name(target) and not helpers["target"].isEnemy(windower.ffxi.get_mob_by_name(target)) then
                new_target = windower.ffxi.get_mob_by_name(target) or false
                
            elseif windower.ffxi.get_mob_by_target("t") then
                new_target = windower.ffxi.get_mob_by_target("t")
            
            else
                new_target = false
                
            end
        
        end
        
        -- If player is the target then clear.
        if new_target and new_target.id == windower.ffxi.get_player().id then
            targets.entrust = false            
        end
        
        if new_target then
            local player = windower.ffxi.get_player()
            
            if (new_target.distance):sqrt() < 22 and new_target.name ~= player.name then
                targets.entrust = new_target                
            end
        
        end
    
    end
    
    self.setPlayerEnmity = function(actor, target)
        local actor   = actor or false
        local target  = target or false
        local ptarget = helpers["target"].getPlayerTarget() or false

        if actor and target and ptarget then
            
            if actor.id == ptarget.id and helpers["target"].exists(actor) and bpcore:canEngage(actor) and actor.is_npc and bpcore:isInParty(target) then
                targets["enmity"] = target
            end
            
        end        
    
    end
    
    self.getTarget = function()
    
        if (targets.player or targets.party) then
            
            if targets.player and not targets.party then
                return targets.player
            
            elseif targets.party and not targets.player then
                return targets.party
            
            elseif targets.party and targets.player then
                return targets.player
                
            end
            
        end
        return false
        
    end
    
    self.isTarget = function(target)
        local target = target or false
        local mine   = helpers["target"].getTarget()
        
        if target and mine and target.id == mine.id then
            return true
        end
        return false
        
    end            
    
    self.getPlayerTarget = function()
        return targets.player
    end
    
    self.getPartyTarget = function()
        return targets.party
    end
    
    self.getLuopanTarget = function()
        return targets.luopan
    end
    
    self.getEntrustTarget = function()
        return targets.entrust
    end
    
    self.getPlayerEnmity = function()
        return targets.enmity
    end
    
    self.setTargetMode = function(value)
        mode:next()
        
        if mode:current() == 1 then
            helpers["popchat"]:pop(("NOW IN PLAYER TARGET MODE."), system["Popchat Window"])
            
        else
            helpers["popchat"]:pop(("NOW IN PARTY TARGET MODE."), system["Popchat Window"])
            
        end
    
    end

    self.getTargetMode = function()
        return mode:current()
    end
    
    self.isEnemy = function(target)
        local target = target or false
    
        if target then
            
            if type(target) == "table" and target.spawn_type then
                return true
                
            elseif type(target) == "number" and tonumber(target) ~= nil then
                local target = windower.ffxi.get_mob_by_id(target)
                
                if type(target) == "table" and target.spawn_type == 16 then
                    return true
                end
                    
            elseif type(target) == "string" then
                local target = windower.ffxi.get_mob_by_target(target) or windower.ffxi.get_mob_by_name(target) or false
                
                if type(target) == "table" and target.spawn_type == 16 then
                    return true
                end
                
            end
        
        end
        return false
        
    end
    
    self.castable = function(target, spell)
        local target  = target or false
        local targets = spell.targets
        
        if target then
            
            for i,v in pairs(targets) do
                
                if i == "Self" and target.name == windower.ffxi.get_player().name then
                    return v
                
                elseif i == "Party" and bpcore:isInParty(target, true) then
                    return v
                    
                elseif i == "Ally" and bpcore:isInParty(target, false) then
                    return v
                    
                elseif i == "Player" and not target.is_npc then
                    return v
                    
                elseif i == "NPC" and not target.is_npc then
                    return v
                    
                elseif i == "Enemy" and target.spawn_type == 16 then
                    return v
                    
                end
                
            end
            
        end
        return false
        
    end
    
    self.onlySelf = function(spell)
        local spell = spell or false
        
        if spell then
            local targets = T(spell.targets)
            
            if #targets == 1 and targets[1] == "Self" and spell.prefix ~= "/song" then
                return true
            end
            
        end
        return false
        
    end
    
    self.isDead = function(target)
        local target = target or false
        
        if target and (target.status == 2 or target.status == 3) then
            return true
        end
        return false
        
    end
    
    self.exists = function(target)
        local target = target or false
        
        if target and type(target) == "table" then
            local target = windower.ffxi.get_mob_by_id(target.id) or windower.ffxi.get_mob_by_target("t") or false
        
            if target and type(target) == "table" and target.distance ~= nil then
                local distance = (target.distance:sqrt())
                
                if (distance == 0.089004568755627 or distance > 35) then
                    return false
                end
                
                if not target then
                    return false
                end
                
                if target.hpp == 0 then
                    return false
                end
                
                if not target.valid_target then
                    return false
                end
                
                if not helpers["target"].isEnemy(target) and not bpcore:isInParty(target) then
                    return false
                end
                
                if target.charmed then
                    return false
                end
                return true
                
            end
        
        end
        return false
        
    end
    
    self.clearTargets = function()
        targets.player = false 
        targets.party  = false
        targets.luopan = false
        helpers["actions"].stopMovement()
        
    end
    
    self.updateTargets = function()
        
        if windower.ffxi.get_player() and windower.ffxi.get_player()["vitals"].hp == 0 then
            targets.player = false
            targets.party  = false
            targets.luopan = false
        
        end
        
        if type(targets.player) == "table" then
            
            if not helpers["target"].exists(targets.player) then
                targets.player = false
                
            elseif helpers["target"].exists(targets.player) then
                targets.player = windower.ffxi.get_mob_by_id(helpers["target"].getPlayerTarget().id)
            
            end
        
        else
            targets.player = false
        
        end
        
        if type(targets.luopan) == 'table' then
            
            if not helpers['target'].exists(targets.luopan) then
                targets.luopan = false
            end
        
        else
            targets.luopan = false
            
        end
        
        if targets.party then
            
            if not helpers["target"].exists(targets.party) then
                targets.party = false
                
            elseif helpers["target"].exists(targets.party) then
                targets.party = windower.ffxi.get_mob_by_id(helpers["target"].getPartyTarget().id)
            
            end
        
        else
            targets.party = false
            
        end
        
        
        
    end
    
    self.autoTarget = function(actor, target)
        local attacker = windower.ffxi.get_mob_by_id(actor)
        local target   = windower.ffxi.get_mob_by_id(target)
        
        -- If actor exists, is in range, and auto targeting is enabled.
        if helpers['target'].getTargetMode() == 1 and helpers['target'].isEnemy(attacker) then
            
            if system["Auto Target"]:current() and not helpers["target"].getPlayerTarget() then
                
                if bpcore:isInParty(target) and helpers["actions"].rangeCheck(target.x, target.y, system["Aggro Range"]) then
                    
                    if helpers["target"].exists(attacker) then
                        helpers["target"].setPlayerTarget(attacker.id)
                    end                    
                
                end
                
            end
            
        elseif helpers["target"].getTargetMode() == 2 and helpers['target'].isEnemy(attacker) then
            
            if system["Auto Target"]:current() and not helpers["target"].getPlayerTarget() then
                
                if bpcore:isInParty(target) and helpers["actions"].rangeCheck(target.x, target.y, system["Aggro Range"]) then
                        
                    if helpers["target"].exists(attacker) and not helpers["target"].getPartyTarget() then
                        helpers["target"].setPartyTarget(attacker.id)
                    end
                    
                end
                
            end
            
        end
        
    end
    
    self.show = function()
        display:bg_visible(true)
        display:show()
    end
    
    self.hide = function()
        display:bg_visible(false)
        display:hide()
    end
    
    self.getTargetDisplay = function()
        return display
    end
    
    self.setExtraVisible = function(value)
        extra:visible(value)
        
        if extra:visible() then
            extra:bg_visible(true)
            
        else
            extra:bg_visible(false)
            
        end
        extra:update()
        
    end
    
    self.getExtraVisible = function()
        return extra:visible()
    end
    
        
    
    self.ping = function()
        local player = windower.ffxi.get_player() or false
        
        if player then
            
            -- Check if targets need to be cleared before updating.
            helpers["target"].updateTargets()            
            
            --Placeholders
            local target1 = helpers["target"].getPlayerTarget()  or ""
            local target2 = helpers["target"].getPartyTarget()   or ""
            local target3 = helpers["target"].getLuopanTarget()  or ""
            local target4 = helpers["target"].getEntrustTarget() or ""
            local strings
            
            if player.main_job == "GEO" then
                
                strings = {
                    player  = "Player: [" .. bpcore:colorize("N/A", "25,200,230") .. "]",
                    party   = "Party: [" .. bpcore:colorize("N/A", "25,200,230") .. "]",
                    luopan  = "Luopan: [" .. bpcore:colorize("N/A", "25,200,230") .. "]",
                    entrust = "Entrust: [" .. bpcore:colorize("N/A", "25,200,230") .. "]",
                }
                
            else
                
                strings = {
                    player  = "Player: [" .. bpcore:colorize("N/A", "25,200,230") .. "]",
                    party   = "Party: [" .. bpcore:colorize("N/A", "25,200,230") .. "]",
                }
                
            end
            
            if target1 ~= "" then
                
                if type(target1) == "table" then
                    strings.player = "Player: [" .. bpcore:colorize(target1.name, "25,200,230") .. "]"
                else
                    strings.player = "Player: [" .. bpcore:colorize(target1, "25,200,230") .. "]"
                end
            
            end
            
            if target2 ~= "" then
                
                if type(target2) == "table" then
                    strings.party = "Party: [" .. bpcore:colorize(target2.name, "25,200,230") .. "]"
                else
                    strings.party = "Party: [" .. bpcore:colorize(target2, "25,200,230") .. "]"
                end
            
            end
            
            if strings.luopan and target3 ~= "" then
                
                if type(target3) == "table" then
                    strings.luopan = "Luopan: [ " .. bpcore:colorize(target3.name, "25,200,230") .. "]"
                else
                    strings.luopan = "Luopan: [ " .. bpcore:colorize(target3, "25,200,230") .. "]"
                end
                
            end
        
            if strings.entrust and target4 ~= "" then
                
                if type(target4) == "table" then
                    strings.entrust = "Entrust: [" .. bpcore:colorize(target4.name, "25,200,230") .. "]"
                else
                    strings.enstrust = "Entrust: [" .. bpcore:colorize(target4, "25,200,230") .. "]"
                end
                
            end
            
            display:text(table.concat(strings, " + "))
            display:bg_visible(true)
            display:update()
            display:show()
            
            if display:visible() then
                
                if target1 ~= "" then
                    local hpp    = tostring(target1.hpp) or "0"
                    local mpp    = tostring(target1.mpp) or "0"
                    local update = string.format("{ Target HPP ---> %s | Target MPP ---> %s }", hpp, mpp)
                    extra:text(update)
                    extra:update()
                    
                elseif target2 ~= "" then
                    local hpp    = tostring(target2.hpp) or "0"
                    local mpp    = tostring(target2.mpp) or "0"
                    local update = string.format("{ Target HPP ---> %s | Target MPP ---> %s }", hpp, mpp)
                    extra:text(update)
                    extra:update()
                
                end
            
            end
        
        end

    end
    
    return self
    
end
return target.new()