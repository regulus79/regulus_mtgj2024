

if minetest.is_creative_enabled() then
    minetest.register_tool(":",{
        tool_capabilities = {
            groupcaps = {
                unbreakable = {maxlevel = 1, times = {0.2}},
                shovelable = {maxlevel = 1, times = {0.2}},
                pickaxeable = {maxlevel = 1, times = {0.2}},
                axeable = {maxlevel = 1, times = {0.2}},
                cuttable = {maxlevel = 1, times = {0.2}},
            }
        }
    })
end