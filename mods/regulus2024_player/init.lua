
minetest.register_on_joinplayer(function(player)
    player:set_pos(vector.new(0,1,0))
    regulus2024_cutscenes.start_intro(player)
end)