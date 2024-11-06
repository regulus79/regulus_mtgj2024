regulus2024_quests = {}

dofile(minetest.get_modpath("regulus2024_quests") .. "/quests.lua")

--
-- CALLBACKS
--

regulus2024_quests.on_finish_dialogue = function(player, npc)
    for questname, questdef in pairs(regulus2024_quests.quests) do
        if questdef.type == "custom" or questdef.type == "talk_to_npc" and questdef.who == self.object:get_name() and regulus2024_quests.get_active_quests(clicker)[questname] then
            local questdata = regulus2024_quests.get_active_quest(questname)
            questdef.on_finish_dialogue(player, npc, questdata)
        end
    end
end

minetest.register_on_dignode(function(pos, oldnode, digger)
    for questname, questdef in pairs(regulus2024_quests.quests) do
        if questdef.type == "custom" or questdef.type == "dig_node" and questdef.what == oldnode.name and regulus2024_quests.get_active_quests(digger)[questname] then
            local questdata = regulus2024_quests.get_active_quest(questname)
            questdef.on_dignode(pos, oldnode, digger, questdata)
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
    regulus2024_quests[questname].on_start_quest(player)
    meta:set_string("active_quests", minetest.serialize(active_quests))
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
    regulus2024_quests.quests[questname].on_complete(player)
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