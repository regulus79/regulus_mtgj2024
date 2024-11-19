

if minetest.is_creative_enabled() then
    minetest.register_tool(":",{
        tool_capabilities = {
            groupcaps = {
                unbreakable = {maxlevel = 1, times = {0.2}},
                shovelable = {maxlevel = 1, times = {0.2}},
                pickaxeable = {maxlevel = 1, times = {0.2}},
                axeable = {maxlevel = 1, times = {0.2}},
                cuttable = {maxlevel = 1, times = {0.2}},
                breakable_by_hand = {maxlevel = 1, times = {0.2}},
            }
        }
    })
else
    minetest.register_tool(":",{
        inventory_image = "blank.png",
        wield_image = "regulus2024_hand.png",
        wield_scale = {x = 1, y = 1, z = 3},
        tool_capabilities = {
            groupcaps = {
                breakable_by_hand = {maxlevel = 1, times = {0.2}},
            }
        }
    })
end

minetest.register_craftitem("regulus2024_admintools:screwdriver", {
    description = "Screwdriver",
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.under then
            local node = minetest.get_node(pointed_thing.under)
            node.param2 = (node.param2 - node.param2 % 4) + (node.param2 % 4 + 1) % 4
            minetest.set_node(pointed_thing.under, node)
        end
    end,
    on_place = function(itemstack, user, pointed_thing)
        if pointed_thing.under then
            local node = minetest.get_node(pointed_thing.under)
            node.param2 = (node.param2 + 4) % (4*6)
            minetest.set_node(pointed_thing.under, node)
        end
    end
})