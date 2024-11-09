
-- Village positions and buildings
local flats = {
    {
        pos = vector.new(0,0.4,0),
        size = 50,
        buffer = 50,
        buildings = {
            {
                schem = minetest.get_modpath("regulus2024_mapgen") .. "/schems/LogHouse1v1.mts",
                rotation = "0",
                offset = vector.new(-15,0,-10),
                rough_size = 20,
            },
            {
                schem = minetest.get_modpath("regulus2024_mapgen") .. "/schems/TownHallv2.mts",
                rotation = "0",
                offset = vector.new(15,0,-20),
                rough_size = 25,
            }
        }
    },
    {pos = vector.new(300,0.4,0), size = 20, buffer = 20},
    {pos = vector.new(0,0.4,500), size = 30, buffer = 50},
}

local paths = {
    {start = vector.new(0,0,0), dst = vector.new(300,0,0), width = 5, randomness = 1},
    {start = vector.new(0,0,0), dst = vector.new(0,20,500), width = 5, randomness = 1},
    {start = vector.new(300,0,0), dst = vector.new(0,20,500), width = 2, randomness = 1},
    --{start = vector.new(0,0,0), dst = vector.new(-500,20,500), width = 5}
}

local path_endpoint_interp_length = 20

local grass_blade_nodenames = {
    "regulus2024_nodes:grassblade1",
    "regulus2024_nodes:grassblade2",
}

local c_stone, c_air, c_dirt, c_dirt_with_grass, c_dirt_with_grass_village
local c_grass_blade_list = {}
local c_path_nodes_list = {}
minetest.register_on_mods_loaded(function()
    c_stone =minetest.get_content_id("mapgen_stone")
    c_dirt = minetest.get_content_id("mapgen_dirt")
    c_air = minetest.get_content_id("air")
    c_dirt_with_grass = minetest.get_content_id("mapgen_dirt_with_grass")
    c_dirt_with_grass_village = minetest.get_content_id("regulus2024_nodes:dirt_with_grass_village1")
    for _, nodename in pairs(grass_blade_nodenames) do
        table.insert(c_grass_blade_list, minetest.get_content_id(nodename))
    end
    for i = 1, 2 do
        table.insert(c_path_nodes_list, minetest.get_content_id("regulus2024_nodes:path1_"..i))
    end
end)

-- Input is slope squared because it's faster to calcuate and doesn't really matter
local nonlinearity = function(height, slope_squared)
    return height - 10 * slope_squared
end

-- Basically stacking two x^3 curves mirrored around x=0.5 to get a smooth transition
local cubic_interpolation = function(a, b, t)
    if t < 0 then
        return a
    elseif t > 1 then
        return b
    else
        if t < 0.5 then
            return a + (b-a) * t*t*t * 4
        else
            return a + (b-a) * ((t - 1)*(t - 1)*(t - 1) + 0.25) * 4
        end
    end
end

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

local map_height = function(noisemap, noise2d_idx, x, z)
    local noiseheight = noisemap[noise2d_idx]
    local sqr_distance_from_center = x*x + z*z
    -- Add mountains around the border of the map
    local outer_mountain_height = 0
    if sqr_distance_from_center > 1000*1000 then
        outer_mountain_height = (sqr_distance_from_center - 1000*1000) ^ 3 / 1000^6 * (noiseheight + 100) * 10 -- Multiplying by a positive version of the noiseheight to get more interesting mountains; better than just adding it.
    end

    local default_map_height = noiseheight + outer_mountain_height
    -- Interpolate to flat plain if nearby
    local dist_to_flat, flat_height, flat_buffer = dist_and_height_and_buffer_of_nearest_flat(x, z)
    if dist_to_flat < flat_buffer then
        if dist_to_flat > 0 then
            -- Interpolate based on distance
            local t = dist_to_flat / flat_buffer
            return cubic_interpolation(flat_height, default_map_height, t)
        else
            return flat_height, true -- Trying to save compution by telling the mapgen that we are on a village flat, so place the village grass
        end
    else
        return default_map_height
    end
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

-- Spawning villages
local spawn_buildings = function(vmanip, emin, emax)
    for _, village in pairs(flats) do
        if village.buildings then
            for _, building in pairs(village.buildings) do
                local building_min = village.pos + building.offset
                local building_max = building_min + vector.new(building.rough_size, building.rough_size, building.rough_size)
                if vector.in_area(emin, building_min, building_max) or vector.in_area(emax, building_min, building_max) or vector.in_area(building_min, emin, emax) or vector.in_area(building_max, emin, emax) then
                    print(emin,emax,minetest.place_schematic_on_vmanip(vmanip, building_min, building.schem, building.rotation))
                end
            end
        end
    end
end


-- NODE PROBABILITIES
-- Probability of being a surface node
local surface_prob = function(pos, depth, slope_squared)
    if depth < 0.5 and depth >= -0.5 then
        return 1
    else
        return 0
    end
end
-- Surface nodes
local grass_prob = function(pos, slope_squared, is_flat)
    return is_flat and 0 or 1
end
local village_grass_prob = function(pos, slope_squared, is_flat)
    return is_flat and 1 or 0
end
local snow_prob = function(pos, slope_squared)
end

local path_prob = function(pos, slope_squared)
    pos.y = 0
    local min_dist_to_path = math.huge
    local path_width = 0
    for i, v in pairs(paths) do
        local new_dist_to_path = dist_to_path(pos, v)
        if new_dist_to_path < min_dist_to_path then
            min_dist_to_path = new_dist_to_path
            path_width = v.width
        end
    end
    if min_dist_to_path < path_width then
        if min_dist_to_path < path_width / 2 then
            return 1
        else
            return (1 - min_dist_to_path / path_width) * 2
        end
    else
        return 0
    end
end

-- On-surface nodes
local on_surface_prob = function(pos, depth, slope_squared)
    if depth <= -0.5 and depth >= -1.5 then
        return 1
    else
        return 0
    end
end
local grass_blade_prob = function(pos, slope_squared)
    return 0.5
end

-- Deep nodes
local underground_prob = function(pos, depth, slope_squared)
    if depth > 0.5 then
        return 1
    else
        return 0
    end
end

local dirt_prob = function(pos, depth, slope_squared)
    if depth < 5 then
        return 1
    else
        return 0
    end
end
local stone_prob = function(pos, depth, slope_squared)
    if depth >= 5 then
        return 1
    else
        return 0
    end
end

local sample_probabilites = function(probs)
    local sum = 0
    for _, v in pairs(probs) do
        sum = sum + v
    end
    local p = math.random() * sum
    local cumulative = 0
    for i, v in pairs(probs) do
        cumulative = cumulative + v
        if cumulative > p then
            return i
        end
    end
end

-- Return node and its param2 value based on all probabilites
local sample_node_probabilities = function(pos, depth, slope_squared, seed, is_flat)
    math.randomseed(seed + pos.x + pos.y*1000 + pos.z*1000000)

    if math.random() < surface_prob(pos, depth, slope_squared) then
        -- Surface node
        local prob_of_path = path_prob(pos, slope_squared, 1)
        if math.random() < prob_of_path then
            -- If near the edge of path, use the whole nodes, not slabs
            if prob_of_path < 1 then
                return c_path_nodes_list[#c_path_nodes_list]
            else
                local level = math.ceil(2 * (0.5 + depth))
                return c_path_nodes_list[level], 0
            end
        else
            local probs = {
                [{c_dirt_with_grass, 0}] = grass_prob(pos, slope_squared, is_flat),
                [{c_dirt_with_grass_village, 0}] = village_grass_prob(pos, slope_squared, is_flat),
            }
            return unpack(sample_probabilites(probs))
        end
    elseif math.random() < on_surface_prob(pos, depth, slope_squared) then
        local probs = {
            ["grass_blade"] = grass_prob(pos, slope_squared) * (1 - path_prob(pos, slope_squared, 1)),
            ["air"] = 1,
        }
        local chosen = sample_probabilites(probs)
        if chosen == "grass_blade" then
            return c_grass_blade_list[math.random(#c_grass_blade_list)], math.random(1,4) + 8 + (math.random() < 0.5 and 16 or 0) + 32
        elseif chosen == "air" then
            return c_air, 0
        end
    elseif math.random() < underground_prob(pos, depth, slope_squared) then
        local probs = {
            [{c_dirt, 0}] = dirt_prob(pos, depth, slope_squared),
            [{c_stone, 0}] = stone_prob(pos, depth, slope_squared)
        }
        return unpack(sample_probabilites(probs))
    end
    return c_air, 0 -- Return air as default
end

-- Now for the actual generation

minetest.register_on_generated(function(vmanip, minp, maxp, blockseed)
    local noise1 = minetest.get_perlin_map({
        offset = 0,
        scale = 20,
        spread = {x = 200, y = 200, z = 200},
        seed = 0,
        octaves = 4,
        persistence = 0.5,
        lacunarity = 2
    }, maxp - minp + vector.new(1, 1, 1))
    local noisemap1 = noise1:get_2d_map_flat({x = minp.x, y = minp.z})

    local data = vmanip:get_data()
    local param2data = vmanip:get_param2_data()

    local emin, emax = vmanip:get_emerged_area()
    local area = VoxelArea(emin, emax)
    local noise2d_idx = 0
    local zstride = maxp.x - minp.x + 1
    local ystride = 0
    local xstride = 1
    for z = minp.z, maxp.z do
        for x = minp.x, maxp.x do
        
            local final_noise2d_idx = noise2d_idx + x-minp.x + 1
            local height, is_flat = map_height(noisemap1, final_noise2d_idx, x, z)
            local xslope
            --print(final_noise2d_idx, (maxp.x - minp.x + 1), (final_noise2d_idx + 1) % (maxp.x - minp.x + 1), final_noise2d_idx % (maxp.x - minp.x + 1))
            if (final_noise2d_idx + 1 - 1) % (maxp.x - minp.x + 1) + 1 > (final_noise2d_idx - 1) % (maxp.x - minp.x + 1) + 1 then
                xslope = map_height(noisemap1, final_noise2d_idx + 1, x, z) - height
            else
                xslope = height - map_height(noisemap1, final_noise2d_idx - 1, x, z)
            end
            local zslope
            if final_noise2d_idx + zstride <= #noisemap1 then
                zslope = map_height(noisemap1, final_noise2d_idx + zstride, x, z) - height
            else
                zslope = height - map_height(noisemap1, final_noise2d_idx - zstride, x, z)
            end
            local slope_squared = xslope * xslope + zslope * zslope
            local final_height = nonlinearity(height, slope_squared)

            for y = minp.y, maxp.y do
                local pos = vector.new(x, y, z)
                local idx = area:indexp(pos)
                local depth = final_height - y

                data[idx], param2data[idx] = sample_node_probabilities(pos, depth, slope_squared, blockseed, is_flat)
            end
        end
        noise2d_idx = noise2d_idx + zstride
    end
    vmanip:set_data(data)
    vmanip:set_param2_data(param2data)
    spawn_buildings(vmanip, emin, emax)
    minetest.generate_decorations(vmanip)
    vmanip:calc_lighting()
end)