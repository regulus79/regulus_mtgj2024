
local flats = {
    {
        pos = vector.new(0,0.4,0),
        size = 50,
        buffer = 50,
        buildings = {
            {
                schem = minetest.get_modpath("regulus2024_mapgen") .. "/schems/LogHouse1v5.mts",
                rotation = "0",
                offset = vector.new(-15,0,-10),
                rough_size = 20,
            },
            {
                schem = minetest.get_modpath("regulus2024_mapgen") .. "/schems/TownHallv2.mts",
                rotation = "0",
                offset = vector.new(15,0,-20),
                rough_size = 25,
            },
            {
                schem = minetest.get_modpath("regulus2024_mapgen") .. "/schems/VillageHouse2v4.mts",
                rotation = "0",
                offset = vector.new(3,0,-13),
                rough_size = 10,
            },
            {
                schem = minetest.get_modpath("regulus2024_mapgen") .. "/schems/VillageHouse1v4.mts",
                rotation = "0",
                offset = vector.new(13,0,13),
                rough_size = 10,
            },
            {
                schem = minetest.get_modpath("regulus2024_mapgen") .. "/schems/Marketv4.mts",
                rotation = "0",
                offset = vector.new(-15,-1,-38),
                rough_size = 10,
            },
        },
        waypoints = {
            -- I really don't want to have to put which village this waypoint is part of in here since it should be 
            -- obvious ~but~ we need to know which village it's part of out of context, such as when it's stored in an npc and we can't get
            -- its sibling waypoints unless we know the village.
            main_intersection = {
                pos = vector.new(2,1,1),
                radius = 5,
                neighbors = {"outside_main_npc_house", "near_town_hall", "towards_marketplace"},
                village = 1
            },
            outside_main_npc_house = {
                pos = vector.new(9,1,17),
                radius = 3,
                neighbors = {"main_intersection","outside_main_npc_house_door"},
                village = 1
            },
            outside_main_npc_house_door = {
                pos = vector.new(15,1,16),
                radius = 0,
                neighbors = {"outside_main_npc_house","inside_main_npc_house_door"},
                village = 1
            },
            inside_main_npc_house_door = {
                pos = vector.new(17,1,16),
                radius = 0,
                neighbors = {"outside_main_npc_house_door","inside_main_npc_house"},
                village = 1
            },
            inside_main_npc_house = {
                pos = vector.new(19,1,18),
                radius = 2,
                neighbors = {"inside_main_npc_house_door"},
                village = 1
            },
            near_town_hall = {
                pos = vector.new(15,1,5),
                radius = 5,
                neighbors = {"main_intersection", "in_front_of_town_hall"},
                village = 1
            },
            in_front_of_town_hall = {
                pos = vector.new(24,1,2),
                radius = 1,
                neighbors = {"near_town_hall", "outside_town_hall_door"},
                village = 1
            },
            outside_town_hall_door = {
                pos = vector.new(24,1,-1),
                radius = 0,
                neighbors = {"in_front_of_town_hall", "inside_town_hall_door"},
                village = 1
            },
            inside_town_hall_door = {
                pos = vector.new(24,1,-3),
                radius = 0,
                neighbors = {"outside_town_hall_door", "inside_town_hall"},
                village = 1
            },
            inside_town_hall = {
                pos = vector.new(25,1,-10),
                radius = 2,
                neighbors = {"inside_town_hall_door"},
                village = 1
            },
            towards_marketplace = {
                pos = vector.new(0,1,-3),
                radius = 1,
                neighbors = {"center_marketplace"},
                village = 1
            },
            center_marketplace = {
                pos = vector.new(-1,1,-28),
                radius = 3,
                neighbors = {"towards_marketplace", "center_marketplace2"},
                village = 1
            },
            center_marketplace2 = {
                pos = vector.new(-8,1,-28),
                radius = 3,
                neighbors = {"center_marketplace"},
                village = 1
            },
        }
    },
    {pos = vector.new(300,0.4,0), size = 20, buffer = 20},
    {pos = vector.new(0,0.4,500), size = 30, buffer = 50},
}

-- Add lamp posts, very repetative so might as well use a loop:
lamp_posts_village1 = {
    vector.new(-4, 1, -12),
    vector.new(-4, 1, -15),
    vector.new(-6, 1, -18),
    vector.new(4, 1, -16),
    vector.new(7, 1, -20),
    vector.new(0, 1, 8),
    vector.new(3, 1, 13),
    vector.new(12, 1, 21),
    vector.new(12, 1, 11),
    vector.new(9, 1, 7),
    vector.new(6, 1, 5),
    vector.new(11, 1, -2),
    vector.new(14, 1, 1),
    vector.new(19, 1, 10),
    vector.new(25, 1, 12),
    vector.new(30, 1, 6),
}
for _, pos in pairs(lamp_posts_village1) do
    table.insert(flats[1].buildings, {
        schem = minetest.get_modpath("regulus2024_mapgen") .. "/schems/LampPostv1.mts",
        rotation = "0",
        offset = pos,
        rough_size = 3,
    })
end



local paths = {
    {start = vector.new(0,0,0), dst = vector.new(300,0,0), width = 5, randomness = 1},
    {start = vector.new(0,0,0), dst = vector.new(0,20,500), width = 5, randomness = 1},
    {start = vector.new(300,0,0), dst = vector.new(0,20,500), width = 2, randomness = 1},
    --{start = vector.new(0,0,0), dst = vector.new(-500,20,500), width = 5}
    -- Paths within village
    {start = vector.new(0,0,0), dst = vector.new(0,0,-20), width = 5, randomness = 0},
}

local path_endpoint_interp_length = 20


local dist_and_height_and_buffer_of_nearest_flat = function(x, z)
    local flat_height = -math.huge
    local dist_to_flat = math.huge
    local flat_buffer = math.huge
    for _, flatdef in pairs(flats) do
        local new_dist_to_flat = math.sqrt((x - flatdef.pos.x)*(x - flatdef.pos.x) + (z - flatdef.pos.z)*(z - flatdef.pos.z)) - flatdef.size
        -- TODO this assumes that no two plains intersect. Maybe fix sometime?
        if new_dist_to_flat < dist_to_flat then
            dist_to_flat = new_dist_to_flat
            flat_height = flatdef.pos.y
            flat_buffer = flatdef.buffer
        end
    end
    return dist_to_flat, flat_height, flat_buffer
end


local dist_to_path = function(pos, path)
    local path_start = path.start
    local path_end = path.dst
    path_start.y = 0
    local path_length = (path_end - path_start):length()
    local path_dir = (path_end - path_start) / path_length
    local along_path = ((pos - path_start)/path_length):dot(path_dir)
    if along_path <= 0 then
        return pos:distance(path_start)
    elseif along_path >= 1 then
        return pos:distance(path_end)
    else
        local path_normal = path_dir:cross(vector.new(0, 1, 0))
        -- Add some randomness to the path to make it wavy
        -- Using path start/end pos as a seed ot make paths unique
        local seed = (path_start.x - path_end.x)*10 + (path_start.y - path_end.y)*100 + (path_start.z - path_end.z)*1000
        local random_offset = path_normal * math.sin(along_path * path_length/30 + seed) * 10
        -- If near the end/start of the path, make randomness less
        if along_path * path_length < path_endpoint_interp_length then
            random_offset = random_offset * (along_path * path_length) / path_endpoint_interp_length
        elseif (1 - along_path) * path_length < path_endpoint_interp_length then
            random_offset = random_offset * ((1 - along_path) * path_length) / path_endpoint_interp_length
        end
        pos = pos + random_offset * path.randomness

        return math.abs(path_normal:dot(pos - path_start))
    end
end


return flats, paths, path_endpoint_interp_length, dist_and_height_and_buffer_of_nearest_flat, dist_to_path