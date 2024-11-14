
regulus2024_quests.quests = {
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
}

