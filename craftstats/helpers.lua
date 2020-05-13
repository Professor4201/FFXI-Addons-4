local helpers = {}
function helpers.get()
    self = {}
    
    -- Local Files Library.
    local files   = require("files")
    local res     = require("resources")
    local texts   = require("texts")
    
    self.findItemById = function(ingredient)
        local items = windower.ffxi.get_items(0) or false
        
        if items then
        
            for ind, ite in ipairs(items) do
                
                if ite and ind and ite.id and ite.status == 0 then
                    
                    if ite.id == ingredient and res.items[ite.id] then
                        return res.items[ite.id]
                    end
                    
                end
                
            end
        
        end
        return false
        
    end
    
    self.createId = function(ingredients, crystal)
        local ingredients, crystal = ingredients or false, crystal or false
        
        if ingredients and crystal and type(ingredients) == "table" then
            local uid = 0
            
            for i,v in ipairs(ingredients) do

                if self.findItemById(v) then
                    uid = (uid + v)
                end
                
            end
            return (uid*crystal)
            
        end
        return false
        
    end
    
    self.add = function(stats, skill, hash, result, quality, item)
        local stats, skill, hash, result, quality, item = stats or false, skill or false, hash or false, result or false, quality or false, item or false
        local f = files.new(string.format("stats/%s.lua", windower.ffxi.get_player().name))
        
        if stats and skill and hash and result and quality and item then
            
            if stats[skill] then
                
                if stats[skill][hash] then
                    local s = stats[skill][hash]
                    
                    if result == 0 then
                        
                        if quality == 0 then
                            stats[skill][hash] = {total=(s.total+1), nq=(s.nq+1), hq1=(s.hq1), hq2=(s.hq2), hq3=(s.hq3), breaks=(s.breaks), item=res.items[item].en}
                        
                        elseif quality == 1 then
                            stats[skill][hash] = {total=(s.total+1), nq=(s.nq), hq1=(s.hq1+1), hq2=(s.hq2), hq3=(s.hq3), breaks=(s.breaks), item=res.items[item].en}
                            
                        elseif quality == 2 then
                            stats[skill][hash] = {total=(s.total+1), nq=(s.nq), hq1=(s.hq1), hq2=(s.hq2+1), hq3=(s.hq3), breaks=(s.breaks), item=res.items[item].en}
                            
                        elseif quality == 3 then
                            stats[skill][hash] = {total=(s.total+1), nq=(s.nq), hq1=(s.hq1), hq2=(s.hq2), hq3=(s.hq3+1), breaks=(s.breaks), item=res.items[item].en}
                            
                        end
                        
                    elseif result == 1 then
                        stats[skill][hash] = {total=(s.total+1), nq=(s.nq), hq1=(s.hq1), hq2=(s.hq2), hq3=(s.hq3), breaks=(s.breaks+1), item=res.items[item].en}
                        
                    end
                    
                else
                    stats[skill][hash] = {}
                    
                    if result == 0 then
                        
                        if quality == 0 then
                            stats[skill][hash] = {total=(1), nq=(1), hq1=(0), hq2=(0), hq3=(0), breaks=(0), item=res.items[item].en}
                        
                        elseif quality == 1 then
                            stats[skill][hash] = {total=(1), nq=(0), hq1=(1), hq2=(0), hq3=(0), breaks=(0), item=res.items[item].en}
                            
                        elseif quality == 2 then
                            stats[skill][hash] = {total=(1), nq=(0), hq1=(0), hq2=(1), hq3=(0), breaks=(0), item=res.items[item].en}
                            
                        elseif quality == 3 then
                            stats[skill][hash] = {total=(1), nq=(0), hq1=(0), hq2=(0), hq3=(1), breaks=(0), item=res.items[item].en}
                            
                        end
                        
                    elseif result == 1 then
                        stats[skill][hash] = {total=(1), nq=(0), hq1=(0), hq2=(0), hq3=(0), breaks=(1), item=res.items[item].en}
                        
                    end
                    
                end
                
            else
                
                if result == 0 then
                        
                    if quality == 0 then
                        stats = {[skill]={[hash]={total=(1), nq=(1), hq1=(0), hq2=(0), hq3=(0), breaks=(0), item=res.items[item].en}}}
                    
                    elseif quality == 1 then
                        stats = {[skill]={[hash]={total=(1), nq=(0), hq1=(1), hq2=(0), hq3=(0), breaks=(0), item=res.items[item].en}}}
                        
                    elseif quality == 2 then
                        stats = {[skill]={[hash]={total=(1), nq=(0), hq1=(0), hq2=(1), hq3=(0), breaks=(0), item=res.items[item].en}}}
                        
                    elseif quality == 3 then
                        stats = {[skill]={[hash]={total=(1), nq=(0), hq1=(0), hq2=(0), hq3=(1), breaks=(0), item=res.items[item].en}}}
                        
                    end
                    
                elseif result == 1 then
                    stats = {[skill]={[hash]={total=(1), nq=(0), hq1=(0), hq2=(0), hq3=(0), breaks=(1), item=res.items[item].en}}}
                    
                end
                
            end
            
        end
        
        if f:exists() then
            f:write("return " .. T(stats):tovstring())
        end
        return stats
        
    end        
    
    self.display = function()
        local settings = {
            ['pos']={['x']=1,['y']=1},
            ['bg']={['alpha']=155,['red']=0,['green']=0,['blue']=0,['visible']=false},
            ['flags']={['right']=false,['bottom']=false,['bold']=false,['draggable']=true,['italic']=false},
            ['padding']=5,
            ['text']={['size']=10,['font']="lucida console",['fonts']={},['alpha']=190,['red']=255,['green']=255,['blue']=255,
                ['stroke']={['width']=1,['alpha']=255,['red']=0,['green']=0,['blue']=0}
            },
        }

        return texts.new("", settings)            
        
    end
    
    self.update = function(display, stats, skill, hash)
        local display, stats, skill, hash  = display or false, stats or false, skill or false, hash or false
        
        if display and stats and skill and hash and stats[skill] and stats[skill][hash] and type(stats[skill][hash]) == "table" then
            local info     = stats[skill][hash]
            local count    = #stats[skill][hash]
            local title    = "\\cs(065,245,245)"
            local craft    = "\\cs(200,175,140)"
            local close    = "\\cr"
            local percents = {total=(((info.nq+info.hq1+info.hq2+info.hq3)/info.total)*100), nq=(info.nq/info.total)*100, hq1=(info.hq1/info.total)*100, hq2=(info.hq2/info.total)*100, hq3=((info.hq3/info.total)*100), breaks=((info.breaks/info.total)*100)}
            local update   = {
                
                string.format("%s $$$$ %+10s Crafting Statistics %-10s $$$$ %s", title, "", "", close),
                string.format("\n\n%s%s - Ingredients Hash: %s%s", craft, res.skills[skill].en, hash, close),
                string.format("\n\nTotal Synths: %+9s %s[%03s]%s", info.total, self.getColor(percents.total), percents.total, close),
                string.format("\nSuccessful:   %+9s %s[%03s]%s", info.nq, self.getColor(percents.nq), percents.nq, close),
                string.format("\nHQ T1:  %+15s %s[%03s]%s", info.hq1, self.getColor(percents.hq1), percents.hq1, close),
                string.format("\nHQ T2:  %+15s %s[%03s]%s", info.hq2, self.getColor(percents.hq2), percents.hq2, close),
                string.format("\nHQ T3:  %+15s %s[%03s]%s", info.hq3, self.getColor(percents.hq3), percents.hq3, close),
                string.format("\nBreaks: %+15s %s[%03s]%s", info.breaks, self.getColor(percents.breaks), percents.breaks, close),
                
            }
            
            display:text(table.concat(update, ""))
            display:visible(true)
            display:bg_visible(true)
            display:update()
        
        else
            display:text("")
            display:visible(false)
            display:bg_visible(false)
            display:update()
            
        end
        
    end
    
    self.getColor = function(value)
        local value = value or false
        
        if value and type(value) == "number" then
            local colors = {[98]="\\cs(101, 237, 9)", [85]="\\cs(166, 224, 40)", [75]="\\cs(232, 232, 39)", [60]="\\cs(230, 161, 44)", [50]="\\cs(232, 106, 28)", [5]="\\cs(217, 37, 37)", [0]="\\cs(196, 0, 0)"} 
            local color  = nil
            
            if value then
                
                for i,v in pairs(colors) do
                    
                    if value >= i then
                        color = v
                    end
                    
                end
                return color
                
            end
            
        end
        return false
        
    end
    
    return self
    
end
return helpers.get()
