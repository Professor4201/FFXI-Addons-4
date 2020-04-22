local files = require("files")

write_settings = function(file, data)
    local f = files.new(file .. ".lua")
    if f:exists() then
        f:write('return ' .. T(data):tovstring())
    end
    return false
end

get_settings = function(file, data)
    local data = data or {}
    local f = files.new(file .. ".lua")
    if not f:exists() then
        f:write('return ' .. T(data):tovstring())
        return require(file)
    else
        return require(file)
    end
    return false
end