
stair_nodes = {
    "regulus2024_nodes:tree1",
    "regulus2024_nodes:tree2",
    "regulus2024_nodes:tree3",
    "regulus2024_nodes:wood1",
    "regulus2024_nodes:wood2",
    "regulus2024_nodes:wood3",
    "regulus2024_nodes:cobble1",
    "regulus2024_nodes:cobble2",
    "regulus2024_nodes:gravel1",
    "regulus2024_nodes:plaster1",
    "regulus2024_nodes:plastertile1",
    "regulus2024_nodes:plastercrosstile1",
    "regulus2024_nodes:stonebrick1",
    "regulus2024_nodes:glass2",
    "regulus2024_nodes:lantern1",
}

stairshapes = {
    slab = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
    middleslab = {-0.5, -0.25, -0.5, 0.5, 0.25, 0.5},
    stair = {
        {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        {-0.5, 0, 0, 0.5, 0.5, 0.5}
    },
    cornerstair = {
        {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        {0, 0, 0, 0.5, 0.5, 0.5}
    },
    outerstair = {
        {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
        {-0.5, 0, 0, 0.5, 0.5, 0.5},
        {0, 0, 0, -0.5, 0.5, -0.5}
    },
    step = {
        {-0.5, -0.5, 0, 0.5, 0, 0.5}
    },
    block = {
        {0, -0.5, 0, 0.5, 0, 0.5}
    },
    pillar = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
    widepillar = {-5/16, -0.5, -5/16, 5/16, 0.5, 5/16},
    shortpillar = {-0.25, -0.5, -0.25, 0.25, 2/16, 0.25},
    wideshortpillar = {-5/16, -0.5, -5/16, 5/16, 2/16, 5/16},
    pole = {-2/16, -0.5, -2/16, 2/16, 0.5, 2/16},
}

for _, nodename in pairs(stair_nodes) do
    normal_def = minetest.registered_nodes[nodename]
    for stairname, stairshape in pairs(stairshapes) do
        copied_def = {}
        for k,v in pairs(normal_def) do
            copied_def[k] = v
        end
        copied_def.drawtype = "nodebox"
        copied_def.node_box = {type = "fixed", fixed = stairshape}
        copied_def.paramtype = "light"
        copied_def.paramtype2 = "facedir"
        copied_def.on_place = minetest.rotate_node
        copied_def.description = copied_def.description .. " " .. stairname
        minetest.register_node(nodename .. "_" .. stairname, copied_def)
    end
end