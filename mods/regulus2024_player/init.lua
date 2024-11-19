
regulus2024_player = {}

regulus2024_player.lock_player_movement = function(player)
    local obj = minetest.add_entity(player:get_pos(), "regulus2024_npcs:player_stop_movement")
    player:set_physics_override({
        speed = 0,
    })
    player:set_attach(obj)
    player:set_velocity(vector.new(0,0,0))
end

regulus2024_player.unlock_player_movement = function(player)
    player:set_physics_override({
        speed = 1,
    })
    player:set_detach()
end

regulus2024_player.timeofday = nil
regulus2024_player.normal_sky = false

minetest.register_on_newplayer(function(player)

    regulus2024_player.timeofday = 0.79

    player:set_pos(vector.new(5,1,44))
    player:set_look_horizontal(math.pi)
    regulus2024_cutscenes.start_intro(player)
    minetest.after(0, function()
        regulus2024_quests.add_active_quest(player, "find_a_place_to_stay")
    end)
    --minetest.set_timeofday(0.8)
end)

minetest.register_globalstep(function(dtime)
    if regulus2024_player.timeofday then
        local new_timeofday = minetest.get_timeofday() + (regulus2024_player.timeofday - minetest.get_timeofday()) * math.sqrt(dtime) -- is the sqrt right? idk
        minetest.set_timeofday(new_timeofday)
        local brightness = 1 - math.abs(new_timeofday - 0.5) * 2
        if not regulus2024_player.normal_sky then
            brightness = brightness * 0.25
        end
        for _, player in pairs(minetest.get_connected_players()) do
            if regulus2024_player.normal_sky then
                player:set_sky({
                    base_color = {r = 245 * brightness, g = 200 * brightness, b = 150 * brightness},
                    type = "plain",
                    clouds = true,
                })
            else
                player:set_sky({
                    base_color = {r = 250 * brightness, g = 250 * brightness, b = 250 * brightness},
                    type = "plain",
                    clouds = true,
                })
            end
        end
    end
end)


minetest.register_on_joinplayer(function(player)
    regulus2024_player.timeofday = regulus2024_player.timeofday or minetest.get_timeofday()
    player:set_inventory_formspec(table.concat({
        "size[8,4]",
        "background9[0,0;0,0;regulus2024_dialogue_background1.png;true;16]",
        "list[current_player;main;0,0;8,4;]",
    }, "\n"))
    local props = player:get_properties()
    props.visual = "mesh"
    props.mesh = "regulus2024_player2.glb"
    props.textures = {"regulus2024_villager_skin5.png"}
    props.visual_size = vector.new(1,1,1)
    player:set_properties(props)
    minetest.after(0, function()
        regulus2024_quests.update_quest_hud(player)
    end)
end)

local _min_speed = 0.5
local _walk_cycle_position = 0
local _stride_length = 1
local _leg_length = 0.6985
local _scale = 1

local get_leg_back_and_forth = function(t)
    t = t - math.floor(t)
    if t < 0.5 then
        return t
    else
        return 0.5 - (t - 0.5)
    end
end

minetest.register_globalstep(function(dtime)
    for _, player in pairs(minetest.get_connected_players()) do
        local control = player:get_player_control()
        if control.up or control.down or control.right or control.left then
            local horizontal_vel = player:get_velocity()
            horizontal_vel.y = 0

            _walk_cycle_position = _walk_cycle_position + dtime * horizontal_vel:length() / (_stride_length * _scale) / (_leg_length * _scale) / 2

            local angle_left = (get_leg_back_and_forth(_walk_cycle_position) - 0.25) * math.pi
            local angle_right = (get_leg_back_and_forth(_walk_cycle_position + 0.5) - 0.25)* math.pi

            player:set_bone_override("LegL", {
                rotation = {vec = vector.new(angle_left, 0, 0), absolute = true}
            })
            player:set_bone_override("LegR", {
                rotation = {vec = vector.new(angle_right, 0, 0), absolute = true}
            })
            player:set_bone_override("ArmL", {
                rotation = {vec = vector.new(angle_right/2, 0, 0), absolute = true}
            })
            player:set_bone_override("ArmR", {
                rotation = {vec = vector.new(angle_left/2, 0, 0), absolute = true}
            })
        else
            --self.object:set_velocity(vector.new(0, self.object:get_velocity().y, 0)) --- BAd idea, not good, migth want to use vel in other code
            player:set_bone_override("LegL", {
                rotation = {vec = vector.new(0, 0, 0), absolute = true, interpolation = 0.25}
            })
            player:set_bone_override("LegR", {
                rotation = {vec = vector.new(0, 0, 0), absolute = true, interpolation = 0.25}
            })
            player:set_bone_override("ArmL", {
                rotation = {vec = vector.new(0, 0, 0), absolute = true, interpolation = 0.25}
            })
            player:set_bone_override("ArmR", {
                rotation = {vec = vector.new(0, 0, 0), absolute = true, interpolation = 0.25}
            })
        end
    end
end)