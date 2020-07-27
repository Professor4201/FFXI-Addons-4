--------------------------------------------------------------------------------
-- Repo helper: Handles pulling all accounts to current accounts position.
--------------------------------------------------------------------------------
local repo = {}
function repo.new()
    local self = {}
    
    self.repo = function(x, y, z)
        
        if x and y and z then
            helpers["actions"].reposition(x, y, z)
        end
    
    end
    
    return self
    
end
return repo.new()
