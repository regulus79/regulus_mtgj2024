regulus2024_quests = {}

dofile(minetest.get_modpath("regulus2024_quests") .. "/quests.lua")

--
-- CALLBACKS
--

---- AAAAAAAAAAAAAAAAAAAA
--- HOW DO I DO THIS RIGHT I need to have npc be passed as an arg, but I gotta save it to meta too :sob:
regulus2024_quests.on_finish_dialogue = function(player, dialogue_id)
    for questname, questdef in pairs(regulus2024_quests.quests) do
        if questdef.type == "custom" or questdef.type == "talk_to_npc" and questdef.dialogue_id == dialogue_id and regulus2024_quests.get_active_quests(player)[questname] then
            local questdata = regulus2024_quests.get_active_quests(player)[questname]
            questdef.on_finish_dialogue(player, dialogue_id, questdata)
        end
    end
end

minetest.register_on_dignode(function(pos, oldnode, digger)
    for questname, questdef in pairs(regulus2024_quests.quests) do
        if questdef.type == "custom" then
            local questdata = regulus2024_quests.get_active_quests(player)[questname]
            questdef.on_dignode(questdata)
        elseif questdef.type == "dig_node" and questdef.what == oldnode.name and regulus2024_quests.get_active_quests(digger)[questname] then
            local questdata = regulus2024_quests.get_active_quests(player)[questname]
            questdef.on_complete(digger, questdata)
        end
    end
end)



--
-- HELPER FUNCTIONS
--

regulus2024_quests.add_active_quest = function(player, questname)
    local meta = player:get_meta()
    local active_quests = minetest.deserialize(meta:get_string("active_quests")) or {}
    if not active_quests[questname] then
        active_quests[questname] = {}
    end
    regulus2024_quests[questname].on_start_quest(player, active_quests[questname])
    meta:set_string("active_quests", minetest.serialize(active_quests))
end

regulus2024_quests.set_active_quest_data = function(player, questname, questdata)
    local meta = player:get_meta()
    -- Only change questdata if quest is active, else do nothing (if you set it to something other than nil, it will count as an active quest)
    if active_quests[questname] then
        local active_quests = minetest.deserialize(meta:get_string("active_quests")) or {}
        active_quests[questname] = questdata
        meta:set_string("active_quests", minetest.serialize(active_quests))
    end
end

regulus2024_quests.get_active_quests = function(player)
    local meta = player:get_meta()
    return minetest.deserialize(meta:get_string("active_quests")) or {}
end

regulus2024_quests.remove_active_quest = function(player, questname)
    local meta = player:get_meta()
    local active_quests = minetest.deserialize(meta:get_string("active_quests")) or {}
    if active_quests[questname] then
        active_quests[questname] = nil
    end
    meta:set_string("active_quests", minetest.serialize(active_quests))
end

regulus2024_quests.add_completed_quest = function(player, questname)
    local meta = player:get_meta()
    local completed_quests = minetest.deserialize(meta:get_string("completed_quests")) or {}
    if not completed_quests[questname] then
        completed_quests[questname] = {}
    end
    meta:set_string("completed_quests", minetest.serialize(completed_quests))
end

regulus2024_quests.get_completed_quests = function(player)
    local meta = player:get_meta()
    return minetest.deserialize(meta:get_string("completed_quests")) or {}
end

regulus2024_quests.complete_quest = function(player, questname)
    if regulus2024_quests.quests[questname].on_complete then
        regulus2024_quests.quests[questname].on_complete(player)
    end
    regulus2024_quests.remove_active_quest(player, questname)
    regulus2024_quests.add_completed_quest(player, questname)
end

-- TESTING
minetest.register_chatcommand("quests", {
    description = "show quests stuff",
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        minetest.debug("ACTIVE QUESTS: ", dump(regulus2024_quests.get_active_quests(player)))
        minetest.debug("COMPLETEd QUESTS: ", dump(regulus2024_quests.get_completed_quests(player)))
    end
})

minetest.register_chatcommand("add_quest", {
    description = "add a quest to be active",
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        regulus2024_quests.add_active_quest(player, param)
    end
})

minetest.register_chatcommand("reset_quests", {
    description = "reset the completed and active quest tables",
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        local meta =player:get_meta()
        meta:set_string("active_quests", "")
        meta:set_string("completed_quests", "")
    end
})