--------------------------------------------------------------------------------
-- Items Commands: Handles commands for useable items.
--------------------------------------------------------------------------------
local items = {}
function items.run()
    self = {}
    
    -- Private variables.
    local toggle = I{true,false}
    local beads  = I{true,false}
    local silt   = I{true,false}
    local skills = I{false,true}
    local rocks  = I{false,true}
    local user   = I{true,false}
    
    local list   = {

        ["Skill Items"] = T{
            ["WAR"] = {"Mikhe's Memo","Dgr. Enchiridion","Swing and Stab","Mieuseloir's Diary","Bull's Diary","Death for Dim.","Ludwig's Report",
                "Clash of Titans","Ferreous's Diary","K-P's Memoirs","Perih's Primer","Barrels of Fun","T.W. Enchiridion","Sonia's Diary","The Successor","Kage. Journal"},
            
            ["MNK"] = {"Mikhe's Memo","Ferreous's Diary","K-P's Memoirs","T.W. Enchiridion","Mikhe's Note","Sonia's Diary","Kage. Journal"},
            ["WHM"] = {"Ferreous's Diary","K-P's Memoirs","T.W. Enchiridion","Sonia's Diary","The Successor","Altana's Hymn","Coveffe Musings","Aid for All","Inv. Report"},
            ["BLM"] = {"Dgr. Enchiridion","Ludwig's Report","Ferreous's Diary","K-P's Memoirs","T.W. Enchiridion","Sonia's Diary","Aid for All","Inv. Report","Bounty List","Dark Deeds"},
            ["RDM"] = {"Dgr. Enchiridion","Swing and Stab","Ferreous's Diary","Perih's Primer","T.W. Enchiridion","Sonia's Diary","The Successor","Kage. Journal","Altana's Hymn","Coveffe Musings","Aid for All","Inv. Report","Bounty List","Dark Deeds"},
            ["THF"] = {"Mikhe's Memo","Dgr. Enchiridion","Swing and Stab","Ferreous's Diary","Perih's Primer","Barrels of Fun","T.W. Enchiridion","Sonia's Diary","The Successor","Kage. Journal"},
            ["PLD"] = {"Dgr. Enchiridion","Swing and Stab","Mieuseloir's Diary","Ferreous's Diary","K-P's Memoirs","Death for Dim.","Clash of Titans","Sonia's Diary","The Successor","Kage. Journal","Altana's Hymn","Coveffe Musings","Aid for All"},
            ["DRK"] = {"Dgr. Enchiridion","Swing and Stab","Mieuseloir's Diary","Bull's Diary","Death for Dim.","Ludwig's Report","Ferreous's Diary","Barrels of Fun","Sonia's Diary","Kage. Journal","Inv. Report","Bounty List","Dark Deeds"},
            ["BST"] = {"Dgr. Enchiridion","Swing and Stab","Bull's Diary","Ludwig's Report","Ferreous's Diary","Sonia's Diary","The Successor","Kage. Journal"},
            ["BRD"] = {"Dgr. Enchiridion","Swing and Stab","Ferreous's Diary","K-P's Memoirs","T.W. Enchiridion","Sonia's Diary","Kage. Journal","Breezy Libretto","Cavernous Score","Beaming Score"},
            ["RNG"] = {"Dgr. Enchiridion","Swing and Stab","Bull's Diary","Ferreous's Diary","Perih's Primer","Barrels of Fun","T.W. Enchiridion","Sonia's Diary"},
            ["SMN"] = {"Dgr. Enchiridion","Ferreous's Diary","K-P's Memoirs","Sonia's Diary","Astral Homeland"},
            ["SAM"] = {"Dgr. Enchiridion","Swing and Stab","Clash of Titans","Noillurie's Log","Ferreous's Diary","Perih's Primer","T.W. Enchiridion","Sonia's Diary","Kage. Journal"},
            ["NIN"] = {"Mikhe's Memo","Dgr. Enchiridion","Swing and Stab","Kagetora's Diary","Noillurie's Log","Ferreous's Diary","Barrels of Fun","T.W. Enchiridion","Sonia's Diary","Kage. Journal","Yomi's Diagram"},
            ["DRG"] = {"Dgr. Enchiridion","Swing and Stab","Clash of Titans","Ferreous's Diary","K-P's Memoirs","Sonia's Diary","Kage. Journal"},
            ["BLU"] = {"Swing and Stab","Ferreous's Diary","Sonia's Diary","Kage. Journal","Life-form Study"},
            ["COR"] = {"Dgr. Enchiridion","Swing and Stab","Barrels of Fun","T.W. Enchiridion","Sonia's Diary","Kage. Journal"},
            ["PUP"] = {"Mikhe's Memo","Dgr. Enchiridion","Ferreous's Diary","T.W. Enchiridion","Mikhe's Note","Sonia's Diary","Kage. Journal"},
            ["DNC"] = {"Mikhe's Memo","Dgr. Enchiridion","Swing and Stab","T.W. Enchiridion","Sonia's Diary","Kage. Journal"},
            ["SCH"] = {"Dgr. Enchiridion","Ferreous's Diary","K-P's Memoirs","T.W. Enchiridion","Sonia's Diary","Kage. Journal","Altana's Hymn","Coveffe Musings","Aid for All","Inv. Report","Bounty List","Dark Deeds"},
            ["GEO"] = {"Ferreous's Diary","K-P's Memoirs","Dgr. Enchiridion","Sonia's Diary","Kage. Journal","Inv. Report","Bounty List","Dark Deeds","Hrohj's Record","The Bell Tolls"},
            ["RUN"] = {"Swing and Stab","Mieuseloir's Diary","Bull's Diary","Death for Dim.","Ferreous's Diary","Sonia's Diary","Kage. Journal","Altana's Hymn","Aid for All"},
        },
        ["Rock Items"] = T{
            "Pluton Case","Beitetsu Parcel","Boulder Case","Pluton Box","Beitetsu Box","Boulder Box",
        },
        ["My Items"] = system["My Items"],
    
    }

    --------------------------------------------------------------------------------------
    -- Handle the execution of all helper commands.
    --------------------------------------------------------------------------------------
    self.execute = function(commands)
        local command = commands[2] or false
        
        if command then
            local scan = command:sub(1, #command):lower()
            
            if ( ("on"):match(scan) or ("toggle"):match(scan) or ("off"):match(scan) ) then
                toggle:next()
                
                local status = tostring(toggle:current()):upper()
                helpers["popchat"]:pop(("USE BAGGED ITEMS: "..status), system["Popchat Window"])
            
            elseif ("beads"):match(scan) then
                beads:next()
                
                local status = tostring(beads:current()):upper()
                helpers["popchat"]:pop(("BEAD POUCHES: "..status), system["Popchat Window"])
                
            elseif ("silt"):match(scan) then
                silt:next()
                
                local status = tostring(silt:current()):upper()
                helpers["popchat"]:pop(("SILT POUCHES: "..status), system["Popchat Window"])
                
            elseif ( ("skills"):match(scan) or ("diary"):match(scan) or ("journal"):match(scan) or ("books"):match(scan) ) then
                skills:next()
                
                local status = tostring(skills:current()):upper()
                helpers["popchat"]:pop(("SKILL-UP BOOKS: "..status), system["Popchat Window"])
                
            elseif ( ("rocks"):match(scan) or ("plutons"):match(scan) or ("boulders"):match(scan)  or ("beitetsu"):match(scan) ) then
                rocks:next()
                
                local status = tostring(rocks:current()):upper()
                helpers["popchat"]:pop(("RMEA ROCK CASES/BOXES: "..status), system["Popchat Window"])
            
            elseif ("user"):match(scan) then
                user:next()
                
                local status = tostring(user:current()):upper()
                helpers["popchat"]:pop(("USER ITEMS: "..status), system["Popchat Window"])
            
            end
        
        elseif not command then
            toggle:next()
                
            local status = tostring(toggle:current()):upper()
            helpers["popchat"]:pop(("USE BAGGED ITEMS: "..status), system["Popchat Window"])
            
        end
        
    end
    
    --------------------------------------------------------------------------------------
    -- Handle the return of all current settings.
    --------------------------------------------------------------------------------------
    self.settings = function()
        
        return {
            
            toggle = toggle:current(),
            beads  = beads:current(),
            silt   = silt:current(),
            skills = skills:current(),
            rocks  = rocks:current(),
            user   = user:current(),
            list   = list,
            
        }
    
    end
    
    return self
    
end
return items.run()