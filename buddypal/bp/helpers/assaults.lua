--------------------------------------------------------------------------------
-- Assaults helper: Handles tracking players assaults progress.
--------------------------------------------------------------------------------
local assaults = {}
function assaults.new()
    local self = {}
    
    -- Private Variables.
    local npc       = {["Rytaal"]=16982171,["Yahsra"]=16982174,["Isdebaaq"]=16982175,["Famad"]=16982176,["Lageegee"]=16982177,["Bhoy Yhupplo"]=16982178}
    local ranks     = {["PSC"]=1,["PFC"]=2,["SP"]=3,["LC"]=4,["C"]=5,["S"]=6,["SM"]=7,["CS"]=8,["SL"]=9,["FL"]=10}
    local map       = bpcore:handleSettings("bp/helpers/assaults/"..windower.ffxi.get_player().name:lower())
    local menus     = dofile(windower.addon_path.."bp/helpers/assaults/menus.lua")
    local portals   = {17101271,17101274,16990590,17027539,16998988,16982076}
    local armbands  = {17101316,17101315,16990603,17027558,16999039}
    local entrances = {17101270,17101273,16990589,17027538,16998987}
    local tags      = nil
    local flag      = false
    
    self.getMenu = function(id, value)
        local id, value = id or false, value or false
        
        if id and value then
            return menus[id][ranks[value]]
        end
        
    end
    
    self.getFlag = function()
        return flag
    end
    
    self.setFlag = function(value)
        local value = value or false
        
        if flag then
            flag = value
        end
        
    end
    
    self.getTags = function()
        return tags
    end
    
    self.setTags = function(data)
        local data   = data or false
        
        if data then
            local id   = data:unpack("I", 0x04+1) or false
            local menu = {data:sub(9,40):unpack("C32")} or false
            
            if id and menu then
                tags = tonumber(menu[5])
            end
        
        end
        
    end
    
    return self
    
end
return assaults.new()
