_addon.name     = "buddypal"
_addon.author   = "Elidyr"
_addon.version  = "0.20200618 Beta"
_addon.command  = "bp"

--Bootstrap all the system files.
require("bp/bootstrap")
bpBootstrap()

-- Build BP Names resources.
MA, JA, IT, WS = bpcore:buildResources()

--Initialize all the addon settings.
system     = settings:initializeSettings()
timestamps = bpcore:handleSettings("bp/settings/timestamps/"..windower.ffxi.get_player().name, {})
commands   = bpcore:initializeCommands(system["Commands"])
helpers    = bpcore:initializeHelpers(system["Helpers"])

-- Get CORE functions for current job.
if windower.ffxi.get_player() then
    system["Core"] = require(string.format("bp/core/%s/%score", (windower.ffxi.get_player().main_job):lower(), (windower.ffxi.get_player().main_job):lower()))
end

-- Register System Events.
bpcore:initializeEvents(system["Events"])
helpers["events"].registerGlobals()

-- Build System Windows.
system["Queue Window"]   = helpers["queue"].createWindow()
system["Popchat Window"] = helpers["popchat"]:build()

-- Register all the keybinds and aliases.
helpers["keybinds"].register()
helpers["alias"].register()

--Autoload all my extra addons.
for _,v in ipairs(system["Addons"]) do
    windower.send_command(string.format("lua load %s", v))
end

--Commands Handler.
windower.register_event("addon command", function(...)
    
    local a = T{...}
    local c = a[1] or false
    
    if c then
        local c = c:lower()
    
        if commands[c] then
            commands[c].execute(a)
            
        elseif c == "mw" and helpers["megawarp"] ~= nil then
            commands["megawarp"].execute(a)
            
        elseif c == ">" and helpers["orders"] ~= nil then
            commands["orders"].execute(a)

        elseif c == "stew" then
            helpers["actions"].buyItem(41, 1)
        
        elseif c then
            system["Core"].handleCommands(a)
        
        end
    
    end
    
end)