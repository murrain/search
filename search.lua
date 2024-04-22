_addon.name = 'search'
_addon.author = 'ainais'
_addon.version = '1.0.0'
_addon.commands = {'search', 'sea'}

require('logger')
res = require('resources')

function check_for_zone(str)
    -- zone auto translate strings start with this pattern
    local pattern = {253, 2, 2, 20}
    if #str >= #pattern then
        for i, byte in ipairs(pattern) do
            local strByte = string.byte(str, i)
            if strByte ~= byte then return false end
        end
        return true
    else
        return false
    end
end

windower.register_event('load', function() end)

windower.register_event('addon command', function(...)
    local args = T {...}:map(string.lower)
    local cmd = args[1]
    args:remove(1)
    local argc = #args

    zone_string = cmd
    if (check_for_zone(cmd)) then
        zone_id = string.byte(cmd, 5) + 5120
        zone_string = res.auto_translates[zone_id].en
    end
    for _, zone in pairs(res.zones) do
        if zone.en:lower() == zone_string:lower() then
            windower.add_to_chat(207, "Searching zone: " .. zone.en)
            windower.chat.input('/sea ' .. zone.search)
            return
        end
    end
    windower.add_to_chat(207, "Search failed.")
end)
