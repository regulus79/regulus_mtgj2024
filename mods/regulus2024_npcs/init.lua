
minetest.register_chatcommand("spawn_npc", {
    description = "spawn npc",
    func = function(name, param)
        minetest.add_entity(minetest.get_player_by_name(name):get_pos(), "regulus2024_npcs:"..param)
    end
})



local register_npc = function(name, def)
    minetest.register_entity(name, {
        initial_properties = {
            visual = def.visual or "mesh",
            mesh = def.mesh or "regulus2024_player2.b3d",
            physical = def.physical or true,
            collide_with_objects = def.collide_with_objects or true,
            collisionbox = def.collisionbox or {-0.3, 0, -0.3, 0.3, 1.8, 0.3},
            selectionbox = def.selectionbox or {-0.3, 0, -0.3, 0.3, 1.8, 0.3},
            pointable = def.pointable or true,
            visual_size = def.collide_with_objects or vector.new(1, 1, 1),
            textures = def.collide_with_objects or {"regulus2024_player_template.png"},
            use_texture_alpha = def.collide_with_objects or true,
            --- PLEAE ADD MORE
        },
        on_step = function(self, dtime)
        end,
        on_rightclick = def.on_rightclick
    })
end

register_npc("regulus2024_npcs:testnpc", {
    on_rightclick = function(self, clicker)
        regulus2024_dialogue.start_dialogue(clicker, "dni1")
    end
})