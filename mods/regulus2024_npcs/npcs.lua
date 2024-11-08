
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