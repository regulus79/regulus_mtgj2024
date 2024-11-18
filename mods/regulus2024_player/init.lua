
regulus2024_player = {}

regulus2024_player.lock_player_movement = function(player)
    player:set_physics_override({
        speed = 0,
    })
end

regulus2024_player.unlock_player_movement = function(player)
    player:set_physics_override({
        speed = 1,
    })
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

minetest.register_globalstep(function()
    if regulus2024_player.timeofday then
        minetest.set_timeofday(regulus2024_player.timeofday)
        local brightness = 1 - math.abs(regulus2024_player.timeofday - 0.5) * 2
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
    minetest.after(0, function()
        regulus2024_quests.update_quest_hud(player)
    end)
end)