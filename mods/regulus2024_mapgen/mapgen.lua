
local flats = {
    {pos = vector.new(0,0,0), size = 50, buffer = 50},
    {pos = vector.new(300,0,0), size = 20, buffer = 20},
    {pos = vector.new(0,20,500), size = 50, buffer = 50},
}

local paths = {
    {start = vector.new(0,0,0), dst = vector.new(300,0,0), width = 5, randomness = 1},
    {start = vector.new(0,0,0), dst = vector.new(0,20,500), width = 5, randomness = 1},
    {start = vector.new(300,0,0), dst = vector.new(0,20,500), width = 2, randomness = 1},
    --{start = vector.new(0,0,0), dst = vector.new(-500,20,500), width = 5}
}

local path_endpoint_interp_length = 20


local c_stone, c_air, c_dirt
minetest.register_on_mods_loaded(function()
    c_stone =minetest.get_content_id("mapgen_stone")
    c_dirt = minetest.get_content_id("mapgen_dirt")
    c_air = minetest.get_content_id("air")
    c_dirt_with_grass = minetest.get_content_id("mapgen_dirt_with_grass")
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
    if dist_to_flat < flat_buffer then
        if dist_to_flat > 0 then
            -- Interpolate based on distance
            local t = dist_to_flat / flat_buffer
            return cubic_interpolation(flat_height, default_map_height, t)
        else
            return flat_height
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


-- NODE PROBABILITIES
-- Probability of air
local air_prob = function(pos, depth, slope_squared)
    if depth < 0 then
        return 1
    else
        return 0
    end
end
-- Probability of being a surface node
local surface_prob = function(pos, depth, slope_squared)
    if depth < 1 then
        return 1
    else
        return 0
    end
end
-- Surface nodes
local grass_prob = function(pos, slope_squared)
    return 1
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
-- Deep nodes
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
-- Return node based on all probabilites
local sample_node_probabilities = function(pos, depth, slope_squared, seed)
    math.randomseed(seed + pos.x + pos.y*1000 + pos.z*1000000)
    local air = air_prob(pos, depth, slope_squared)
    if math.random() < air then
        return c_air
    end

    local surface = surface_prob(pos, depth, slope_squared)
    if math.random() < surface then
        -- Surface node
        if math.random() < path_prob(pos, slope_squared, 1) then
            return c_dirt
        else
            local probs = {
                [c_dirt_with_grass] = grass_prob(pos, slope_squared),
            }
            return sample_probabilites(probs)
        end
    else
        local probs = {
            [c_dirt] = dirt_prob(pos, depth, slope_squared),
            [c_stone] = stone_prob(pos, depth, slope_squared)
        }
        return sample_probabilites(probs)
    end
    return c_air -- Just in case as default
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
    local emin, emax = vmanip:get_emerged_area()
    local area = VoxelArea(emin, emax)
    local noise2d_idx = 0
    local zstride = maxp.x - minp.x + 1
    local ystride = 0
    local xstride = 1
    for z = minp.z, maxp.z do
        for x = minp.x, maxp.x do
        
            local final_noise2d_idx = noise2d_idx + x-minp.x + 1
            local height = map_height(noisemap1, final_noise2d_idx, x, z)
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

                data[idx] = sample_node_probabilities(pos, depth, slope_squared, blockseed)
            end
        end
        noise2d_idx = noise2d_idx + zstride
    end
    vmanip:set_data(data)
end)