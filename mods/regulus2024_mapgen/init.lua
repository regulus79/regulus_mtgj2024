-- these are unused we can delete them NO WAIT GOTTA REMOVE EM FROM MAPGEN.LUA
minetest.register_alias("mapgen_stone", "regulus2024_nodes:stone1")
minetest.register_alias("mapgen_dirt", "regulus2024_nodes:dirt1")
minetest.register_alias("mapgen_dirt_with_grass", "regulus2024_nodes:dirt_with_grass1")
minetest.register_alias("mapgen_sand", "regulus2024_nodes:stone1")
minetest.register_alias("mapgen_water_source", "regulus2024_nodes:stone1")
minetest.register_alias("mapgen_lava_source", "regulus2024_nodes:stone1")
minetest.register_alias("mapgen_cobble", "regulus2024_nodes:stone1")
minetest.register_alias("mapgen_tree", "regulus2024_nodes:stone1")
minetest.register_alias("mapgen_leaves", "regulus2024_nodes:stone1")
minetest.register_alias("mapgen_apple", "regulus2024_nodes:stone1")


minetest.register_mapgen_script(minetest.get_modpath("regulus2024_mapgen") .. "/mapgen.lua")

--[[
minetest.register_on_generated(function(minp, maxp, blockseed)

end)
]]
for i=1,2 do
    minetest.register_decoration({
        name = "regulus2024_mapgen:tree2_"..i,
        deco_type = "schematic",
        place_on = {"regulus2024_nodes:dirt_with_grass1"},
        sidelen = 16,
        noise_params = {
            offset = 0,
            scale = 0.1,
            spread = {x = 100, y = 100, z = 100},
            seed = 0,
            octaves = 3,
            persistence = 0.5,
            lacunarity = 2,
        },
        schematic = minetest.get_modpath("regulus2024_mapgen") .. "/schems/tree2_"..i..".mts",
        flags = "place_center_x, place_center_z",
        place_offset_y = 1,
        rotation = "random",
    })
end

for i=1,4 do
    minetest.register_decoration({
        name = "regulus2024_mapgen:flowers"..i,
        deco_type = "simple",
        decoration = "regulus2024_nodes:flowers"..i,
        place_on = {"regulus2024_nodes:dirt_with_grass1"}, -- TODO, should it spawn in villages too?
        sidelen = 8,
        noise_params = {
            offset = -8,
            scale = 10,
            spread = {x = 100, y = 100, z = 100},
            seed = 0 + i,
            octaves = 1,
            persistence = 0.5,
            lacunarity = 2,
        },
        place_offset_y = 0,
        param2 = 8 + 32 + 0,
        param2_max = 8 + 32 + 4,
    })
end
