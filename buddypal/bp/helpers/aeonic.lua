--------------------------------------------------------------------------------
-- Aeonic helper: Handles functions to purchase Aeonic KI.
--------------------------------------------------------------------------------
local aeonic = {}
function aeonic.new()
    local self = {}
    
    -- Private Variables
    local injecting = false
    local weapon    = ""
    local aeonics   = {
        
        ["Knuckles"]      = 63168,
        ["Dagger"]        = 63232,
        ["Sword"]         = 63296,
        ["Great Sword"]   = 63360,
        ["Axe"]           = 63424,
        ["Great Axe"]     = 63488,
        ["Polearm"]       = 63552,
        ["Scythe"]        = 63616,
        ["Katana"]        = 63680,
        ["Great Katana"]  = 63744,
        ["Club"]          = 63808,
        ["Staff"]         = 63872,
        ["Bow"]           = 63936,
        ["Gun"]           = 64000,
        ["Shield"]        = 64064,
        ["Flute"]         = 64128,
        
    }
    
    self.getKI = function(packets)
        local packets = packets or false
        local target  = windower.ffxi.get_mob_by_id(packets["NPC"]) or false
        local weapon  = helpers["aeonic"].getWeapon() or false
        
        if packets and target and weapon and aeonics and weapon ~= "" and aeonics[weapon] then
            helpers["actions"].injectMenu(packets["NPC"], packets["NPC Index"], packets["Zone"], aeonics[weapon], packets["Menu ID"], false, 2, 0)
            helpers["aeonic"].setWeapon("")
            
        else
            helpers["actions"].doExitMenu(packets, target)
            helpers["aeonic"].setWeapon("")
            
        end
        
    end
    
    self.setInjecting = function(value)
        injecting = value
    end
    
    self.getInjecting = function()
        return injecting
    end
    
    self.setWeapon = function(name)
        weapon = name
    end
    
    self.getWeapon = function()
        return weapon
    end
    
    return self
    
end
return aeonic.new()
