--------------------------------------------------------------------------------
-- Popchat helper: This helper controls on screen chat bubble.
--------------------------------------------------------------------------------
-- @return orders
local popchat = {}

-- Popchat Settings.
system["Popchat Window"]        = {}
system["Popchat Delay"]         = 5
system["Popchat Position"]      = {["x"]=1100,["y"]=375}
system["Popchat BG"]            = {["alpha"]=155,["r"]=000,["g"]=000,["b"]=000}
system["Popchat Flags"]         = {['right']=false,['bottom']=false,['bold']=false,['draggable']=false,['italic']=false}
system["Popchat Padding"]       = 8
system["Popchat Text"]          = {['size']=10,['font']='lucida console',['alpha']=255,['r']=245,['g']=200,['b']=020}
system["Popchat Stroke"]        = {['width']=001,['alpha']=255,['r']=0,['g']=0,['b']=0}
system["Popchat Check"]         = (system["Popchat Delay"]/(system["Popchat Delay"]*16))
system["Popchat Fade"]          = system["Popchat BG"]["alpha"]
system["Popchat Fader"]         = (255/(system["Popchat Delay"]*16))
system["Popchat Last"]          = os.clock()

function popchat:build()
    
    --Popchat Window Settings.
    local settings = {
        ['pos']={['x']=system["Popchat Position"]["x"],['y']=system["Popchat Position"]["y"]},
        ['bg']={['alpha']=system["Popchat BG"]["alpha"],['red']=system["Popchat BG"]["r"],['green']=system["Popchat BG"]["g"],['blue']=system["Popchat BG"]["b"],['visible']=false},
        ['flags']={['right']=system["Popchat Flags"]["right"],['bottom']=system["Popchat Flags"]["bottom"],['bold']=system["Popchat Flags"]["bold"],['draggable']=system["Popchat Flags"]["draggable"],['italic']=system["Popchat Flags"]["italic"]},
        ['padding']=system["Popchat Padding"],
        ['text']={['size']=system["Popchat Text"]["size"],['font']=system["Popchat Text"]["font"],['fonts']={},['alpha']=system["Popchat Text"]["alpha"],['red']=system["Popchat Text"]["r"],['green']=system["Popchat Text"]["g"],['blue']=system["Popchat Text"]["b"],
            ['stroke']={['width']=system["Popchat Stroke"]["width"],['alpha']=system["Popchat Stroke"]["alpha"],['red']=system["Popchat Stroke"]["r"],['green']=system["Popchat Stroke"]["g"],['blue']=system["Popchat Stroke"]["b"]}
        },
    }
    
    local w = texts.new("", settings, settings)
    w:visible(false)
    w:bg_visible(false)
    w:update(w, settings)
    return w
    
end

function popchat:show(window)
    window:bg_visible(true)
    window:bg_alpha(system["Popchat BG"]["alpha"])
    window:show()
end

function popchat:hide(window)
    window:bg_visible(false)
    window:bg_alpha(system["Popchat BG"]["alpha"])
    window:hide()
end

function popchat:pop(text, window)
    system["Popchat Fade"] = system["Popchat BG"]["alpha"]
    window:text("[ " .. text .. " ]")
    window:bg_visible(true)
    window:bg_alpha(system["Popchat BG"]["alpha"])
    window:update()
    window:show()    
    
end
return popchat

