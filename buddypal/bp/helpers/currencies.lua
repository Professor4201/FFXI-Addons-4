--------------------------------------------------------------------------------
-- Currencies helper: This helper controls the on screen display of multiple currencies, and xp/jp/cp.
--------------------------------------------------------------------------------
local currencies = {}
function currencies.new()
    self = {}
    
    -- Private Variables
    local string        = ""
    local font          = system["Currencies Font"]
    local stroke        = system["Currencies Stroke"]
    local delay         = 0.5
    local update        = os.clock()
    local currency      = {
        
        ["Sparks"]           = 0,
        ["Accolades"]        = 0,
        ["Ichor"]            = 0,
        ["Tokens"]           = 0,
        ["Voidstones"]       = 0,
        ["Bayld"]            = 0,
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
        ["Canteens"]         = 0,
        
    }
    
    local settings = {
        ['pos']={['x']=system["Currencies Window X"],['y']=system["Currencies Window Y"]},
        ['bg']={['alpha']=0,['red']=0,['green']=0,['blue']=0,['visible']=false},
        ['flags']={['right']=false,['bottom']=false,['bold']=false,['draggable']=system["Currencies Draggable"],['italic']=false},
        ['padding']=system["Currencies Padding"],
        ['text']={['size']=font.size,['font']=font.font,['fonts']={},['alpha']=font.alpha,['red']=font.r,['green']=font.g,['blue']=font.b,
            ['stroke']={['width']=stroke.width,['alpha']=stroke.alpha,['red']=stroke.r,['green']=stroke.g,['blue']=stroke.b}
        },
    }
    
    local window     = texts.new("", settings, settings)
    local background = images.new({color={alpha = 255}, texture={fit = false}, draggable = false,})
        background:path(windower.addon_path .. 'bp/img/backgrounds/currencies_background.png')
        background:size(1920, 19)
        background:transparency(0)
        background:pos_x(system["Currencies Window X"])
        background:pos_y(system["Currencies Window Y"]-1)
        background:show()
        
    -- Show the currency window.
    self.show = function()
        window:show()
    end
    
    -- Hide the currency window.
    self.hide = function()
        window:hide()
    end
    
    -- Update the currency window.
    self.update = function()
        local updated = {}
        
        for i,v in pairs(currency) do
            
            if system["Currencies Visible"][i] then
                table.insert(updated, (i.." "..v))
            end
            
        end    
        
        window:text(table.concat(updated, "  :  "))
        window:bg_visible(true)
        window:update()
        
    end
    
    -- Set the currency value.
    self.setCurrency = function(name, value)
        currency[name] = value
        
    end
    
    -- Return currency value.
    self.getCurrency = function(name)
        return tonumber(currency[name])
        
    end
    
    -- Return currency value.
    self.getAllCurrency = function()
        return currency
        
    end
    
    -- Handle ping for the helper.
    self.ping = function()
        local toggle = commands["currencies"].settings().toggle
    
        if toggle and os.clock()-update > delay * 60 then
            windower.packets.inject_outgoing(0x10f,'0000')
            windower.packets.inject_outgoing(0x115,'0000')          
            
            helpers["currencies"].update()
            update = os.clock()
    
        end
    
    end
    
    return self
    
end
return currencies.new()
