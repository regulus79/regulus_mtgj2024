
regulus2024_music = {}

regulus2024_music.bpm = 120 -- TODO make it depend ont he current music

regulus2024_music.seconds_per_beat = function(time)
    return time * 1 / regulus2024_music.bpm * 60
end