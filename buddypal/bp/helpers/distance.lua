--------------------------------------------------------------------------------
-- Distance helper: Simple distance feature to coordinate with all the other helpers and make it more visually appealing.
--------------------------------------------------------------------------------
local distance = {}
function distance.new()
    local self = {}
    
    -- Private Variables
    local player        = windower.ffxi.get_player()
    local pos           = {x=system["Target Window X"], y=system["Target Window Y"]}
    local font          = system["Distance Font"]
    local draggable     = system["Distance Draggable"]
    local padding       = system["Distance Padding"]
    local stroke        = system["Distance Stroke"]
    local settings = {
        ['pos']={['x']=pos.x-85,['y']=pos.y},
        ['bg']={['alpha']=200,['red']=0,['green']=0,['blue']=0,['visible']=false},
        ['flags']={['right']=false,['bottom']=false,['bold']=false,['draggable']=draggable,['italic']=false},
        ['padding']=7,
        ['text']={['size']=font.size,['font']=font.font,['fonts']={},['alpha']=font.alpha,['red']=font.r,['green']=font.g,['blue']=font.b,
            ['stroke']={['width']=stroke.width,['alpha']=stroke.alpha,['red']=stroke.r,['green']=stroke.g,['blue']=stroke.b}
        },
    }
    local display = texts.new("{ - }", settings, settings)
    
    self.show = function()
        display:bg_visible(true)
        display:show()
        
    end
    
    self.hide = function()
        display:bg_visible(false)
        display:hide()
        
    end
    
    self.update = function()
        local target = windower.ffxi.get_mob_by_target("t") or windower.ffxi.get_mob_by_target("st") or false

        if target then
            local whole     = tostring(target.distance:sqrt()):sub(1,2)
            local tenths    = tostring(target.distance:sqrt()):sub(4,4)
            local hundreths = tostring(target.distance:sqrt()):sub(5,5)
            
            if (tonumber(whole) == nil or whole == "") then
                whole = "0"
            end
            
            if (tonumber(hundreths) == nil or hundreths == "") then
                hundreths = "0"
            end
            
            if (tonumber(tenths) == nil or tenths == "") then
                tenths = "0"
            end
            
            local distance  = string.format("%02d.%d%d", whole, tenths, hundreths)
            local text      = "{ " .. bpcore:colorize(distance, "25,200,230") .. " }"
            
            display:text(text)
            display:bg_visible(true)
            display:update()
            display:show()
        
        else
            display:text("")
            display:bg_visible(false)
            display:update()
            display:hide()
        
        end
        
    end
    
    return self
    
end
return distance.new()