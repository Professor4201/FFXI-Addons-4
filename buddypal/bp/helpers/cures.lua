--------------------------------------------------------------------------------
-- Cures helper: Library for handling how to determine curing for party.
--------------------------------------------------------------------------------
local cures = {}
function cures.new()
    local self = {}
    
    -- Private Variables
    local multiplier  = (0.15)
    local majesty     = false
    local cure_data   = dofile(string.format("%sbp/helpers/cures/cure_data.lua", windower.addon_path))
    local needed      = {}
    local party       = {}
    local alliance    = {}
    local mFloor      = math.floor
    
    self.handleCuring = function()
        local party    = party or false
        local alliance = alliance or false
        local mode     = system["Core"].current("CURES")
        local count    = helpers["cures"].curesNeeded()
        
        if party and alliance and mode ~= 1 then
            local player = windower.ffxi.get_player() or false
            
            if mode == 2 and count > 2 and (player.main_job == "WHM" or player.sub_job == "WHM") then
                local party = T(party)
                local missing = 0
                local id = false
                
                for _,v in ipairs(party) do
                    missing = (missing + v.missing)
                    
                    if not id and v.id ~= player.id then
                        id = v.id
                    end
                    
                end

                if missing > 0 then
                    local cure   = helpers["cures"].estimateCuraga(missing, count) or false
                    local target = windower.ffxi.get_mob_by_id(id) or false
                    
                    if cure and target and not helpers["queue"].inQueue(cure.spell, target) then
                    
                        if cure.priority then
                            helpers["queue"].addToFront(cure.spell, target)
                        
                        elseif not cure.priority then
                            helpers["queue"].replace(cure.spell, target, (cure.spell.en):sub(1,4))
                        
                        end
                    
                    end
                    
                end
                
            elseif mode == 2 then
                local party = T(party)
                
                if (player.main_job == "WHM" or player.main_job == "RDM" or player.main_job == "SCH" or player.main_job == "PLD" or player.sub_job == "WHM" or player.sub_job == "RDM" or player.sub_job == "SCH" or player.sub_job == "PLD") then
                    
                    for i,v in ipairs(party) do
                        local cure   = helpers["cures"].estimateCure(v.missing) or false
                        local target = windower.ffxi.get_mob_by_id(v.id) or false
                        
                        if cure and target and not helpers["queue"].inQueue(cure.spell, target) then
                            
                            if cure.priority then
                                helpers["queue"].addToFront(cure.spell, target)
                                
                            elseif not cure.priority then
                                helpers["queue"].replace(cure.spell, target, (cure.spell.en):sub(1,4))
                                
                            end
                            
                        end
                        
                    end
                    
                end
            
            elseif mode == 3 and count > 2 and (player.main_job == "WHM" or player.sub_job == "WHM") then
                local party = T(party):extend(T(alliance))
                    
                for i,v in ipairs(party) do
                    local cure   = helpers["cures"].estimateCuraga(v.missing) or false
                    local target = windower.ffxi.get_mob_by_id(v.id) or false
                    
                    if cure and target and not helpers["queue"].inQueue(cure.spell, target) then
                        
                        if cure.priority then
                            helpers["queue"].addToFront(cure.spell, target)
                            
                        elseif not cure.priority then
                            helpers["queue"].replace(cure.spell, target, (cure.spell.en):sub(1,4))
                            
                        end
                        
                    end
                    
                end            
            
            elseif mode == 3 then
                local party = T(party):extend(T(alliance))
                
                if (player.main_job == "WHM" or player.main_job == "RDM" or player.main_job == "SCH" or player.main_job == "PLD" or player.sub_job == "WHM" or player.sub_job == "RDM" or player.sub_job == "SCH" or player.sub_job == "PLD") then
                    
                    for i,v in ipairs(party) do
                        local cure   = helpers["cures"].estimateCure(v.missing) or false
                        local target = windower.ffxi.get_mob_by_id(v.id) or false
                        
                        if cure and target then
                            
                            if cure.priority and not helpers["queue"].inQueue(cure.spell, target) then
                                helpers["queue"].addToFront(cure.spell, target)
                                
                            elseif cure.priority and not helpers["queue"].inQueue(cure.spell, target) then
                                helpers["queue"].replace(cure.spell, target, (cure.spell.en):sub(1,4))
                                
                            end
                            
                        end
                        
                    end
                    
                end
            
            end
            
        end
        
    end        
    
    self.estimateCure = function(amount)
        local player  = windower.ffxi.get_player()
        local amount  = amount or 0
        local cure    = false
        
        if amount > 0 then
            local selected = nil
            local spells   = res.spells:type("WhiteMagic")
                    
            for i,v in ipairs(cure_data[1]) do
                
                if type(v) == "table" then
                    
                    for _,vv in ipairs(v.powers) do
                        local base, rate, floor = vv.power or false, vv.rate or false, vv.floor or false
                        local power = helpers["cures"].getCurePower()
                        local spell = spells[v.id]
                        
                        if base and rate and floor and base > power and bpcore:isMAReady(MA[spell.en].recast_id) and bpcore:getAvailable("MA", spell.en) then
                            local estimate = ( mFloor((power-base)/rate)+floor )
                            
                            if (estimate+(estimate*multiplier)) <= amount then

                                if spell.en == "Cure" then
                                    
                                    if (player.main_job == "WHM" and player.main_job_level >= 1) or (player.sub_job == "WHM" and player.sub_job_level >= 1) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    elseif (player.main_job == "RDM" and player.main_job_level >= 3) or (player.sub_job == "RDM" and player.sub_job_level >= 3) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    elseif (player.main_job == "SCH" and player.main_job_level >= 5) or (player.sub_job == "SCH" and player.sub_job_level >= 5) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    elseif (player.main_job == "PLD" and player.main_job_level >= 5) or (player.sub_job == "PLD" and player.sub_job_level >= 5) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    end
                                    
                                elseif spell.en == "Cure II" then
                                    
                                    if (player.main_job == "WHM" and player.main_job_level >= 11) or (player.sub_job == "WHM" and player.sub_job_level >= 11) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    elseif (player.main_job == "RDM" and player.main_job_level >= 14) or (player.sub_job == "RDM" and player.sub_job_level >= 14) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    elseif (player.main_job == "SCH" and player.main_job_level >= 17) or (player.sub_job == "SCH" and player.sub_job_level >= 17) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    elseif (player.main_job == "PLD" and player.main_job_level >= 17) or (player.sub_job == "PLD" and player.sub_job_level >= 17) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    end
                                    
                                elseif spell.en == "Cure III" then
                                    
                                    if (player.main_job == "WHM" and player.main_job_level >= 21) or (player.sub_job == "WHM" and player.sub_job_level >= 21) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    elseif (player.main_job == "RDM" and player.main_job_level >= 26) or (player.sub_job == "RDM" and player.sub_job_level >= 26) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    elseif (player.main_job == "SCH" and player.main_job_level >= 30) or (player.sub_job == "SCH" and player.sub_job_level >= 30) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    elseif (player.main_job == "PLD" and player.main_job_level >= 30) or (player.sub_job == "PLD" and player.sub_job_level >= 30) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    end
                                    
                                elseif spell.en == "Cure IV" then
                                    
                                    if (player.main_job == "WHM" and player.main_job_level >= 41) or (player.sub_job == "WHM" and player.sub_job_level >= 41) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    elseif (player.main_job == "RDM" and player.main_job_level >= 48) or (player.sub_job == "RDM" and player.sub_job_level >= 48) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    elseif (player.main_job == "SCH" and player.main_job_level >= 55) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    elseif (player.main_job == "PLD" and player.main_job_level >= 55) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                        
                                    end
                                    
                                elseif spell.en == "Cure V" then
                                    
                                    if (player.main_job == "WHM" and player.main_job_level >= 61) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}                                        
                                    end
                                    
                                elseif spell.en == "Cure VI" then
                                    
                                    if (player.main_job == "WHM" and player.main_job_level >= 80) then
                                        cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}                                        
                                    end
                                
                                end
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            end
            
        end
        
        if cure then
            return cure
        end
        
    end
    
    self.estimateCuraga = function(amount, count)
        local player = windower.ffxi.get_player()
        local amount = amount or 0
        local count  = count or 0
        local cure   = false
        
        if amount > 0 and count > 2 then
            local selected = nil
            local spells   = res.spells:type("WhiteMagic")
                    
            for i,v in ipairs(cure_data[2]) do
                
                if type(v) == "table" then
                    
                    for _,vv in ipairs(v.powers) do
                        local base, rate, floor = (vv.power+(vv.power*multiplier)) or false, vv.rate or false, vv.floor or false
                        local power = helpers["cures"].getCuragaPower()
                        local spell = spells[v.id]
                        
                        if base and rate and floor and base <= power and bpcore:isMAReady(MA[spell.en].recast_id) and bpcore:getAvailable("MA", spell.en) and player.main_job == "WHM" and player["vitals"].mp > spell.mp_cost then
                            local estimate = ( mFloor((power/2)/rate)+floor )
                            
                            if ((estimate*count) <= amount) then
                                
                                if spell.en == "Curaga" and (player.main_job_level >= 16 or player.sub_job_level >= 16) then
                                    cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}

                                elseif spell.en == "Curaga II" and (player.main_job_level >= 31 or player.sub_job_level >= 31) then
                                    cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}

                                elseif spell.en == "Curaga III" and player.main_job_level >= 51 then
                                    cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}

                                elseif spell.en == "Curaga IV" and player.main_job_level >= 71 then
                                    cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}

                                elseif spell.en == "Curaga V" and player.main_job_level >= 91 then
                                    cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}

                                end
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            end
            
        end
        
        if cure then
            return cure
        end
        
    end
    
    self.estimateWaltz = function(amount)
        local player = windower.ffxi.get_player()
        local amount = amount or 0
        local cure   = false
        
        if amount > 0 then
            local selected = nil
            local spells   = res.job_abilities:type("Waltz")
                    
            for i,v in ipairs(cure_data[5]) do
                
                if type(v) == "table" then
                    
                    for _,vv in ipairs(v.powers) do
                        local base, rate, floor = (vv.power+(vv.power*multiplier)) or false, vv.rate or false, vv.floor or false
                        local spell = spells[v.id]
                        
                        if base and rate and floor and bpcore:isJAReady(JA[spell.en].recast_id) and bpcore:getAvailable("JA", spell.en) and (player.main_job == "DNC" or player.sub_job == "DNC") and player["vitals"].tp > spell.tp_cost then
                            local player = windower.ffxi.get_player()
                            local CHR    = system["Stats"].CHR                                
                                
                            if spell.en == "Curing Waltz" and (player.main_job_level >= 15 or player.sub_job_level >= 15) then
                                local estimate = ( mFloor((CHR+220)/4) + 60 )
                                
                                if estimate <= amount then
                                    cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                end
                                
                            elseif spell.en == "Curing Waltz II" and (player.main_job_level >= 30 or player.sub_job_level >= 30) then
                                local estimate = ( mFloor((CHR+220)/2) + 130 )
                                
                                if estimate <= amount then
                                    cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                end
                                
                            elseif spell.en == "Curing Waltz III" and (player.main_job_level >= 45 or player.sub_job_level >= 45) then
                                local estimate = ( mFloor((CHR+220)*0.75) + 270 )
                                
                                if estimate <= amount then
                                    cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                end
                                
                            elseif spell.en == "Curing Waltz IV" and player.main_job_level >= 70 then
                                local estimate = ( CHR + 220 + 450 )
                                
                                if estimate <= amount then
                                    cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                end
                                
                            elseif spell.en == "Curing Waltz V" and player.main_job_level >= 87 then
                                local estimate = ( mFloor((CHR+220)*1.25) + 600 )
                                
                                if estimate <= amount then
                                    cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                end
                                
                            end                            
                            
                        end
                        
                    end
                    
                end
                
            end
            
        end
        
        if cure then
            return cure
        end
        
    end
    
    self.estimateWaltzga = function(amount)
        local player = windower.ffxi.get_player()
        local amount = amount or 0
        local cure   = false
        
        if amount > 0 then
            local selected = nil
            local spells   = res.job_abilities:type("Waltz")
            
            for i,v in ipairs(cure_data[6]) do
                
                if type(v) == "table" then
                    
                    for _,vv in ipairs(v.powers) do
                        local base, rate, floor = (vv.power+(vv.power*multiplier)) or false, vv.rate or false, vv.floor or false
                        local spell = spells[v.id]
                        
                        if base and rate and floor and bpcore:isJAReady(JA[spell.en].recast_id) and bpcore:getAvailable("JA", spell.en) and (player.main_job == "DNC" or player.sub_job == "DNC") and player["vitals"].tp > spell.tp_cost then
                            local player = windower.ffxi.get_player()
                            local CHR    = system["Stats"].CHR                                
                                
                            if spell.en == "Divine Waltz" and (player.main_job_level >= 25 or player.sub_job_level >= 25) then
                                local estimate = ( mFloor((CHR+220)/4) + 60 )
                                
                                if estimate <= amount then
                                    cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                end
                                
                            elseif spell.en == "Divine Waltz II" and player.main_job_level >= 78 then
                                local estimate = ( mFloor((CHR+220)*0.75) + 270 )
                                
                                if estimate <= amount then
                                    cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}
                                end
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            end
            
        end
        return cure
        
    end
    
    self.estimateBlue = function(amount)
        local player = windower.ffxi.get_player()
        local amount = amount or 0
        local cure   = false
        
        if amount > 0 then
            local selected = nil
            local spells   = res.spells:type("BlueMagic")
            
            for i=12, 16 do
                
                if cure_data[i] then
                    
                    for base, data in pairs(cure_data[i]) do
                        
                        if type(data) == "table" then
                            local power = helpers["cures"].getCuragaPower()
                            local spell = spells[cure_data[i].id]

                            if base > power and bpcore:getAvailable("MA", spell.en) then
                                local estimate = ( mFloor((power/2)/data.rate)+data.floor )
                                
                                if estimate <= amount then
                                    cure = spell
                                end
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            end
            
        end
        return cure
        
    end
    
    self.estimateBluega = function(amount, count)
        local player = windower.ffxi.get_player()
        local amount = amount or 0
        local count  = count or 0
        local cure   = false
        
        if amount > 0 and count > 2 then
            local selected = nil
            local spells   = res.spells:type("BlueMagic")
                    
            for i,v in ipairs(cure_data[4]) do
                
                if type(v) == "table" then
                    
                    for _,vv in ipairs(v.powers) do
                        local base, rate, floor = (vv.power+(vv.power*multiplier)) or false, vv.rate or false, vv.floor or false
                        local power = helpers["cures"].getCuragaPower()
                        local spell = spells[v.id]
                        
                        if base and rate and floor and base <= power and bpcore:isMAReady(MA[spell.en].recast_id) and bpcore:getAvailable("MA", spell.en) and player.main_job == "WHM" and player["vitals"].mp > spell.mp_cost then
                            local estimate = ( mFloor((power/2)/rate)+floor )
                            
                            if ((estimate*count) <= amount) then
                                
                                if spell.en == "Healing Breeze" and (player.main_job_level >= 16 or player.sub_job_level >= 16) then
                                    cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}

                                elseif spell.en == "White Wind" and (player.main_job_level >= 94 or player.sub_job_level >= 94) then
                                    cure = {spell=spell, base=base, rate=rate, floor=floor, priority=v.priority}

                                end
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            end
            
        end
        
        if cure then
            return cure
        end
        
    end
    
    self.getCure = function(id)
        local id = id or false
        
        if id then
            
            for _,v in ipairs(cure_data) do
                
                if v.id == id then
                    return v
                end
                
            end
        
        end
        return false
        
    end
    
    self.getRate = function(id)
        local id = id or false
        
        if id then
            return helpers["cures"].getCure().rate
            
        end
        return false
        
    end
    
    self.getFloor = function(id)
        local id = id or false
        
        if id then
            return helpers["cures"].getCure().floor
            
        end
        return false
        
    end
    
    self.getBasePower = function(id)
        local id = id or false
        
        if id then
            
            for i,v in ipairs(cure_data) do
                
                if v.id == id then
                    return (i + (i * multiplier))
                end
                
            end
        
        end
        return false
        
    end
    
    self.getCurePower = function()
        local player = windower.ffxi.get_player()
        local MND    = system["Stats"].MND
        local VIT    = system["Stats"].VIT
        local skill  = player["skills"].healing_magic
        
        return ( (mFloor(MND/2))+(mFloor(VIT/2))+(skill) )
        
    end
    
    self.getCuragaPower = function()
        local player = windower.ffxi.get_player()
        local MND    = system["Stats"].MND
        local VIT    = system["Stats"].VIT
        local skill  = player["skills"].healing_magic
        
        return ( (3*MND)+VIT+(3*(mFloor(skill/5))) )
        
    end
    
    self.getWaltzPower = function()
        local player = windower.ffxi.get_player()
        local CHR    = system["Stats"].CHR
        local VIT    = 220 --Using flat rate here; this was the median between my WHM and my RUN.

        return ( mFloor((CHR+VIT)/4)+60 )
        
    end
    
    self.buildData = function()
        local temp    = windower.ffxi.get_party() or false
        local inside  = {}
        local outside = {}
        
        if temp then
            
            for i,v in pairs(temp) do
                
                if i:sub(1,1) == "p" and tonumber(i:sub(2)) ~= nil and type(v) == "table" then
                    local hp, hpp, max  = v.hp, v.hpp, mFloor(v.hp/((v.hpp)/100))
                    
                    if v.mob then
                        table.insert(inside, {id=v.mob.id, hp=hp, hpp=hpp, max=max, missing=(max-hp)})
                    end
                    
                elseif i:sub(1,1) == "a" and type(v) == "table" then
                    local hp, hpp, max  = v.hp, v.hpp, mFloor(v.hp/((v.hpp)/100))
                    
                    if v.mob then
                        table.insert(outside, {id=v.mob.id, hp=hp, hpp=hpp, max=max, missing=(max-hp)})
                    end
                    
                end
                
            end                
            
            party    = inside
            alliance = outside
            
        end
        
    end
    
    self.curesNeeded = function()
        local count = 0
        
        for _,v in ipairs(party) do

            if v.hpp < 95 and v.hpp ~= 0 then
                count = (count + 1)
            end
            
        end
        return count
        
    end     
    
    self.valid = function(id)
        local id = id or false
        
        if id then
            
            for _,v in ipairs(cure_data) do
                
                if type(v) == "table" then
                    
                    if v.id == id then
                        return true
                    end
                    
                end
                
            end
            
        end
        return false
        
    end
    
    self.validTarget = function(spellId, target)
        local spellId, target, player = spellId or false, target or false, windower.ffxi.get_player() or false
        
        if spellId and res.spells[spellId] and player then
            local spell = res.spells[spellId]
            
            if (spell.targets):contains("Self") and player.name == target.name then
                return windower.ffxi.get_mob_by_id(target.id)
            
            elseif (spell.targets):contains("Ally") and bpcore:isInParty(target, false) then
                return windower.ffxi.get_mob_by_id(target.id)
            
            elseif (spell.targets):contains("Party") and bpcore:isInParty(target, true) then
                return windower.ffxi.get_mob_by_id(target.id)
                
            elseif (spell.targets):contains("Self") and (spell.targets):contains("Party") and (spell.targets):contains("NPC") and (spell.targets):contains("Player") and (spell.targets):contains("Ally") and (spell.targets):contains("Enemy") then
                return windower.ffxi.get_mob_by_id(target.id)
                
            end
                
            
        elseif spellId and res.job_abilities[spellId] then
            local spell = res.job_abilities[spellId]
            
            if (spell.targets):contains("Self") and player.name == target.name then
                return windower.ffxi.get_mob_by_id(target.id)
            
            elseif (spell.targets):contains("Ally") and bpcore:isInParty(target, false) then
                return windower.ffxi.get_mob_by_id(target.id)
            
            elseif (spell.targets):contains("Party") and bpcore:isInParty(target, true) then
                return windower.ffxi.get_mob_by_id(target.id)
                
            elseif (spell.targets):contains("Self") and (spell.targets):contains("Party") and (spell.targets):contains("NPC") and (spell.targets):contains("Player") and (spell.targets):contains("Ally") and (spell.targets):contains("Enemy") then
                return windower.ffxi.get_mob_by_id(target.id)
                
            end
            
        end
        return false
        
    end
    
    self.setMultiplier = function(value)
        local value = value or 0
        
        if value and tonumber(value) ~= nil then
            multiplier = (value / 100)            
        end            
        
    end
    
    return self

end
return cures.new()