regulus2024_nodes = {}

minetest.register_node("regulus2024_nodes:stone1", {
    description = "Test stone",
    tiles = {"regulus2024_stone1.png"},
    groups = {pickaxeable = 1},
})

minetest.register_node("regulus2024_nodes:dirt1", {
    description = "Test dirt",
    tiles = {"regulus2024_dirt1.png"},
    groups = {shovelable = 1},
})
for i = 1, 2 do
    minetest.register_node("regulus2024_nodes:path1_"..i, {
        description = "Test path slab"..i,
        tiles = {"regulus2024_dirt1.png"},
        groups = {shovelable = 1},
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.5, 0.5, -0.5 + i/2, 0.5}
        }
    })
end

minetest.register_node("regulus2024_nodes:dirt_with_grass1", {
    description = "Test dirt with grass",
    tiles = {
        "regulus2024_grass1.png",
        "regulus2024_dirt1.png",
        "regulus2024_dirt1.png^regulus2024_grass1_sideoverlay.png",
        "regulus2024_dirt1.png^regulus2024_grass1_sideoverlay.png",
        "regulus2024_dirt1.png^regulus2024_grass1_sideoverlay.png",
        "regulus2024_dirt1.png^regulus2024_grass1_sideoverlay.png",
    },
    groups = {shovelable = 1},
})

for i = 1,2 do
    minetest.register_node("regulus2024_nodes:wood"..i, {
        description = "Test wood"..i,
        tiles = {"regulus2024_wood"..i..".png"},
        groups = {cuttable = 1},
    })
end

for i = 1,2 do
    minetest.register_node("regulus2024_nodes:leaves"..i, {
        description = "Test leaves"..i,
        tiles = {"regulus2024_leaves"..i..".png"},
        use_texture_alpha = "blend",
        drawtype = "allfaces",
        paramtype = "light",
        groups = {cuttable = 1},
    })
end

for i = 1,2 do
    minetest.register_node("regulus2024_nodes:tree"..i, {
        description = "Test tree"..i,
        tiles = {
            "regulus2024_tree"..i..".png",
            "regulus2024_tree"..i..".png",
            "regulus2024_tree"..i.."_side.png",
            "regulus2024_tree"..i.."_side.png",
            "regulus2024_tree"..i.."_side.png",
            "regulus2024_tree"..i.."_side.png",
        },
        groups = {axeable = 1},
        paramtype2 = "facedir",
        on_place = minetest.rotate_node,
    })
end

minetest.register_node("regulus2024_nodes:cobble1", {
    description = "Test cobble",
    tiles = {"regulus2024_cobble1.png"},
    groups = {pickaxeable = 1},
})

minetest.register_node("regulus2024_nodes:gravel1", {
    description = "Test gravel",
    tiles = {"regulus2024_gravel1.png"},
    groups = {shovelable = 1},
})

for i = 1,2 do
    local nodename = "regulus2024_nodes:grassblade"..i
    minetest.register_node(nodename, {
        description = "Test grassblade"..i,
        tiles = {"regulus2024_grassblade"..i..".png"},
        walkable = false,
        buildable_to = true,
        move_resistance = 1,
        paramtype = "light",
        drawtype = "plantlike",
        paramtype2 = "meshoptions",
        groups = {cuttable = 1},
        selection_box = {
            type = "fixed",
            fixed = {-3/16, -8/16, -3/16, 3/16, -2/16, 3/16}
        }
    })
end


for i = 1,2 do
    minetest.register_node("regulus2024_nodes:glass"..i, {
        description = "Test glass"..i,
        tiles = {"regulus2024_glass"..i..".png"},
        use_texture_alpha = "blend",
        drawtype = "glasslike",
        paramtype = "light",
        groups = {pickaxeable = 1},
    })
end