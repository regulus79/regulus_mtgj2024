
local villages = dofile(minetest.get_modpath("regulus2024_mapgen") .. "/mapdata.lua")

regulus2024_music = {}

regulus2024_music.music = {
    in_the_library = {
        spec = {
            name = "in_the_library_v2",
            gain = 1.0,
        },
        parameters = {
            loop = true,
            gain = 0.00001 -- start out the gain at almost zero, so that the correct track can fade in at the start.
        },
        handle = nil,
    },
    darkness = {
        spec = {
            name = "darkness",
            gain = 1.0,
            pitch = -2,
        },
        parameters = {
            loop = true,
            gain = 0.00001 -- start out the gain at almost zero, so that the correct track can fade in at the start.
        },
        handle = nil,
    },
    default = {
        spec = {
            name = "village_theme2",
            gain = 0.2,
        },
        parameters = {
            loop = true,
            gain = 0.00001 -- start out the gain at almost zero, so that the correct track can fade in at the start.
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
            minetest.sound_fade(track.handle, 0.5, track.spec.gain)
        else
            minetest.sound_fade(track.handle, 0.5, 0.000001)
        end
    end
end

local library_area = {
    min = vector.new(-40-0.5, 0, -8-0.5),
    max = vector.new(-27+0.5, 4, 4+0.5)
}


minetest.register_globalstep(function()
    for _, player in pairs(minetest.get_connected_players()) do
        if player:get_pos():in_area(library_area.min, library_area.max) then
            regulus2024_music.set_music(player, "in_the_library")
        elseif regulus2024_cutscenes.active_cutscene == "darkness_cutscene1" or regulus2024_cutscenes.active_cutscene == "darkness_cutscene2" then
            regulus2024_music.set_music(player, "darkness")
        elseif regulus2024_quests.get_completed_quests(player).banish_the_darkness then
            regulus2024_music.set_music(player, "in_the_library")
        else
            regulus2024_music.set_music(player, "default")
        end
    end
end)