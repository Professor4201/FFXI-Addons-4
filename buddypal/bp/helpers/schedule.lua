--------------------------------------------------------------------------------
-- Schedule helper: Handles the scheduling and maintenance of all events.
--------------------------------------------------------------------------------
local schedule = {}

-- Create schedule object.
function schedule.new()
    local self = {}
    
    -- Private Variables
    local schedules = bpcore:handleSettings("/bp/settings/schedule/"..windower.ffxi.get_player().name, {})
    local timestamp = bpcore:currentStamp()
    
    self.checkSchedule = function()
        local enabled = commands["schedule"].settings().toggle
        
        if next(helpers["events"]:getCurrentRegistered()) == nil and enabled then
            local player = windower.ffxi.get_player()
            local imps   = helpers["currencies"].getCurrency("Imps")
            
            if imps > 2 and helpers["coalitions"].getRepeating() and helpers["schedule"].getAvailable(helpers["coalitions"].getCoalition(), "minute", 1) then
                --helpers["schedule"].scheduleEvent(commands["coalitions"].getCoalition(), "Legend")

            elseif helpers["schedule"].getAvailable("Domain Invasion", "Day", 1) then
                
                --if player.main_job_level == 99 then
                    --helpers["schedule"].scheduleEvent("Domain Invasion", "AziDahaka")
                --end
                
            end
        
        end
        
    end
    
    -- Check schedule to see if an event is available.
    self.getAvailable = function(sequence, time_type, time_passed)
        local sequence, time_type, time_passed = sequence or false, time_type or false, time_passed or false
        local schedules = schedules or false

        if sequence and time_type and time_passed and timestamps and schedules then
            local new_timestamp = false
            
            -- Build a new timestamp if needed.
            if not timestamps[sequence] then
                bpcore:stamp(sequence)
                new_timestamp = true
            
            end
            
            -- Build a new schedule if needed.
            if not schedules[sequence] then
                schedules[sequence] = {count=0,max=10,total=0}
                bpcore:writeSettings("/bp/settings/schedule/"..windower.ffxi.get_player().name, schedules)

            end
            
            -- Build timestamp table.
            local stamp = timestamps[sequence]
            
            if (schedules[sequence].count <= schedules[sequence].max and stamp and bpcore:checkTimestamp(sequence, "minute", 1)) or schedules[sequence].max == 0 or new_timestamp then
                
                if bpcore:checkTimestamp(sequence, "day", 1) then
                    helpers["schedule"].resetEvent(sequence)
                end
                return true
    
            elseif schedules[sequence].count > schedules[sequence].max then
                
                if not stamp or ( stamp and bpcore:checkTimestamp(sequence, time_type, time_passed) ) then
                    helpers["schedule"].resetEvent(sequence)
                    return true
                end
            
            end
        
        end
        return false
        
    end
    
    self.scheduleEvent = function(sequence, event)
        local sequence, event= sequence or false, event or false
        local player   = windower.ffxi.get_player() or false
        
        if sequence and event and player then
            helpers["events"].register(sequence, event)
            bpcore:stamp(sequence)
            bpcore:writeSettings( ("/bp/settings/schedule/"..player.name), schedules)
            
        end
        return false
    
    end
    
    self.resetEvent = function(sequence)
        local sequence = sequence or false
        local player   = windower.ffxi.get_player() or false
        
        if sequence and player and schedules[sequence] then
            schedules[sequence].count = 0
            bpcore:writeSettings( ("/bp/settings/schedule/"..player.name), schedules)
        
        end
        return false
    
    end
    
    self.updateStats = function(sequence)
        
        if schedules[sequence] then
            schedules[sequence].count = schedules[sequence].count + 1
            schedules[sequence].total = schedules[sequence].total + 1
            bpcore:writeSettings("/bp/settings/schedule/"..windower.ffxi.get_player().name, schedules)
            
        else
            schedules[sequence] = {count=1,max=10,total=1}
            bpcore:writeSettings("/bp/settings/schedule/"..windower.ffxi.get_player().name, schedules)
            
        end
    
    end
    
    self.getSchedule = function()
        return bpcore:handleSettings("/bp/settings/schedule/"..windower.ffxi.get_player().name, {})
    
    end
    return self
    
end

return schedule.new()