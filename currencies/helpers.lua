function createBaseSettings()
    
    local settings = {
        
        ["Last Ping"]        = os.clock(),
        ["Ping Delay"]       = 1,
        ["Zone Delay"]       = 0,
        ["Autosave"]         = 15,
        ["Visible"]          = false,
        ["Sparks"]           = true,
        ["Accolades"]        = true,
        ["Ichor"]            = false,
        ["Tokens"]           = false,
        ["Zeni"]             = false,
        ["Plasm"]            = false,
        ["Imps"]             = false,
        ["Beads"]            = false,
        ["Silt"]             = false,
        ["Potpourri"]        = false,
        ["Hallmarks"]        = false,
        ["Gallantry"]        = false,
        ["Crafter"]          = false,
        ["Silver Vouchers"]  = false,
        ["Points String"]    = "",
        ["Window Settings"]  = {
            ['pos'] = {
                ['x'] = 100,
                ['y'] = 300,
            },
            ['bg'] = {
                ['alpha']   = 155,
                ['red']     = 000,
                ['green']   = 000,
                ['blue']    = 000,
                ['visible'] = true,
            },
            ['flags'] = {
                ['right']       = false,
                ['bottom']      = false,
                ['bold']        = false,
                ['draggable']   = true,
                ['italic']      = false,
            },
            ['padding'] = 10,
            ['text']    = {
                ['size']        = 10,
                ['font']        = 'lucida console',
                ['fonts']       = {},
                ['alpha']       = 255,
                ['red']         = 245,
                ['green']       = 200,
                ['blue']        = 020,
                ['stroke']      = {
                    ['width']   = 001,
                    ['alpha']   = 255,
                    ['red']     = 0,
                    ['green']   = 0,
                    ['blue']    = 0,
                },
            },
        },
    }
    return settings
    
end

---------------------------------------------------------------------------
-- Write table to file.
---------------------------------------------------------------------------
function updateFile(my_file, my_table)
    my_file:write('return ' .. T(my_table):tovstring())
end

---------------------------------------------------------------------------
-- Update the display window.
---------------------------------------------------------------------------
-- @table window_name
function updateDisplay(window, updateString)
    window:text(updateString)
    window:update()
    
end

---------------------------------------------------------------------------
-- Build display string.
---------------------------------------------------------------------------
function buildDisplayString(currencies)
    
    -- Get all display data, and build a new display string.
    local updatedString = ""
    
    if settings["Sparks"] and currencies["Sparks"] then
        updatedString = updatedString .. " | Sparks: " .. tostring(currencies["Sparks"])
    end
    
    if settings["Accolades"] and currencies["Accolades"] then
        updatedString = updatedString .. " | Accolades: " .. tostring(currencies["Accolades"])
    end
    
    if settings["Ichor"] and currencies["Ichor"] then
        updatedString = updatedString .. " | Ichor: " .. tostring(currencies["Ichor"])
    end
    
    if settings["Tokens"] and currencies["Tokens"] then
        updatedString = updatedString .. " | Tokens: " .. tostring(currencies["Tokens"])
    end
    
    if settings["Zeni"] and currencies["Zeni"] then
        updatedString = updatedString .. " | Zeni: " .. tostring(currencies["Zeni"])
    end
    
    if settings["Plasm"] and currencies["Plasm"] then
        updatedString = updatedString .. " | Plasm: " .. tostring(currencies["Plasm"])
    end
    
    if settings["Imps"] and currencies["Imps"] then
        updatedString = updatedString .. " | Imprimaturs: " .. tostring(currencies["Imps"])
    end
    
    if settings["Beads"] and currencies["Beads"] then
        updatedString = updatedString .. " | Beads: " .. tostring(currencies["Beads"])
    end
    
    if settings["Silt"] and currencies["Silt"] then
        updatedString = updatedString .. " | Silt: " .. tostring(currencies["Silt"])
    end
    
    if settings["Potpourri"] and currencies["Potpourri"] then
        updatedString = updatedString .. " | Potpourri: " .. tostring(currencies["Potpourri"])
    end
    
    if settings["Hallmarks"] and currencies["Hallmarks"] then
        updatedString = updatedString .. " | Hallmarks: " .. tostring(currencies["Hallmarks"])
    end
    
    if settings["Gallantry"] and currencies["Gallantry"] then
        updatedString = updatedString .. " | Gallantry: " .. tostring(currencies["Gallantry"])
    end
    
    if settings["Crafter"] and currencies["Crafter"] then
        updatedString = updatedString .. " | Crafter Points: " .. tostring(currencies["Crafter"])
    end
    
    if settings["Silver Vouchers"] and currencies["Silver Vouchers"] then
        updatedString = updatedString .. " | Silver Vouchers: " .. tostring(currencies["Silver Vouchers"])
    end
    
    updatedString = updatedString .. " | "
    
    return updatedString
    
end