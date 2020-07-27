--------------------------------------------------------------------------------
-- Queue helper: Handles all event queues for the addon.
--------------------------------------------------------------------------------
local queue = {}

-- Create event object.
function queue.new()
    local self = {}
    
    local bpq                    = Q{}
    local winQueue               = {}
        winQueue["Position"]     = {["x"]=500,["y"]=75}
        winQueue["BG"]           = {["alpha"]=200,["r"]=000,["g"]=000,["b"]=000}
        winQueue["Flags"]        = {['right']=false,['bottom']=false,['bold']=false,['draggable']=false,['italic']=false}
        winQueue["Padding"]      = 5
        winQueue["Text"]         = {['size']=8,['font']='lucida console',['alpha']=255,['r']=245,['g']=200,['b']=020}
        winQueue["Stroke"]       = {['width']=001,['alpha']=255,['r']=0,['g']=0,['b']=0}
    
    local protection             = os.clock()
    local add_protection         = os.clock()
    local last_action            = {id=0}
    local last_target            = {id=0}
    local max_attempts           = 10
    local attempts               = 0
    
    --------------------------------------------------------------------------------
    -- Create the Queue Window.
    --------------------------------------------------------------------------------
    self.createWindow = function(settings)
        local settings = settings or {
            ['pos']={['x']=winQueue["Position"]["x"],['y']=winQueue["Position"]["y"]},
            ['bg']={['alpha']=winQueue["BG"]["alpha"],['red']=winQueue["BG"]["r"],['green']=winQueue["BG"]["g"],['blue']=winQueue["BG"]["b"],['visible']=false},
            ['flags']={['right']=winQueue["Flags"]["right"],['bottom']=winQueue["Flags"]["bottom"],['bold']=winQueue["Flags"]["bold"],['draggable']=winQueue["Flags"]["draggable"],['italic']=winQueue["Flags"]["italic"]},
            ['padding']=winQueue["Padding"],
            ['text']={['size']=winQueue["Text"]["size"],['font']=winQueue["Text"]["font"],['fonts']={},['alpha']=winQueue["Text"]["alpha"],['red']=winQueue["Text"]["r"],['green']=winQueue["Text"]["g"],['blue']=winQueue["Text"]["b"],
                ['stroke']={['width']=winQueue["Stroke"]["width"],['alpha']=winQueue["Stroke"]["alpha"],['red']=winQueue["Stroke"]["r"],['green']=winQueue["Stroke"]["g"],['blue']=winQueue["Stroke"]["b"]}
            },
        }
        
        local w = texts.new("", settings, settings)
              w:visible(false)
              w:bg_visible(false)
              w:update(w, settings)
        
        return w
    
    end
    
    --------------------------------------------------------------------------------
    -- Show the Queue Window.
    --------------------------------------------------------------------------------
    self.show = function()
        system["Queue Window"]:bg_visible(true)
        system["Queue Window"]:bg_alpha(winQueue["BG"]["alpha"])
        system["Queue Window"]:show()
    end
    
    --------------------------------------------------------------------------------
    -- Hide the Queue Window.
    --------------------------------------------------------------------------------
    self.hide = function()
        system["Queue Window"]:bg_visible(false)
        system["Queue Window"]:bg_alpha(winQueue["BG"]["alpha"])
        system["Queue Window"]:hide()
    end
    
    --------------------------------------------------------------------------------
    -- Update the event window.
    --------------------------------------------------------------------------------
    self.update = function(window)
        local max = system["Queue Max Visible"]
        local contents = {}
        local text = (" ":lpad(" ", 20) .. "[ Action Queue ]" .. " ":rpad(" ", 20))
        
        if bpq:length() == 0 and window:visible() == true then
            text = ""
            helpers["queue"]:hide(window)
            
        elseif bpq:length() > 0 then
            
            for i,v in ipairs(bpq.data) do
                
                if i < max + 1 then
                    
                    if v.action and v.target and v.priority then
                        
                        local name     = tostring(v.action.en):sub(1,20)
                        local attempts = tostring(v.attempts)
                        local act_type = helpers["queue"].getType(v.action):sub(1,3)
                        local target
                        local mp_cost
                        local element
                        
                        if v.action.mp_cost and v.action.element then
                            mp_cost = tostring(v.action.mp_cost)
                            element = tostring(res.elements[v.action.element].en):sub(1,7)
                        else
                            mp_cost = "0"
                            element = "None"
                        end

                        if type(v.target) == "string" or type(v.target) == "number" then
                            target = tostring(v.target.name):sub(1,15)
                            
                        elseif type(v.target) == "table" then
                            target = tostring(v.target.name):sub(1,15)
                            
                        end
                        
                        text = text .. 
                            ("\n<\\cs(255,255,255)" .. attempts .. "\\cr>":rpad(" ", 7-attempts:len())) ..  -- Priority
                            ("{\\cs(255,102,204)"   .. act_type .. "\\cr}":rpad(" ", 8-act_type:len())) ..  -- Action Type
                            ("[\\cs(000,204,255)"   .. element  .. "\\cr]":rpad(" ", 12-element:len())) ..  -- Element
                            ("(\\cs(000,153,204)"   .. mp_cost  .. "\\cr)":rpad(" ", 8-mp_cost:len()))  ..  -- MP Cost
                            ("\\cs(000,153,204)"    .. name     .. "\\cr":rpad("-",  24-name:len()))    ..  -- Action Name
                            ("►\\cs(102,225,051) "  .. target   .. "\\cr")                                  -- Target
                    end
                
                end
                
            end
            
            window:text(text)
            window:bg_visible(true)
            window:bg_alpha(winQueue["BG"]["alpha"])
            window:update()
            window:show()
            
        end
    
    end
    
    --------------------------------------------------------------------------------
    -- Add an action to the front of the queue.
    --------------------------------------------------------------------------------
    self.addToFront = function(action, target, priority)
        local player      = windower.ffxi.get_player() or false
        local action_type = helpers["queue"].getType(action)
        local priority    = priority or 0
        local new_target
        
        if (player.status == 0 or player.status == 1) and not helpers["actions"].getMoving() then
            
            if type(target) == "string" then
                local types = T{"t","bt","st","me","ft","ht"}
                
                if types:contains(target) and windower.ffxi.get_mob_by_target(target) then
                    new_target = windower.ffxi.get_mob_by_target(target)
                    
                elseif windower.ffxi.get_mob_by_name(target) then
                    new_target = windower.ffxi.get_mob_by_name(target)
                
                end
            
            elseif type(target) == "number" then
                
                if windower.ffxi.get_mob_by_id(target) then
                    new_target = windower.ffxi.get_mob_by_id(target)
                end
            
            elseif type(target) == "table" then
                
                if target.id then
                
                    if windower.ffxi.get_mob_by_id(target.id) then
                        new_target = windower.ffxi.get_mob_by_id(target.id)
                    end
                
                end
                
            end
            
            if new_target then
                local ranges   = helpers["actions"].getRanges()
                local distance = (new_target.distance):sqrt()
                
                -- Convert to self target.
                if helpers["target"].onlySelf(action) and new_target.id ~= player.id then
                    new_target = windower.ffxi.get_mob_by_target("me")
                end
                
                if action_type == "JobAbility" then
                    
                    if bpcore:canAct() and not helpers["queue"].inQueue(action, new_target) and bpcore:isJAReady(JA[action.en].recast_id) then
                        
                        if action.prefix == "/pet" then
                            local pet = windower.ffxi.get_mob_by_target("pet") or false
                            
                            if pet and (distance-pet.distance:sqrt()) < (ranges[action.range]+new_target.model_size) and not helpers["queue"].typeInQueue(action) and player["vitals"].mp >= action.mp_cost then
                                bpq:insert(1, {action=action, target=new_target, priority=priority, attempts=0})
                            end
                            
                        else
                            
                            if distance < (ranges[action.range]+new_target.model_size) and player["vitals"].mp >= action.mp_cost then
                                bpq:insert(1, {action=action, target=new_target, priority=priority, attempts=0})
                            end
                            
                        end
                        
                    end
                    
                elseif action_type == "Magic" then
                    
                    if bpcore:canCast() and not helpers["queue"].inQueue(action, new_target) and bpcore:isMAReady(MA[action.en].recast_id) and player["vitals"].mp > action.mp_cost then
                        
                        if distance < ((ranges[action.range]+new_target.model_size) + 2) then
                            
                            if action.prefix == "/song" and new_target.id ~= player.id then
                                
                                if (("Requiem"):match(action.en) == nil or ("Nocturne"):match(action.en) == nil or ("FInale"):match(action.en) == nil) and bpcore:isJAReady(JA["Pianissimo"].recast_id) and bpcore:getAvailable("JA", "Pianissimo") then
                                    bpq:insert(1, {action=JA["Pianissimo"], target=windower.ffxi.get_mob_by_target("me"), priority=priority, attempts=0})
                                    bpq:insert(1, {action=action, target=new_target, priority=priority, attempts=0})
                                    
                                else
                                    bpq:insert(1, {action=action, target=new_target, priority=priority, attempts=0})
                                    
                                end
                                
                            elseif action.prefix == "/song" and new_target.id == player.id then
                                bpq:insert(1, {action=action, target=new_target, priority=priority, attempts=0})
                            
                            elseif player["vitals"].mp >= action.mp_cost then
                                bpq:insert(1, {action=action, target=new_target, priority=priority, attempts=0})                                
                            end

                        end
                        
                    end
                    
                elseif action_type == "WeaponSkill" then
                    
                    if bpcore:canAct() and not helpers["queue"].inQueue(action, new_target) and not helpers["queue"].wsInQueue(action) and player["vitals"].tp > 1000 then
                        
                        if distance < (ranges[action.range]+new_target.model_size) then
                            bpq:insert(1, {action=action, target=new_target, priority=priority, attempts=0})                    
                        end    
                        
                    end
                    
                elseif action_type == "Item" then
                    
                    if bpcore:canItem() and not helpers["queue"].inQueue(action, new_target) then
                        
                        if (bpcore:findItemByName(action.en, 0) or bpcore:findItemByName(action.en, 8) or bpcore:findItemByName(action.en, 10) or bpcore:findItemByName(action.en, 11) or bpcore:findItemByName(action.en, 12)) then
                            bpq:insert(1, {action=action, target=new_target, priority=priority, attempts=0})
                        end
                        
                    end
                    
                elseif action_type == "Ranged" then
                    
                    if bpcore:canAct() and not helpers["queue"].inQueue({id=65536,en="Ranged",prefix="/ra",type="Ranged", range=14}, new_target) then
                        
                        if distance < (ranges[action.range]+new_target.model_size) then
                            bpq:insert(1, {action={id=65536,en="Ranged",element=-1,prefix="/ra",type="Ranged", range=14}, target=new_target, priority=priority, attempts=0})
                        end
                        
                    end
                    
                end
            
            end
            
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Add an action to the end queue.
    --------------------------------------------------------------------------------
    self.add = function(action, target, priority)
        local player      = windower.ffxi.get_player() or false
        local action_type = helpers["queue"].getType(action)
        local priority    = priority or 0
        local new_target
        
        if (player.status == 0 or player.status == 1) then
            
            if type(target) == "string" and action_type ~= "Movement" then
                local types = T{"t","bt","st","me","ft","ht"}
                
                if types:contains(target) and windower.ffxi.get_mob_by_target(target) then
                    new_target = windower.ffxi.get_mob_by_target(target)
                    
                elseif windower.ffxi.get_mob_by_name(target) then
                    new_target = windower.ffxi.get_mob_by_name(target)
                
                end
            
            elseif type(target) == "number" and action_type ~= "Movement" then
            
                if windower.ffxi.get_mob_by_id(target) then
                    new_target = windower.ffxi.get_mob_by_id(target)
                
                else
                    new_target = target
                end
            
            elseif type(target) == "table" and action_type ~= "Movement" then
                
                if target.id then
                
                    if windower.ffxi.get_mob_by_id(target.id) then
                        new_target = windower.ffxi.get_mob_by_id(target.id)
                    end
                
                end
                
            end
            
            if new_target and not helpers["actions"].getMoving() then
                local ranges   = helpers["actions"].getRanges()
                local distance = (new_target.distance):sqrt()
                
                -- Convert to self target.
                if helpers["target"].onlySelf(action) and new_target.id ~= player.id and action_type ~= "Movement" then
                    new_target = windower.ffxi.get_mob_by_target("me")
                end
                
                if action_type == "JobAbility" then

                    if bpcore:canAct() and not helpers["queue"].inQueue(action, new_target) and bpcore:isJAReady(JA[action.en].recast_id) then
                        
                        if action.prefix == "/pet" then
                            local pet = windower.ffxi.get_mob_by_target("pet") or false
                            
                            if pet and (distance-pet.distance:sqrt()) < (ranges[action.range]+new_target.model_size) and not helpers["queue"].typeInQueue(action) and player["vitals"].mp >= action.mp_cost then
                                bpq:push({action=action, target=new_target, priority=priority, attempts=0})
                            end
                            
                        else
                            
                            if distance < (ranges[action.range]+new_target.model_size) and player["vitals"].mp >= action.mp_cost then
                                bpq:push({action=action, target=new_target, priority=priority, attempts=0})
                            end
                            
                        end
                        
                    end
                    
                elseif action_type == "Magic" then

                    if bpcore:canCast() and not helpers["queue"].inQueue(action, new_target) and player["vitals"].mp > action.mp_cost then
                        
                        if distance < ((ranges[action.range]+new_target.model_size) + 2) then
                            
                            if action.prefix == "/song" and new_target.id ~= player.id then
                                
                                if (("Requiem"):match(action.en) == nil or ("Nocturne"):match(action.en) == nil or ("Finale"):match(action.en) == nil) and bpcore:isJAReady(JA["Pianissimo"].recast_id) and bpcore:getAvailable("JA", "Pianissimo") then
                                    bpq:push({action=JA["Pianissimo"], target=windower.ffxi.get_mob_by_target("me"), priority=priority, attempts=0})
                                    bpq:push({action=action, target=new_target, priority=priority, attempts=0})
                                    
                                else
                                    bpq:push({action=action, target=new_target, priority=priority, attempts=0})
                                    
                                end
                                
                            elseif action.prefix == "/song" and new_target.id == player.id then
                                bpq:push({action=action, target=new_target, priority=priority, attempts=0})
                                
                            elseif player["vitals"].mp >= action.mp_cost then
                                bpq:push({action=action, target=new_target, priority=priority, attempts=0})
                                
                            end
                            
                        end
                        
                    end
                    
                elseif action_type == "WeaponSkill" then
                    
                    if bpcore:canAct() and not helpers["queue"].inQueue(action, new_target) and not helpers["queue"].wsInQueue(action) and player["vitals"].tp > 1000 then
                        
                        if distance < (ranges[action.range]+new_target.model_size) then
                            bpq:push({action=action, target=new_target, priority=priority, attempts=0})
                        end
                        
                    end
                    
                elseif action_type == "Item" then

                    if bpcore:canItem() and not helpers["queue"].inQueue(action, new_target) then
                        
                        if (bpcore:findItemByName(action.en, 0) or bpcore:findItemByName(action.en, 8) or bpcore:findItemByName(action.en, 10) or bpcore:findItemByName(action.en, 11) or bpcore:findItemByName(action.en, 12)) then
                            bpq:push({action=action, target=new_target, priority=priority, attempts=0})
                        end
                        
                    end
                    
                elseif action_type == "Ranged" then
                        
                    if bpcore:canAct() and not helpers["queue"].inQueue({id=65536,en="Ranged",prefix="/ra",type="Ranged", range=14}, new_target) then
                        
                        if distance < (ranges[action.range]+new_target.model_size) then
                            bpq:push({action={id=65536,en="Ranged",element=-1,prefix="/ra",type="Ranged", range=14}, target=new_target, priority=priority, attempts=0})
                        end
                        
                    end
                    
                end
            
            elseif action_type == "Movement" and target and target.name and target.x and target.y then
            
                --if bpcore:canMove() and not helpers["queue"].inQueue({id=65535,en="Movement",prefix="/move",type="Movement", range=255}, target) then
                if bpcore:canMove() then
                    bpq:push({action={id=65535,en="Movement",element=-1,prefix="/move",type="Movement", range=255}, target=target, priority=priority, attempts=0})                    
                end
                
            end
        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Remove an action to queue.
    --------------------------------------------------------------------------------
    self.remove = function(action, target)
        local action, target = action or false, target or false
        local data  = bpq.data
        local cures = T{1,2,3,4,5,6,7,8,9,10,11,549,645,578,593,711,581,690}
        local waltz = T{190,191,192,193,311,195,262}
        
        if action and target then
            
            for i,v in ipairs(data) do
                
                if type(v) == "table" and type(target) == "table" and v.action then
                    
                    if (cures):contains(action.id) and (cures):contains(v.action.id) and action.prefix == "/magic" then
                        bpq:remove(i)
                            
                    elseif (waltz):contains(action.id) and (waltz):contains(v.action.id) and action.prefix == "/jobability" then
                        bpq:remove(i)
                    
                    elseif v.action.id == action.id and action.en ~= "Pianissimo" then
                        
                        if v.action.type == "Weapon" then
                            bpq:remove(i)
                            
                        elseif v.action.type == action.type and v.action.en == action.en then
                            bpq:remove(i)
                            
                        end
                    
                    elseif action.en == "Pianissimo" then
                        bpq:remove(i)
                        break
                        
                    end
                    
                end
            
            end
            
        end
        return false
        
    end
    
    --------------------------------------------------------------------------------
    -- Determine if an action is already in queue.
    --------------------------------------------------------------------------------
    self.isInQueue = function(action)
        local data = bpq.data
        
        if action then
            
            for _,v in ipairs(data) do
                
                if type(v) == 'table' and v.action then
    
                    if v.action.id == action.id then
                        return true
                        
                    end
                    
                end
            
            end
            
        end
        return false
        
    end
    
    --------------------------------------------------------------------------------
    -- Clear the action queue.
    --------------------------------------------------------------------------------
    self.clear = function()
        bpq:clear()
        bpq = Q{}
        helpers["queue"].update(system["Queue Window"])
        
    end
    
    --------------------------------------------------------------------------------
    -- Handle the next action in the queue.
    --------------------------------------------------------------------------------
    self.handleQueue = function()
        
        if bpq:length() > 0 and (os.clock() - protection) > 1 then
            
            local player   = windower.ffxi.get_player() or false
            local action   = helpers["queue"].getNextAction()
            local target   = helpers["queue"].getNextTarget()
            local priorty  = helpers["queue"].getNextPriority()
            local attempts = helpers["queue"].getNextAttempts()
            local type     = helpers["queue"].getType(action)
            local ranges   = helpers["actions"].getRanges()
            
            if type == "JobAbility" then
                
                if bpcore:checkReady() and helpers["target"].exists(target) then
                    local mob      = windower.ffxi.get_mob_by_id(target.id)
                    local distance = mob.distance:sqrt()
                    
                    if helpers["queue"].getNextAttempts() == 15 then
                        helpers["queue"].remove(res.job_abilities[action.id], target)
                        
                    elseif not bpcore:canAct() or not bpcore:getAvailable("JA", action.en) or not bpcore:isJAReady(JA[action.en].recast_id) and action.en ~= "Pianissimo" then
                        helpers["queue"].remove(res.job_abilities[action.id], target)
                    
                    elseif action.prefix == "/pet" then
                        local pet = windower.ffxi.get_mob_by_target("pet") or false
                        
                        if action.type == "BloodPactRage" then
                            local distance = ((pet.distance):sqrt()-distance)
                            
                            if pet and distance < (ranges[action.range]+target.model_size) then
                                windower.send_command(string.format('input %s "%s" %s', action.prefix, action.en, target.id))
                                helpers["queue"].attempt()
                                
                            elseif pet and distance > (ranges[action.range]+target.model_size) then
                                helpers["queue"].remove(res.job_abilities[action.id], target)
                                
                            elseif not pet then
                                helpers["queue"].remove(res.job_abilities[action.id], target)
                                
                            end
                            
                        else
                        
                            if pet and distance < (ranges[action.range]+target.model_size) then
                                windower.send_command(string.format('input %s "%s" %s', action.prefix, action.en, target.id))
                                helpers["queue"].attempt()
                                
                            elseif pet and distance > (ranges[action.range]+target.model_size) then
                                helpers["queue"].remove(res.job_abilities[action.id], target)
                                
                            elseif not pet then
                                helpers["queue"].remove(res.job_abilities[action.id], target)
                                
                            end
                        
                        end
                        
                    else
                        
                        if distance < (ranges[action.range]+target.model_size) then
                            windower.send_command(string.format('input %s "%s" %s', action.prefix, action.en, target.id))
                            helpers["queue"].attempt()
                            
                        elseif distance > (ranges[action.range]+target.model_size) then
                            helpers["queue"].remove(res.job_abilities[action.id], target)
                            
                        end
                    
                    end
                    
                elseif not helpers["target"].exists(target) then
                    helpers["queue"].remove(action, target)
                    
                end
                
            elseif type == "Magic" then
                
                if bpcore:checkReady() and helpers["target"].exists(target) then
                    local mob      = windower.ffxi.get_mob_by_id(target.id)
                    local distance = mob.distance:sqrt()
                    
                    if helpers["queue"].getNextAttempts() == 15 then
                        helpers["queue"].remove(res.spells[action.id], target)
                        
                    elseif not bpcore:canCast() or not bpcore:getAvailable("MA", action.en) or not bpcore:isMAReady(MA[action.en].recast_id) then
                        helpers["queue"].remove(res.spells[action.id], target)
                    
                    elseif distance < (ranges[action.range]+target.model_size) then
                        windower.send_command(string.format('input %s "%s" %s', action.prefix, action.en, target.id))
                        helpers["queue"].attempt()
                    
                    elseif distance > (ranges[action.range]+target.model_size) then
                        helpers["queue"].remove(res.spells[action.id], target)
                        
                    end
                    
                elseif not helpers["target"].exists(target) then
                    helpers["queue"].remove(action, target)
                    
                end
                
            elseif type == "WeaponSkill" then
                
                if bpcore:checkReady() and helpers["target"].exists(target) then
                    local mob      = windower.ffxi.get_mob_by_id(target.id)
                    local distance = mob.distance:sqrt()
                    
                    
                    if helpers["queue"].getNextAttempts() == 15 then
                        helpers["queue"].remove(res.weapon_skills[action.id], target)
                        
                    elseif not bpcore:canAct() or not bpcore:getAvailable("WS", action.en) or player["vitals"].tp < 1000 then
                        helpers["queue"].remove(res.weapon_skills[action.id], target)
                    
                    elseif distance < (ranges[action.range]+target.model_size) then
                        windower.send_command(string.format('input %s "%s" %s', action.prefix, action.en, target.id))
                        helpers["queue"].attempt()
                        
                    elseif distance > (ranges[action.range]+target.model_size) then
                        helpers["queue"].remove(res.weapon_skills[action.id], target)
                        
                    end
                    
                elseif not helpers["target"].exists(target) then
                    helpers["queue"].remove(action, target)

                end
                
            elseif type == "Item" then
                
                if bpcore:checkReady() and helpers["target"].exists(target) then
                    local mob      = windower.ffxi.get_mob_by_id(target.id)
                    local distance = mob.distance:sqrt()
                
                    if helpers["queue"].getNextAttempts() == 15 then
                        helpers["queue"].remove(res.items[action.id], target)
                        
                    elseif not bpcore:canItem() or bpcore:buffActive(473) then
                        helpers["queue"].remove(res.items[action.id], target)
                    
                    else
                        windower.send_command(string.format('input /item "%s" %s', action.en, target.id))
                        helpers["queue"].attempt()
                        
                    end
                    
                elseif not helpers["target"].exists(target) then
                    helpers["queue"].remove(action, target)

                end
                
            elseif type == "Ranged" then
    
                if bpcore:checkReady() and bpcore:canAct() and helpers["target"].exists(target) then
                    local mob      = windower.ffxi.get_mob_by_id(target.id)
                    local distance = mob.distance:sqrt()
                    
                    if helpers["queue"].getNextAttempts() == 15 or system["Ranged"] == nil then
                        helpers["queue"].remove({id=65536,en="Ranged",element=-1,prefix="/ra",type="Ranged", range=14}, target)
                    
                    elseif distance < (ranges[action.range]+target.model_size) then
                        windower.send_command(string.format('input %s "%s" %s', action.prefix, action.en, target.id))
                        helpers["queue"].attempt()
                        
                    elseif distance > (ranges[action.range]+target.model_size) then
                        helpers["queue"].remove({id=65536,en="Ranged",element=-1,prefix="/ra",type="Ranged", range=14}, target)
                        
                    end
                    
                elseif not helpers["target"].exists(target) then
                    helpers["queue"].remove(action, target)
                    
                    
                end
            
            elseif type == "Movement" then
                
                if bpcore:canMove() and target.x ~= nil and target.y ~= nil then
                    helpers["actions"].move(target.x, target.y)
                    helpers["queue"].remove({id=65535,en="Movement",prefix="/move",type="Movement", range=255}, target)
                    
                end
            
            end
        
        end
        
    end
    
    --------------------------------------------------------------------------------
    -- Check if an action is already in the queue.
    --------------------------------------------------------------------------------
    self.inQueue = function(action, target)
        local action = action or false
        local target = target or false
        local data   = bpq.data
        
        if action and target and data then
            
            for _,v in ipairs(data) do
                
                if type(v) == "table" and type(action) == "table" and type(target) == "table" and v.action and v.target then
                    
                    if v.action.id == action.id and v.action.type == action.type and v.action.en == action.en and v.target.id == target.id then
                        return true
                    end
                    
                end
            
            end
            
        end
        return false
        
    end
    
    --------------------------------------------------------------------------------
    -- Check if a WeaponSkill is already in the queue.
    --------------------------------------------------------------------------------
    self.wsInQueue = function(action)
        local action = action or false
        local data   = bpq.data
        
        if action and data then
            
            for _,v in ipairs(data) do
                
                if type(v) == "table" and type(action) == "table" and v.action then
                    local prefix = v.action.prefix or ""
                    
                    if v.action.prefix == "/weaponskill" then
                        return true
                    end
                    
                end
            
            end
            
        end
        return false
        
    end
    
    --------------------------------------------------------------------------------
    -- See if the same Action Type is already in the queue.
    --------------------------------------------------------------------------------
    self.typeInQueue = function(action)
        local action = action or false
        local data   = bpq.data
        
        if action and data and action.type then
            
            for _,v in ipairs(data) do
                
                if type(v) == "table" and type(action) == "table" and v.action and v.action.type then
                    
                    if v.action.type == action.type then
                        return true
                    end
                    
                end
            
            end
            
        end
        return false
        
    end
    
    --------------------------------------------------------------------------------
    -- Check if an action is already in the queue.
    --------------------------------------------------------------------------------
    self.replace = function(action, target, name)
        local action_type = helpers["queue"].getType(action)
        local action = action or false
        local target = target or false
        local name   = name or ""
        local data   = bpq.data
        
        if action and target and data and name ~= "" then
            
            if #data > 0 then
            
                for i,v in ipairs(data) do
    
                    if type(v) == "table" and type(action) == "table" and type(target) == "table" and v.action and v.target then
    
                        if v.target.id == target.id and (name):match(v.action.en) and v.action.id ~= action.id then
                            local player   = windower.ffxi.get_player() or false
    
                            -- Convert to self target.
                            if player and helpers["target"].onlySelf(action) and target.id ~= player.id then
                                target = windower.ffxi.get_mob_by_target("me")
                            end
                            
                            if action_type == "JobAbility" then
                                helpers["queue"].remove(JA[v.action.en], target)
                                bpq:insert(i, {action=action, target=target, priority=0, attempts=0})
                                break
                                
                            elseif action_type == "Magic" then
                                helpers["queue"].remove(MA[v.action.en], target)
                                bpq:insert(i, {action=action, target=target, priority=0, attempts=0})
                                break
                                
                            elseif action_type == "WeaponSkill" then
                                helpers["queue"].remove(WS[v.action.en], target)
                                bpq:insert(i, {action=action, target=target, priority=0, attempts=0})
                                break
                                
                            end
                        
                        elseif v.target.id == target.id and not (name):match(v.action.en) and v.action.id ~= action.id then
                            local player = windower.ffxi.get_player() or false
                            
                            -- Convert to self target.
                            if player and helpers["target"].onlySelf(action) and target.id ~= player.id then
                                target = windower.ffxi.get_mob_by_target("me")
                            end
                            
                            -- Add new action.
                            helpers["queue"].add(action, target)
                            break
                        
                        end
                        
                    end
                
                end
            
            elseif #data == 0 then
                local player = windower.ffxi.get_player() or false
                    
                -- Convert to self target.
                if player and helpers["target"].onlySelf(action) and target.id ~= player.id then
                    target = windower.ffxi.get_mob_by_target("me")
                end
                
                -- Add new action.
                helpers["queue"].add(action, target)
                
            end
            
        end
        return false
        
    end
    
    --------------------------------------------------------------------------------
    -- Get a queued action.
    --------------------------------------------------------------------------------
    self.getQueued = function(action, target)
        local action = action or false
        local target = target or false
        local data   = bpq.data
        
        if action and target and data then
            
            for i,v in ipairs(data) do
                
                if type(v) == 'table' and v.action and v.target then
                    
                    if v.action.id == action.id and v.action.type == action.type and v.action.en == action.en and v.target.id == target.id then
                        return data[i]
                    end
                    
                end
            
            end
            
        end
        return false
        
    end
    
    --------------------------------------------------------------------------------
    -- Get the action type.
    --------------------------------------------------------------------------------
    self.getType = function(action)
        local action_type    = bpcore:getActionType(action)
        local spell_types    = T{"BlackMagic","WhiteMagic","BlueMagic","SummonerPact","Ninjutsu","BardSong","Geomancy","Trust"}
        local ability_types  = T{"JobAbility","PetCommand","CorsairRoll","CorsairShot","Samba","Waltz","Jig","Step","Flourish1","Flourish2","Flourish3","Scholar","Rune","Ward","Effusion","BloodPactWard","BloodPactRage","Monster"}
        local wskill_types   = "WeaponSkill"
        local item_type      = "Item"
        local ranged_type    = "Ranged"
        local movement       = "Movement"
        
        if ability_types:contains(action_type) then
            return "JobAbility"
            
        elseif spell_types:contains(action_type) then
            return "Magic"
            
        elseif action_type == wskill_types then
            return "WeaponSkill"
            
        elseif action_type == item_type then
            return "Item"
            
        elseif action_type == ranged_type then
            return "Ranged"
            
        elseif action_type == movement then
            return "Movement"
        
        end
        return false
        
    end
    
    --------------------------------------------------------------------------------
    -- Get queue table contents.
    --------------------------------------------------------------------------------
    self.getQueue = function()
        return bpq
    end
    
    --------------------------------------------------------------------------------
    -- Get next action queued.
    --------------------------------------------------------------------------------
    self.getNextAction = function()
        if bpq:length() > 0 then
            return bpq[1].action
        end
    end
    
    --------------------------------------------------------------------------------
    -- Get next target queued.
    --------------------------------------------------------------------------------
    self.getNextTarget = function()
        if bpq:length() > 0 then
            return bpq[1].target
        end
    end
    
    --------------------------------------------------------------------------------
    -- Get next priority queued.
    --------------------------------------------------------------------------------
    self.getNextPriority = function()
        if bpq:length() > 0 then
            return bpq[1].priority
        end
    end
    
    --------------------------------------------------------------------------------
    -- Get next action attempts.
    --------------------------------------------------------------------------------
    self.getNextAttempts = function()
        if bpq:length() > 0 then
            return bpq[1].attempts
        end
    end
    
    --------------------------------------------------------------------------------
    -- Increase attempts.
    --------------------------------------------------------------------------------
    self.attempt = function()
        if bpq:length() > 0 then
            bpq[1].attempts = (bpq[1].attempts + 1)
            protection      = os.clock()
            return helpers["queue"].getNextAttempts()
            
        end
        
    end       
    
    return self
    
end

return queue.new()