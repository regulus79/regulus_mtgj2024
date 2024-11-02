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