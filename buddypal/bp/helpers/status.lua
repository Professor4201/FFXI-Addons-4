--------------------------------------------------------------------------------
-- Status helper: Library for tracking all players status effects in party.
--------------------------------------------------------------------------------
local status = {}
function status.new()
    self = {}
    
    -- Private Variables
    local statuses   = {}
    local na         = {3,4,5,6,7,8,9,15,20}
    local erase      = {11,12,13,21,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,144,145,146,147,148,149,167,174,175,186,192,194,217,223,404,557,558,559,560,561,562,563,564,567,572}
    local waltz      = {11,12,13,21,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,144,145,146,147,148,149,174,175,186,404,557,558,559,560,561,562,563,564,567,572}
    local wake       = {2,19,193}
    local sleep      = {14,17}
    local misery     = {}
    local kill       = {14,17}
    local debug      = true
    local attempt    = nil
    local messages   = {
     
        {82,127,128,141,166,186,194,203,205,230,236,237,242,243,266,267,268,269,270,271,272,277,278,279,280,319,320,321,412,453,645,754,755,804},
        {64,83,123,159,168,204,206,322,341,342,343,344,350,378,531,647,805,806},
        {75},
        
    }
    
    local removal = {
        
        [1] = {[3]=14,[4]=15,[5]=16,[6]=17,[7]=18,[8]=19,[9]=20,[15]=20,[20]=20},
        [2] = {143},
        [3] = {194},
        [4] = {7},
        [5] = {259,253,471,463,98},
        [6] = {0},
        [7] = {0},
    
    }
    
    self.actions = function(original)
        local data     = packets.parse("incoming", original)
        local targets  = data["Target Count"]
        local actor    = windower.ffxi.get_mob_by_id(data["Actor"])
        local target   = windower.ffxi.get_mob_by_id(data["Target 1 ID"])
        local category = data["Category"]
        local param    = data["Param"]
        
        if actor and target and bpcore:isInParty(target) then
            
            -- Melee Attacks.
            if category == 1 then
                
                for i=1, targets do
                    local target  = windower.ffxi.get_mob_by_id(data[string.format("Target %s ID", i)])
                    local param   = string.format("Target %s Action 1 Param", i)
                    local message = string.format("Target %s Action 1 Message", i)
                        
                    if data[message] and data[param] then
                        
                        if helpers["status"].gain(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), false)
                            
                        elseif helpers["status"].lose(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), true)
                            
                        end
                        
                    end
                
                end
                
            -- Finish Ranged Attack.
            elseif category == 2 then
                
                for i=1, targets do
                    local target  = windower.ffxi.get_mob_by_id(data[string.format("Target %s ID", i)])
                    local param   = string.format("Target %s Action 1 Param", i)
                    local message = string.format("Target %s Action 1 Message", i)
                        
                    if data[message] and data[param] then
                        
                        if helpers["status"].gain(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), false)
                            
                        elseif helpers["status"].lose(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), true)
                            
                        end
                        
                    end
                
                end
                
            -- Finish Weaponskill.
            elseif category == 3 then
                
                for i=1, targets do
                    local target  = windower.ffxi.get_mob_by_id(data[string.format("Target %s ID", i)])
                    local param   = string.format("Target %s Action 1 Param", i)
                    local message = string.format("Target %s Action 1 Message", i)
                        
                    if data[message] and data[param] then
                        
                        if helpers["status"].gain(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), false)
                            
                        elseif helpers["status"].lose(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), true)
                            
                        end
                        
                    end
                
                end
                
            -- Finish Spell Casting.
            elseif category == 4 then
            
                for i=1, targets do
                    local target  = windower.ffxi.get_mob_by_id(data[string.format("Target %s ID", i)])
                    local param   = string.format("Target %s Action 1 Param", i)
                    local message = string.format("Target %s Action 1 Message", i)
                    
                    if data[message] and data[param] then
                        
                        if helpers["status"].gain(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), false)
                            
                        elseif helpers["status"].lose(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), true)
                            
                        elseif data[message] == 75 and bpcore:isInParty(actor) and bpcore:isInParty(target) then
                            print(string.format("%s had no effect on target; removing debuff from table.", res.spells[data["Param"]].en))
                            helpers["status"].noEffect(target.id, data["Param"])
                            
                        end
                        
                    end
                
                end
                
            -- Finish using an Item.
            elseif category == 5 then
                
                for i=1, targets do
                    local target  = windower.ffxi.get_mob_by_id(data[string.format("Target %s ID", i)])
                    local param   = string.format("Target %s Action 1 Param", i)
                    local message = string.format("Target %s Action 1 Message", i)
                        
                    if data[message] and data[param] then
                        
                        if helpers["status"].gain(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), false)
                            
                        elseif helpers["status"].lose(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), true)
                            
                        end
                        
                    end
                
                end
                
            -- Use Job Ability.
            elseif category == 6 then
            
                for i=1, targets do
                    local target  = windower.ffxi.get_mob_by_id(data[string.format("Target %s ID", i)])
                    local param   = string.format("Target %s Action 1 Param", i)
                    local message = string.format("Target %s Action 1 Message", i)
                        
                    if data[message] and data[param] then
                        
                        if helpers["status"].gain(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), false)
                            
                        elseif helpers["status"].lose(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), true)
                        
                        elseif data[message] == 75 and bpcore:isInParty(actor) and bpcore:isInParty(target) then
                            print(string.format("%s had no effect on target; removing debuff from table.", res.job_abilities[data["Param"]].en))
                            helpers["status"].noEffect(target.id, data["Param"])
                        
                        end
                        
                    end
                
                end
                
            -- Use Weaponskill.
            elseif category == 7 then
                
                for i=1, targets do
                    local target  = windower.ffxi.get_mob_by_id(data[string.format("Target %s ID", i)])
                    local param   = string.format("Target %s Action 1 Param", i)
                    local message = string.format("Target %s Action 1 Message", i)
                        
                    if data[message] and data[param] then
                        
                        if helpers["status"].gain(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), false)
                            
                        elseif helpers["status"].lose(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), true)
                            
                        end
                        
                    end
                
                end
                
            -- NPC TP Move.
            elseif category == 11 then
                
                for i=1, targets do
                    local target  = windower.ffxi.get_mob_by_id(data[string.format("Target %s ID", i)])
                    local param   = string.format("Target %s Action 1 Param", i)
                    local message = string.format("Target %s Action 1 Message", i)
                        
                    if data[message] and data[param] then
                        
                        if helpers["status"].gain(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), false)
                            
                        elseif helpers["status"].lose(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), true)
                            
                        end
                        
                    end
                
                end
                
            -- Finish Pet Move.
            elseif category == 13 then
                
                for i=1, targets do
                    local target  = windower.ffxi.get_mob_by_id(data[string.format("Target %s ID", i)])
                    local param   = string.format("Target %s Action 1 Param", i)
                    local message = string.format("Target %s Action 1 Message", i)
                        
                    if data[message] and data[param] then
                        
                        if helpers["status"].gain(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), false)
                            
                        elseif helpers["status"].lose(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), true)
                            
                        end
                        
                    end
                
                end
                
            -- DNC Abilities
            elseif category == 14 then
                
                for i=1, targets do
                    local target  = windower.ffxi.get_mob_by_id(data[string.format("Target %s ID", i)])
                    local param   = string.format("Target %s Action 1 Param", i)
                    local message = string.format("Target %s Action 1 Message", i)
                        
                    if data[message] and data[param] then
                        
                        if helpers["status"].gain(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), false)
                            
                        elseif helpers["status"].lose(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), true)
                            
                        end
                        
                    end
                
                end
                
            -- RUN Abilities
            elseif category == 15 then
                
                for i=1, targets do
                    local target  = windower.ffxi.get_mob_by_id(data[string.format("Target %s ID", i)])
                    local param   = string.format("Target %s Action 1 Param", i)
                    local message = string.format("Target %s Action 1 Message", i)
                        
                    if data[message] and data[param] then
                        
                        if helpers["status"].gain(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), false)
                            
                        elseif helpers["status"].lose(data[message]) and res.buffs[data[param]] then
                            helpers["status"].handle(actor, target, res.buffs[data[param]].id, helpers["status"].getCategory(res.buffs[data[param]].id), true)
                            
                        end
                        
                    end
                
                end
                
            end  
            
        end
    
    end
    
    self.messages = function(original)
        local data    = packets.parse("incoming", original)
        local actor   = windower.ffxi.get_mob_by_id(data["Actor"])
        local target  = windower.ffxi.get_mob_by_id(data["Target"])
        local message = data["Message"]
        local params  = {data["Param 1"],data["Param 2"]}
        
        if actor and target and message and bpcore:isInParty(target) then
            
            if helpers["status"].gain(message) then
                
                if res.buffs[params[1]] and helpers["status"].getCategory(params[1]) then
                    helpers["status"].handle(actor, target, res.buffs[params[1]].id, helpers["status"].getCategory(res.buffs[params[1]].id), false)
                
                elseif res.buffs[params[2]] and helpers["status"].getCategory(params[2]) then
                    helpers["status"].handle(actor, target, res.buffs[params[2]].id, helpers["status"].getCategory(res.buffs[params[2]].id), false)
                    
                end
            
            elseif helpers["status"].lose(message) then
                
                if res.buffs[params[1]] and helpers["status"].getCategory(params[1]) then
                    helpers["status"].handle(actor, target, res.buffs[params[1]].id, helpers["status"].getCategory(res.buffs[params[1]].id), true)
                
                elseif res.buffs[params[2]] and helpers["status"].getCategory(params[2]) then
                    helpers["status"].handle(actor, target, res.buffs[params[2]].id, helpers["status"].getCategory(res.buffs[params[2]].id), true)
                    
                end
                
            end
        
        end
        
    end
    
    self.handle = function(actor, target, buff, category, lost)
        local actor, target, buff, category, lost = actor or false, target or false, buff or false, category or false, lost or false
        
        if actor and target and buff and category and not lost then
            
            if removal[category] then
                local remove = removal[category]
                
                if category == 1 and remove[buff] and res.spells[remove[buff]] and not helpers["status"].hasStatus(target.id, buff) then
                    helpers["status"].insert(target, buff, res.spells[remove[buff]].id)
                    
                elseif not remove[buff] and not helpers["status"].hasStatus(target.id, buff) then
                    
                    for _,v in ipairs(remove) do
                        
                        if type(v) == "table" then
                            
                            for _,vv in ipairs(v) do
                                
                                if res.spells[vv] and res.spells[vv].en ~= "Erase" then
                                    helpers["status"].insert(target, buff, res.spells[vv].id)
                                    
                                elseif res.spells[vv] and res.spells[vv].en == "Erase" and bpcore:isInParty(target, false) then
                                    helpers["status"].insert(target, buff, res.spells[vv].id)
                                    
                                end
                                
                            end
                            
                        else

                            if res.spells[v] and res.spells[v].en ~= "Erase" then
                                helpers["status"].insert(target, buff, res.spells[v].id)
                                
                            elseif res.spells[v] and res.spells[v].en == "Erase" and bpcore:isInParty(target, true) then
                                helpers["status"].insert(target, buff, res.spells[v].id)
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            end
            
        elseif actor and target and buff and category and lost then
            
            if removal[category] then
                local remove = removal[category]
                
                if category == 1 and remove[buff] and res.spells[remove[buff]] and helpers["status"].hasStatus(target.id, buff) then
                    helpers["status"].removeBuff(target.id, buff)
                    
                elseif not remove[buff] and helpers["status"].hasStatus(target.id, buff) then
                    
                    for _,v in ipairs(remove) do
                        
                        if type(v) == "table" then
                            
                            for _,vv in ipairs(v) do
                                
                                if res.spells[vv] then
                                    
                                    if (helpers["status"].getDebuffCount() - 1) == 0 then
                                        helpers["status"].removePlayer(target.id)
                                    
                                    else
                                        helpers["status"].removeBuff(target.id, buff)
                                        
                                    end
                                    
                                end
                            end
                            
                        else
                            
                            if res.spells[v] then
                                
                                if (helpers["status"].getDebuffCount() - 1) == 0 then
                                    helpers["status"].removePlayer(target.id)
                                
                                else
                                    helpers["status"].removeBuff(target.id, buff)
                                    
                                end
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            end
            
        end
        
    end
    
    self.manangeStatuses = function()
        local debuffs = helpers["status"].getAllStatuses()
        
        for i,v in pairs(statuses) do
            
            if windower.ffxi.get_mob_by_id(i) and bpcore:isInParty(windower.ffxi.get_mob_by_id(i)) then
                local target = windower.ffxi.get_mob_by_id(i)
                
                for _,cast in ipairs(v) do
                    
                    if res.job_abilities[cast.spell] and res.job_abilities[cast.spell].en == "Healing Waltz" and not helpers["queue"].inQueue(res.job_abilities[cast.spell], target) then
                        local spell = res.job_abilities[cast.spell]
                        
                        if spell and bpcore:isJAReady(JA[spell.en].recast_id) and bpcore:getAvailable("JA", spell.en) then
                            helpers['queue'].add(JA[spell.en], target)
                        end
                        
                    elseif res.spells[cast.spell] and not helpers["queue"].inQueue(res.spells[cast.spell], target) then
                        local spell = res.spells[cast.spell]
                        
                        if spell and bpcore:isMAReady(MA[spell.en].recast_id) and bpcore:getAvailable("MA", spell.en) then
                            
                            if spell.en ~= "Cursna" then
                                helpers['queue'].add(MA[spell.en], target)
                            
                            elseif spell.en == "Cursna" then
                                helpers['queue'].addToFront(MA[spell.en], target)
                            
                            end
                        
                        end
                        
                    end
                    
                end
                
            end
            
        end
        
    end
    
    self.gain = function(id)
        local id = id or false

        if id then
            
            for _,v in ipairs(messages[1]) do
                
                if v == id then
                    return true
                end
                
            end
            
        end
        return false
        
    end
    
    self.lose = function(id)
        local id = id or false
        
        if id then
            
            for _,v in ipairs(messages[2]) do
                
                if v == id then
                    return true
                end
                
            end
            
        end
        return false
        
    end
    
    self.noEffect = function(id, spell)
        local id, spell = id or false, spell or false
        
        if id and spell and statuses[id] and type(statuses[id]) == "table" then
            
            if (T{14,15,16,17,18,19,20}):contains(spell) then
                
                for _,v in pairs(statuses[id]) do
                    
                    if na[v] then
                        helpers["status"].remove(id, v)
                    end
                    
                end
                
            elseif spell == 143 then
                
                for _,v in pairs(statuses[id]) do
                    
                    if erase[v] then
                        helpers["status"].remove(id, v)
                    end
                    
                end
                
            elseif spell == 194 then
                
                for _,v in pairs(statuses[id]) do
                    
                    if waltz[v] then
                        helpers["status"].remove(id, v)
                    end
                    
                end
                
            end
            
        end
        
    end
    
    self.getCategory = function(id)
        local id = id or false
        
        if id then
            
            for _,v in ipairs(na) do
                
                if v == id then
                    return 1
                end
                
            end
            
            for _,v in ipairs(erase) do
                
                if v == id then
                    return 2
                end
                
            end
            
            for _,v in ipairs(waltz) do
                
                if v == id then
                    return 3
                end
                
            end
            
            for _,v in ipairs(wake) do
                
                if v == id then
                    return 4
                end
                
            end
            
            for _,v in ipairs(sleep) do
                
                if v == id then
                    return 5
                end
                
            end
            
            for _,v in ipairs(misery) do
                
                if v == id then
                    return 6
                end
                
            end
            
            for _,v in ipairs(kill) do
                
                if v == id then
                    return 7
                end
                
            end
            
        end
        return false
        
    end
    
    self.insert = function(target, buff, spell, priority)
        local target, buff, spell = target or false, buff or false, spell or false
        
        if target and buff and spell then
            
            if statuses[target.id] then
                table.insert(statuses[target.id], {buff=buff, spell=spell})                
            else
                statuses[target.id] = {}
                table.insert(statuses[target.id], {buff=buff, spell=spell})                
            end
            
        end
        
    end
    
    self.hasStatus = function(id, buff)
        local id, buff = id or false, buff or false
        
        if id and buff and statuses[id] then
            
            for _,v in ipairs(statuses[id]) do
                
                if v.buff == buff then
                    return true
                end
                
            end
            
        end
        return false
        
    end
    
    self.removeBuff = function(id, buff)
        local id, buff = id or false, buff or false
        
        if id and buff and statuses[id] then
            local temp = {}
            
            for i,v in pairs(statuses[id]) do

                if v.buff ~= buff then
                    table.insert(temp, v)
                end
                
            end
            statuses[id] = temp
            
        end
        
    end
    
    self.removePlayer = function(id)
        local id = id or false

        if id and statuses then
            local temp = {}
            
            for i,v in pairs(statuses) do

                if i ~= id then
                    table.insert(temp, v)
                end
                
            end
            statuses = temp
            
        end
        
    end
    
    self.getStatuses = function(id)
        local id = id or false
        
        if id and statuses[id] then
            return statuses[id]
        end
        return false
        
    end
    
    self.getAllStatuses = function()
        return statuses
        
    end
    
    self.getDebuffCount = function(id)
        local id = id or false
        
        if id and statuses[id] then
            return #statuses[id]
        end
        return 0
        
    end
    
    self.clear = function()
        statuses = {}
    end
    
    return self

end
return status.new()