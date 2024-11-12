
-- HELP I don't want to dofile this twice, one in the parent init.lua and one here, but whatever
local villages = dofile(minetest.get_modpath("regulus2024_mapgen") .. "/mapdata.lua")


regulus2024_npcs.register_npc("regulus2024_npcs:testnpc", {
    _average_time_per_look_update = 3,
    _gain_notice_dist = 1,
    _lose_notice_dist = 5,
    extra_on_rightclick = function(self, clicker)
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:testnpc", {})

-- Main npc

regulus2024_npcs.register_npc("regulus2024_npcs:mainnpc", {
    _average_time_per_look_update = 3,
    _gain_notice_dist = 8,
    _lose_notice_dist = 12,
    extra_on_activate = function(self)
        self._general_walk_target = self.object:get_pos()
    end,
    extra_on_rightclick = function(self, clicker)
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "hello")
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:mainnpc", {})

-- Side npcs


regulus2024_npcs.register_npc("regulus2024_npcs:sidenpc1", {
    _average_time_per_look_update = 3,
    _gain_notice_dist = 1,
    _lose_notice_dist = 5,
    extra_on_activate = function(self)
        self._general_walk_target = self.object:get_pos()
    end,
    extra_on_rightclick = function(self, clicker)
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:sidenpc1", {})


regulus2024_npcs.register_npc("regulus2024_npcs:sidenpc2", {
    _average_time_per_look_update = 3,
    _gain_notice_dist = 1,
    _lose_notice_dist = 5,
    extra_on_activate = function(self)
        self._general_walk_target = self.object:get_pos()
    end,
    extra_on_rightclick = function(self, clicker)
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:sidenpc2", {})





-- Marketplace

regulus2024_npcs.register_npc("regulus2024_npcs:marketnpc1", {
    _average_time_per_look_update = 3,
    _gain_notice_dist = 4,
    _lose_notice_dist = 5,
    extra_on_activate = function(self)
        self._awake_time = {wake_up = 0.25 + math.random()*0.1 - 0.05, fall_asleep = 0.75 + math.random()*0.1 - 0.05}
    end,
    extra_on_rightclick = function(self, clicker)
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:marketnpc1", {})

regulus2024_npcs.register_npc("regulus2024_npcs:marketnpc2", {
    _average_time_per_look_update = 3,
    _gain_notice_dist = 4,
    _lose_notice_dist = 5,
    extra_on_activate = function(self)
        self._awake_time = {wake_up = 0.25 + math.random()*0.1 - 0.05, fall_asleep = 0.75 + math.random()*0.1 - 0.05}
    end,
    extra_on_rightclick = function(self, clicker)
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:marketnpc2", {})

regulus2024_npcs.register_npc("regulus2024_npcs:marketnpc3", {
    _average_time_per_look_update = 3,
    _gain_notice_dist = 4,
    _lose_notice_dist = 5,
    extra_on_activate = function(self)
        self._awake_time = {wake_up = 0.25 + math.random()*0.1 - 0.05, fall_asleep = 0.75 + math.random()*0.1 - 0.05}
    end,
    extra_on_rightclick = function(self, clicker)
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:marketnpc3", {})

regulus2024_npcs.register_npc("regulus2024_npcs:marketnpc4", {
    _average_time_per_look_update = 3,
    _gain_notice_dist = 4,
    _lose_notice_dist = 5,
    extra_on_activate = function(self)
        self._awake_time = {wake_up = 0.25 + math.random()*0.1 - 0.05, fall_asleep = 0.75 + math.random()*0.1 - 0.05}
    end,
    extra_on_rightclick = function(self, clicker)
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:marketnpc4", {})

regulus2024_npcs.register_npc("regulus2024_npcs:marketnpc5", {
    _average_time_per_look_update = 3,
    _gain_notice_dist = 4,
    _lose_notice_dist = 5,
    extra_on_activate = function(self)
        self._awake_time = {wake_up = 0.25 + math.random()*0.1 - 0.05, fall_asleep = 0.75 + math.random()*0.1 - 0.05}
    end,
    extra_on_rightclick = function(self, clicker)
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:marketnpc5", {})


-- Random villagers walking around
regulus2024_npcs.register_npc("regulus2024_npcs:villagenpc1", {
    _average_time_per_look_update = 3,
    _gain_notice_dist = 2,
    _lose_notice_dist = 5,
    extra_on_activate = function(self)
        self._awake_time = {wake_up = 0.25 + math.random()*0.1 - 0.05, fall_asleep = 0.75 + math.random()*0.1 - 0.05}
        -- Randomize scale
        self._scale = 0.75 + math.random() * 0.25
        self._walk_speed = 1 + math.random() * 0.5
        local props = self.object:get_properties()
        props.visual_size = vector.new(1, 1, 1) * self._scale
        self.object:set_properties(props)

        self._state = "walk_to_waypoint"
        minetest.after(math.random() * 20, function()
            local possible_destinations = {
                "main_intersection",
                "inside_town_hall",
                "center_marketplace",
                "center_marketplace2",
                "inside_main_npc_house",
            }
            local destination = possible_destinations[math.random(#possible_destinations)]
            self._target_waypoint = villages[1].waypoints[destination]
        end)
    end,
    on_reach_target_waypoint = function(self)
        minetest.after(math.random() * 20, function()
            local possible_destinations = {
                "main_intersection",
                "inside_town_hall",
                "center_marketplace",
                "center_marketplace2",
                "inside_main_npc_house",
            }
            local destination = possible_destinations[math.random(#possible_destinations)]
            self._target_waypoint = villages[1].waypoints[destination]
        end)
    end,
    extra_on_rightclick = function(self, clicker)
        self._awake_time = {wake_up = 0.25 + math.random()*0.1 - 0.05, fall_asleep = 0.75 + math.random()*0.1 - 0.05}
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end,
    extra_on_step = function(self, dtime)
        -- Randomize target waypoint every now and then to stop use from getting stuck forever
        if math.random() < 1 / 60 * dtime and self.object:get_velocity():length() < 0.1 then
            minetest.debug("Randomizing pos!")
            local possible_destinations = {
                "main_intersection",
                "inside_town_hall",
                "center_marketplace",
                "center_marketplace2",
                "inside_main_npc_house",
            }
            local destination = possible_destinations[math.random(#possible_destinations)]
            self._target_waypoint = villages[1].waypoints[destination]
        end
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:villagenpc1", {})