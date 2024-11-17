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
        paramtype = "light",
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
    },
    groups = {shovelable = 1},
})

minetest.register_node("regulus2024_nodes:dirt_with_grass_village1", {
    description = "Test dirt with grass for villages, no tree grows here, unbreakable",
    tiles = {
        "regulus2024_grass1.png",
        "regulus2024_dirt1.png",
        "regulus2024_dirt1.png^regulus2024_grass1_sideoverlay.png",
    },
    groups = {unbreakable = 1},
})

for i = 1,4 do
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
        drawtype = "allfaces_optional",
        paramtype = "light",
        groups = {cuttable = 1},
    })
end

for i = 1,3 do
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

for i = 1,2 do
    minetest.register_node("regulus2024_nodes:cobble"..i, {
        description = "Test cobble"..i,
        tiles = {"regulus2024_cobble"..i..".png"},
        groups = {pickaxeable = 1},
    })
end

minetest.register_node("regulus2024_nodes:gravel1", {
    description = "Test gravel",
    tiles = {"regulus2024_gravel1.png"},
    groups = {shovelable = 1},
})


minetest.register_node("regulus2024_nodes:lantern1", {
    description = "Test lantern1",
    tiles = {"regulus2024_lantern1.png"},
    paramtype = "light",
    groups = {pickaxeable = 1},
    light_source = 10,
})

for i = 1,2 do
    minetest.register_node("regulus2024_nodes:grassblade"..i, {
        description = "Test grassblade"..i,
        tiles = {"regulus2024_grassblade"..i..".png"},
        --walkable = false, -- Can't make them not walkable ebcause then tree placement breaks
        buildable_to = true,
        move_resistance = 1,
        paramtype = "light",
        drawtype = "plantlike",
        paramtype2 = "meshoptions",
        groups = {cuttable = 1},
        selection_box = {
            type = "fixed",
            fixed = {-3/16, -8/16, -3/16, 3/16, -2/16, 3/16}
        },
        collision_box = {
            type = "fixed",
            fixed = {0, -0.5, 0, 0, -0.5, 0},
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


for i = 1,4 do
    minetest.register_node("regulus2024_nodes:flowers"..i, {
        description = "Test flowers"..i,
        tiles = {"regulus2024_flowers"..i..".png"},
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
        },
    })
end


minetest.register_node("regulus2024_nodes:plaster1", {
    description = "Test plaster",
    tiles = {"regulus2024_plaster1.png"},
    groups = {pickaxeable = 1},
})
minetest.register_node("regulus2024_nodes:plastertile1", {
    description = "Test plaster tile",
    tiles = {"regulus2024_plastertile1.png"},
    groups = {pickaxeable = 1},
})
minetest.register_node("regulus2024_nodes:plastercrosstile1", {
    description = "Test plaster cross tile",
    tiles = {"regulus2024_plastercrosstile1.png"},
    groups = {pickaxeable = 1},
})
for i = 1, 2 do
    minetest.register_node("regulus2024_nodes:stonebrick" .. i, {
        description = "Test stone brick" .. i,
        tiles = {"regulus2024_stonebrick" .. i .. ".png"},
        groups = {pickaxeable = 1},
    })
    minetest.register_node("regulus2024_nodes:stonebrick_not_walkthrough" .. i, {
        description = "Test stone brick not walkthrough" .. i,
        tiles = {"regulus2024_stonebrick" .. i .. ".png"},
        groups = {pickaxeable = 1},
    })
    minetest.register_node("regulus2024_nodes:stonebrick_walkthrough" .. i, {
        description = "Test stone brick walkthrough" .. i,
        tiles = {"regulus2024_stonebrick" .. i .. ".png^regulus2024_stonebrick_walkthrough_overlay.png"},
        walkable = false,
        drawtype = "allfaces",
        paramtype = "light",
        groups = {pickaxeable = 1},
    })
    minetest.register_abm({
        label = "Make the stonebrick" .. i .. " walkthrough",
        nodenames = {"regulus2024_nodes:stonebrick_not_walkthrough" .. i},
        interval = 3,
        chance = 1,
        action = function(pos)
            if pos == vector.new(26, 1, -2) or pos == vector.new(26, 2, -2) then
                for _, player in pairs(minetest.get_connected_players()) do
                    if regulus2024_quests.get_completed_quests(player)["use_the_spell_of_revealing"] then
                        minetest.set_node(pos, {name = "regulus2024_nodes:stonebrick_walkthrough" .. i})
                        minetest.debug("Maek the stone walkthrough!")
                    end
                end
            end
        end
    })
end


dofile(minetest.get_modpath("regulus2024_nodes").."/books.lua")

dofile(minetest.get_modpath("regulus2024_nodes").."/stairs.lua")