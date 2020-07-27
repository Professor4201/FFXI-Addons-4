local globals = {}
    
--------------------------------------------------------------------------------
-- Incoming Text Event.
--------------------------------------------------------------------------------
globals[1] = function(original, modified, o_mode, m_mode, blocked)
    local message = (original):strip_format() or ""
    --print(o_mode, message)
    if message ~= "" and o_mode == 150 then
        local filtered = helpers["filter"].filter(message, o_mode)
        
    end
    
end

return globals