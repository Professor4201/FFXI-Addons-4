--------------------------------------------------------------------------------
-- Chatcommands helper: Handles party chat commands.
--------------------------------------------------------------------------------
local chatcommands = {}
function chatcommands.new()
    self = {}
    
    -- Private Variables.
    local controllers = system["Controllers"]
        
    self.common = function(message, sender)
        local message     = message or false
        local sender      = sender or false
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local player  = windower.ffxi.get_player()
            local count   = #message:split(" ")
            local message = message:split(" ")
            
            -- Only one command was detected.
            if count == 1 and message[1] then
                local command = message[1]:lower()
                
                if command == "warpout" then
                    helpers["actions"].tryWarping()
                    
                elseif command == "invite" then
                    windower.send_command(string.format("pcmd add %s", sender))
                    
                elseif command == "bpfollow" then
                    windower.send_command(string.format("follow %s", sender))
                    
                end
            
            -- Multiple Commands were sent.
            elseif count > 1 then

                if message[1] and message[2] and (message[1]):sub(1, #message[1]):lower() == (player.name):sub(1, #message[1]):lower() then
                    local command = message[2]:lower()
                    
                    if command == "warpout" then
                        helpers["actions"].tryWarping()
                        
                    end
                
                end
                
            end
            
        end
        
    end
    
    self.war = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
    
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local player  = windower.ffxi.get_player()
            local count   = #message:split(" ")
            local message = message:split(" ")
            local check = "WAR"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.mnk = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "MNK"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.whm = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local target  = windower.ffxi.get_mob_by_name(sender)
            local player  = windower.ffxi.get_player()
            local count   = #message:split(" ")
            local message = message:split(" ")
            local check = "WHM"
            
            if job == check then
                
                -- Only one command was detected.
                if count == 1 and message[1] then
                    local command = message[1]:lower()
                    
                    if command == "haste" and helpers["target"].castable(target, MA["Haste"]) then
                        helpers["queue"].add(MA["Haste"], target)
                        
                    elseif command == "protect" and helpers["target"].castable(target, MA["Protect"]) then
                        helpers["queue"].add(MA["Protect V"], target)
                        
                    elseif command == "protectra" and helpers["target"].castable(player, MA["Protectra"]) and bpcore:isInParty(target, true) then
                        helpers["queue"].add(MA["Protectra V"], player)
                    
                    elseif command == "shell" and helpers["target"].castable(target, MA["Shell"]) then
                        helpers["queue"].add(MA["Shell V"], target)
                        
                    elseif command == "shellra" and helpers["target"].castable(player, MA["Shellra"]) and bpcore:isInParty(target, true) then
                        helpers["queue"].add(MA["Shellra V"], player)
                        
                    elseif command == "auspice" and helpers["target"].castable(player, MA["Auspice"]) and bpcore:isInParty(target, true) then
                        helpers["queue"].add(MA["Auspice"], player)
                        
                    elseif command == "regen" and helpers["target"].castable(target, MA["Regen"]) then
                        helpers["queue"].add(MA["Regen IV"], target)
                        
                    elseif command == "erase" and helpers["target"].castable(target, MA["Erase"]) and bpcore:isInParty(target, true) then
                        helpers["queue"].add(MA["Erase"], target)
                        
                    elseif command == "zzz" then
                        
                        if helpers["target"].castable(target, MA["Curaga"]) and bpcore:isInParty(target, true) then
                            helpers["queue"].add(MA["Curaga"], target)
                            
                        elseif helpers["target"].castable(target, MA["Cure"]) and bpcore:isInParty(target, false) then
                            helpers["queue"].add(MA["Cure"], target)
                        
                        end
                        
                    elseif command == "firebuff" and helpers["target"].castable(player, MA["Auspice"]) and bpcore:isInParty(target, true) then
                        helpers["queue"].add(MA["Protectra V"], player)
                        helpers["queue"].add(MA["Shellra V"], player)
                        helpers["queue"].add(MA["Boost-STR"], player)
                        helpers["queue"].add(MA["Barfira"], player)
                        helpers["queue"].add(MA["Baramnesra"], player)
                        helpers["queue"].add(MA["Auspice"], player)
                        
                    elseif command == "waterbuff" and helpers["target"].castable(player, MA["Auspice"]) and bpcore:isInParty(target, true) then
                        helpers["queue"].add(MA["Protectra V"], player)
                        helpers["queue"].add(MA["Shellra V"], player)
                        helpers["queue"].add(MA["Boost-DEX"], player)
                        helpers["queue"].add(MA["Barwatera"], player)
                        helpers["queue"].add(MA["Barpoisonra"], player)
                        helpers["queue"].add(MA["Auspice"], player)
                        
                    elseif command == "icebuff" and helpers["target"].castable(player, MA["Auspice"]) and bpcore:isInParty(target, true) then
                        helpers["queue"].add(MA["Protectra V"], player)
                        helpers["queue"].add(MA["Shellra V"], player)
                        helpers["queue"].add(MA["Boost-DEX"], player)
                        helpers["queue"].add(MA["Barblizzara"], player)
                        helpers["queue"].add(MA["Barparalyzra"], player)
                        helpers["queue"].add(MA["Auspice"], player)
                        
                    elseif command == "windbuff" and helpers["target"].castable(player, MA["Auspice"]) and bpcore:isInParty(target, true) then
                        helpers["queue"].add(MA["Protectra V"], player)
                        helpers["queue"].add(MA["Shellra V"], player)
                        helpers["queue"].add(MA["Boost-DEX"], player)
                        helpers["queue"].add(MA["Baraera"], player)
                        helpers["queue"].add(MA["Barsilencera"], player)
                        helpers["queue"].add(MA["Auspice"], player)
                        
                    elseif command == "stonebuff" and helpers["target"].castable(player, MA["Auspice"]) and bpcore:isInParty(target, true) then
                        helpers["queue"].add(MA["Protectra V"], player)
                        helpers["queue"].add(MA["Shellra V"], player)
                        helpers["queue"].add(MA["Boost-DEX"], player)
                        helpers["queue"].add(MA["Barstonera"], player)
                        helpers["queue"].add(MA["Barpetra"], player)
                        helpers["queue"].add(MA["Auspice"], player)
                        
                    elseif command == "thunderbuff" and helpers["target"].castable(player, MA["Auspice"]) and bpcore:isInParty(target, true) then
                        helpers["queue"].add(MA["Protectra V"], player)
                        helpers["queue"].add(MA["Shellra V"], player)
                        helpers["queue"].add(MA["Boost-DEX"], player)
                        helpers["queue"].add(MA["Barthundra"], player)
                        helpers["queue"].add(MA["Barsilencera"], player)
                        helpers["queue"].add(MA["Auspice"], player)
                        
                    elseif (command == "raise" or command == "arise") and helpers["target"].castable(player, MA["Raise"]) and helpers["target"].isDead(target) then
                        
                        if bpcore:isMAReady(MA["Arise"].recast_id) and bpcore:getAvailable("MA", "Arise") then
                            helpers["queue"].add(MA["Arise"], player)
                            
                        elseif bpcore:isMAReady(MA["Raise III"].recast_id) and bpcore:getAvailable("MA", "Raise III") then
                            helpers["queue"].add(MA["Raise III"], player)
                            
                        elseif bpcore:isMAReady(MA["Raise II"].recast_id) and bpcore:getAvailable("MA", "Raise II") then
                            helpers["queue"].add(MA["Raise II"], player)
                            
                        elseif bpcore:isMAReady(MA["Raise"].recast_id) and bpcore:getAvailable("MA", "Raise") then
                            helpers["queue"].add(MA["Raise"], player)
                            
                        end
                        
                    elseif command == "aoeregen" and helpers["target"].castable(target, MA["Regen"]) and bpcore:isInParty(target, true) then
                        
                        if bpcore:isMAReady(MA["Regen IV"].recast_id) and bpcore:isJAReady(JA["Accession"].recast_id) and bpcore:getAvailable("MA", "Regen IV") and bpcore:getAvailable("JA", "Accession") and player.sub_job == "SCH" then
                            helpers["queue"].add(JA["Accession"], "me")
                            helpers["queue"].add(MA["Regen IV"], player)
                            
                        end
                    
                    elseif command == "holla" and helpers["party"].isInParty(target) then
                        helpers["queue"].add(MA["Teleport-Holla"], player)
                        
                    elseif command == "dem" and helpers["party"].isInParty(target) then
                        helpers["queue"].add(MA["Teleport-Dem"], player)
                        
                    elseif command == "mea" and helpers["party"].isInParty(target) then
                        helpers["queue"].add(MA["Teleport-Mea"], player)
                        
                    elseif command == "yhoat" and helpers["party"].isInParty(target) then
                        helpers["queue"].add(MA["Teleport-Yhoat"], player)
                        
                    elseif command == "altepa" and helpers["party"].isInParty(target) then
                        helpers["queue"].add(MA["Teleport-Altepa"], player)
                        
                    elseif command == "vazhl" and helpers["party"].isInParty(target) then
                        helpers["queue"].add(MA["Teleport-Vahzl"], player)
                        
                    elseif command == "jugner" and helpers["party"].isInParty(target) then
                        helpers["queue"].add(MA["Recall-Jugner"], player)
                        
                    elseif command == "pash" and helpers["party"].isInParty(target) then
                        helpers["queue"].add(MA["Recall-Pashh"], player)
                        
                    elseif command == "meriph" and helpers["party"].isInParty(target) then
                        helpers["queue"].add(MA["Recall-Meriph"], player)
                    
                    end
                
                -- Multiple Commands were sent.
                elseif count > 1 then
                    
                    for i=1, count do
                        
                        if message[1] and message[i+1] and (message[1]):sub(1, #message[1]):lower() == (player.name):sub(1, #message[1]):lower() then
                            local command = message[i+1]:lower()
                            
                            if command == "haste" and helpers["target"].castable(target, MA["Haste"]) then
                                helpers["queue"].add(MA["Haste"], target)
                                
                            elseif command == "protect" and helpers["target"].castable(target, MA["Protect"]) then
                                helpers["queue"].add(MA["Protect V"], target)
                                
                            elseif command == "protectra" and helpers["target"].castable(player, MA["Protectra"]) and bpcore:isInParty(target, true) then
                                helpers["queue"].add(MA["Protectra V"], player)
                            
                            elseif command == "shell" and helpers["target"].castable(target, MA["Shell"]) then
                                helpers["queue"].add(MA["Shell V"], target)
                                
                            elseif command == "shellra" and helpers["target"].castable(player, MA["Shellra"]) and bpcore:isInParty(target, true) then
                                helpers["queue"].add(MA["Shellra V"], player)
                                
                            elseif command == "auspice" and helpers["target"].castable(player, MA["Auspice"]) and bpcore:isInParty(target, true) then
                                helpers["queue"].add(MA["Auspice"], player)
                                
                            elseif command == "regen" and helpers["target"].castable(target, MA["Regen"]) then
                                helpers["queue"].add(MA["Regen IV"], target)
                                
                            elseif command == "erase" and helpers["target"].castable(target, MA["Erase"]) and bpcore:isInParty(target, true) then
                                helpers["queue"].add(MA["Erase"], target)
                                
                            elseif command == "zzz" then
                                
                                if helpers["target"].castable(target, MA["Curaga"]) and bpcore:isInParty(target, true) then
                                    helpers["queue"].add(MA["Curaga"], target)
                                    
                                elseif helpers["target"].castable(target, MA["Cure"]) and bpcore:isInParty(target, false) then
                                    helpers["queue"].add(MA["Cure"], target)
                                
                                end
                                
                            elseif command == "aoeregen" and helpers["target"].castable(target, MA["Regen"]) and bpcore:isInParty(target, true) then
                                
                                if bpcore:isMAReady(MA["Regen IV"].recast_id) and bpcore:isJAReady(JA["Accession"].recast_id) and bpcore:getAvailable("MA", "Regen IV") and bpcore:getAvailable("JA", "Accession") and player.sub_job == "SCH" then
                                    helpers["queue"].add(JA["Accession"], "me")
                                    helpers["queue"].add(MA["Regen IV"], player)
                                    
                                end
                                
                            end
                            
                            
                        end
                    
                    end
                    
                end
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.blm = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "BLM"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.rdm = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "RDM"
            
            if job == check then
                
            elseif sub == check then
            
            end

        end
        
    end
    
    self.thf = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "THF"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.pld = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "PLD"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.drk = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "DRK"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.bst = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "BST"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.brd = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "BRD"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.rng = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "RNG"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.smn = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "SMN"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.sam = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "SAM"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.nin = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "NIN"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.drg = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "DRG"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.blu = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "BLU"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.cor = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "COR"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.pup = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "PUP"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.dnc = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "DNC"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.sch = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "SCH"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.geo = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "GEO"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.run = function(message, sender)
        local message = message or false
        local sender  = sender or false
        local job     = windower.ffxi.get_player().main_job
        local sub     = windower.ffxi.get_player().sub_job
        
        if message and sender and helpers["chatcommands"].isAllowed(sender) then
            local check = "RUN"
            
            if job == check then
                
            elseif sub == check then
            
            end
            
        end
        
    end
    
    self.isAllowed = function(name)
        local name = name or false
        local controllers = controllers or false
        
        if controllers then
        
            for _,v in ipairs(controllers) do
                
                if v and type(v) == "string" then
                    
                    if v == name then
                        return true
                    end
                    
                end
                
            end
            
        end
        return false
    
    end
    
    return self
    
end
return chatcommands.new()
