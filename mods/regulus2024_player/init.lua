
minetest.register_on_joinplayer(function(player) -- make newplayer in production
    player:set_pos(vector.new(5,1,44))
    player:set_look_horizontal(math.pi)
    --regulus2024_cutscenes.start_intro(player)
    regulus2024_quests.add_active_quest(player, "find_a_place_to_stay")
    minetest.set_timeofday(0.8)
end)