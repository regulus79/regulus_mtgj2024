
local villages = dofile(minetest.get_modpath("regulus2024_mapgen") .. "/mapdata.lua")

regulus2024_quests.quests = {
    find_a_place_to_stay = {
        type = "custom",
        hud_text = "Find a place to stay the night",
        on_start_quest = function(player, questdata)
            questdata.num_villagers_encountered = 0
        end,
        on_finish_dialogue = function(player, dialogue_id, questdata)
            if dialogue_id == "find_a_place_to_stay1" or dialogue_id == "find_a_place_to_stay2" or dialogue_id == "find_a_place_to_stay3" then
                questdata.num_villagers_encountered = questdata.num_villagers_encountered + 1
            end
            if questdata.num_villagers_encountered == 3 then
                regulus2024_quests.complete_quest(player, "find_a_place_to_stay")
                regulus2024_quests.add_active_quest(player, "ask_wizard_for_place_to_stay")
            end
        end
    },
    ask_wizard_for_place_to_stay = {
        type = "complete_dialogue",
        hud_text = "Ask the Wizard",
        dialogue_id = "ask_wizard_for_place_to_stay",
        on_complete = function(player, questdata)
            -- Find the npc. UGH this is bad but it's the only way I know of, since you can't serialize objects to store in meta, cuz like what if they rejoin?
            for object in minetest.objects_inside_radius(player:get_pos(), 8) do
                if not object:is_player() and object:get_luaentity().name == "regulus2024_npcs:oldman" then
                    object:get_luaentity()._target_waypoint = villages[1].waypoints.inside_library_second_room_center
                    object:get_luaentity()._state = "walk_to_waypoint"
                end
            end
            regulus2024_quests.add_active_quest(player, "go_inside_the_house")
        end
    },
    go_inside_the_house = {
        type = "go_to_pos",
        hud_text = "Follow the Wizard",
        pos = vector.new(-15,0,0),
        radius = 3,
        on_complete = function(player, questdata)
            regulus2024_quests.add_active_quest(player, "talk_to_wizard_again")
        end
    },
    talk_to_wizard_again = {
        type = "complete_dialogue",
        hud_text = "Talk to the Wizard",
        dialogue_id = "talk_to_wizard_again",
        on_complete = function(player, questdata)
            for object in minetest.objects_inside_radius(player:get_pos(), 8) do
                if not object:is_player() and object:get_luaentity().name == "regulus2024_npcs:oldman" then
                end
            end
            regulus2024_quests.add_active_quest(player, "go_to_the_bedroom")
        end
    },
    go_to_the_bedroom = {
        type = "go_to_pos",
        hud_text = "Find the bedroom",
        pos = vector.new(-18.5,4.5,-6.5),
        radius = 2,
        on_complete = function(player, questdata)
            regulus2024_quests.add_active_quest(player, "read_the_book_on_floor")
        end
    },
    read_the_book_on_floor = {
        type = "read_book",
        book_id = "bedroom_book",
        hud_text = "Read the book on the floor",
        on_complete = function(player, questdata)
            regulus2024_quests.add_active_quest(player, "read_more_bedroom_books")
        end
    },
    read_more_bedroom_books = {
        type = "custom",
        hud_text = "Find more books",
        on_start_quest = function(player, questdata)
            questdata.num_books_read = 0
        end,
        on_read_book = function(player, book_id, questdata)
            if book_id == "bedroom_book2" or book_id == "bedroom_book3" then
                questdata.num_books_read = questdata.num_books_read + 1
            end
            if questdata.num_books_read >= 2 then
                regulus2024_quests.complete_quest(player, "read_more_bedroom_books")
                regulus2024_quests.add_active_quest(player, "find_the_library")
            end
            return questdata
        end
    },
    find_the_library = {
        type = "cast_spell",
        spell_id = "reveal",
        hud_text = "Find the Library",
        on_complete = function(player, questdata)
            regulus2024_quests.add_active_quest(player, "enter_the_library")
        end
    },
    enter_the_library = {
        type = "go_to_pos",
        hud_text = "",
        pos = vector.new(-31,0,-2),
        radius = 3,
        on_complete = function(player, questdata)
            regulus2024_player.timeofday = 0.3
            minetest.after(8, function()
                regulus2024_quests.add_active_quest(player, "talk_to_wizard_in_library")
            end)
            regulus2024_quests.add_active_quest(player, "find_all_four_books")
        end
    },
    talk_to_wizard_in_library = {
        type = "complete_dialogue",
        hud_text = "Talk to the Wizard",
        dialogue_id = "talk_to_wizard_in_library",
        on_complete = function(player, questdata)
            -- Find the npc. UGH this is bad but it's the only way I know of, since you can't serialize objects to store in meta, cuz like what if they rejoin?
            for object in minetest.objects_inside_radius(player:get_pos(), 8) do
                if not object:is_player() and object:get_luaentity().name == "regulus2024_npcs:oldman" then
                    object:get_luaentity()._force_disappear = true
                end
            end
            regulus2024_quests.add_active_quest(player, "go_to_the_pedestal")
        end
    },
    go_to_the_pedestal = {
        type = "go_to_pos",
        hud_text = "Travel to the Pedestals of Banishment",
        pos = villages[2].pos,
        radius = 10,
        on_complete = function(player, questdata)
            regulus2024_quests.add_active_quest(player, "find_the_book_of_banishment")
        end
    },
    find_the_book_of_banishment = {
        type = "read_book",
        book_id = "the_book_of_banishment",
        hud_text = "Find the Book of Banishment",
        on_complete = function(player, questdata)
            local find_all_four_books_questdata = regulus2024_quests.get_active_quests(player).find_all_four_books
            if find_all_four_books_questdata then
                find_all_four_books_questdata.hud_text = "Find the four books"
                regulus2024_quests.set_active_quest_data(player, "find_all_four_books", find_all_four_books_questdata)
            end
            regulus2024_quests.add_active_quest(player, "meet_darkness1")
        end
    },
    meet_darkness1 = {
        type = "go_to_pos",
        pos = vector.new(150, 0, -45),
        radius = 50,
        hud_text = "",
        on_complete = function(player, questdata)
            regulus2024_cutscenes.start_darkness_cutscene1(player)
        end
    },
    find_all_four_books = {
        type = "custom",
        hud_text = "",--"Find the four books", -- empty at first, onyl appears after find the book of banishment. This is to prevent bugs with players getting the books too early.
        on_start_quest = function(player, questdata)
            questdata.num_books_read = 0
        end,
        on_get_book = function(player, book_id, questdata)
            if book_id == "the_book_of_light" or book_id == "the_book_of_darkness" or book_id == "the_book_of_truth" or book_id == "the_book_of_lies" then
                questdata.num_books_read = questdata.num_books_read + 1
            end
            if questdata.num_books_read >= 4 then
                regulus2024_quests.complete_quest(player, "find_all_four_books")
                regulus2024_quests.add_active_quest(player, "banish_the_darkness")
                regulus2024_quests.add_active_quest(player, "meet_darkness2")
            end
            return questdata
        end
    },
    meet_darkness2 = {
        type = "go_to_pos",
        pos = vector.new(150, 0, -45),
        radius = 50,
        hud_text = "",
        on_complete = function(player, questdata)
            regulus2024_cutscenes.start_darkness_cutscene2(player)
        end
    },
    banish_the_darkness = {
        type = "custom",
        hud_text = "Banish the Darkness",
        -- To be handled by the spell. If the spell is successful, it will complete this quest.
    },

--[[
-- OLD STUFF NOT USED
    start_talk_to_old_man = {
        type = "complete_dialogue",
        dialogue_id = "its_dangerous_outside_come_in",
        on_complete = function(player, questdata)
            minetest.debug("You compleded the first quest!")
            regulus2024_quests.add_active_quest(player, "go_inside_the_house")
        end
    },
    go_inside_the_house = {
        type = "go_to_pos",
        pos = vector.new(0,0,0),
        radius = 5,
        on_complete = function(player, questdata)
            minetest.debug("You compleded the go inside house quest!")
            regulus2024_quests.add_active_quest(player, "talk_to_old_man_again")
        end
    },
    -- TODO add go to bed quest
    -- Then after you wake up:
    talk_to_old_man_again = {
        type = "complete_dialogue",
        dialogue_id = "I_must_get_to_my_studies",
        on_complete = function(player, questdata)
            -- Find the npc. UGH this is bad but it's the only way I know of, since you can't serialize objects
            for object in minetest.objects_inside_radius(player:get_pos(), 8) do
                if not object:is_player() and object:get_luaentity().name == "regulus2024_npcs:oldman" then
                    object:get_luaentity()._force_disappear = true
                    minetest.debug("Found the old man, told him to disappear")
                    minetest.after(10, function()
                        object:get_luaentity()._force_disappear = false
                        minetest.debug("Told him he can appear again")
                    end)
                end
            end
            minetest.debug("You compleded the talk to old man quest!")
            regulus2024_quests.add_active_quest(player, "talk_to_villagers")
        end
    },
    talk_to_villagers = {
        type = "custom",
        on_start_quest = function(player, questdata)
            minetest.debug("You started the talk to villagers quest!")
            questdata.num_villagers_encountered = 0
        end,
        on_finish_dialogue = function(player, dialogue_id, questdata)
            if dialogue_id == "talking_to_villagers" then
                questdata.num_villagers_encountered = questdata.num_villagers_encountered + 1
                minetest.debug("You talked to a villager! So far:", questdata.num_villagers_encountered)
            end
            if questdata.num_villagers_encountered == 4 then
                minetest.debug("You completed the talk to villagers quest")
                regulus2024_quests.complete_quest(player, "talk_to_villagers")
            end
        end
    },

    -- TEST QUESTS, NOT USED
    quest1 = {
        type = "dig_node",
        what = "regulus2024_nodes:dirt1",
        on_start_quest = function(player, questdata)
        end,
        on_complete = function(player, questdata)
            regulus2024_quests.add_active_quest(player, "quest2")
            minetest.debug("YOU DID IT QUEST1")
        end
    },
    quest2 = {
        type = "custom",
        on_start_quest = function(player, questdata)
        end,
        on_dignode = function(pos, oldnode, digger, questdata)
            if oldnode.name == "regulus2024_nodes:dirt_with_grass1" then
                regulus2024_quests.complete_quest(digger, "quest2")
                minetest.debug("YOU DID IT QUEST2")
                regulus2024_quests.add_active_quest(digger, "quest3")
            end
        end
    },
    quest3 = {
        type = "complete_dialogue",
        --who = "regulus2024_npcs:testnpc",
        dialogue_id = "dialogue1",
        on_start_quest = function(player)
        end,
        on_finish_dialogue = function(player, dialogue_id, questdata)
            minetest.debug("YOU DID IT QUEST3")
            regulus2024_quests.complete_quest(player, "quest3")
        end
    },
]]
}

