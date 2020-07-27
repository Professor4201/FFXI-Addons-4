--------------------------------------------------------------------------------
-- UI Helper: Library of functions to handle the UI system.
--------------------------------------------------------------------------------
local ui = {}

function ui.newInputWindow(settings)
    local settings = settings or {
        ["pos"]={["x"]=100,["y"]=100},
        ["bg"]={["alpha"]=0,["red"]=1,["green"]=1,["blue"]=1,["visible"]=false},
        ["flags"]={["right"]=false,["bottom"]=false,["bold"]=false,["draggable"]=true,["italic"]=false},
        ["padding"]=5,
        ["text"]={["size"]=10,["font"]="lucida console",["fonts"]={},["alpha"]=255,["red"]=245,["green"]=200,["blue"]=20,
            ["stroke"]={["width"]=1,["alpha"]=255,["red"]=1,["green"]=1,["blue"]=1}
        },
    }
    
    return texts.new("", settings, settings)    
    
end


function ui.new()
    local self = {}
    
    -- Private Variables
    local resolution   = {x=windower.get_windower_settings().ui_x_res, y=windower.get_windower_settings().ui_y_res}
    local input_window = ui.newInputWindow()
    local img = {
        
        background = images.new({color={alpha = 255},texture={fit = false},draggable=true}),
        equipment  = images.new({color={alpha = 255},texture={fit = false},draggable=true}),
        
    }
    
    self.getChatInput = function()
        local open = windower.chat.is_open()
        
        if open then
            local input, length = windower.chat.get_input()
            
            if length and length > 0 then
                
                if not input_window:visible() then
                    input_window:visible(true)
                    input_window:bg_visible(true)
                end
                
                -- Update display.
                input_window:text(input)
                input_window:update()
                
            end

        end
        
    end
    
    self.renderUI = function()
        img.background:path(string.format("%sbp/helpers/ui/background.png", windower.addon_path))
        img.background:size(1920, 501)
        img.background:transparency(0)
        img.background:pos_x(0)
        img.background:pos_y(resolution.y-img.background:height())
        img.background:show()
        
        if bpcore:fileExists(string.format("/bp/helpers/ui/equipment_backgrounds/%s.png", (windower.ffxi.get_player().name):lower())) then
            img.equipment:path(string.format("%sbp/helpers/ui/equipment_backgrounds/%s_flipped.png", windower.addon_path, (windower.ffxi.get_player().name):lower()))
            img.equipment:size(258, 258)
            img.equipment:transparency(0)
            img.equipment:pos_x(-60)
            img.equipment:pos_y(resolution.y-198)
            img.equipment:show()

        elseif bpcore:fileExists(string.format("/bp/helpers/ui/equipment_backgrounds/%s.png", "moogle")) then
        
        
        end
            
    end
    
    return self
    
end
return ui.new()
