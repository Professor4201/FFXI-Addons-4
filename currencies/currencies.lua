_addon.name    = 'currencies'
_addon.author  = 'Elidyr'
_addon.version = '1.10162019'
_addon.command = 'cur'

-- Required libraries.
res     = require 'resources'
packets = require 'packets'
files   = require 'files'
texts   = require 'texts'
          require 'strings'
          require 'actions'
          require 'tables'
          require 'sets'
          require 'chat'
          require 'pack'
          require 'logger'
          require 'helpers'

-- Load settings from file.
if windower.ffxi.get_player() then 
    
    player           = windower.ffxi.get_player()
    setting_file     = files.new(player.name:lower() .. '_settings.lua')
        
        if not setting_file:exists() then
            windower.add_to_chat(2,'Creating new settings data...')
            settings = createBaseSettings()
            setting_file:write('return ' .. T(settings):tovstring())
        
        end
        
    settings = require(player.name:lower() .. '_settings')

end

-- Points Display.
points_window = {}

-- Variables for points.
currency = {
    
    ["Sparks"]           = 0,
    ["Accolades"]        = 0,
    ["Ichor"]            = 0,
    ["Tokens"]           = 0,
    ["Zeni"]             = 0,
    ["Plasm"]            = 0,
    ["Imps"]             = 0,
    ["Beads"]            = 0,
    ["Silt"]             = 0,
    ["Potpourri"]        = 0,
    ["Hallmarks"]        = 0,
    ["Gallantry"]        = 0,
    ["Crafter"]          = 0,
    ["Silver Vouchers"]  = 0,
    
}

--------------------------------------------------------------------------------
-- Command Handler.
--------------------------------------------------------------------------------
function handle_command(command, ...)
    
    local cmd       = (command) and (command):lower()
    local args      = {...}
    
    if cmd then
        
        if cmd == "visible" then
        
            if settings['Visible'] then
                points_window:hide()
                settings['Visible'] = false
                
            elseif not settings['Visible'] then
                points_window:show()
                settings["Visible"] = true
                
            end
            
            updateFile(setting_file, settings)
            
        elseif cmd == "sparks" then
            
            if settings["Sparks"] then
                settings["Sparks"] = false
            else
                settings["Sparks"] = true
            end
            
            updateFile(setting_file, settings)
            
        elseif cmd == "unity" then
            
            if settings["Accolades"] then
                settings["Accolades"] = false
            else
                settings["Accolades"] = true
            end
            
            updateFile(setting_file, settings)
            
        elseif cmd == "ichor" then
            
            if settings["Ichor"] then
                settings["Ichor"] = false
            else
                settings["Ichor"] = true
            end
            
            updateFile(setting_file, settings)
            
        elseif cmd == "tokens" then
            
            if settings["Tokens"] then
                settings["Tokens"] = false
            else
                settings["Tokens"] = true
            end
            
            updateFile(setting_file, settings)
            
        elseif cmd == "zeni" then
            
            if settings["Zeni"] then
                settings["Zeni"] = false
            else
                settings["Zeni"] = true
            end
            
            updateFile(setting_file, settings)
            
        elseif cmd == "plasm" then
            
            if settings["Plasm"] then
                settings["Plasm"] = false
            else
                settings["Plasm"] = true
            end
            
            updateFile(setting_file, settings)
            
        elseif cmd == "imps" then
            
            if settings["Imps"] then
                settings["Imps"] = false
            else
                settings["Imps"] = true
            end
            
            updateFile(setting_file, settings)
            
        elseif cmd == "beads" then
            
            if settings["Beads"] then
                settings["Beads"] = false
            else
                settings["Beads"] = true
            end
            
            updateFile(setting_file, settings)
            
        elseif cmd == "silt" then
            
            if settings["Silt"] then
                settings["Silt"] = false
            else
                settings["Silt"] = true
            end
            
            updateFile(setting_file, settings)
            
        elseif cmd == "potp" then
            
            if settings["Potpourri"] then
                settings["Potpourri"] = false
            else
                settings["Potpourri"] = true
            end
            
            updateFile(setting_file, settings)
            
        elseif cmd == "hallmark" then
            
            if settings["Hallmarks"] then
                settings["Hallmarks"] = false
            else
                settings["Hallmarks"] = true
            end
            
            updateFile(setting_file, settings)
            
        elseif cmd == "gallantry" then
            
            if settings["Gallantry"] then
                settings["Gallantry"] = false
            else
                settings["Gallantry"] = true
            end
            
            updateFile(setting_file, settings)
            
        elseif cmd == "crafter" then
            
            if settings["Crafter"] then
                settings["Crafter"] = false
            else
                settings["Crafter"] = true
            end
            
            updateFile(setting_file, settings)
            
        elseif cmd == "silver" then
            
            if settings["Silver Vouchers"] then
                settings["Silver Vouchers"] = false
            else
                settings["Silver Vouchers"] = true
            end

            updateFile(setting_file, settings)
            
        elseif cmd == "stroke" then
            
            if cmd and tonumber(args[1]) and tonumber(args[2]) and tonumber(args[3]) then
                
                -- Stroke - Color:Red
                if tonumber(args[1]) > 0 and tonumber(args[1]) < 256 then
                    settings['Window Settings']['text']['stroke']['red'] = tonumber(args[1])
                else
                    settings['Window Settings']['text']['stroke']['red'] = tonumber(0)
                    windower.add_to_chat(2, 'Stroke: Red format improper; defaulting to 0.')
                end
                
                -- Stroke - Color:Green
                if tonumber(args[2]) > 0 and tonumber(args[2]) < 256 then
                    settings['Window Settings']['text']['stroke']['green'] = tonumber(args[2])
                else
                    settings['Window Settings']['text']['stroke']['green'] = tonumber(0)
                    windower.add_to_chat(2, 'Stroke: Green format improper; defaulting to 0.')
                end
                
                -- Stroke - Color:Blue
                if tonumber(args[3]) > 0 and tonumber(args[3]) < 256 then
                    settings['Window Settings']['text']['stroke']['blue'] = tonumber(args[3])
                else
                    settings['Window Settings']['text']['stroke']['blue'] = tonumber(0)
                    windower.add_to_chat(2, 'Stroke: Blue format improper; defaulting to 0.')
                end
                
                local red   = settings['Window Settings']['text']['stroke']['red']
                local green = settings['Window Settings']['text']['stroke']['green']
                local blue  = settings['Window Settings']['text']['stroke']['blue']
                
                windower.add_to_chat(2, 'Stroke: Color now set to (' .. red .. ',' .. green .. ',' .. blue .. ')')
                
                points_window:stroke_color(red,green,blue)
                points_window:text(settings["Points String"])
                points_window:update()
                updateFile(setting_file, settings)
                
            else
                windower.add_to_chat(2, 'Proper format for Stroke color is: //crim stroke [1-255] [1-255] [1-255]')
                
            end            
            
        elseif cmd == "delay" then
            
            if cmd and tonumber(args[1]) and tonumber(args[1]) > 0 and tonumber(args[1]) < 11 and #cmd+#args[1] > 5 then
                settings['Ping Delay'] = tonumber(args[1])
                windower.add_to_chat(2, 'Message delay now set to ' .. settings['Ping Delay'] .. ' minutes.')
                updateFile(setting_file, settings)
                
            else
                windower.add_to_chat(2, 'Please enter the delay in minutes: 1-10!')
                
            end
            
        elseif cmd == "text" then

            if cmd and tonumber(args[1]) and tonumber(args[1]) > 0 and tonumber(args[1]) < 26 and #cmd+#args[1] > 4 then
                settings['Window Settings']['text']['size'] = tonumber(args[1])
                windower.add_to_chat(2, 'Font Size now set to ' .. settings['Window Settings']['text']['size'] .. '.')
                
                points_window:size(settings['Window Settings']['text']['size'])
                points_window:text(settings["Points String"])
                points_window:update()
                updateFile(setting_file, settings)
                
            else
                windower.add_to_chat(2, 'Please enter the delay in minutes: 1-25!')
                
            end
            
        elseif cmd == "color" then

            if cmd and tonumber(args[1]) and tonumber(args[2]) and tonumber(args[3]) then
                
                -- Font - Color:Red
                if tonumber(args[1]) > 0 and tonumber(args[1]) < 256 then
                    settings['Window Settings']['text']['red'] = tonumber(args[1])
                else
                    settings['Window Settings']['text']['red'] = tonumber(0)
                    windower.add_to_chat(2, 'Text: Red format improper; defaulting to 0.')
                end
                
                -- Font - Color:Green
                if tonumber(args[2]) > 0 and tonumber(args[2]) < 256 then
                    settings['Window Settings']['text']['green'] = tonumber(args[2])
                else
                    settings['Window Settings']['text']['green'] = tonumber(0)
                    windower.add_to_chat(2, 'Text: Green format improper; defaulting to 0.')
                end
                
                -- Font - Color:Blue
                if tonumber(args[3]) > 0 and tonumber(args[3]) < 256 then
                    settings['Window Settings']['text']['blue'] = tonumber(args[3])
                else
                    settings['Window Settings']['text']['blue'] = tonumber(0)
                    windower.add_to_chat(2, 'Text: Blue format improper; defaulting to 0.')
                end
                
                local red   = settings['Window Settings']['text']['red']
                local green = settings['Window Settings']['text']['green']
                local blue  = settings['Window Settings']['text']['blue']
                
                windower.add_to_chat(2, 'Text: Color now set to (' .. red .. ',' .. green .. ',' .. blue .. ')')
                
                points_window:color(red,green,blue)
                points_window:text(settings["Points String"])
                points_window:update()
                updateFile(setting_file, settings)
                
            else
                windower.add_to_chat(2, 'Proper format for font color is: //crim color [1-255] [1-255] [1-255]')
                
            end
            
        elseif cmd == "bg" then
            
            if cmd and tonumber(args[1]) and tonumber(args[2]) and tonumber(args[3]) then
                
                -- Font - Color:Red
                if tonumber(args[1]) > 0 and tonumber(args[1]) < 256 then
                    settings['Window Settings']['bg']['red'] = tonumber(args[1])
                else
                    settings['Window Settings']['bg']['red'] = tonumber(0)
                    windower.add_to_chat(2, 'Background: Red format improper; defaulting to 0.')
                end
                
                -- Font - Color:Green
                if tonumber(args[2]) > 0 and tonumber(args[2]) < 256 then
                    settings['Window Settings']['bg']['green'] = tonumber(args[2])
                else
                    settings['Window Settings']['bg']['green'] = tonumber(0)
                    windower.add_to_chat(2, 'Background: Green format improper; defaulting to 0.')
                end
                
                -- Font - Color:Blue
                if tonumber(args[3]) > 0 and tonumber(args[3]) < 256 then
                    settings['Window Settings']['bg']['blue'] = tonumber(args[3])
                else
                    settings['Window Settings']['bg']['blue'] = tonumber(0)
                    windower.add_to_chat(2, 'Background: Blue format improper; defaulting to 0.')
                end
                
                local red   = settings['Window Settings']['bg']['red']
                local green = settings['Window Settings']['bg']['green']
                local blue  = settings['Window Settings']['bg']['blue']
                
                windower.add_to_chat(2, 'Background: Color now set to (' .. red .. ',' .. green .. ',' .. blue .. ')')
                
                points_window:bg_color(red,green,blue)
                points_window:text(settings["Points String"])
                points_window:update()
                updateFile(setting_file, settings)
                
            else
                windower.add_to_chat(2, 'Proper format for font color is: //crim color [1-255] [1-255] [1-255]')
                
            end
            
        elseif cmd == "pad" then
            
            if cmd and tonumber(args[1]) and tonumber(args[1]) > 0 and tonumber(args[1]) < 11 and #cmd+#args[1] > 3 then
                settings['Window Settings']['padding'] = tonumber(args[1])
                windower.add_to_chat(2, 'Padding now set to ' .. settings['Window Settings']['padding'] .. '.')
            else
                windower.add_to_chat(2, 'Proper format for padding is: //crim pad [1-10]')
            
            end
            
            local padding = settings['Window Settings']['padding']
            
            points_window:pad(padding)
            points_window:text(settings["Points String"])
            points_window:update()
            updateFile(setting_file, settings)
            
        elseif cmd == "lock" then
            
            if settings["Window Settings"]["flags"]["draggable"] then
                settings["Window Settings"]["flags"]["draggable"] = false
                points_window:text(settings["Points String"])
                points_window:update()
                updateFile(setting_file, settings)
                windower.add_to_chat(2, "Points display is now locked!")
                
            else
                settings["Window Settings"]["flags"]["draggable"] = true
                points_window:text(settings["Points String"])
                points_window:update()
                updateFile(setting_file, settings)
                windower.add_to_chat(2, "Points display is now unlocked!")
            
            end
            
        elseif cmd == "update" then
            
            -- Update currencies data.
            windower.packets.inject_outgoing(0x10f,'0000')
            
            -- Get all display data, and build a new display string.        
            settings["Points String"] = buildDisplayString(currency)
            
            -- Update the display settings.
            updateDisplay(points_window, settings["Points String"])
            
        elseif cmd == "help" then            
            print("\\cs(215,245,255)__ -- ** ` Crimsonpoints Display ` ** -- __\\cr")
            print("\\cs(190,240,225)Stroke:\\cr":rpad(' ',28) ..  "\\cs(115,164,180) Adjust the stroke color.\\cr":rpad(' ',50)           .. "\\cs(132,150,163)[ //crim stroke 10 10 100 ]\\cr")
            print("\\cs(190,240,225)Text:\\cr":rpad(' ',28)   ..  "\\cs(115,164,180) Adjust the text size.\\cr":rpad(' ',50)              .. "\\cs(132,150,163)[ //crim text 25 ]\\cr")
            print("\\cs(190,240,225)Color:\\cr":rpad(' ',28)  ..  "\\cs(115,164,180) Adjust the font color.\\cr":rpad(' ',50)             .. "\\cs(132,150,163)[ //crim color 10 10 100 ]\\cr")
            print("\\cs(190,240,225)Bg:\\cr":rpad(' ',28)     ..  "\\cs(115,164,180) Adjust the background color.\\cr":rpad(' ',50)       .. "\\cs(132,150,163)[ //crim bg 10 10 100 ]\\cr")
            print("\\cs(190,240,225)Pad:\\cr":rpad(' ',28)    ..  "\\cs(115,164,180) Adjust the padding amount.\\cr":rpad(' ',50)         .. "\\cs(132,150,163)[ //crim pad 5 ]\\cr")
            print("\\cs(190,240,225)Lock:\\cr":rpad(' ',28)   ..  "\\cs(115,164,180) Adjust the stroke color.\\cr":rpad(' ',50)           .. "\\cs(132,150,163)[ //crim lock ]\\cr")
            print("\\cs(190,240,225)Delay:\\cr":rpad(' ',28)  ..  "\\cs(115,164,180) Adjust the delay between updates.\\cr":rpad(' ',50)  .. "\\cs(132,150,163)[ //crim delay 2 ]\\cr")
            
        elseif cmd == "reload" or cmd == "r" then
            windower.send_command("lua reload crimsonpoints")
        
        end
        
    end

end

windower.register_event('addon command', handle_command)

-- Addon Load Handler.
windower.register_event('load', function()
    
    local player = windower.ffxi.get_player()
    local myself = windower.ffxi.get_mob_by_target('me')
    local zone   = res.zones[windower.ffxi.get_info().zone]
    
    -- Set delay after loading.
    settings['Zone Delay'] = 10
    
    -- Update currencies data.
    windower.packets.inject_outgoing(0x10f,'0000')
    
    -- Get all display data, and build a new display string.        
    settings["Points String"] = buildDisplayString(currency)
    
    -- Load Display.
    points_window = texts.new(settings["Points String"], settings["Window Settings"], settings["Window Settings"])
    
    -- Update the display settings.
    if settings['Visible'] then
        points_window:show()
                
    elseif not settings['Visible'] then
        points_window:hide()
                
    end
    
end)

-- Zone Change Handler.
windower.register_event('zone change', function(new, old)
    
    -- Set delay after loading.
    settings['Zone Delay'] = 10
    
    -- Update currencies data.
    windower.packets.inject_outgoing(0x10f,'0000')
    
    -- Get all display data, and build a new display string.        
    settings["Points String"] = buildDisplayString(currency)
    
    -- Update the display settings.
    updateDisplay(points_window, settings["Points String"])
    
end)

-- Time Change Handler.
windower.register_event('prerender', function()
    
    if settings["Visible"] and os.clock()-settings["Last Ping"] > settings["Ping Delay"] + settings["Zone Delay"] * 60 then
        
        -- Reset the action delay.
        settings["Zone Delay"] = 0
        
        -- Autosave settings.
        if os.clock()-settings["Last Ping"] > settings["Autosave"] * 60 then
            updateFile(setting_file, settings)
            windower.add_to_chat(2, "Autosaving Points Display!")
        end
        
        -- Update currencies data.
        windower.packets.inject_outgoing(0x10f,'0000')
        
        -- Get all display data, and build a new display string.        
        settings["Points String"] = buildDisplayString(currency)
        
        -- Update the display settings.
        updateDisplay(points_window, settings["Points String"])
        
        settings["Last Ping"] = os.clock()
        
    end
    
end)

-- Incoming Chunck Handler.
windower.register_event("incoming chunk", function(id, data)
    
    if id == 0x113 and settings["Visible"] then
        local p = packets.parse('incoming', data)
    
        currency["Sparks"]    = p['Sparks of Eminence']
        currency["Accolades"] = p['Unity Accolades']
        currency["Ichor"]     = p['Therion Ichor']
        currency["Tokens"]    = p['Nyzul Tokens']
        currency["Zeni"]      = p['Zeni']
    
    elseif id == 0x118 and settings["Visible"] then
        local p = packets.parse('incoming', data)

        currency["Plasm"]           = p['Mweya Plasm Corpuscles']
        currency["Imps"]            = p['Coalition Imprimaturs']
        currency["Beads"]           = p['Escha Beads']
        currency["Silt"]            = p['Escha Silt']
        currency["Potpourri"]       = p['Potpourri']
        currency["Hallmarks"]       = p['Hallmarks']
        currency["Gallantry"]       = p['Badges of Gallantry']
        currency["Crafter"]         = p['Crafter Points']
        currency["Silver Vouchers"] = p['Silver A.M.A.N. Vouchers Stored']
        
    end

end)