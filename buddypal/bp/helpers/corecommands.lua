--------------------------------------------------------------------------------
-- `Corecommands Helper`: A library of functions to help handle all the general commands for the "Core Logic."
--------------------------------------------------------------------------------
local corecommands = {}
function corecommands.new()
    local self = {}
    
    self.handle = function(commands)
        local command  = commands[1] or false
        local settings = system["Core"].getSettings()
        local message  = ""
        
        if command then
            command = windower.convert_auto_trans(command):lower()
        end
        
        if command == "on" or command == "toggle" or command == "off" then
            system["BP Enabled"]:next()
            message = string.format("AUTOMATION: %s", tostring(system["BP Enabled"]:current()))
            
            if not system["BP Enabled"]:current() then
                helpers["queue"].clear()
            end
        
        elseif command == "am" then
            system["Core"].next("AM")
            message = string.format("AUTO-AFTERMATH: %s", tostring(system["Core"].current("AM")))
            
        elseif command == "amt" then
            system["Core"].next("AM THRESHOLD")
            message = string.format("AFTERMATH THRESHOLD: %s", tostring(system["Core"].current("AM THRESHOLD")))
        
        elseif command == "1hr" then
            system["Core"].next("1HR")
            message = string.format("AUTO-1HR: %s", tostring(system["Core"].current("1HR")))
        
        elseif command == "ja" then
            system["Core"].next("JA")
            message = string.format("AUTO-ABILITIES: %s", tostring(system["Core"].current("JA")))
            
        elseif command == "buffs" then
            system["Core"].next("BUFFS")
            message = string.format("AUTO-BUFFING: %s", tostring(system["Core"].current("BUFFS")))
            
        elseif command == "debuffs" then
            system["Core"].next("DEBUFFS")
            message = string.format("AUTO-DEBUFFING: %s", tostring(system["Core"].current("DEBUFFS")))
            
        elseif command == "hate" then
            system["Core"].next("HATE")
            message = string.format("AUTO-ENMITY: %s", tostring(system["Core"].current("HATE")))
            
        elseif command == "aoehate" then
            system["Core"].next("AOEHATE")
            message = string.format("AUTO-ENMITY (AOE): %s", tostring(system["Core"].current("AOEHATE")))
        
        elseif command == "ra" then
            system["Core"].next("RA")
            message = string.format("AUTO-RANGED ATTACKS: %s", tostring(system["Core"].current("RA")))
            
        elseif command == "ws" then
            system["Core"].next("WS")
            message = string.format("AUTO-WEAPONSKILLS: %s", tostring(system["Core"].current("WS")))
            
        elseif command == "sc" then
            system["Core"].next("SC")
            message = string.format("AUTO-SKILLCHAINS: %s", tostring(system["Core"].current("SC")))
        
        elseif command == "status" then
            system["Core"].next("STATUS")
            message = string.format("STATUS DEBUFFING: %s", tostring(system["Core"].current("STATUS")))
        
        elseif command == "burst" then
            system["Core"].next("BURST")
            message = string.format("AUTO-BURST: %s", tostring(system["Core"].current("BURST")))
        
        elseif command == "tier" then
            system["Core"].next("TIER")
            message = string.format("BURST TIER NOW SET TO: %s", tostring(system["Core"].current("TIER")))
            
        elseif command == "aoe" then
            system["Core"].next("ALLOW-AOE")
            message = string.format("AOE BURST NOW SET TO: %s", tostring(system["Core"].current("ALLOW-AOE")))
            
        elseif command == "drains" then
            system["Core"].next("DRAINS")
            message = string.format("AUTO-DRAIN|ASPIR: %s", tostring(system["Core"].current("DRAINS")))
            
        elseif command == "stuns" then
            system["Core"].next("STUNS")
            message = string.format("AUTO-STUNNING: %s", tostring(system["Core"].current("STUNS")))
        
        elseif command == "spikes" then
            system["Core"].next("SPIKES")
            message = string.format("AUTO-SPIKES NOW SET TO: %s", tostring(system["Core"].current("SPIKES")))
            
        elseif command == "dia" or command == "bio" then
            system["Core"].next("DIA")
            message = string.format("DIA|BIO MODE NOW SET TO: %s", tostring(system["Core"].current("DIA")))
            
        elseif command == "storm" or command == "weather" then
            system["Core"].next("WEATHER")
            message = string.format("WEATHER NOW SET TO: %s", tostring(system["Core"].current("WEATHER")))
        
        elseif command == "sub" then
            system["Core"].next("SUBLIMATION")
            message = string.format("AUTO-SUBLIMATION: %s", tostring(system["Core"].current("SUBLIMATION")))
        
        elseif command == "composure" then
            system["Core"].next("COMPOSURE")
            message = string.format("AUTO-COMPOSURE: %s", tostring(system["Core"].current("COMPOSURE")))
            
        elseif command == "convert" then
            system["Core"].next("CONVERT")
            message = string.format("AUTO-SUBLIMATION: %s", tostring(system["Core"].current("CONVERT")))
            
        elseif command == "boost" then
            system["Core"].next("BOOST")
            message = string.format("AUTO-BOOST: %s", tostring(system["Core"].current("BOOST")))
        
        elseif command == "steps" then
            system["Core"].next("STEPS")
            message = string.format("AUTO-STEPS NOW SET TO: %s", tostring(system["Core"].current("STEPS")))
        
        elseif command == "sambas" then
            system["Core"].next("SAMBAS")
            message = string.format("AUTO-SAMBAS NOW SET TO: %s", tostring(system["Core"].current("SAMBAS")))
        
        elseif command == "rune1" then
            system["Core"].next("RUNE1")
            message = string.format("AUTO-RUNE(#1) NOW SET TO: %s", tostring(system["Core"].current("RUNE1")))
        
        elseif command == "rune2" then
            system["Core"].next("RUNE2")
            message = string.format("AUTO-RUNE(#2) NOW SET TO: %s", tostring(system["Core"].current("RUNE2")))
            
        elseif command == "rune3" then
            system["Core"].next("RUNE3")
            message = string.format("AUTO-RUNE(#3) NOW SET TO: %s", tostring(system["Core"].current("RUNE3")))
        
        elseif command == "sanguine" then
            system["Core"].next("SANGUINE")
            message = string.format("AUTO-SANGUINE: %s", tostring(system["Core"].current("SANGUINE")))
            
        elseif command == "pet" then
            system["Core"].next("PET")
            message = string.format("AUTO-PET: %s", tostring(system["Core"].current("PET")))
            
        elseif command == "sic" then
            system["Core"].next("AUTO SIC")
            message = string.format("AUTO-PET ENGAGE: %s", tostring(system["Core"].current("AUTO SIC")))
            
        elseif command == "rage" then
            system["Core"].next("BPRAGE")
            message = string.format("AUTO-BLOOD PACT (RAGE): %s", tostring(system["Core"].current("BPRAGE")))
            
        elseif command == "ward" then
            system["Core"].next("BPWARD")
            message = string.format("AUTO-BLOOD PACT (WARD): %s", tostring(system["Core"].current("BPWARD")))
            
        elseif command == "rotate" then
            system["Core"].next("ROTATE")
            message = string.format("AUTO-ROTATE BLOOD PACT (WARD): %s", tostring(system["Core"].current("ROTATE")))
            
        elseif command == "summon" then
            system["Core"].next("SUMMON")
            message = string.format("PET SET TO: %s", tostring(system["Core"].current("SUMMON")))
        
        elseif command == "super" then
            system["Core"].next("SUPER-TANK")
            message = string.format("SUPER-TANK MODE: %s", tostring(system["Core"].current("SUPER-TANK")))
        
        elseif command == "utsu" then
            system["Core"].next("SHADOWS")
            message = string.format("AUTO-SHADOWS: %s", tostring(system["Core"].current("SHADOWS")))
        
        elseif command == "skillup" then
            system["Core"].next("SKILLUP")
            message = string.format("AUTO-SKILLUP: %s", tostring(system["Core"].current("SKILLUP")))
            
        elseif command == "skills" then
            system["Core"].next("SKILLS")
            message = string.format("SKILL-UP SPELL NOW SET TO: %s", tostring(system["Core"].current("SKILLS")))
        
        elseif command == "food" then
            system["Core"].next("FOOD")
            message = string.format("AUTO-FOOD NOW SET TO: %s", tostring(system["Core"].current("FOOD")))
            
        elseif command == "tank" then
            system["Core"].next("TANK MODE")
            message = string.format("TANK MODE: %s", tostring(system["Core"].current("TANK MODE")))
            
        elseif command == "display" then
            system["Core"].toggleDisplay()
        
        elseif command == "cures" then
            system["Core"].next("CURES")
            
            if system["Core"].current("CURES") == 1 then
                message = ("AUTO-CURES: DISABLED")
            
            elseif system["Core"].current("CURES") == 2 then
                message = ("AUTO-CURES: PARTY ONLY")
            
            elseif system["Core"].current("CURES") == 3 then
                message = ("AUTO-CURES: ALLIANCE")
            
            end
        
        elseif command == "element" then
            local element = commands[2] or false            

            if element then
                local element = windower.convert_auto_trans(element):lower() or false

                for _,v in pairs(res.elements) do

                    if v and element:sub(1,6) == v.en:sub(1,6):lower() then
                        system["Core"].set("ELEMENT", v.en)
                        message = string.format("BURST ELEMENT NOW SET TO: %s", tostring(system["Core"].current("ELEMENT")))
                    
                    else
                        message = ("THAT IS NOT A VALID ELEMENT!")
                        
                    end
                    
                end
                
            else
                message = ("PLEASE ENTER THE ELEMENT NAME AS A SECOND PARAMETER!")
                
            end
        
        elseif command == "wsname" then
            local weaponskill = windower.convert_auto_trans(table.concat(commands, " "):sub(8))
            
            for _,v in pairs(windower.ffxi.get_abilities().weapon_skills) do
                
                if v and res.weapon_skills[v].en then
                    local match = (res.weapon_skills[v].en):match(("[%a%s%'%:]+"))

                    if weaponskill:sub(1,8):lower() == match:sub(1,8):lower() then
                        system["Core"].value("WSNAME",  res.weapon_skills[v].en)
                        message = string.format("WEAPONSKILL NOW SET TO: %s", tostring(system["Core"].get("WSNAME")))
                    end
                    
                end
                
            end
        
        elseif command == "rws" then
            local weaponskill = windower.convert_auto_trans(table.concat(commands, " "):sub(5))
            
            for _,v in pairs(windower.ffxi.get_abilities().weapon_skills) do
                
                if v and res.weapon_skills[v].en then
                    local match = (res.weapon_skills[v].en):match(("[%a%s%'%:]+"))

                    if weaponskill:sub(1,8):lower() == match:sub(1,8):lower() then
                        system["Core"].value("RANGED WS",  res.weapon_skills[v].en)
                        message = string.format("RANGED WEAPONSKILL NOW SET TO: %s", tostring(system["Core"].get("RANGED WS")))
                    end
                    
                end
                
            end
        
        elseif command == "sekka" then
            local weaponskill = windower.convert_auto_trans(table.concat(commands, " "):sub(7))
            
            for _,v in pairs(windower.ffxi.get_abilities().weapon_skills) do
                
                if v and res.weapon_skills[v].en then
                    local match = (res.weapon_skills[v].en):match(("[%a%s%'%:]+"))
                    
                    if weaponskill:sub(1,8):lower() == match:sub(1,8):lower() then
                        system["Core"].value("SEKKA",  res.weapon_skills[v].en)
                        message = string.format("SEKKANOKI WEAPONSKILL NOW SET TO: %s", tostring(system["Core"].get("SEKKA")))
                    end
                    
                end
                
            end
        
        elseif command == "enspell" then
            local enspell = commands[2] or false
            
            if enspell then
                local enspell = windower.convert_auto_trans(enspell):sub(1,3):lower()
                local list = system["Core"].getSettings()
                
                for _,v in pairs(list["ENSPELL"]) do

                    if v and type(v) == 'string' and enspell == v:sub(1,3):lower() then
                        system["Core"].set("ENSPELL", v)
                        message = string.format("AUTO-ENSPELL NOW SET TO: %s", tostring(system["Core"].current("ENSPELL")))
                    end
                    
                end
                
            end
        
        elseif command == "gains" then
            local gain = commands[2] or false
            
            if gain then
                local gain = windower.convert_auto_trans(commands[2]):lower()
                local list = system["Core"].getSettings()

                for _,v in pairs(list["GAINS"]) do
                    
                    if v and type(v) == 'string' and gain == v:lower() then
                        system["Core"].set("GAINS", v)
                        message = string.format("AUTO-GAINS NOW SET TO: %s", tostring(system["Core"].current("GAINS")))
                    end
                    
                end
                
            end
        
        elseif command == "tpt" then
            local number = commands[2] or false
            
            if number then
                number = tonumber(number)
                
                if number > 999 and number <= 3000 then
                    system["Core"].value("TP THRESHOLD", number)
                    message = string.format("TP THRESHOLD: %s", tostring(system["Core"].get("TP THRESHOLD")))
                    
                else
                    message = ("INVALID! - PLEASE PICK A NUMBER BETWEEN 1000 and 3000.")
                    
                end
            
            end
        
        end
        
        if message ~= "" then
            helpers['popchat']:pop(message:upper() or ("INVALID COMANDS"):upper(), system["Popchat Window"])
        end
        
    end
    
    return self
    
end
return corecommands.new()
