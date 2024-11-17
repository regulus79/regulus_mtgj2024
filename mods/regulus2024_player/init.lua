
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

minetest.register_on_newplayer(function(player)

    regulus2024_player.timeofday = 0.79

    player:set_pos(vector.new(5,1,44))
    player:set_look_horizontal(math.pi)
    --regulus2024_cutscenes.start_intro(player)
    minetest.after(0, function()
        regulus2024_quests.add_active_quest(player, "find_a_place_to_stay")
    end)
    --minetest.set_timeofday(0.8)
end)

minetest.register_globalstep(function()
    if regulus2024_player.timeofday then
        minetest.set_timeofday(regulus2024_player.timeofday)
        local brightness = 1 - math.abs(regulus2024_player.timeofday - 0.5) * 2
        brightness = brightness * 0.25
        minetest.debug(regulus2024_player.timeofday, brightness)
        for _, player in pairs(minetest.get_connected_players()) do
            player:set_sky({
                base_color = {r = 245 * brightness, g = 130 * brightness, b = 36 * brightness},
                type = "plain",
                clouds = true,
            })
        end
    end
end)


minetest.register_on_joinplayer(function(player)
    regulus2024_player.timeofday = regulus2024_player.timeofday or minetest.get_timeofday()
end)