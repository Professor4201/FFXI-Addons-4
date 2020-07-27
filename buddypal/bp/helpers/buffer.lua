--------------------------------------------------------------------------------
-- Buffer Helper: Library of functions to handle repeat buffing on a player.
--------------------------------------------------------------------------------
local Buffer = {}
function Buffer.new()
    local self = {}
    
    -- Private Variables.
    local buffs = {}
    local default_delay = 120
    
    self.add = function(player, spell, delay, alliance)
        local player, spell, delay, alliance = player or false, spell or false, delay or default_delay, alliance or false
        
        if player and spell and delay and type(player) == "table" and type(spell) == "table" and tonumber(delay) ~= nil and helpers["party"].isInParty(player, alliance) then
            
            if buffs[player.id] then
                local exists = false
                
                for _,buff in ipairs(buffs[player.id]) do
                    
                    if spell.id == buff.spell.id then
                        helpers["buffer"].remove(player, spell)
                        exists = true
                        break
                    
                    end
                
                end
                
                if not exists then
                    table.insert(buffs[player.id], {player=player, spell=spell, timer=0, delay=delay})
                end
                
            elseif not buffs[player.id] then
                local exists = false
                buffs[player.id] = {}
                
                for _,buff in ipairs(buffs[player.id]) do
                    
                    if spell.id == buff.spell.id then
                        helpers["buffer"].remove(player, spell)
                        exists = true
                        break
                    
                    end
                
                end
                
                if not exists then
                    table.insert(buffs[player.id], {player=player, spell=spell, timer=0, delay=delay})
                end
                
            end
            
        end
        
    end
    
    self.remove = function(player, spell)
        local player, spell = player or false, spell or false
        
        if player and spell and type(player) == "table" and type(spell) == "table" then
            
            for i,v in ipairs(buffs[player.id]) do
                
                if spell.id == v.spell.id then
                    table.remove(buffs[player.id], i)
                    break
                end
                
            end
            
        end
        
    end
    
    self.handleBuffs = function()

        for _,player in pairs(buffs) do
            
            if player and type(player) == "table" then
                
                for i,buff in ipairs(player) do

                    if (os.clock()-buff.timer) > buff.delay then
                        helpers["queue"].add(buff.spell, buff.player)
                        buffs[buff.player.id][i].timer = os.clock()
                        break
                        
                    end
                
                end
            
            end
        
        end
    
    end
    
    self.commands = function(target, spell, delay)
        local player = windower.ffxi.get_player() or false
        local target = target or false
        local spell  = spell or false
        local delay  = delay
        
        if player and target and spell then
            
            if player.main_job == "WAR" then
                
            elseif player.main_job == "MNK" then
                
            elseif player.main_job == "WHM" then
                    
                if spell == "haste" then
                    helpers["buffer"].add(target, MA["Haste"], delay, true)
                    
                elseif spell == "regen4" then
                    helpers["buffer"].add(target, MA["Regen IV"], delay, true)
                    
                end
                
            elseif player.main_job == "BLM" then
                
            elseif player.main_job == "RDM" then
                
                if spell == "haste" then
                    helpers["buffer"].add(target, MA["Haste"], delay, true)
                    
                elseif spell == "haste2" then
                    helpers["buffer"].add(target, MA["Haste II"], delay, true)
                    
                elseif spell == "refresh" then
                    helpers["buffer"].add(target, MA["Refresh"], delay, true)
                    
                elseif spell == "refresh2" then
                    helpers["buffer"].add(target, MA["Refresh II"], delay, true)
                    
                elseif spell == "refresh3" then
                    helpers["buffer"].add(target, MA["Refresh III"], delay, true)
                    
                elseif spell == "flurry" then
                    helpers["buffer"].add(target, MA["Flurry"], delay, true)
                    
                elseif spell == "flurry2" then
                    helpers["buffer"].add(target, MA["Flurry II"], delay, true)
                    
                end
                
            elseif player.main_job == "THF" then
                
            elseif player.main_job == "PLD" then
                
            elseif player.main_job == "DRK" then
                
            elseif player.main_job == "BST" then
                
            elseif player.main_job == "BRD" then
                
            elseif player.main_job == "RNG" then
                
            elseif player.main_job == "SMN" then
                
            elseif player.main_job == "SAM" then
                
            elseif player.main_job == "NIN" then
                
            elseif player.main_job == "DRG" then
            
            elseif player.main_job == "BLU" then
                
            elseif player.main_job == "COR" then
                
            elseif player.main_job == "PUP" then
            
            elseif player.main_job == "DNC" then
                
            elseif player.main_job == "SCH" then
                
                if spell == "vstorm" then
                    helpers["buffer"].add(target, MA["Voidstorm"], delay, true)
                    
                elseif spell == "astorm" then
                    helpers["buffer"].add(target, MA["Aurorastorm"], delay, true)
                    
                elseif spell == "fstorm" then
                    helpers["buffer"].add(target, MA["Firestorm"], delay, true)
                    
                elseif spell == "rstorm" then
                    helpers["buffer"].add(target, MA["Rainstorm"], delay, true)
                    
                elseif spell == "tstorm" then
                    helpers["buffer"].add(target, MA["Thunderstorm"], delay, true)
                   
                elseif spell == "sstorm" then
                    helpers["buffer"].add(target, MA["Sandstorm"], delay, true)
                    
                elseif spell == "wstorm" then
                    helpers["buffer"].add(target, MA["Windstorm"], delay, true)
                    
                elseif spell == "hstorm" then
                    helpers["buffer"].add(target, MA["Hailstorm"], delay, true)
                
                elseif spell == "vstorm2" then
                    helpers["buffer"].add(target, MA["Voidstorm II"], delay, true)
                    
                elseif spell == "astorm2" then
                    helpers["buffer"].add(target, MA["Aurorastorm II"], delay, true)
                    
                elseif spell == "fstorm2" then
                    helpers["buffer"].add(target, MA["Firestorm II"], delay, true)
                    
                elseif spell == "rstorm2" then
                    helpers["buffer"].add(target, MA["Rainstorm II"], delay, true)
                    
                elseif spell == "tstorm2" then
                    helpers["buffer"].add(target, MA["Thunderstorm II"], delay, true)
                   
                elseif spell == "sstorm2" then
                    helpers["buffer"].add(target, MA["Sandstorm II"], delay, true)
                    
                elseif spell == "wstorm2" then
                    helpers["buffer"].add(target, MA["Windstorm II"], delay, true)
                    
                elseif spell == "hstorm2" then
                    helpers["buffer"].add(target, MA["Hailstorm II"], delay, true)
                    
                elseif spell == "regen5" then
                    helpers["buffer"].add(target, MA["Regen V"], delay, true)
                
                end
                
            elseif player.main_job == "GEO" then
                
            elseif player.main_job == "RUN" then
                
            end
            
            if player.sub_job == "WAR" then
                
            elseif player.sub_job == "MNK" then
                
            elseif player.sub_job == "WHM" then
                
                if spell == "haste" then
                    helpers["buffer"].add(target, MA["Haste"], delay, true)
                end
                
            elseif player.sub_job == "BLM" then
                
            elseif player.sub_job == "RDM" then
                
            elseif player.sub_job == "THF" then
                
            elseif player.sub_job == "PLD" then
                
            elseif player.sub_job == "DRK" then
                
            elseif player.sub_job == "BST" then
                
            elseif player.sub_job == "BRD" then
                
            elseif player.sub_job == "RNG" then
                
            elseif player.sub_job == "SMN" then
                
            elseif player.sub_job == "SAM" then
                
            elseif player.sub_job == "NIN" then
                
            elseif player.sub_job == "DRG" then
            
            elseif player.sub_job == "BLU" then
                
            elseif player.sub_job == "COR" then
                
            elseif player.sub_job == "PUP" then
            
            elseif player.sub_job == "DNC" then
                
            elseif player.sub_job == "SCH" then
                
                if spell == "vstorm" then
                    helpers["buffer"].add(target, MA["Voidstorm"], delay, true)
                    
                elseif spell == "astorm" then
                    helpers["buffer"].add(target, MA["Aurorastorm"], delay, true)
                    
                elseif spell == "fstorm" then
                    helpers["buffer"].add(target, MA["Firestorm"], delay, true)
                    
                elseif spell == "rstorm" then
                    helpers["buffer"].add(target, MA["Rainstorm"], delay, true)
                    
                elseif spell == "tstorm" then
                    helpers["buffer"].add(target, MA["Thunderstorm"], delay, true)
                   
                elseif spell == "sstorm" then
                    helpers["buffer"].add(target, MA["Sandstorm"], delay, true)
                    
                elseif spell == "wstorm" then
                    helpers["buffer"].add(target, MA["Windstorm"], delay, true)
                    
                elseif spell == "hstorm" then
                    helpers["buffer"].add(target, MA["Hailstorm"], delay, true)
                
                end
                
            elseif player.sub_job == "GEO" then
                
            elseif player.sub_job == "RUN" then
                
            end
            
        end
        
    end
    
    return self

end
return Buffer.new()