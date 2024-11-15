
regulus2024_cutscenes = {}

local spb = regulus2024_music.seconds_per_beat

regulus2024_cutscenes.intro_text = {
    {text = "It was a fateful night.", length = 4},
    {text = "It was a fateful night.\nThe village was deep in slumber, when suddenly everyone heard it.", length = 10 - 4},
    {text = "", length = 2},
    {text = "A piercing cry from over the mountain.", length = 6},
    {text = "", length = 2},
    {text = "It was the monster, a magical beast of old.\nIt desired only to spread terror and destruction wherever it went.", length = 12},
    {text = "", length = 2},
    {text = "It came flying across the plains at a horrible speed.", length = 8},
    {text = "", length = 2},
    {text = "As it approached the village it cast a spell which put fear in the hearts of all.", length = 8},
    {text = "As it approached the village it cast a spell which put fear in the hearts of all.\nEveryone who saw it, even the guards, became frozen in terror.", length = 8},
    {text = "", length = 2},
    {text = "No one could challenge it.", length = 6},
    {text = "No one could challenge it.\nExcept for one man.", length = 4},
    {text = "", length = 2},
    {text = "He stood in the village street facing the monster with his staff firm in his hand and his hat tall upon his head.", length = 8},
    {text = "", length = 2},
    {text = "It was the wizard.", length = 2},
    {text = "", length = 2},
    {text = "He fought with the beast and chased it to it's den in the mountains.", length = 6},
    {text = "", length = 2},
    {text = "Back in the village, a dying roar was heard in the distance.", length = 4},
    {text = "Back in the village, a dying roar was heard in the distance.\nEveryone celebrated that the wizard had killed the monster.", length = 4},
    {text = "", length = 2},
    {text = "There would be peace again.", length = 4},
    {text = "", length = 4},
    {text = "But the wizard never came back.", length = 6},
    {text = "", length = 4},
    {text = "Soon after, reports were heard of the monster roaming the plains below the mountains.", length = 8},
    {text = "", length = 4},
    {text = "It had not been killed.", length = 8},
}

regulus2024_cutscenes.start_intro = function(player)
    local blackscreen_id = player:hud_add({
        type = "image",
        text = "regulus2024_blackscreen.png",
        position = {x = 0.5, y = 0.5},
        scale = {x = -100, y = -110}, -- greater than 100 because it was leaving a gap of pizels at the top
        z_index = 1000,
    })
    local time = 0
    for i, line in ipairs(regulus2024_cutscenes.intro_text) do
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
        time =time + spb(line.length)
    end
    minetest.after(time, function()
        player:hud_remove(blackscreen_id)
    end)
end