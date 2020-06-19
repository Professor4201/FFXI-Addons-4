--------------------------------------------------------------------------------
-- Bootstrap to load all includes, and settings.
--------------------------------------------------------------------------------
res     = require("resources")
files   = require("files")
packets = require("packets")
texts   = require("texts")
sets    = require("sets")
images  = require('images')
queues  = require("queues")
extdata = require("extdata")
          require("strings")
          require("lists")
          require("tables")
          require("chat")
          require("logger")
          require("pack")

function bpBootstrap()    
    local zone   = windower.ffxi.get_info().zone
    
                   require("bp/helpers/iterator")
    settings     = require("bp/settings/settings")
    bpcore       = require("bp/bpcore")
    warps        = require("bp/resources/warps")
    npcs         = bpcore:handleSettings("bp/resources/npc/"..zone.."/npc", {})
    gather       = bpcore:handleSettings("bp/resources/gather/"..zone.."/gather", {})
    JSON         = loadfile(windower.addon_path.."bp/libraries/JSON.lua")()
    
end