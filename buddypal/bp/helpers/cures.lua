--------------------------------------------------------------------------------
-- Cures helper: Library for handling how to determine curing for party.
--------------------------------------------------------------------------------
local cures = {}
function cures.new()
    self = {}
    
    -- Private Variables
    local power       = 1.0
    local majesty     = false
    local tiers       = {1,2,3,4,5,6}
    local cure_data   = dofile(string.format("%sbp/helpers/cures/cure_data.lua", windower.addon_path))
    local party       = {}
    local alliance    = {}
    local curaga      = {}
    
    self.handleParty = function()
        local party  = party
        local needed = helpers["cures"].curesNeeded()
        local player = windower.ffxi.get_player()
        
        
        if needed > 2 and (player.main_job == "WHM" or player.sub_job == "WHM") then
            
            for _,v in ipairs(party) do
                local spell  = helpers["cures"].estimateCuraga(v.missing) or false
                local target = windower.ffxi.get_mob_by_id(v.id) or false
                
                if spell and target and helpers["cures"].validTarget(spell.id, target) and bpcore:isInParty(target, true) then
                    
                    if spell.en == "Curaga" and player.main_job_level < 75 then
                        
                        if helpers["queue"].getQueued(MA["Curaga II"], target) then
                            helpers["queue"].remove(MA["Curaga II"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Curaga III"], target) then
                            helpers["queue"].remove(MA["Curaga III"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Curaga IV"], target) then
                            helpers["queue"].remove(MA["Curaga IV"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Curaga V"], target) then
                            helpers["queue"].remove(MA["Curaga V"], target)                        
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Curaga II" then
                        
                        if helpers["queue"].getQueued(MA["Curaga"], target) then
                            helpers["queue"].remove(MA["Curaga"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Curaga III"], target) then
                            helpers["queue"].remove(MA["Curaga III"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Curaga IV"], target) then
                            helpers["queue"].remove(MA["Curaga IV"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Curaga V"], target) then
                            helpers["queue"].remove(MA["Curaga V"], target)                        
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Curaga III" then
                        
                        if helpers["queue"].getQueued(MA["Curaga"], target) then
                            helpers["queue"].remove(MA["Curaga"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Curaga II"], target) then
                            helpers["queue"].remove(MA["Curaga II"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Curaga IV"], target) then
                            helpers["queue"].remove(MA["Curaga IV"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Curaga V"], target) then
                            helpers["queue"].remove(MA["Curaga V"], target)                        
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Curaga IV" then
                        
                        if helpers["queue"].getQueued(MA["Curaga"], target) then
                            helpers["queue"].remove(MA["Curaga"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Curaga II"], target) then
                            helpers["queue"].remove(MA["Curaga II"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Curaga III"], target) then
                            helpers["queue"].remove(MA["Curaga III"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Curaga V"], target) then
                            helpers["queue"].remove(MA["Curaga V"], target)                        
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Curaga V" then
                        
                        if helpers["queue"].getQueued(MA["Curaga"], target) then
                            helpers["queue"].remove(MA["Curaga"], target)
                        end    
                        
                        if helpers["queue"].getQueued(MA["Curaga II"], target) then
                            helpers["queue"].remove(MA["Curaga II"], target)
                        end    
                        
                        if helpers["queue"].getQueued(MA["Curaga III"], target) then
                            helpers["queue"].remove(MA["Curaga III"], target)
                        end    
                        
                        if helpers["queue"].getQueued(MA["Curaga IV"], target) then
                            helpers["queue"].remove(MA["Curaga IV"], target)
                        end
                        helpers["queue"].addToFront(MA[spell.en], target)
                        
                    end
                    
                end
                
            end
            
        elseif needed < 3 and (player.main_job == "WHM" or player.main_job == "RDM" or player.sub_job == "WHM") then
            
            for _,v in ipairs(party) do
                local spell  = helpers["cures"].estimateCure(v.missing) or false
                local target = windower.ffxi.get_mob_by_id(v.id) or false
                
                if spell and target and helpers["cures"].validTarget(spell.id, target) and bpcore:isInParty(target, true) then
                
                    if spell.en == "Cure" and player.main_job_level < 75 then
                        
                        if helpers["queue"].getQueued(MA["Cure II"], target) then
                            helpers["queue"].remove(MA["Cure II"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure III"], target) then
                            helpers["queue"].remove(MA["Cure III"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure IV"], target) then
                            helpers["queue"].remove(MA["Cure IV"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure V"], target) then
                            helpers["queue"].remove(MA["Cure V"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure VI"], target) then
                            helpers["queue"].remove(MA["Cure VI"], target)                        
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Cure II" and player.main_job_level < 75 then
                        
                        if helpers["queue"].getQueued(MA["Cure"], target) then
                            helpers["queue"].remove(MA["Cure"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure III"], target) then
                            helpers["queue"].remove(MA["Cure III"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure IV"], target) then
                            helpers["queue"].remove(MA["Cure IV"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure V"], target) then
                            helpers["queue"].remove(MA["Cure V"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure VI"], target) then
                            helpers["queue"].remove(MA["Cure VI"], target)                        
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Cure III" then
                        
                        if helpers["queue"].getQueued(MA["Cure"], target) then
                            helpers["queue"].remove(MA["Cure"], target)
                        end
                            
                        if helpers["queue"].getQueued(MA["Cure II"], target) then
                            helpers["queue"].remove(MA["Cure II"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure IV"], target) then
                            helpers["queue"].remove(MA["Cure IV"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure V"], target) then
                            helpers["queue"].remove(MA["Cure V"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure VI"], target) then
                            helpers["queue"].remove(MA["Cure VI"], target)                        
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Cure IV" then
                        
                        if helpers["queue"].getQueued(MA["Cure"], target) then
                            helpers["queue"].remove(MA["Cure"], target)
                        end
                            
                        if helpers["queue"].getQueued(MA["Cure II"], target) then
                            helpers["queue"].remove(MA["Cure II"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure III"], target) then
                            helpers["queue"].remove(MA["Cure III"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure V"], target) then
                            helpers["queue"].remove(MA["Cure V"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure VI"], target) then
                            helpers["queue"].remove(MA["Cure VI"], target)
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Cure V" then
                        
                        if helpers["queue"].getQueued(MA["Cure"], target) then
                            helpers["queue"].remove(MA["Cure"], target)
                        end    
                        
                        if helpers["queue"].getQueued(MA["Cure II"], target) then
                            helpers["queue"].remove(MA["Cure II"], target)
                        end    
                        
                        if helpers["queue"].getQueued(MA["Cure III"], target) then
                            helpers["queue"].remove(MA["Cure III"], target)
                        end    
                        
                        if helpers["queue"].getQueued(MA["Cure IV"], target) then
                            helpers["queue"].remove(MA["Cure IV"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure VI"], target) then
                            helpers["queue"].remove(MA["Cure VI"], target)
                        end
                        helpers["queue"].addToFront(MA[spell.en], target)
                        
                    elseif spell.en == "Cure VI" then
                        
                        if helpers["queue"].getQueued(MA["Cure"], target) then
                            helpers["queue"].remove(MA["Cure"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure II"], target) then
                            helpers["queue"].remove(MA["Cure II"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure III"], target) then
                            helpers["queue"].remove(MA["Cure III"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure IV"], target) then
                            helpers["queue"].remove(MA["Cure IV"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure V"], target) then
                            helpers["queue"].remove(MA["Cure V"], target)
                        end
                        helpers["queue"].addToFront(MA[spell.en], target)
                        
                    end
                    
                end
                
            end
            
        elseif needed < 3 and (player.main_job == "DNC" or player.sub_job == "DNC") then
            
            for _,v in ipairs(party) do
                local spell  = helpers["cures"].estimateWaltz(v.missing) or false
                local target = windower.ffxi.get_mob_by_id(v.id) or false
                
                if spell and target and helpers["cures"].validTarget(spell.id, target) and bpcore:isInParty(target, true) then
                    
                    if spell.en == "Curing Waltz" and player.main_job_level < 75 then
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Curing Waltz II" and player.main_job_level < 75 then
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz"], target) then
                            helpers["queue"].remove(JA["Curing Waltz"], target)                        
                        end
                        helpers["queue"].add(JA[spell.en], target)
                        
                    elseif spell.en == "Curing Waltz III" then
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz"], target) then
                            helpers["queue"].remove(JA["Curing Waltz"], target)
                        end
                            
                        if helpers["queue"].getQueued(JA["Curing Waltz II"], target) then
                            helpers["queue"].remove(JA["Curing Waltz II"], target)                        
                        end
                        helpers["queue"].add(JA[spell.en], target)
                        
                    elseif spell.en == "Curing Waltz IV" then
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz"], target) then
                            helpers["queue"].remove(JA["Curing Waltz"], target)
                        end
                            
                        if helpers["queue"].getQueued(JA["Curing Waltz II"], target) then
                            helpers["queue"].remove(JA["Curing Waltz II"], target)
                        end
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz III"], target) then
                            helpers["queue"].remove(JA["Curing Waltz"], target)
                        end
                        helpers["queue"].addToFront(JA[spell.en], target)
                        
                    elseif spell.en == "Curing Waltz V" then
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz"], target) then
                            helpers["queue"].remove(JA["Curing Waltz"], target)
                        end    
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz II"], target) then
                            helpers["queue"].remove(JA["Curing Waltz II"], target)
                        end    
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz III"], target) then
                            helpers["queue"].remove(JA["Curing Waltz III"], target)
                        end    
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz IV"], target) then
                            helpers["queue"].remove(JA["Curing Waltz IV"], target)
                        end
                        helpers["queue"].addToFront(JA[spell.en], target)
                        
                    end
                    
                end
                
            end
        
        elseif needed > 2 and (player.main_job == "DNC" or player.sub_job == "DNC") then
            
            for _,v in ipairs(party) do
                local spell  = helpers["cures"].estimateWaltzga(v.missing) or false
                local target = windower.ffxi.get_mob_by_id(v.id) or false
                
                if spell and target and helpers["cures"].validTarget(spell.id, target) and bpcore:isInParty(target, true) then
                    
                    if spell.en == "Divine Waltz" and player.main_job_level < 75 then
                        helpers["queue"].add(JA[spell.en], target)
                        
                    elseif spell.en == "Divine Waltz II" and player.main_job < 75 then
                        
                        if helpers["queue"].getQueued(JA["Divine Waltz"], target) then
                            helpers["queue"].remove(JA["Divine Waltz"], target)                        
                        end
                        helpers["queue"].add(JA[spell.en], target)
                        
                    end
                    
                end
                
            end
        
        elseif needed < 3 and player.main_job == "BLU" then
            
            for _,v in ipairs(party) do
                local spell  = helpers["cures"].estimateBlue(v.missing) or false
                local target = windower.ffxi.get_mob_by_id(v.id) or false
                
                if spell and target and helpers["cures"].validTarget(spell.id, target) and bpcore:isInParty(target, true) then
                    
                    if (spell.en == "Pollen" or spell.en == "Exuviation") and player.main_job < 75 and player.name == target.name then
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en ~= "Pollen" then
                        helpers["queue"].add(MA[spell.en], target)
                        
                    end
                    
                end
                
            end
            
        elseif needed > 2 and player.main_job == "BLU" then
            
            for _,v in ipairs(party) do
                local spell  = helpers["cures"].estimateBluega(v.missing) or false
                local target = windower.ffxi.get_mob_by_id(v.id) or false
                
                if spell and target and helpers["cures"].validTarget(spell.id, target) and bpcore:isInParty(target, true) then
                    
                    if player.name == target.name then
                        helpers["queue"].add(MA[spell.en], target)                        
                    end
                    
                end
                
            end
        
        end
        
    end
    
    self.handleAlliance = function()
        local alliance = alliance
        local needed   = helpers["cures"].curesNeeded()
        local player   = windower.ffxi.get_player() or false
        
        if player and needed > 2 and (player.main_job == "WHM" or player.sub_job == "WHM") then
            
            for _,v in ipairs(alliance) do
                local spell  = helpers["cures"].estimateCuraga(v.missing)
                local target = windower.ffxi.get_mob_by_id(v.id)
                
                if spell and target and helpers["cures"].validTarget(spell.id, target) and bpcore:isInParty(target, true) then
                    
                    if spell.en == "Curaga" and player.main_job < 75 then
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Curaga II" then
                        
                        if helpers["queue"].getQueued(MA["Curaga"], target) then
                            helpers["queue"].remove(MA["Curaga"], target)                        
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Curaga III" then
                        
                        if helpers["queue"].getQueued(MA["Curaga"], target) then
                            helpers["queue"].remove(MA["Curaga"], target)
                        end
                            
                        if helpers["queue"].getQueued(MA["Curaga II"], target) then
                            helpers["queue"].remove(MA["Curaga II"], target)                        
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Curaga IV" then
                        
                        if helpers["queue"].getQueued(MA["Curaga"], target) then
                            helpers["queue"].remove(MA["Curaga"], target)
                        end
                            
                        if helpers["queue"].getQueued(MA["Curaga II"], target) then
                            helpers["queue"].remove(MA["Curaga II"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Curaga III"], target) then
                            helpers["queue"].remove(MA["Curaga"], target)
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Curaga V" then
                        
                        if helpers["queue"].getQueued(MA["Curaga"], target) then
                            helpers["queue"].remove(MA["Curaga"], target)
                        end    
                        
                        if helpers["queue"].getQueued(MA["Curaga II"], target) then
                            helpers["queue"].remove(MA["Curaga II"], target)
                        end    
                        
                        if helpers["queue"].getQueued(MA["Curaga III"], target) then
                            helpers["queue"].remove(MA["Curaga III"], target)
                        end    
                        
                        if helpers["queue"].getQueued(MA["Curaga IV"], target) then
                            helpers["queue"].remove(MA["Curaga IV"], target)
                        end
                        helpers["queue"].addToFront(MA[spell.en], target)
                        
                    end
                    
                end
                
            end
        
        elseif needed < 3 and (player.main_job == "WHM" or player.main_job == "RDM" or player.sub_job == "WHM") then
            
            for _,v in ipairs(alliance) do
                local spell  = helpers["cures"].estimateCure(v.missing)
                local target = windower.ffxi.get_mob_by_id(v.id)
                
                if spell and target and helpers["cures"].validTarget(spell.id, target) and bpcore:isInParty(target, false) then
                    
                    if spell.en == "Cure" and player.main_job_level < 75 then
                        
                        if helpers["queue"].getQueued(MA["Cure II"], target) then
                            helpers["queue"].remove(MA["Cure II"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure III"], target) then
                            helpers["queue"].remove(MA["Cure III"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure IV"], target) then
                            helpers["queue"].remove(MA["Cure IV"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure V"], target) then
                            helpers["queue"].remove(MA["Cure V"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure VI"], target) then
                            helpers["queue"].remove(MA["Cure VI"], target)                        
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Cure II" and player.main_job_level < 75 then
                        
                        if helpers["queue"].getQueued(MA["Cure"], target) then
                            helpers["queue"].remove(MA["Cure"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure III"], target) then
                            helpers["queue"].remove(MA["Cure III"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure IV"], target) then
                            helpers["queue"].remove(MA["Cure IV"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure V"], target) then
                            helpers["queue"].remove(MA["Cure V"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure VI"], target) then
                            helpers["queue"].remove(MA["Cure VI"], target)                        
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Cure III" then
                        
                        if helpers["queue"].getQueued(MA["Cure"], target) then
                            helpers["queue"].remove(MA["Cure"], target)
                        end
                            
                        if helpers["queue"].getQueued(MA["Cure II"], target) then
                            helpers["queue"].remove(MA["Cure II"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure IV"], target) then
                            helpers["queue"].remove(MA["Cure IV"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure V"], target) then
                            helpers["queue"].remove(MA["Cure V"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure VI"], target) then
                            helpers["queue"].remove(MA["Cure VI"], target)                        
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Cure IV" then
                        
                        if helpers["queue"].getQueued(MA["Cure"], target) then
                            helpers["queue"].remove(MA["Cure"], target)
                        end
                            
                        if helpers["queue"].getQueued(MA["Cure II"], target) then
                            helpers["queue"].remove(MA["Cure II"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure III"], target) then
                            helpers["queue"].remove(MA["Cure III"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure V"], target) then
                            helpers["queue"].remove(MA["Cure V"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure VI"], target) then
                            helpers["queue"].remove(MA["Cure VI"], target)
                        end
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Cure V" then
                        
                        if helpers["queue"].getQueued(MA["Cure"], target) then
                            helpers["queue"].remove(MA["Cure"], target)
                        end    
                        
                        if helpers["queue"].getQueued(MA["Cure II"], target) then
                            helpers["queue"].remove(MA["Cure II"], target)
                        end    
                        
                        if helpers["queue"].getQueued(MA["Cure III"], target) then
                            helpers["queue"].remove(MA["Cure III"], target)
                        end    
                        
                        if helpers["queue"].getQueued(MA["Cure IV"], target) then
                            helpers["queue"].remove(MA["Cure IV"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure VI"], target) then
                            helpers["queue"].remove(MA["Cure VI"], target)
                        end
                        helpers["queue"].addToFront(MA[spell.en], target)
                        
                    elseif spell.en == "Cure VI" then
                        
                        if helpers["queue"].getQueued(MA["Cure"], target) then
                            helpers["queue"].remove(MA["Cure"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure II"], target) then
                            helpers["queue"].remove(MA["Cure II"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure III"], target) then
                            helpers["queue"].remove(MA["Cure III"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure IV"], target) then
                            helpers["queue"].remove(MA["Cure IV"], target)
                        end
                        
                        if helpers["queue"].getQueued(MA["Cure V"], target) then
                            helpers["queue"].remove(MA["Cure V"], target)
                        end
                        helpers["queue"].addToFront(MA[spell.en], target)
                        
                    end
                    
                end
                
            end
            
        elseif needed < 3 and (player.main_job == "DNC" or player.sub_job == "DNC") then
            
            for _,v in ipairs(alliance) do
                local spell  = helpers["cures"].estimateWaltz(v.missing)
                local target = windower.ffxi.get_mob_by_id(v.id)
                
                if spell and target and helpers["cures"].validTarget(spell.id, target) and bpcore:isInParty(target, true) then
                    
                    if spell.en == "Curing Waltz" and player.main_job < 75 then
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz II"], target) then
                            helpers["queue"].remove(JA["Curing Waltz II"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz III"], target) then
                            helpers["queue"].remove(JA["Curing Waltz III"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz IV"], target) then
                            helpers["queue"].remove(JA["Curing Waltz IV"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz V"], target) then
                            helpers["queue"].remove(JA["Curing Waltz V"], target)                        
                        end                        
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en == "Curing Waltz II" and player.main_job < 75 then
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz"], target) then
                            helpers["queue"].remove(JA["Curing Waltz"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz III"], target) then
                            helpers["queue"].remove(JA["Curing Waltz III"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz IV"], target) then
                            helpers["queue"].remove(JA["Curing Waltz IV"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz V"], target) then
                            helpers["queue"].remove(JA["Curing Waltz V"], target)                        
                        end
                        helpers["queue"].add(JA[spell.en], target)
                        
                    elseif spell.en == "Curing Waltz III" then
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz"], target) then
                            helpers["queue"].remove(JA["Curing Waltz"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz II"], target) then
                            helpers["queue"].remove(JA["Curing Waltz II"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz IV"], target) then
                            helpers["queue"].remove(JA["Curing Waltz IV"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz V"], target) then
                            helpers["queue"].remove(JA["Curing Waltz V"], target)                        
                        end
                        helpers["queue"].add(JA[spell.en], target)
                        
                    elseif spell.en == "Curing Waltz IV" then
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz"], target) then
                            helpers["queue"].remove(JA["Curing Waltz"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz II"], target) then
                            helpers["queue"].remove(JA["Curing Waltz II"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz III"], target) then
                            helpers["queue"].remove(JA["Curing Waltz III"], target)                        
                        end
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz V"], target) then
                            helpers["queue"].remove(JA["Curing Waltz V"], target)                        
                        end
                        helpers["queue"].addToFront(JA[spell.en], target)
                        
                    elseif spell.en == "Curing Waltz V" then
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz"], target) then
                            helpers["queue"].remove(JA["Curing Waltz"], target)
                        end    
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz II"], target) then
                            helpers["queue"].remove(JA["Curing Waltz II"], target)
                        end    
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz III"], target) then
                            helpers["queue"].remove(JA["Curing Waltz III"], target)
                        end    
                        
                        if helpers["queue"].getQueued(JA["Curing Waltz IV"], target) then
                            helpers["queue"].remove(JA["Curing Waltz IV"], target)
                        end
                        helpers["queue"].addToFront(JA[spell.en], target)
                        
                    end
                    
                end
                
            end
        
        elseif needed > 2 and (player.main_job == "DNC" or player.sub_job == "DNC") then
            
            for _,v in ipairs(alliance) do
                local spell  = helpers["cures"].estimateWaltzga(v.missing)
                local target = windower.ffxi.get_mob_by_id(v.id)
                
                if spell and target and helpers["cures"].validTarget(spell.id, target) and bpcore:isInParty(target, true) then
                    
                    if spell.en == "Divine Waltz" and player.main_job < 75 then
                        
                        if helpers["queue"].getQueued(JA["Divine Waltz II"], target) then
                            helpers["queue"].remove(JA["Divine Waltz II"], target)                        
                        end
                        helpers["queue"].add(JA[spell.en], target)
                        
                    elseif spell.en == "Divine Waltz II" and player.main_job < 75 then
                        
                        if helpers["queue"].getQueued(JA["Divine Waltz"], target) then
                            helpers["queue"].remove(JA["Divine Waltz"], target)                        
                        end
                        helpers["queue"].add(JA[spell.en], target)
                        
                    end
                    
                end
                
            end
        
        elseif needed < 3 and player.main_job == "BLU" then
            
            for _,v in ipairs(party) do
                local spell  = helpers["cures"].estimateBlue(v.missing)
                local target = windower.ffxi.get_mob_by_id(v.id)
                
                if spell and target and helpers["cures"].validTarget(spell.id, target) and bpcore:isInParty(target, true) then
                    
                    if (spell.en == "Pollen" or spell.en == "Exuviation") and player.main_job < 75 and player.name == target.name then
                        helpers["queue"].add(MA[spell.en], target)
                        
                    elseif spell.en ~= "Pollen" then
                        helpers["queue"].add(MA[spell.en], target)
                        
                    end
                    
                end
                
            end
            
        elseif needed > 2 and player.main_job == "BLU" then
            
            for _,v in ipairs(party) do
                local spell  = helpers["cures"].estimateBluega(v.missing)
                local target = windower.ffxi.get_mob_by_id(v.id)
                
                if spell and target and helpers["cures"].validTarget(spell.id, target) and bpcore:isInParty(target, true) then
                    
                    if player.name == target.name then
                        helpers["queue"].add(MA[spell.en], target)                        
                    end
                    
                end
                
            end
        
        end
        
    end
    
    self.estimateCure = function(amount)
        local player = windower.ffxi.get_player()
        local amount = amount or 0
        local cure   = false
        
        if amount > 0 then
            local selected = nil
            
            for i=1, 6 do
                
                if cure_data[i] then
                    
                    for base, data in pairs(cure_data[i]) do
                        
                        if type(data) == "table" then
                            local power = helpers["cures"].getCurePower()
                            local spell = res.spells[cure_data[i].id]
                            
                            if base > power and bpcore:getAvailable("MA", spell.en) then
                                local estimate = ( math.floor((power-base)/data.rate)+data.floor )
                                
                                if estimate <= amount then
                                    cure = res.spells[cure_data[i].id]
                                end
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            end
            
        end
        return cure
        
    end
    
    self.estimateCuraga = function(amount)
        local player = windower.ffxi.get_player()
        local amount = amount or 0
        local cure   = false
        
        if amount > 0 then
            local selected = nil
            
            for i=7, 11 do
                
                if cure_data[i] then
                    
                    for base, data in pairs(cure_data[i]) do
                        
                        if type(data) == "table" then
                            local power = helpers["cures"].getCuragaPower()
                            local spell = res.spells[cure_data[i].id]

                            if base > power and bpcore:getAvailable("MA", spell.en) then
                                local estimate = ( math.floor((power/2)/data.rate)+data.floor )
                                
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
    
    self.estimateWaltz = function(amount)
        local player = windower.ffxi.get_player()
        local amount = amount or 0
        local cure   = false
        
        if amount > 0 then
            local selected = nil
            
            for i=19, 23 do
                
                if cure_data[i] then
                    
                    for base, data in pairs(cure_data[i]) do
                        
                        if type(data) == "table" then
                            local power = helpers["cures"].getCuragaPower()
                            local spell = res.spells[cure_data[i].id]

                            if base > power and bpcore:getAvailable("JA", spell.en) then
                                local estimate = ( math.floor((power/2)/data.rate)+data.floor )
                                
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
    
    self.estimateWaltzga = function(amount)
        local player = windower.ffxi.get_player()
        local amount = amount or 0
        local cure   = false
        
        if amount > 0 then
            local selected = nil
            
            for i=24, 25 do
                
                if cure_data[i] then
                    
                    for base, data in pairs(cure_data[i]) do
                        
                        if type(data) == "table" then
                            local power = helpers["cures"].getCuragaPower()
                            local spell = res.spells[cure_data[i].id]

                            if base > power and bpcore:getAvailable("JA", spell.en) then
                                local estimate = ( math.floor((power/2)/data.rate)+data.floor )
                                
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
    
    self.estimateBlue = function(amount)
        local player = windower.ffxi.get_player()
        local amount = amount or 0
        local cure   = false
        
        if amount > 0 then
            local selected = nil
            
            for i=12, 16 do
                
                if cure_data[i] then
                    
                    for base, data in pairs(cure_data[i]) do
                        
                        if type(data) == "table" then
                            local power = helpers["cures"].getCuragaPower()
                            local spell = res.spells[cure_data[i].id]

                            if base > power and bpcore:getAvailable("MA", spell.en) then
                                local estimate = ( math.floor((power/2)/data.rate)+data.floor )
                                
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
    
    self.estimateBluega = function(amount)
        local player = windower.ffxi.get_player()
        local amount = amount or 0
        local cure   = false
        
        if amount > 0 then
            local selected = nil
            
            for i=17, 18 do
                
                if cure_data[i] then
                    
                    for base, data in pairs(cure_data[i]) do
                        
                        if type(data) == "table" then
                            local power = helpers["cures"].getCuragaPower()
                            local spell = res.spells[cure_data[i].id]

                            if base > power and bpcore:getAvailable("JA", spell.en) then
                                local estimate = ( math.floor((power/2)/data.rate)+data.floor )
                                
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
                    return i
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
        
        return ( (math.floor(MND/2))+(math.floor(VIT/2))+(skill) )
        
    end
    
    self.getCuragaPower = function()
        local player = windower.ffxi.get_player()
        local MND    = system["Stats"].MND
        local VIT    = system["Stats"].VIT
        local skill  = player["skills"].healing_magic
        
        return ( (3*MND)+VIT+(3*(math.floor(skill/5))) )
        
    end
    
    self.getWaltzPower = function()
        local player = windower.ffxi.get_player()
        local CHR    = system["Stats"].CHR
        local VIT    = 220 --Using flat rate here; this was the median between my WHM and my RUN.

        return ( math.floor((CHR+VIT)/4)+60 )
        
    end
    
    self.buildData = function()
        local temp    = windower.ffxi.get_party() or false
        local inside  = {}
        local outside = {}
        
        if temp then
            
            for i,v in pairs(temp) do
                
                if i:sub(1,1) == "p" and tonumber(i:sub(2)) ~= nil and type(v) == "table" then
                    local hp, hpp, max  = v.hp, v.hpp, math.floor(v.hp/((v.hpp)/100))
                    
                    if v.mob then
                        table.insert(inside, {id=v.mob.id, hp=hp, hpp=hpp, max=max, missing=(max-hp)})
                    end
                    
                elseif i:sub(1,1) == "a" and type(v) == "table" then
                    local hp, hpp, max  = v.hp, v.hpp, math.floor(v.hp/((v.hpp)/100))
                    
                    if v.mob then
                        table.insert(outside, {id=v.mob.id, hp=hp, hpp=hpp, max=max, missing=(max-hp)})
                    end
                    
                end
                
            end                
            
            party    = inside
            alliance = outside
            
        end
        
    end
    
    self.curagaData = function()
        local needed  = helpers["cures"].curesNeeded()
        local data    = {hp=0, max=0, percent=0, power=0}
        
        if needed > 3 then
            
            for _,v in ipairs(party) do
                data.hp  = (data.hp + v.hp)
                data.max = (data.max + v.max)
            
            end
            data.percent = math.floor((data.hp/data.max)*100)
            data.power   = math.floor((data.max-data.hp)/needed)
            curaga       = data
            return true
            
        end
        return false
        
    end
    
    self.curesNeeded = function()
        local count = 0
        
        for _,v in ipairs(party) do

            if v.hpp < 80 and v.hpp ~= 0 then
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
    
    return self

end
return cures.new()