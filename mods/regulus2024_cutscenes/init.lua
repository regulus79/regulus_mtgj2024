
regulus2024_cutscenes = {}

local spb = regulus2024_music.seconds_per_beat

regulus2024_cutscenes.intro_text = {
    {text = "", length = 2},
    {text = "It was a fateful night.", length = 4},
    {text = "", length = 2},
    {text = "It was a fateful night.", length = 4},
}


regulus2024_cutscenes.darkness_cutscene1 = {
    {text = "", length = 2},
    {text = "I am darkness.", length = 4},
    {text = "", length = 2},
    {text = "You have been learning much, haven't you?", length = 4},
    {text = "", length = 2},
    {text = "You fool.", length = 1},
    {text = "", length = 2},
    {text = "The darkness knows all.", length = 4},
    {text = "The darkness knows all.\nYou cannot defeat it.", length = 4},
    {text = "", length = 4},
    {text = "This is your warning.", length = 4},
    {text = "This is your warning.\nStop learning now, and I will let you live.", length = 4},
    {text = "", length = 2},
    {text = "If you continue reading books,", length = 4},
    {text = "", length = 2},
    {text = "Know that it will end badly for you.", length = 4},
    {text = "", length = 2},
    {text = "I am darkness.", length = 4},
    {text = "", length = 2},
}

regulus2024_cutscenes.darkness_cutscene2 = {
    {text = "", length = 2},
    {text = "What have you done?", length = 4},
    {text = "", length = 2},
    {text = "I thought I warned you.", length = 4},
    {text = "", length = 2},
    {text = "The darkness is now coming after you.", length = 6},
}

regulus2024_cutscenes.darkness_cutscene3 = {
    {text = "", length = 2},
    {text = "I am darkness.", length = 4},
}

regulus2024_cutscenes.start_cutscene = function(player, cutscene_id, afterward)
    local blackscreen_id = player:hud_add({
        type = "image",
        text = "regulus2024_blackscreen.png",
        position = {x = 0.5, y = 0.5},
        scale = {x = -100, y = -110}, -- greater than 100 because it was leaving a gap of pizels at the top
        z_index = 1000,
    })
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
        player:hud_remove(blackscreen_id)
        afterward()
    end)
end

regulus2024_cutscenes.start_intro = function(player)
    local afterward = function()
        player:set_pos(vector.new(5,0.5,44))
        player:set_look_horizontal(math.pi)
    end
    regulus2024_cutscenes.start_cutscene(player, "intro_text", afterward)
end


regulus2024_cutscenes.start_darkness_cutscene1 = function(player)
    local afterward = function()
        minetest.after(2, function()
            regulus2024_player.timeofday = 0.3
        end)
    end
    regulus2024_cutscenes.start_cutscene(player, "darkness_cutscene1", afterward)
end

regulus2024_cutscenes.start_darkness_cutscene2 = function(player)
    local afterward = function()
        minetest.after(2, function()
            regulus2024_player.timeofday = 0.79
        end)
        player:set_hp(1, "punch")
        player:add_velocity(vector.new(0, 10, 0) - player:get_look_dir() * 5)
    end
    regulus2024_cutscenes.start_cutscene(player, "darkness_cutscene2", afterward)
end

regulus2024_cutscenes.start_darkness_cutscene3 = function(player)
    local afterward = function()
    end
    regulus2024_cutscenes.start_cutscene(player, "darkness_cutscene3", afterward)
end