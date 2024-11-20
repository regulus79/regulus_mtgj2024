
regulus2024_music = {}

regulus2024_music.music = {
    in_the_library = {
        spec = {
            name = "in_the_library_v2",
            gain = 1.0,
        },
        parameters = {
            loop = true,
        },
        handle = nil,
    }
}

minetest.register_on_joinplayer(function(player)
    for _, track in pairs(regulus2024_music.music) do
        track.handle = minetest.sound_play(track.spec, track.parameters)
    end
end)

regulus2024_music.bpm = 120 -- TODO make it depend ont he current music

regulus2024_music.seconds_per_beat = function(time)
    return time * 1 / regulus2024_music.bpm * 60
end


regulus2024_music.set_music = function(player, music)
    for trackname, track in pairs(regulus2024_music.music) do
        if trackname == music then
            minetest.sound_fade(track.handle, 1.0)
        else
            minetest.sound_fade(track.handle, 0.000001)
        end
    end
end

minetest.register_globalstep(function()
end)