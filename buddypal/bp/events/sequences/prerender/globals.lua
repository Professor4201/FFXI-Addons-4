local globals = {}
    
--------------------------------------------------------------------------------
-- Update the Popchat Overlay.
--------------------------------------------------------------------------------
globals[1] = function()

    -- Handle Popchat display.
    if system["Popchat Window"]:visible() and os.clock()-system["Popchat Last"] > system["Popchat Check"] then
        system["Popchat Window"]:bg_alpha(system["Popchat Fade"])
        system["Popchat Fade"] = (system["Popchat Fade"]-system["Popchat Fader"])
        
        -- Fade out popchat.
        if system["Popchat Fade"] <= 0 then
            system["Popchat Window"]:hide()
        end
        system["Popchat Last"] = os.clock()
        
    end
    
end

--------------------------------------------------------------------------------
-- BP System Wide Pinger.
--------------------------------------------------------------------------------
globals[2] = function()
    
    -- Handle Core Display.
    helpers["actions"].setMoving()
    helpers["distance"].update()
    system["Core"].handleWindow()
    
    -- BP pinger sequence outside towns.
    if system["BP Enabled"]:current() and os.clock()-system["Last Ping"] > system["Ping Delay"] and not system["BP Allowed"][windower.ffxi.get_info().zone] and not system["Shutdown"][windower.ffxi.get_info().zone] and windower.ffxi.get_player() then
        
        -- Build Custom Party Tables.
        bpcore.buildPartyData()
        
        -- Update Curing Data, and Action Queue.
        helpers["cures"].buildData()
        helpers["queue"].update(system["Queue Window"])
        
        -- Update Globals.
        system["Info"]         = windower.ffxi.get_info()
        system["Player"]       = windower.ffxi.get_player()
        system["Buffs"].Player = windower.ffxi.get_player().buffs
        system["Recast"]       = {["Abilities"]=windower.ffxi.get_ability_recasts(), ["Spells"]=windower.ffxi.get_spell_recasts()}
        system["Zone"]         = {id=res['zones'][windower.ffxi.get_info().zone].id, name=res['zones'][windower.ffxi.get_info().zone].name}
        
        -- Update Missions helper.
        if helpers["missions"] ~= nil then
            helpers["missions"].update()
        end
        
        -- Update Currencies helper.
        if helpers["currencies"] ~= nil then
            helpers["currencies"].ping()
        end
        
        -- Update Target helper.
        if helpers["target"] ~= nil then
            helpers["target"].ping()
        end
        
        -- HELM Farming.
        if helpers["helm"] ~= nil and helpers["helm"].getToggle() then
            helpers["helm"].ping()
        end
        
        -- Handle CORE Automation.
        helpers["controls"].ping()
        helpers["trust"].ping()
        system["Core"].handleAutomation()
        
        -- Update ping.
        system["Last Ping"] = os.clock()
    
    -- BP pinger sequence inside towns.
    elseif system["BP Enabled"]:current() and os.clock()-system["Last Ping"] > system["Ping Delay"] and windower.ffxi.get_player() then
        
        -- Build Custom Party Tables.
        bpcore.buildPartyData()
        
        -- Update Action Queue.
        helpers["queue"].update(system["Queue Window"])
        
        -- Update Globals.
        system["Info"]         = windower.ffxi.get_info()
        system["Player"]       = windower.ffxi.get_player()
        system["Buffs"].Player = windower.ffxi.get_player().buffs
        system["Recast"]       = {["Abilities"]=windower.ffxi.get_ability_recasts(), ["Spells"]=windower.ffxi.get_spell_recasts()}
        system["Zone"]         = {id=res['zones'][windower.ffxi.get_info().zone].id, name=res['zones'][windower.ffxi.get_info().zone].name}
        
        if bpcore:checkReady() and not helpers["actions"].getMoving() then
            bpcore:useBaggedGoods()
        end
        
        -- Update Missions helper.
        if helpers["missions"] ~= nil then
            helpers["missions"].update()
        end
        
        -- Update Currencies helper.
        if helpers["currencies"] ~= nil then
            helpers["currencies"].ping()
        end
        
        -- Update Target helper.
        if helpers["target"] ~= nil then
            helpers["target"].ping()
        end
        
        -- Handle any actions allowed in the queue not related to CORE system.
        helpers["queue"].handleQueue()
        
        --[[
        if windower.ffxi.get_player() and windower.ffxi.get_player().name == "ffff" and windower.ffxi.get_player().status == 0 and system["HQ HACK"]:current() then
            helpers["popchat"]:pop(("ATTEMPTING HQ..."):upper(), system["Popchat Window"])
            helpers["actions"].synthItem(bpcore:findItemByName("Inferno Crystal"), 5,
                bpcore:findItemByName("Koh-I-Noor"),
                bpcore:findItemByName("Dark Matter"),
                bpcore:findItemByName("Dark Matter"),
                bpcore:findItemByName("Tartarian Chain"),
                bpcore:findItemByName("Tartarian Chain")
            )
        ]]--
        
        -- Update ping.
        system["Last Ping"] = os.clock()
    
    end
    
end

return globals