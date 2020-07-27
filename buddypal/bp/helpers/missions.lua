--------------------------------------------------------------------------------
-- Missions helper: This helper controls the on screen display of current missions
--------------------------------------------------------------------------------
local missions = {}
function missions.new()
    local self = {}
    
    -- Private Variables
    local updated       = {}
    local font          = system["Missions Font"]
    local stroke        = system["Missions Stroke"]
    local delay         = 0.5
    local update        = 0
    local nation        = system["Nation"][windower.ffxi.get_player().nation]:lower()
    local map           = {["NATION"]="[ - ]",["ROZ"]="[ - ]",["COP"]="[ - ]",["TOAU"]="[ - ]",["WOTG"]="[ - ]",["SOA"]="[ - ]",["ROV"]="[ - ]"}
    local missions_list = {
        
        ["nation"] = require('bp/helpers/missions/missions-'..nation),
        ["roz"]    = require('bp/helpers/missions/missions-zilart'),
        ["cop"]    = require('bp/helpers/missions/missions-promathia'),
        ["toau"]   = require('bp/helpers/missions/missions-ahtuhrgan'),
        ["wotg"]   = require('bp/helpers/missions/missions-goddess'),
        ["soa"]    = require('bp/helpers/missions/missions-adoulin'),
        ["rov"]    = require('bp/helpers/missions/missions-rhapsodies'),
    
    }
    
    local settings = {
        ['pos']={['x']=system["Missions Window X"],['y']=system["Missions Window Y"]},
        ['bg']={['alpha']=0,['red']=0,['green']=0,['blue']=0,['visible']=false},
        ['flags']={['right']=false,['bottom']=false,['bold']=false,['draggable']=system["Missions Draggable"],['italic']=false},
        ['padding']=system["Missions Padding"],
        ['text']={['size']=font.size,['font']=font.font,['fonts']={},['alpha']=font.alpha,['red']=font.r,['green']=font.g,['blue']=font.b,
            ['stroke']={['width']=stroke.width,['alpha']=stroke.alpha,['red']=stroke.r,['green']=stroke.g,['blue']=stroke.b}
        },
    }

    local window     = texts.new("", settings, settings)
    local background = images.new({color={alpha = 255}, texture={fit = false}, draggable = false,})
        background:path(windower.addon_path .. 'bp/img/backgrounds/missions_background.png')
        background:size(1920, 19)
        background:transparency(0)
        background:pos_x(system["Missions Window X"])
        background:pos_y(system["Missions Window Y"]-1)
        background:show()
    
    self.get = function()
        return updated
    end
    
    -- Show the currency window.
    self.show = function()
        window:bg_visible(true)
        window:show()
    end
    
    -- Hide the currency window.
    self.hide = function()
        window:bg_visible(false)
        window:hide()
    end
    
    -- Update the currency window.
    self.update = function()
        
        if commands["missions"].settings().toggle then
            
            local string = table.concat(updated, "  |  ")
                window:text(string)
                window:bg_visible(true)
                window:update()
                window:show()
                
        elseif window:visible() then
            window:bg_visible(false)
            window:update()
            window:hide()
                
        end
        
    end
    
    self.buildMissions = function(original, parsed)
        local isVisible = system["Missions Visible"]
        
        if original and parsed then
            local bits = bit.band(parsed.Type, 0xFFFF)        
            
            if bits == 0xffff then
                --print(string.format("COP: %s {%s} | SOA: %s", parsed['Current COP Mission'], ((parsed['Current COP Mission']/3)-37):floor(), parsed['Current SOA Mission']))
                
                if parsed['Current Nation Mission'] then
                    map["NATION"] = missions_list["nation"][parsed['Current Nation Mission']]
                end
                
                if parsed['Current ROZ Mission'] then
                    map["ROZ"] = missions_list["roz"][parsed['Current ROZ Mission']]
                end
                
                if parsed['Current COP Mission'] then
                    map["COP"] = missions_list["cop"][(((parsed['Current COP Mission']-125)/2)-33):floor()]
                end
                
                if parsed['Current SOA Mission'] then
                    map["SOA"] = missions_list["soa"][((parsed['Current SOA Mission']/2)-55)]
                end
                
                if parsed['Current ROV Mission'] then
                    map["ROV"] = missions_list["rov"][((parsed['Current ROV Mission']-110)/2-1)]
                end
                
            elseif bits == 0x0080 then
                
                if parsed['Current TOAU Mission'] then
                    map["TOAU"] = missions_list["toau"][parsed['Current TOAU Mission']]
                end
                
                if parsed['Current WOTG Mission'] then
                    map["WOTG"] = missions_list["wotg"][parsed['Current WOTG Mission']]
                end
                
            end
            
        end
        
        for i,v in pairs(map) do
            
            if i and map[i] and isVisible[i] then
                local color1 = (font.r..","..font.g..","..font.b)
                
                updated[i] = ("[ " .. bpcore:colorize(i, tostring(color1)) .. ": " .. bpcore:colorize(v, "240,175,50") .. " ]")
                
            end
            
        end
        
    end
    
    return self
    
end
return missions.new()