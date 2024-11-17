
local villages = dofile(minetest.get_modpath("regulus2024_mapgen") .. "/mapdata.lua")

regulus2024_spells = {}

regulus2024_spells.spells = {
    reveal = {
        phrase = "reveal et reveala",
        func = function(player)
            minetest.set_node(vector.new(-26, 1, -2), {name = "regulus2024_nodes:stonebrick_walkthrough2"})
            minetest.set_node(vector.new(-26, 2, -2), {name = "regulus2024_nodes:stonebrick_walkthrough2"})
        end
    },
    banish = {
        phrase = "banisha darknessa",
        func = function(player)
            local books_on_pedestals = {
                minetest.get_node(villages[2].pos + vector.new(0, 4, -2)).name,
                minetest.get_node(villages[2].pos + vector.new(0, 4, 2)).name,
                minetest.get_node(villages[2].pos + vector.new(-2, 4, 0)).name,
                minetest.get_node(villages[2].pos + vector.new(2, 4, 0)).name,
            }
            local is_book_of_light_there = false
            local is_book_of_darkness_there = false
            local is_book_of_truth_there = false
            local is_book_of_lies_there = false
            for _, nodename in pairs(books_on_pedestals) do
                if nodename == "regulus2024_nodes:book_open_the_book_of_light" then
                    is_book_of_light_there = true
                elseif nodename == "regulus2024_nodes:book_open_the_book_of_darkness" then
                    is_book_of_darkness_there = true
                elseif nodename == "regulus2024_nodes:book_open_the_book_of_truth" then
                    is_book_of_truth_there = true
                elseif nodename == "regulus2024_nodes:book_open_the_book_of_lies" then
                    is_book_of_lies_there = true
                end
            end
            if is_book_of_light_there and is_book_of_darkness_there and is_book_of_lies_there and is_book_of_lies_there then
                minetest.debug("You win!")
                regulus2024_quests.complete_quest(player, "banish_the_darkness")
            end
        end
    }
}

minetest.register_on_chat_message(function(name, message)
    local player = minetest.get_player_by_name(name)
    for spell_id, spell in pairs(regulus2024_spells.spells) do
        if spell.phrase == message then
            spell.func(player)
            regulus2024_quests.on_cast_spell(player, spell_id)
            return true
        end
    end
    minetest.chat_send_all("<player> "..minetest.colorize("#00AAFF", message))
    return true
end)