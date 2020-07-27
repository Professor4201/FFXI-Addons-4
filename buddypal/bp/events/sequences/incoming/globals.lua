local globals = {}
--------------------------------------------------------------------------------
-- Update the Missions Overlay.
--------------------------------------------------------------------------------
globals[1] = function(id,original,modified,injected,blocked)
    
    if id == 0x056 then
        local p = packets.parse("incoming", original)
        
        if helpers["missions"] ~= nil then
            helpers["missions"].buildMissions(original, p)
            helpers["missions"].update()
        
        end
        
    end
    
end

--------------------------------------------------------------------------------
-- Update the Currencies Overlay.
--------------------------------------------------------------------------------
globals[2] = function(id,original,modified,injected,blocked)
    
    -- Currencies Menu.
    if id == 0x113 and helpers["currencies"] ~= nil then
        local p = packets.parse("incoming", original)

        helpers["currencies"].setCurrency("Sparks",                 p["Sparks of Eminence"])
        helpers["currencies"].setCurrency("Accolades",              p["Unity Accolades"])
        helpers["currencies"].setCurrency("Ichor",                  p["Therion Ichor"])
        helpers["currencies"].setCurrency("Tokens",                 p["Nyzul Tokens"])
        helpers["currencies"].setCurrency("Voidstones",             p["Voidstones"])
        helpers["currencies"].setCurrency("Zeni",                   p["Zeni"])        
        helpers["currencies"].setCurrency("Fishing (GP)",           p["Guild Points (Fishing)"])
        helpers["currencies"].setCurrency("Woodworking (GP)",       p["Guild Points (Woodworking)"])
        helpers["currencies"].setCurrency("Smithing (GP)",          p["Guild Points (Smithing)"])
        helpers["currencies"].setCurrency("Goldsmithing (GP)",      p["Guild Points (Goldsmithing)"])
        helpers["currencies"].setCurrency("Clothcraft (GP)",        p["Guild Points (Weaving)"])
        helpers["currencies"].setCurrency("Leathercraft (GP)",      p["Guild Points (Leathercraft)"])
        helpers["currencies"].setCurrency("Bonecraft (GP)",         p["Guild Points (Bonecraft)"])
        helpers["currencies"].setCurrency("Alchemy (GP)",           p["Guild Points (Alchemy)"])
        helpers["currencies"].setCurrency("Cooking (GP)",           p["Guild Points (Cooking)"])
        helpers["currencies"].setCurrency("Fire Crystals",          p["Fire Crystals"])
        helpers["currencies"].setCurrency("Ice Crystals",           p["Ice Crystals"])
        helpers["currencies"].setCurrency("Wind Crystals",          p["Wind Crystals"])
        helpers["currencies"].setCurrency("Earth Crystals",         p["Earth Crystals"])
        helpers["currencies"].setCurrency("Lightning Crystals",     p["Lightning Crystals"])
        helpers["currencies"].setCurrency("Water Crystals",         p["Water Crystals"])
        helpers["currencies"].setCurrency("Light Crystals",         p["Light Crystals"])
        helpers["currencies"].setCurrency("Dark Crystals",          p["Dark Crystals"])
    
    -- Currencies Menu 2.
    elseif id == 0x118 and helpers["currencies"] ~= nil then
        local p = packets.parse("incoming", original)
        
        helpers["currencies"].setCurrency("Bayld",                  p["Bayld"])
        helpers["currencies"].setCurrency("Plasm",                  p["Mweya Plasm Corpuscles"])
        helpers["currencies"].setCurrency("Imps",                   p["Coalition Imprimaturs"])
        helpers["currencies"].setCurrency("Beads",                  p["Escha Beads"])
        helpers["currencies"].setCurrency("Silt",                   p["Escha Silt"])
        helpers["currencies"].setCurrency("Potpourri",              p["Potpourri"])
        helpers["currencies"].setCurrency("Hallmarks",              p["Hallmarks"])
        helpers["currencies"].setCurrency("Gallantry",              p["Badges of Gallantry"])
        helpers["currencies"].setCurrency("Crafter",                p["Crafter Points"])
        helpers["currencies"].setCurrency("Silver Vouchers",        p["Silver A.M.A.N. Vouchers Stored"])
        
    end
    
end

--------------------------------------------------------------------------------
-- Set target when aggrod by a mob.
--------------------------------------------------------------------------------
globals[3] = function(id,original,modified,injected,blocked)
    
    if id == 0x028 then 
        local p        = packets.parse("incoming", modified)
        local actor    = windower.ffxi.get_mob_by_id(p["Actor"])
        local target   = windower.ffxi.get_mob_by_id(p["Target 1 ID"])
        local category = p["Category"]
        local param    = p["Param"]
        
        helpers["status"].actions(original)
        
        if actor and target then
        
            -- Melee Attacks.
            if p["Category"] == 1 then
                
                -- Set Enmity Target.
                helpers["target"].setPlayerEnmity(actor, target)
                
                -- Make sure that I am the one using the weaponskill.
                if actor.name == windower.ffxi.get_mob_by_target("me").name and actor.name == "Uwu" then
                    local random  = math.random(1, 100)
                    local select  = math.random(1, 010)
                    local message = {"Dick!", "Kick you", "right in the", "Bitch!", "the nuts", "the tits", "in yo-", "MNK Life!", "Eat White Rice!~", "Catch deez handzzzzzzz!"}

                    if random > 65 and windower.ffxi.get_player().main_job == "MNK" then
                        helpers["popchat"]:pop(message[select], system["Popchat Window"])
                    end
                    
                end
            
            -- Finish Ranged Attack.
            elseif p["Category"] == 2 then
                
                -- Make sure that I am the one using the weaponskill.
                if actor.name == windower.ffxi.get_mob_by_target("me").name then
                    local delays = helpers["actions"].getDelays()
                    
                    helpers["queue"].remove({id=65536,en="Ranged",element=-1,prefix="/ra",type="Ranged", range=14}, actor)
                    helpers["actions"].setMidaction(false)
                    system["Next Allowed"] = (os.clock() + delays["Ranged"])
                    
                end
                
            -- Finish Weaponskill.
            elseif p["Category"] == 3 then
                
                -- Make sure that I am the one using the weaponskill.
                if actor.name == windower.ffxi.get_mob_by_target("me").name then
                    local delays = helpers["actions"].getDelays()
                    
                    helpers["queue"].remove(res.weapon_skills[param], actor)
                    helpers["actions"].setMidaction(false)
                    system["Next Allowed"] = (os.clock() + delays["WeaponSkill"])
                    
                end
                
            -- Finish Spell Casting.
            elseif p["Category"] == 4 then
                
                -- Make sure that I finished casting the spell.
                if actor.name == windower.ffxi.get_mob_by_target("me").name then
                    local me     = windower.ffxi.get_mob_by_target("me")
                    local delays = helpers["actions"].getDelays()
                    local spell  = res.spells[param] or false
                    
                    if spell and type(spell) == "table" and spell.type then
                        helpers["queue"].remove(spell, actor)
                        helpers["actions"].setMidaction(false)
                        system["Next Allowed"] = (os.clock() + delays[spell.type])
                    
                    end
                    
                end
                
                if windower.ffxi.get_player().main_job == "GEO" and param >= 768 and param <= 797 and not bpcore:buffActive(584) then
                    system["Core"].setColure(param)
                
                elseif windower.ffxi.get_player().main_job == "GEO" and param >= 798 and param <= 827 then
                    system["Core"].setLuopan(param)
                    
                end
                
            -- Finish using an Item.
            elseif p["Category"] == 5 then
                
                -- Make sure that I finished using the item.
                if actor.name == windower.ffxi.get_mob_by_target("me").name then
                    local delays = helpers["actions"].getDelays()
                    
                    helpers["queue"].remove(res.items[param], actor)
                    helpers["actions"].setMidaction(false)
                    system["Next Allowed"] = (os.clock() + delays["Item"])
                    
                    --Timestamp items with cooldowns.
                    if res.items[param] then
                        local item = res.items[param]
                        
                        if item and system["Cooldown Items"]:contains(item.name) then
                            bpcore:stamp(item.name)
                        end
                        
                    end                        
                    
                end
                
            -- Use Job Ability.
            elseif p["Category"] == 6 then
                local rolls = res.job_abilities:type("CorsairRoll")
                local runes = res.job_abilities:type("Rune")
                
                -- Set Enmity Target.
                helpers["target"].setPlayerEnmity(actor, target)
                
                -- Make sure that I am using the ability.
                if actor.name == windower.ffxi.get_mob_by_target("me").name then
                    local player = windower.ffxi.get_player()
                    local action = bpcore:buildAction(category, param)
                    local delay  = bpcore:getActionDelay(action)
                    
                    helpers["actions"].setMidaction(true)
                    system["Next Allowed"] = (os.clock() + delay)
                    helpers["queue"].attempt()
                    helpers["queue"].remove(res.job_abilities[param], actor)
                    helpers["actions"].setMidaction(false)
                    
                    if player.main_job == "COR" and rolls[param] then
                        helpers["rolls"].setRolling(rolls[param].en, p["Target 1 Action 1 Param"])
                    
                    elseif player.main_job == "RUN" and runes[param] and helpers["runes"].getBuff(runes[param].en) and helpers["runes"].valid(helpers["runes"].getBuff(runes[param].en).id) then
                        helpers["runes"].add(helpers["runes"].getBuff(runes[param].en).id)                        
                    
                    end
                    
                end
                
            -- Use Weaponskill.
            elseif p["Category"] == 7 then
                
                -- Set Enmity Target.
                helpers["target"].setPlayerEnmity(actor, target)
                
                -- Make sure that I am using the weaponskill.
                if actor.name == windower.ffxi.get_mob_by_target("me").name then
                    
                    if param == 24931 then
                        local param  = p["Target 1 Action 1 Param"]
                        local action = bpcore:buildAction(category, param)
                        local delay  = bpcore:getActionDelay(action)
                        
                        helpers["actions"].setMidaction(true)
                        system["Next Allowed"] = (os.clock() + delay)
                        
                    elseif param == 28787 then
                        helpers["actions"].setMidaction(false)
                        system["Next Allowed"] = (os.clock() + 0.8)
                    end
                    
                    
                end
                
            -- Begin Spell Casting.
            elseif p["Category"] == 8 then
                
                -- Set Enmity Target.
                helpers["target"].setPlayerEnmity(actor, target)
                
                -- Make sure that I am casting the spell.
                if actor.name == windower.ffxi.get_mob_by_target("me").name then
                    local me = windower.ffxi.get_mob_by_target("me")
                    
                    if param == 24931 then
                        local param  = p["Target 1 Action 1 Param"]
                        local action = bpcore:buildAction(category, param)
                        local delay  = bpcore:getActionDelay(action)
                        
                        helpers["actions"].setMidaction(true)
                        system["Next Allowed"] = (os.clock() + delay)
                        
                    elseif param == 28787 then
                        helpers["actions"].setMidaction(false)
                        system["Next Allowed"] = (os.clock() + 0.8)
                        
                    end
                    
                end
                
            -- Begin Item Usage.
            elseif p["Category"] == 9 then
                
                -- Make sure that I am using an item.
                if actor.name == windower.ffxi.get_mob_by_target("me").name then
                    local me = windower.ffxi.get_mob_by_target("me")
                    
                    if param == 24931 then
                        local param  = p["Target 1 Action 1 Param"]
                        local action = bpcore:buildAction(category, param)
                        local delay  = bpcore:getActionDelay(action)
                        
                        helpers["actions"].setMidaction(true)
                        system["Next Allowed"] = (os.clock() + delay)
                        
                    elseif param == 28787 then
                        helpers["actions"].setMidaction(false)
                        system["Next Allowed"] = (os.clock() + 0.8)
                        
                    end
                    
                end
                
            -- NPC TP Move.
            elseif p["Category"] == 11 then
                
                -- Set Enmity Target.
                helpers["target"].setPlayerEnmity(actor, target)
                
            -- Begin Ranged Attack.
            elseif p["Category"] == 12 then
                
                -- Set Enmity Target.
                helpers["target"].setPlayerEnmity(actor, target)
                
                -- Make sure that I am using an item.
                if actor.name == windower.ffxi.get_mob_by_target("me").name then
                    local me = windower.ffxi.get_mob_by_target("me")
                    
                    if param == 24931 then
                        local param  = p["Target 1 Action 1 Param"]
                        local action = bpcore:buildAction(category, param)
                        local delay  = bpcore:getActionDelay(action)
                        
                        helpers["actions"].setMidaction(true)
                        system["Next Allowed"] = (os.clock() + delay)
                    
                    elseif param == 28787 then
                        helpers["actions"].setMidaction(false)
                        system["Next Allowed"] = (os.clock() + 0.8)
                        
                    end
                    
                end
                
            -- Finish Pet Ability / Weaponskill.
            elseif p["Category"] == 13 then
                
                -- Make sure that I am using the ability.
                if actor.name == windower.ffxi.get_mob_by_target("me").name then
                    local action = bpcore:buildAction(category, param)
                    local delay  = bpcore:getActionDelay(action)
                    
                    helpers["actions"].setMidaction(true)
                    system["Next Allowed"] = (os.clock() + delay)
                    helpers["queue"].remove(res.job_abilities[param], actor)
                    helpers["actions"].setMidaction(false)
                    
                end
                
            -- DNC Abilities
            elseif p["Category"] == 14 then
                
                -- Set Enmity Target.
                helpers["target"].setPlayerEnmity(actor, target)
                
                -- Make sure that I am using the ability.
                if actor.name == windower.ffxi.get_mob_by_target("me").name then
                    local action = bpcore:buildAction(category, param)
                    local delay  = bpcore:getActionDelay(action)
                    
                    helpers["actions"].setMidaction(true)
                    system["Next Allowed"] = os.clock() + delay
                    helpers["queue"].remove(res.job_abilities[param], actor)
                    helpers["actions"].setMidaction(false)
                    
                end
            
            -- RUN Abilities
            elseif p["Category"] == 15 then
                
                -- Set Enmity Target.
                helpers["target"].setPlayerEnmity(actor, target)
                
                -- Make sure that I am using the ability.
                if actor.name == windower.ffxi.get_mob_by_target("me").name then
                    local action = bpcore:buildAction(category, param)
                    local delay  = bpcore:getActionDelay(action)
                    
                    helpers["actions"].setMidaction(true)
                    system["Next Allowed"] = os.clock() + delay
                    helpers["queue"].remove(res.job_abilities[param], actor)
                    helpers["actions"].setMidaction(false)
                    
                end
                
            end    
        
        end
        
    end
    
end

--------------------------------------------------------------------------------
-- Pet Status Update.
--------------------------------------------------------------------------------
globals[4] = function(id,original,modified,injected,blocked)
    
    if id == 0x068 then
        local pet = windower.ffxi.get_mob_by_target("pet") or false
        
        if pet then
            local hpp    = original:unpack("C", 0x0e+1)
            local mpp    = original:unpack("C", 0x0f+1)
            local tp     = original:unpack("I", 0x10+1)
            local target = original:unpack("I", 0x14+1)
            
            system["Pet"] = {hpp=hpp, mpp=mpp, tp=tp, target=target}
            
        elseif not pet then
            system["Pet"] = {hpp=0, mpp=0, tp=0, target=0}
            
        end
        
    end
    
end

--------------------------------------------------------------------------------
-- NPC Resource Builder.
--------------------------------------------------------------------------------
globals[5] = function(id,original,modified,injected,blocked)
    
    if id == 0x00e then
        local p = packets.parse("incoming", original)
        
        if helpers["resourcer"] ~= nil and helpers["resourcer"].isEnabled() then
            
            local zone   = windower.ffxi.get_info().zone
            local player = windower.ffxi.get_player() or false
            local mob    = windower.ffxi.get_mob_by_id(p["NPC"]) or false
            local update = helpers["bits"].unpack(0x0a, 8, original)
            local update_types = {
                
                despawn = "00000100",
                spawn   = "11110000",
                
            }
            
            if player and mob and update and player.name == "Eliidyr" then
            
                if update == update_types.spawn then
                    
                    if (mob.name):match("Home Point") then
                        
                        if not warps["homepoints"][mob.id] then
                            warps["homepoints"][mob.id] = {name=mob.name, id=mob.id, index=mob.index, x=mob.x, y=mob.y, z=mob.z, size=mob.model_size, scale=mob.model_scale, option=0, menu=0, _u1=0, _u2=0}
                            bpcore:writeSettings(("/bp/resources/homepoints/"..zone.."/homepoints"), warps["homepoints"])
                            helpers["popchat"]:pop(string.format("%s added to resources!", mob.name):upper(), system["Popchat Window"])
                            
                        end
    
                    elseif (mob.name):match("Survival Guide") then
                        
                        if not warps["guides"][mob.id] then
                            warps["guides"][mob.id] = {name=mob.name, id=mob.id, index=mob.index, x=mob.x, y=mob.y, z=mob.z, size=mob.model_size, scale=mob.model_scale, option=0, menu=0, _u1=0, _u2=0}
                            bpcore:writeSettings(("/bp/resources/guides/"..zone.."/guides"), warps["guides"])
                            helpers["popchat"]:pop(string.format("%s added to resources!", mob.name):upper(), system["Popchat Window"])
                            
                        end
                        
                    elseif (mob.name):match("Proto[-]?Waypoint") then
                        
                        if not warps["proto"][mob.id] then
                            warps["proto"][mob.id] = {name=mob.name, id=mob.id, index=mob.index, x=mob.x, y=mob.y, z=mob.z, size=mob.model_size, scale=mob.model_scale, option=0, menu=0, _u1=0, _u2=0}
                            bpcore:writeSettings(("/bp/resources/proto/"..zone.."/proto"), warps["proto"])
                            helpers["popchat"]:pop(string.format("%s added to resources!", mob.name):upper(), system["Popchat Window"])
                            
                        end
                        
                    elseif mob.name == "Atmacite Refiner" then
                        
                        if not warps["vw"][mob.id] then
                            warps["vw"][mob.id] = {name=mob.name, id=mob.id, index=mob.index, x=mob.x, y=mob.y, z=mob.z, size=mob.model_size, scale=mob.model_scale, option=0, menu=0, _u1=0, _u2=0}
                            bpcore:writeSettings(("/bp/resources/vw/"..zone.."/vw"), warps["vw"])
                            helpers["popchat"]:pop(string.format("%s added to resources!", mob.name):upper(), system["Popchat Window"])
                            
                        end
                    
                    elseif (mob.name):match("Veridical Conflux") then
                        
                        if not warps["conflux"][mob.id] then
                            warps["conflux"][mob.id] = {name=mob.name, id=mob.id, index=mob.index, x=mob.x, y=mob.y, z=mob.z, size=mob.model_size, scale=mob.model_scale, option=0, menu=0, _u1=0, _u2=0}
                            bpcore:writeSettings(("/bp/resources/conflux/"..zone.."/conflux"), warps["conflux"])
                            helpers["popchat"]:pop(string.format("%s added to resources!", mob.name):upper(), system["Popchat Window"])
                            
                        end
                        
                    elseif mob.name == "Urbiolaine" or mob.name == "Igsli" or mob.name == "Teldro-Kesdrodo" or mob.name == "Yonolala" or mob.name == "Nunaarl Bthtrogg" then
                        
                        if not warps["unity"][mob.id] then
                            warps["unity"][mob.id] = {name=mob.name, id=mob.id, index=mob.index, x=mob.x, y=mob.y, z=mob.z, size=mob.model_size, scale=mob.model_scale, option=0, menu=0, _u1=0, _u2=0}
                            bpcore:writeSettings(("/bp/resources/unity/"..zone.."/unity"), warps["unity"])
                            helpers["popchat"]:pop(string.format("%s added to resources!", mob.name):upper(), system["Popchat Window"])
                            
                        end
                    
                    elseif mob.name == "Ernst" or mob.name == "Ivan" or mob.name == "Willis" or mob.name == "Kierron" or mob.name == "Vincent" or mob.name == "Horst" or mob.name:match("Cavernous Maw") then
                        
                        if not warps["abyssea"][mob.id] then
                            warps["abyssea"][mob.id] = {name=mob.name, id=mob.id, index=mob.index, x=mob.x, y=mob.y, z=mob.z, size=mob.model_size, scale=mob.model_scale, option=0, menu=0, _u1=0, _u2=0}
                            bpcore:writeSettings(("/bp/resources/abyssea/"..zone.."/abyssea"), warps["abyssea"])
                            helpers["popchat"]:pop(string.format("%s added to resources!", mob.name):upper(), system["Popchat Window"])
                            
                        end
                    
                    elseif (mob.name == "Undulating Confluence" or (mob.name):match("Ethereal Ingress") or mob.name == "Dimensional Portal" or mob.name:match("Eschan Portal")) then
                        
                        if not warps["escha"][mob.id] then
                            warps["escha"][mob.id] = {name=mob.name, id=mob.id, index=mob.index, x=mob.x, y=mob.y, z=mob.z, size=mob.model_size, scale=mob.model_scale, option=0, menu=0, _u1=0, _u2=0}
                            bpcore:writeSettings(("/bp/resources/escha/"..zone.."/escha"), warps["escha"])
                            helpers["popchat"]:pop(string.format("%s added to resources!", mob.name):upper(), system["Popchat Window"])
                            
                        end
                    
                    elseif mob.name == "Waypoint" then
                        
                        if not warps["waypoints"][mob.id] then
                            warps["waypoints"][mob.id] = {name=mob.name, id=mob.id, index=mob.index, x=mob.x, y=mob.y, z=mob.z, size=mob.model_size, scale=mob.model_scale, option=0, menu=0, _u1=0, _u2=0}
                            bpcore:writeSettings(("bp/resources/waypoints/"..zone.."/waypoints"), warps["waypoints"])
                            helpers["popchat"]:pop(string.format("%s added to resources!", mob.name):upper(), system["Popchat Window"])
                            
                        end
                        
                    elseif (mob.name == "Logging Point" or mob.name == "Mining Point" or mob.name == "Harvesting Point") then
                        
                        if not gather[mob.id] then
                            gather[mob.id] = {name=mob.name, id=mob.id, index=mob.index, x=mob.x, y=mob.y, z=mob.z}
                            bpcore:writeSettings(("bp/resources/gather/"..zone.."/gather"), gather)
                            helpers["popchat"]:pop(string.format("%s added to resources!", mob.name):upper(), system["Popchat Window"])
                            
                        end
                        
                    elseif mob and mob.index < 1024 and mob.name ~= "" and tonumber(mob.name) == nil and (mob.x+mob.y+mob.z) ~= 0 then
                                
                        if not npcs[mob.id] then
                            npcs[mob.id] = {name=mob.name, id=mob.id, index=mob.index, x=mob.x, y=mob.y, z=mob.z, size=mob.model_size, scale=mob.model_scale}
                            bpcore:writeSettings(("bp/resources/npc/"..zone.."/npc"), npcs)
                            helpers["popchat"]:pop(string.format("%s added to resources!", mob.name):upper(), system["Popchat Window"])
                            
                        end
                    
                    end
                
                end
            
            end
            
        end
    
    end
    
end

--------------------------------------------------------------------------------
-- Player Update.
--------------------------------------------------------------------------------
globals[6] = function(id,original,modified,injected,blocked)
    
    if id == 0x037 then
        local p = packets.parse("incoming", original)
        local timestamp = original:unpack("I", 0x40+1)
        
        -- Store data.
        system["I: 0x037 Data"] = original
        
        if system["Fast Synth"] then
            system["Finish Synth"] = true
        end
        
        if helpers["speed"] ~= nil then
            helpers["speed"].setData(original)
        end
        
        if helpers["speed"] ~= nil and commands["mode"] ~= nil and commands["mode"].getMode() then
            return original:sub(1, 44)..("C"):pack(helpers["speed"].getSpeed())..original:sub(46,48)..("C"):pack(31)..original:sub(50)
        
        elseif system["Fast Synth"] then
            --local timestamp = original:unpack("I", 0x40+1)
            --local update    = original:sub(1,64)..("I"):pack(timestamp - 100)..original:sub(69)
        
        else
            return original:sub(1, 44)..("C"):pack(helpers["speed"].getSpeed())..original:sub(46)
        
        end
        
    end
    
end

--------------------------------------------------------------------------------
-- Player Update.
--------------------------------------------------------------------------------
globals[7] = function(id,original,modified,injected,blocked)
    
    -- Player Update.
    if id == 0x00d then
    
        -- Store data for later use.
        system["I: 0x00d Data"] = original
        
        -- Build local variables.
        local p           = packets.parse("incoming", original)
        local me          = windower.ffxi.get_mob_by_target("me")
        local index       = original:unpack("H", 0x08+1)
        local despawn     = p["Despawn"]
        local status      = p["Status"]
        
        if (despawn or status == 2) and helpers["status"].getDebuffCount(p["Player"]) > 0 then
            helpers["status"].removePlayer(p["Player"])
        end
        
        -- Check if speed helper is enabled.
        if helpers["speed"] ~= nil and helpers["speed"].getEnabled() and index == me.index then
            return original:sub(1,28)..("C"):pack(helpers["speed"].getSpeed())..original:sub(30)
            
        else
            return original
            
        end
        
    end
    
end

--------------------------------------------------------------------------------
-- Party Buffs.
--------------------------------------------------------------------------------
globals[8] = function(id,original,modified,injected,blocked)
    
    if id == 0x076 then
        local p       = packets.parse("incoming", original)
        local member1 = {original:sub(21,52):unpack("C32")}
        local member2 = {original:sub(69,100):unpack("C32")}
        local member3 = {original:sub(117,148):unpack("C32")}
        local member4 = {original:sub(165,196):unpack("C32")}
        local member5 = {original:sub(213,244):unpack("C32")}
        
        if system["Buffs"] then
            system["Buffs"]["Party"][p["ID 1"]] = {member1}
            system["Buffs"]["Party"][p["ID 2"]] = {member2}
            system["Buffs"]["Party"][p["ID 3"]] = {member3}
            system["Buffs"]["Party"][p["ID 4"]] = {member4}
            system["Buffs"]["Party"][p["ID 5"]] = {member5}
            
        end
        
    end
    
end

--------------------------------------------------------------------------------
-- NPC Interaction 1.
--------------------------------------------------------------------------------
globals[9] = function(id,original,modified,injected,blocked)
    
    if id == 0x032 or id == 0x034 then
        local p = packets.parse("incoming", original)
        
        if helpers["megawarp"] ~= nil then
        
            if helpers["megawarp"].getStatus() == "homepoints" then
                local nearest = helpers["megawarp"].getNearest()
                local options = helpers["megawarp"].getOptions()
                
                if nearest and options then
                    helpers["actions"].doHomepoint(p, nearest, options.unknown1)
                
                end
                helpers["megawarp"].setStatus(false)
                return true
            
            elseif helpers["megawarp"].getStatus() == "survivalguides" then
                local nearest = helpers["megawarp"].getNearest()
                local options = helpers["megawarp"].getOptions()
                
                if nearest and options then
                    helpers["actions"].doSurvivalguide(p, nearest, options.option)
                    
                end
                helpers["megawarp"].setStatus(false)
                return true
            
            elseif helpers["megawarp"].getStatus() == "waypoints" then
                local nearest = helpers["megawarp"].getNearest()
                local options = helpers["megawarp"].getOptions()
                
                if nearest and options then
                    helpers["actions"].doWaypoint(p, nearest, options.x, options.y, options.z, options.option, options.zone)
                
                end
                helpers["megawarp"].setStatus(false)
                return true
            
            elseif helpers["megawarp"].getStatus() == "proto" then
                local nearest = helpers["megawarp"].getNearest()
                local options = helpers["megawarp"].getOptions()
    
                if nearest and options then
                    helpers["actions"].doProtoWP(p, nearest, options.option)
                end
                helpers["megawarp"].setStatus(false)
                return true
            
            elseif helpers["megawarp"].getStatus() == "voidwatch" then
                local nearest = helpers["megawarp"].getNearest()
                local options = helpers["megawarp"].getOptions()
                
                if nearest and options then
                    helpers["actions"].doVoidwatch(p, nearest, options.option)
                
                end
                helpers["megawarp"].setStatus(false)
                return true
            
            elseif helpers["megawarp"].getStatus() == "unity" then
                local nearest = helpers["megawarp"].getNearest()
                local options = helpers["megawarp"].getOptions()
                
                if nearest and options then
                    helpers["actions"].doUnity(p, nearest, options.option)
                
                end
                helpers["megawarp"].setStatus(false)
                return true
            
            elseif helpers["megawarp"].getStatus() == "abyssea" then
                local nearest = helpers["megawarp"].getNearest()
                local options = helpers["megawarp"].getOptions()
                local zone    = helpers["megawarp"].getNextZone()
                
                if nearest and options and zone ~= "*" then
                    helpers["actions"].doAbyssea(p, nearest, options.option)
                    
                else
                    helpers["actions"].doEntrance(p, nearest)
                    
                end
                helpers["megawarp"].setStatus(false)
                return true
            
            elseif helpers["megawarp"].getStatus() == "escha" then
                local nearest = helpers["megawarp"].getNearest()
                local options = helpers["megawarp"].getOptions()
                local zone    = helpers["megawarp"].getNextZone()
                
                if nearest and options and zone ~= "*" then
                    helpers["actions"].doEscha(p, nearest, options.x, options.y, options.z, options.option, options.zone)
                    
                else
                    helpers["actions"].doEntrance(p, nearest)
                    
                end
                helpers["megawarp"].setStatus(false)
                return true
            
            elseif helpers["megawarp"].getStatus() == "conflux" then
                local nearest = helpers["megawarp"].getNearest()
                local options = helpers["megawarp"].getOptions()
                local zone    = helpers["megawarp"].getNextZone()
                
                if nearest and options and zone ~= "*" then
                    helpers["actions"].doConflux(p, nearest, options.x, options.y, options.z, options.option, options.zone)
                    
                end
                helpers["megawarp"].setStatus(false)
                return true
                
            end
            helpers["megawarp"].setStatus(false)         
            
        end
        
    end
    
end

--------------------------------------------------------------------------------
-- NPC Interaction 2.
--------------------------------------------------------------------------------
globals[10] = function(id,original,modified,injected,blocked)
    
    if id == 0x034 then
        local p             = packets.parse("incoming", original)
        local npc           = windower.ffxi.get_mob_by_id(original:sub(5,8):unpack("I")) or false
        local menu          = { original:sub(9,40):unpack("C32") }
        local assault_NPCs  = T{"Yahsra","Isdebaaq","Famad","Lageegee","Bhoy Yhupplo"}
        local toggle        = commands["menus"].settings().toggle
        
        if toggle and not injected then
            
            if npc then
                commands["menus"].setNPC(npc.name)
            end
            
            -- Unlock Coalitions.
            if npc and npc.name == "Task Delegator" then                
                local unpacked = { original:sub(9,40):unpack('C32') }
                local packed   = {}

                for i,v in ipairs(unpacked) do
                    
                    if (i < 2 or i > 4) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(222)
                    end
                    
                end
                
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
            
            -- Sparks NPC.
            elseif npc and npc.name == "Isakoth" then
                local unpacked = { original:sub(9,40):unpack('C32') }
                local packed   = {}

                for i,v in ipairs(unpacked) do
                    
                    if (i < 9 or i > 20) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(255)
                    end
                    
                end
                
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
            
            -- Unlock Assaults.
            elseif npc and (npc.name == "Yahsra" or npc.name == "Isdebaaq" or npc.name == "Famad" or npc.name == "Lageegee" or npc.name == "Bhoy Yhupplo") then                
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 4 or i > 4) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(1)
                    end
                    
                end
                
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
            
            -- Unlock Nyzul Assault Floors.
            elseif npc and npc.name == "----" then
                local menus1 = bpcore:adjustNPCMenu(original:sub(9,40), 32, 6, 255)
                table.print({menus1:unpack("C32")})
                
                return original:sub(1,8)..menus1..original:sub(41)
            
            -- Unlock Bastok Nation Items.
            elseif npc and (npc.name:match("I.M.") or npc.name:match("T.K.")) then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 3 or i > 11) then
                        packed[i] = ("C"):pack(unpacked[i])
                    
                    elseif i == 3 then
                        packed[i] = ("C"):pack(255)
                    
                    elseif i == 4 then
                        packed[i] = ("C"):pack(255)
                    
                    elseif i == 5 then
                        packed[i] = ("C"):pack(255)
                    
                    elseif i == 6 then
                        packed[i] = ("C"):pack(255)
                    
                    elseif i == 7 then
                        packed[i] = ("C"):pack(255)
                        
                    elseif i == 8 then
                        packed[i] = ("C"):pack(255)
                        
                    elseif i == 9 then
                        packed[i] = ("C"):pack(182)
                        
                    elseif i == 10 then
                        packed[i] = ("C"):pack(255)
                        
                    elseif i == 11 then
                        packed[i] = ("C"):pack(255)
                        
                    end
                    
                end
                table.print( {table.concat(packed,""):unpack("C32")} )
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
            
            -- Unlock Windurst Nation Items.
            elseif npc and npc.name:match("W.W.") then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                local data     = {[4]=37,[5]=42,[6]=86,[7]=106,[8]=31,[9]=91,[10]=49,[11]=16,[12]=60,[21]=94}
                
                for i,v in ipairs(unpacked) do
                    
                    if i == 21 then
                        packed[i] = ("C"):pack(94)
                        
                    elseif (i < 4 or i > 12) then
                        packed[i] = ("C"):pack(unpacked[i])
                        
                    else
                        packed[i] = ("C"):pack(data[i])
                        
                    end
                    
                end

                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
            
            -- HTBF.
            elseif npc and (npc.name == "Raving Opossum" or npc.name == "Trisvain" or npc.name == "Mimble-Pimble") then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 5 or i > 9) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(255)
                    end
                    
                end
                
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
                
            -- Unlock Delve Items.
            elseif npc and npc.name == "Forri-Porri" then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 6 or i > 9) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(255)
                    end
                    
                end
                
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
            
            -- Unlock Voidwatch Warps.
            elseif npc and npc.name:match("Atmacite") then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 20 or i > 26) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(255)
                    end
                    
                end
                
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
            
            -- Eschan Portals.
            elseif npc and npc.name:match("Eschan Portal") then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 6 or i > 7) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(255)
                    end
                    
                end
                
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
            
            -- Unlock Proto-Waypoints.
            elseif npc and npc.name == "Proto-Waypoint" then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 1 or i > 5) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(255)
                    end
                    
                end
                
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
            
            -- Waypoints.
            elseif npc and npc.name:match("Waypoint") then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 13 or i > 26) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(255)
                    end
                    
                end
                
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
            
            -- Home Points.
            elseif npc and npc.name:match("Home Point") then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 2 or i > 12) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(255)
                    end
                    
                end
                
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
            
            -- Unlock Abyssea Warps.
            elseif npc and npc.name == "Horst" then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if i ~= 9 then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(255)
                    end
                    
                end
                
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
                
            -- Unlock Trust in Eastern Adoulin.
            elseif npc and npc.name == "Ujlei Zelekko" then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 3 or i > 8) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(255)
                    end
                    
                end
                
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
            
            -- Skipper Moogle.
            elseif npc and (npc.name == "Zenicca" or npc.name == "Skipper Moogle") then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 2 or i > 10) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(175)
                    end
                    
                end
                
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
            
            -- Green Thumb Moogle.
            elseif npc and npc.name == "Green Thumb Moogle" then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 2 or i > 32) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(math.random(1,255))
                    end
                    
                end
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
            
            -- Temprix.
            elseif npc and npc.name == "Temprix" then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if i == 1 then
                        packed[i] = ("C"):pack(4)
                    
                    elseif (i < 29 or i > 30) then
                        packed[i] = ("C"):pack(unpacked[i])
                        
                    else
                        packed[i] = ("C"):pack(0)
                    end
                    
                end
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
                
            -- Emporox.
            elseif npc and npc.name == "Emporox" then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 3 or i > 20) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(255)
                    end
                    
                end
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
                
            -- Escha NPCs.
            elseif npc and (npc.name == "Affi" or npc.name == "Dremi" or npc.name == "Shiftrix") then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 5 or i > 10) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(5)
                    end
                    
                end
                windower.packets.inject_incoming(0x034, original:sub(1,8)..table.concat(packed,"")..original:sub(41))
                return true
                
            end
        
        -- Rytaal (Assualt NPC).
        elseif helpers["assaults"] ~= nil and npc and npc.name == "Rytaal" then
            helpers["assaults"].setTags(original)
        
        else
            return original
        
        end
        
    end
    
end

--------------------------------------------------------------------------------
-- NPC Interaction.
--------------------------------------------------------------------------------
globals[11] = function(id,original,modified,injected,blocked)
    
    if (id == 0x032 or id == 0x034) then
        local p = packets.parse("incoming", original)

        if helpers["sparks"].getInjecting() and helpers["sparks"].getItem ~= "" then
            helpers["sparks"].purchaseItem(p)
            helpers["sparks"].setInjecting(false)
            
        elseif helpers["aeonic"].getInjecting() then
            helpers["aeonic"].getKI(p)
            helpers["aeonic"].setInjecting(false)
            return true
            
        elseif helpers["millioncorn"].getInjecting() then
            helpers["millioncorn"].handleMenus(p)
            return true
            
        elseif helpers["zincore"].getInjecting() then
            helpers["zincore"].handleMenus(p)
            return true
            
        elseif helpers["crystals"].getFlag() then
            local target   = windower.ffxi.get_mob_by_target("t") or false
            local crystal  = helpers["crystals"].getCrystal() or false
            local quantity = helpers["crystals"].getQuantity() or false
            
            if target and crystal and quantity then
                helpers["crystals"].getCrystals(target, crystal, quantity)
                helpers["crystals"].setFlag(false)
                return true

            else
                helpers["crystals"].setFlag(false)
                return original
            
            end
        
        elseif helpers["ciphers"].getInjecting() then
            local target = windower.ffxi.get_mob_by_target("t") or false
            local id     = helpers["ciphers"].getId()
            
            if target and id and helpers["ciphers"].isTrust(id) then
                helpers["actions"].injectMenu(target.id, target.index, p["Zone"], id, p["Menu ID"], false, 0, 0)
                helpers["ciphers"].setInjecting(false)
                return true

            else
                helpers["ciphers"].setInjecting(false)
                return original
                
            end
        
        elseif helpers["kits"] ~= nil and helpers["kits"].getInjecting() then
            local target = windower.ffxi.get_mob_by_target("t") or false
            local kit = helpers["kits"].getKit()
            local quantity = helpers["kits"].getQuantity()
            
            if target and kit and quantity and tonumber(kit) ~= nil and tonumber(quantity) ~= nil then
                helpers["kits"].purchase(p, target, kit, quantity)
                helpers["kits"].setInjecting(false)
                return true
            
            else
                helpers["kits"].setInjecting(false)
                return original
                
            end
        
        else
            helpers["ciphers"].setInjecting(false)
            helpers["sparks"].setInjecting(false)
            helpers["millioncorn"].setInjecting(false)
            helpers["zincore"].setInjecting(false)
            helpers["crystals"].setFlag(false)
            helpers["kits"].setInjecting(false)
            return original
        
        end
        
    end
    
end

--------------------------------------------------------------------------------
-- Character Stats.
--------------------------------------------------------------------------------
globals[12] = function(id,original,modified,injected,blocked)
    
    if id == 0x061 then
        local p = packets.parse("incoming", original)
        helpers["stats"].buildStats(p)
        
    end
    
end

--------------------------------------------------------------------------------
-- Incoming Chat.
--------------------------------------------------------------------------------
globals[13] = function(id,original,modified,injected,blocked)
    
    if id == 0x017 then
        local p = packets.parse("incoming", original)
        local mode = p["Mode"]
        local message = p["Message"]
        
    end
    
end

--------------------------------------------------------------------------------
-- Incoming NPC Messages.
--------------------------------------------------------------------------------
globals[14] = function(id,original,modified,injected,blocked)
    
    if id == 0x036 then
        local p = packets.parse("incoming", original)
        
    end
    
end

--------------------------------------------------------------------------------
-- Incoming Shop Prices.
--------------------------------------------------------------------------------
globals[15] = function(id,original,modified,injected,blocked)
    
    if id == 0x03c then
        local p     = packets.parse("incoming", original)
        local pad   = original:sub(7,8):unpack("H")
        local count = original:sub(5,6):unpack("H")
        local zone  = res.zones[windower.ffxi.get_info().zone] or false
        
        if commands["guilds"].getStatus() == "Woodworking" then
            return original:sub(1,8):append(helpers["guilds"].unlockWoodworking(original))
            
        elseif commands["guilds"].getStatus() == "Smithing" then
            return original:sub(1,8):append(helpers["guilds"].unlockSmithing(original))
            
        elseif commands["guilds"].getStatus() == "Bonecraft" then
            return original:sub(1,8):append(helpers["guilds"].unlockBonecraft(original))
            
        elseif commands["guilds"].getStatus() == "Alchemy" then            
            return original:sub(1,8):append(helpers["guilds"].unlockAlchemy(original))
            
        elseif commands["guilds"].getStatus() == "Goldsmithing" then
            return original:sub(1,8):append(helpers["guilds"].unlockGoldsmithing(original))
            
        elseif commands["guilds"].getStatus() == "Leathercraft" then
            return original:sub(1,8):append(helpers["guilds"].unlockLeathercraft(original))
            
        elseif commands["guilds"].getStatus() == "Clothcraft" then
            return original:sub(1,8):append(helpers["guilds"].unlockClothcraft(original))
            
        elseif commands["guilds"].getStatus() == "Cooking" then
            return original:sub(1,8):append(helpers["guilds"].unlockCooking(original))
        
        elseif zone and helpers["shops"].getShopName() and zone.en == "Mog Garden" and not injected then
            helpers["shops"].build(original, 13, true)
            return true
        
        elseif helpers["shops"].getShopName() then
            local new_data = (original:sub(1,8)..helpers["shops"].unlock(original))
            helpers["shops"].reset()
            return new_data
        
        else
            return original
        
        end
        
    end
    
end

--------------------------------------------------------------------------------
-- Menu Parameters Update.
--------------------------------------------------------------------------------
globals[16] = function(id,original,modified,injected,blocked)
    
    if id == 0x05c then
        local menus = commands["menus"].settings().toggle
        local name  = commands["menus"].getNPC()
        
        if menus then
            local p = packets.parse("incoming", original)
            local menu = { original:sub(5,36):unpack("C32") }

            -- Escha NPCs.
            if (name == "Affi" or name == "Dremi" or name == "Shiftrix") then
                local unpacked = { original:sub(9,40):unpack("C32") }
                local packed   = {}
                
                for i,v in ipairs(unpacked) do
                    
                    if (i < 2 or i > 32) then
                        packed[i] = ("C"):pack(unpacked[i])
                    else
                        packed[i] = ("C"):pack(1)
                    end
                    
                end
                return original:sub(1,4)..table.concat(packed,"")
            
            -- HTBF.
            elseif name and (name == "Raving Opossum" or name == "Trisvain" or name == "Mimble-Pimble") then
                local menus1 = bpcore:adjustNPCMenu(original:sub(1,9),   9,  9, 255)
                local menus2 = bpcore:adjustNPCMenu(original:sub(10,10), 1,  1, 255)
                local menus3 = bpcore:adjustNPCMenu(original:sub(11,36), 26, 1, 255)
                
                return menus1..menus2..menus3
                
            elseif name and (name):match("Home Point") then
                local menus1 = bpcore:adjustNPCMenu(original:sub(1,9),   9,  9, 0)
                local menus2 = bpcore:adjustNPCMenu(original:sub(10,10), 1,  1, 0)
                local menus3 = bpcore:adjustNPCMenu(original:sub(11,11), 1,  1, 0)
                local menus4 = bpcore:adjustNPCMenu(original:sub(12,12), 1,  1, 0)
                local menus5 = bpcore:adjustNPCMenu(original:sub(13,13), 1,  1, 0)
                local menus6 = bpcore:adjustNPCMenu(original:sub(14,14), 1,  1, 0)
                local menus7 = bpcore:adjustNPCMenu(original:sub(15,15), 1,  1, 0)
                local menus8 = bpcore:adjustNPCMenu(original:sub(16,36), 21, 1, 0)
                
                return menus1..menus2..menus3..menus4..menus5..menus6..menus7..menus8
            
            end
        
        end
    
    end
    
end

--------------------------------------------------------------------------------
-- Zone Update.
--------------------------------------------------------------------------------
globals[17] = function(id,original,modified,injected,blocked)
    
    if id == 0x00a then
        return original:sub(1,28)..("C"):pack(helpers["speed"].getSpeed())..original:sub(30)
    
    end
    
end

--------------------------------------------------------------------------------
-- Pet Update.
--------------------------------------------------------------------------------
globals[18] = function(id,original,modified,injected,blocked)
    
    if id == 0x068 then
        local player = windower.ffxi.get_player()
        local p      = packets.parse("incoming", original)
        
        if player.main_job == "SMN" and p["Pet Index"] == 0 then
            system["Core"].handleWindow(true)
            
        elseif player.main_job == "SMN" and p["Pet Index"] ~= 0 then
            system["Core"].handleWindow(false)
        
        end
    
    end
    
end

--------------------------------------------------------------------------------
-- Found Item.
--------------------------------------------------------------------------------
globals[19] = function(id,original,modified,injected,blocked)
    
    if id == 0x0d2 then
        local item = original:unpack("H", 0x10+1) or false

        if item then
            
        
        end
    
    end
    
end

--------------------------------------------------------------------------------
-- Item Synthesis.
--------------------------------------------------------------------------------
globals[20] = function(id,original,modified,injected,blocked)
    
    if id == 0x030 and helpers["fastcraft"].getToggle() then
        local id        = original:unpack("I", 0x04+1) or false
        local index     = original:unpack("H", 0x08+1) or false
        local effect    = original:unpack("H", 0x0a+1) or false
        local param     = original:unpack("C", 0x0c+1) or false
        local animation = original:unpack("C", 0x0d+1) or false
        local wut       = original:unpack("C", 0x0e+1) or false
        
        if id and index and effect and param and animation and animation == 44 and param ~= 1 and id == windower.ffxi.get_mob_by_target("me").id then
            local packet  = original:sub(1,4)..("I"):pack(id)..("H"):pack(index)..("H"):pack(effect)..("C"):pack(param)..("C"):pack(animation)..("C"):pack(120)
            system["Fast Synth"] = true
            system["Synth Quality"] = param
            --print(packet:unpack("C", 0x0e+1))
            return packet
        
        elseif id == windower.ffxi.get_mob_by_target("me").id then
            return original
        
        else
            return original
        
        end

    end
    
end

--------------------------------------------------------------------------------
-- Synth Result.
--------------------------------------------------------------------------------
globals[21] = function(id,original,modified,injected,blocked)
    
    if id == 0x06f then
        local inject  = "Ibbbbbbbb":pack(0, 0, 0, 0, 0, 0, 0, 0, 0)
        local result  = original:unpack("C", 0x04+1)
        local count   = original:unpack("C", 0x06+1)
        local _junk1  = original:unpack("C", 0x07+1)
        local item    = original:unpack("H", 0x08+1)
        local crystal = original:unpack("H", 0x22+1)
        local lost1,  lost2,  lost3,  lost4  = original:unpack("H", 0x0a+1), original:unpack("H", 0x0c+1), original:unpack("H", 0x0e+1), original:unpack("H", 0x10+1)
        local lost5,  lost6,  lost7,  lost8  = original:unpack("H", 0x12+1), original:unpack("H", 0x14+1), original:unpack("H", 0x16+1), original:unpack("H", 0x18+1)
        local skill1, skill2, skill3, skill4 = original:unpack("C", 0x1a+1), original:unpack("C", 0x1b+1), original:unpack("C", 0x1c+1), original:unpack("C", 0x1d+1)
        local up1,    up2,    up3,    up4    = original:unpack("C", 0x1e+1), original:unpack("C", 0x1f+1), original:unpack("C", 0x20+1), original:unpack("C", 0x21+1)
        local extra   = original:sub(37)
        local quality
        local success
        
        if system["Synth Quality"] == 0 then
            quality, success = 0, 0
        elseif system["Synth Quality"] == 2 then
            quality, success = 2, 0
        else
            quality, success = -1, 1
        end
        
        if system["Fast Synth"] and system["Finish Synth"] then
            
            if item and res.items[item] then
                helpers["popchat"]:pop(string.format("You successfully synthesized a %s", res.items[item].name), system["Popchat Window"])
            
                if result == 14 then
                    local packed = ("iCCCCHHHHHHHHHCCCCCCCCH"):pack(0x00006f08, success, quality, count, _junk1, item, lost1, lost2, lost3, lost4, lost5, lost6, lost7, lost8, skill1, skill2, skill3, skill4, up1, up2, up3, up4, crystal):append(extra)
                    
                    windower.packets.inject_incoming(0x6f, packed)
                    system["Finish Synth"] = false
                    system["Fast Synth"] = false
                    
                end 
            
            end
            
        else
            return original
            
        end
        return true
        
    end

end

--------------------------------------------------------------------------------
-- String Message.
--------------------------------------------------------------------------------
globals[22] = function(id,original,modified,injected,blocked)
    
    if id == 0x027 then
    end

end

--------------------------------------------------------------------------------
-- Action Message.
--------------------------------------------------------------------------------
globals[23] = function(id,original,modified,injected,blocked)
    
    if id == 0x029 then
        helpers["status"].messages(original)
    end

end

--------------------------------------------------------------------------------
-- Server Message.
--------------------------------------------------------------------------------
globals[24] = function(id,original,modified,injected,blocked)
    
    if id == 0x04d then
    end

end

--------------------------------------------------------------------------------
-- Server Message.
--------------------------------------------------------------------------------
globals[25] = function(id,original,modified,injected,blocked)
    
    if id == 0x04b then
    end

end

--------------------------------------------------------------------------------
-- Resting Message.
--------------------------------------------------------------------------------
globals[26] = function(id,original,modified,injected,blocked)
    
    if id == 0x02a then
        local player   = original:unpack("I", 0x04+1)
        local param1   = original:unpack("I", 0x08+1)
        local param2   = original:unpack("I", 0x0C+1)
        local param3   = original:unpack("I", 0x10+1)
        local param4   = original:unpack("I", 0x14+1)
        local message  = original:unpack("b16", 0x1A+1)
        local messages = {
            
            [39156] = "You found an item!",
            [40027] = string.format("You can still gather %s more times.", param1),
            [40028] = "You didn't find anything...",
            [40029] = "You're tool broke!",
            [40031] = string.format("You found an item! You can still gather %s more times.", param1),
            [40291] = "You're out of range!",            
            
        }
        
    end

end

--------------------------------------------------------------------------------
-- NPC Message.
--------------------------------------------------------------------------------
globals[27] = function(id,original,modified,injected,blocked)
    
    if id == 0x036 then
        local actor    = original:unpack("I", 0x04+1)
        local message  = original:unpack("b15", 0x0A+1)
        
    end

end

--------------------------------------------------------------------------------
-- Item Updates.
--------------------------------------------------------------------------------
globals[28] = function(id,original,modified,injected,blocked)
    
    if id == 0x020 then
        local item = original:unpack("H", 0x0C+1)
        --print(res.items[item].en)
    end

end

--------------------------------------------------------------------------------
-- Bazaar Listings.
--------------------------------------------------------------------------------
globals[29] = function(id,original,modified,injected,blocked)
    
    if id == 0x105 then
        
        if helpers["discord"] ~= nil then
            helpers["discord"].add(original)
        end
        
    end

end

--------------------------------------------------------------------------------
-- Bazaar Item Purchased.
--------------------------------------------------------------------------------
globals[30] = function(id,original,modified,injected,blocked)
    
    if id == 0x10a then
        
        if helpers["discord"] ~= nil then
            helpers["discord"].remove(original)
        end
        
    end

end

--------------------------------------------------------------------------------
-- Knock Back Blocker.
--------------------------------------------------------------------------------
globals[31] = function(id,original,modified,injected,blocked)
    
    if id == 0x028 then
        local bits    = helpers["bits"]
        local data    = bits.unpack(0x00, (original:length()*8), original)
        local actor   = data:sub(40, 71):reverse()
        local stagger = data:sub(208, 215):reverse()
        local block   = ""
        
        for i=1, stagger:length() do
            if i < 2 then
                block = (block..0)
            else
                block = (block..stagger:sub(i,i))
            end
        end
        --return original:sub(1,26)..("b8"):pack(bits.tonumber(block:reverse()))..original:sub(28)
    
    end
    
end

return globals