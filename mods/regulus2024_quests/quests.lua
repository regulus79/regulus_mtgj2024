
regulus2024_quests.quests = {
    quest1 = {
        type = "dig_node",
        what = "regulus2024_nodes:dirt1",
        on_start_quest = function(player, questdata)
        end,
        on_dignode = function(pos, oldnode, digger, questdata)
            minetest.debug("YOU DID IT QUEST1") 
            regulus2024_quests.complete_quest(clicker, "quest1")
            regulus2024_quests.add_active_quest(player, "quest2")
        end
    },
    quest2 = {
        type = "custom",
        on_start_quest = function(player, questdata)
        end,
        on_dignode = function(pos, oldnode, digger, questdata)
            if oldnode.name == "regulus2024_nodes:dirt_with_grass1" then
                regulus2024_quests.complete_quest(player, "quest2")
                minetest.debug("YOU DID IT QUEST2") 
                regulus2024_quests.add_active_quest(player, "quest3")
            end
        end
    },
    quest3 = {
        type = "talk_to_npc",
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

