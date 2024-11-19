
regulus2024_cutscenes = {}

local spb = regulus2024_music.seconds_per_beat

regulus2024_cutscenes.intro_text = {
    {text = "", length = 2},
    {text = "The world was filled with darkness.", length = 4},
    {text = "", length = 2},
    {text = "And the darkness could not be defeated.", length = 4},
    {text = "", length = 2},
    {text = "Not even the greatest wizard or warrior could challenge it.", length = 6},
    {text = "", length = 2},
    {text = "But legends say that there is a way to bansh it forever.", length = 6},
    {text = "", length = 2},
    {text = "Somewhere in the village, there is a magical library.", length = 6},
    {text = "", length = 2},
    {text = "Find it, and you will discover the knowledge to conquer the darkness.", length = 6},
    {text = "", length = 2},
}


regulus2024_cutscenes.darkness_cutscene1 = {
    {text = "", length = 2},
    {text = "I am darkness.", length = 4},
    {text = "", length = 2},
    {text = "You have been learning much, haven't you?", length = 4},
    {text = "", length = 2},
    {text = "You fool.", length = 2},
    {text = "", length = 2},
    {text = "The darkness knows all.", length = 4},
    {text = "The darkness knows all.\nYou cannot defeat it.", length = 4},
    {text = "", length = 2},
    {text = "This is your warning.", length = 4},
    {text = "This is your warning.\nStop learning now, and I will let you live.", length = 4},
    {text = "", length = 2},
    {text = "If you continue reading books,", length = 4},
    {text = "", length = 2},
    {text = "Know that it will end badly for you.", length = 4},
    {text = "", length = 2},
    {text = "I am darkness.", length = 4},
}

regulus2024_cutscenes.darkness_cutscene2 = {
    {text = "", length = 2},
    {text = "What have you done?", length = 4},
    {text = "", length = 2},
    {text = "I thought I warned you.", length = 4},
    {text = "", length = 2},
    {text = "The darkness is coming after you.", length = 6},
}

regulus2024_cutscenes.outro_text = {
    {text = "", length = 2},
    {text = "You have done it.", length = 2},
    {text = "", length = 2},
    {text = "The darkness is no more.", length = 4},
    {text = "", length = 2},
    {text = "Thank you, traveller, for your help.", length = 4},
    {text = "", length = 2},
}

regulus2024_cutscenes.start_cutscene = function(player, cutscene_id, afterward, blackscreen)
    local blackscreen_id
    if blackscreen then
        blackscreen_id = player:hud_add({
            type = "image",
            text = "regulus2024_blackscreen.png",
            position = {x = 0.5, y = 0.5},
            scale = {x = -100, y = -110}, -- greater than 100 because it was leaving a gap of pizels at the top
            z_index = 1000,
        })
    end
    local time = 0
    for i, line in ipairs(regulus2024_cutscenes[cutscene_id]) do
        minetest.after(time, function()
            local id = player:hud_add({
                type = "text",
                text = line.text,
                position = {x = 0.5, y = 0.75},
                size = {x = 2},
                style = 1,
                z_index = 1001,
                alignment = {x = 0, y = 1},
                number = 0xFFFFFF
            })
            minetest.after(spb(line.length), function()
                player:hud_remove(id)
            end)
        end)
        time = time + spb(line.length)
    end
    minetest.after(time, function()
        if blackscreen then
            player:hud_remove(blackscreen_id)
        end
        afterward()
    end)
end

regulus2024_cutscenes.start_intro = function(player)
    local afterward = function()
        player:set_pos(vector.new(5,0.5,44))
        player:set_look_horizontal(math.pi)
    end
    regulus2024_cutscenes.start_cutscene(player, "intro_text", afterward, true)
end


regulus2024_cutscenes.start_darkness_cutscene1 = function(player)
    regulus2024_player.timeofday = 0.79
    regulus2024_player.lock_player_movement(player)
    local look_dir_horizontal = player:get_look_dir()
    look_dir_horizontal.y = 0
    look_dir_horizontal = look_dir_horizontal:normalize()
    local darkness_pos = player:get_pos() + look_dir_horizontal * 10 + vector.new(0, 3, 0)
    local darkness_obj = minetest.add_entity(darkness_pos, "regulus2024_npcs:darkness")
    local afterward = function()
        darkness_obj:remove()
        minetest.after(2, function()
            regulus2024_player.timeofday = 0.3
            regulus2024_player.unlock_player_movement(player)
        end)
    end
    regulus2024_cutscenes.start_cutscene(player, "darkness_cutscene1", afterward, false)
end

regulus2024_cutscenes.start_darkness_cutscene2 = function(player)
    regulus2024_player.timeofday = 0.79
    regulus2024_player.lock_player_movement(player)
    local look_dir_horizontal = player:get_look_dir()
    look_dir_horizontal.y = 0
    look_dir_horizontal = look_dir_horizontal:normalize()
    local darkness_pos = player:get_pos() + look_dir_horizontal * 10 + vector.new(0, 3, 0)
    local darkness_obj = minetest.add_entity(darkness_pos, "regulus2024_npcs:darkness")
    local afterward = function()
        regulus2024_player.unlock_player_movement(player)
        darkness_obj:remove()
        minetest.after(2, function()
            regulus2024_player.timeofday = 0.3
        end)
        player:set_hp(1, "punch")
        player:add_velocity(vector.new(0, 10, 0) - player:get_look_dir() * 5)
    end
    regulus2024_cutscenes.start_cutscene(player, "darkness_cutscene2", afterward, false)
end

regulus2024_cutscenes.start_outro = function(player)
    local afterward = function()
        minetest.disconnect_player(player:get_player_name(), "You completed the game.")
    end
    regulus2024_cutscenes.start_cutscene(player, "outro_text", afterward, true)
end