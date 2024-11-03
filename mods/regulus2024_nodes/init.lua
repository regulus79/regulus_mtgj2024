minetest.register_node("regulus2024_nodes:stone1", {
    description = "Test stone",
    tiles = {"regulus2024_stone1.png"},
})

minetest.register_node("regulus2024_nodes:dirt1", {
    description = "Test dirt",
    tiles = {"regulus2024_dirt1.png"},
})

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
})

minetest.register_node("regulus2024_nodes:wood1", {
    description = "Test wood",
    tiles = {"regulus2024_wood1.png"},
})