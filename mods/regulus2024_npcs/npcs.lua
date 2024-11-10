
regulus2024_npcs.register_npc("regulus2024_npcs:testnpc", {
    _average_time_per_look_update = 5,
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
    _average_time_per_look_update = 5,
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
    _average_time_per_look_update = 5,
    _gain_notice_dist = 1,
    _lose_notice_dist = 5,
    _awake_time = {wake_up = 0.25, fall_asleep = 0.75},
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
    _average_time_per_look_update = 5,
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
    _average_time_per_look_update = 5,
    _gain_notice_dist = 4,
    _lose_notice_dist = 5,
    extra_on_rightclick = function(self, clicker)
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:marketnpc1", {})

regulus2024_npcs.register_npc("regulus2024_npcs:marketnpc2", {
    _average_time_per_look_update = 5,
    _gain_notice_dist = 4,
    _lose_notice_dist = 5,
    extra_on_rightclick = function(self, clicker)
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:marketnpc2", {})

regulus2024_npcs.register_npc("regulus2024_npcs:marketnpc3", {
    _average_time_per_look_update = 5,
    _gain_notice_dist = 4,
    _lose_notice_dist = 5,
    extra_on_rightclick = function(self, clicker)
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:marketnpc3", {})

regulus2024_npcs.register_npc("regulus2024_npcs:marketnpc4", {
    _average_time_per_look_update = 5,
    _gain_notice_dist = 4,
    _lose_notice_dist = 5,
    extra_on_rightclick = function(self, clicker)
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:marketnpc4", {})

regulus2024_npcs.register_npc("regulus2024_npcs:marketnpc5", {
    _average_time_per_look_update = 5,
    _gain_notice_dist = 4,
    _lose_notice_dist = 5,
    extra_on_rightclick = function(self, clicker)
        self._look_target = clicker
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end
})
regulus2024_npcs.register_spawner("regulus2024_npcs:marketnpc5", {})