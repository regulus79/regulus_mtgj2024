
local flats = {
    {pos = vector.new(0,0,0), size = vector.new(50,50,50)},
}




local c_stone, c_air, c_dirt
minetest.register_on_mods_loaded(function()
    c_stone =minetest.get_content_id("mapgen_stone")
    c_dirt = minetest.get_content_id("mapgen_dirt")
    c_air = minetest.get_content_id("air")
    c_dirt_with_grass = minetest.get_content_id("mapgen_dirt_with_grass")
end)

-- Input is slope squared because it's faster to calcuate and doesn't really matter
local nonlinearity = function(height, slope_squared)
    return height * 1 / (1 + 1*slope_squared)
end

local map_height = function(noisemap, noise2d_idx, x, z)
    local noiseheight = noisemap[noise2d_idx]
    local sqr_distance_from_center = x*x + z*z
    -- higher powers to distance to get mountains to rise up steeply and abruptly
    local outer_mountain_height = 1000 *
        math.floor(sqr_distance_from_center / 1000000) * 
        math.floor(sqr_distance_from_center / 1000000) * 
        math.floor(sqr_distance_from_center / 1000000) * 
        math.floor(sqr_distance_from_center / 1000000) * 
        math.floor(sqr_distance_from_center / 1000000) * 
        math.floor(sqr_distance_from_center / 1000000)
    return noiseheight + outer_mountain_height
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
    math.randomseed(seed)
    local air = air_prob(pos, depth, slope_squared)
    if math.random() < air then
        return c_air
    end

    local surface = surface_prob(pos, depth, slope_squared)
    if math.random() < surface then
        -- Surface node
        local probs = {
            [c_dirt_with_grass] = grass_prob(pos, slope_squared)
        }
        return c_dirt_with_grass--sample_probabilites(probs)
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