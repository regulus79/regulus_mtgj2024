

minetest.register_entity("regulus2024_npcs:darkness_sphere", {
    initial_properties = {
        visual = "mesh",
        mesh = "regulus2024_sphere.obj",
        pointable = false,
        visual_size = vector.new(30, 30, 30),
        textures = {"regulus2024_blackscreen.png"},
        use_texture_alpha = true,
    },
    _rotation_dir = vector.new(0,1,0),
    on_activate = function(self)
        self._rotation_dir = vector.new(math.random()-0.5, math.random()-0.5, math.random()-0.5)
        local props = self.object:get_properties()
        props.visual_size = vector.new(1, 0.8, 0.7) * (math.random() * 10 + 20)
        self.object:set_properties(props)
    end,
    on_step = function(self, dtime)
        if self and self.object and self.object:get_rotation() then
            self.object:set_rotation(self.object:get_rotation() + self._rotation_dir * dtime)
        end
    end
})

minetest.register_entity("regulus2024_npcs:darkness", {
    initial_properties = {
        visual = "mesh",
        mesh = "regulus2024_sphere.obj",
        pointable = false,
        visual_size= vector.new(0, 0, 0),
        use_texture_alpha = true,
    },
    _spheres = {},
    on_activate = function(self)
        minetest.add_particlespawner({
            amount = 100,
            time = 0,
            texture = "regulus2024_darkness_particle.png",
            vel = {
                min = vector.new(-10,-10,-10),
                max = vector.new(10,10,10),
            },
            blend = "alpha",
            attached = self.object,
        })
        if self.object:is_valid() then
            for i = 1, 4 do
                local obj = minetest.add_entity(self.object:get_pos(), "regulus2024_npcs:darkness_sphere")
                if obj then
                    table.insert(self._spheres, obj)
                end
            end
        end
    end,
    on_deactivate = function(self)
        for _, sphere in pairs(self._spheres) do
            sphere:remove()
        end
    end
})


minetest.register_entity("regulus2024_npcs:player_stop_movement", {
    initial_properties = {
        visual = "mesh",
        mesh = "regulus2024_sphere.obj",
        pointable = false,
        visual_size= vector.new(0, 0, 0),
        use_texture_alpha = true,
    },
    on_detach_child = function(self)
        self.object:remove()
    end
})


-- ik this stuff isn't about the darkness, maybe I will move this code later

minetest.register_entity("regulus2024_npcs:finish_beam", {
    initial_properties = {
        visual = "mesh",
        mesh = "regulus2024_beam.obj",
        pointable = false,
        visual_size = vector.new(30, 100, 30),
        textures = {"regulus2024_beam2.png"},
        use_texture_alpha = true,
        backface_culling = false,
    },
    _rotation_speed = 0,
    on_activate = function(self, dtime)
        self.object:set_rotation(vector.new(0, math.random() * math.pi * 2, 0))
        self._rotation_speed = (math.random() - 0.5) * 2
        if math.abs(self._rotation_speed) < 0.5 then
            self._rotation_speed = math.sign(self._rotation_speed) * 0.5
        end
        local props = self.object:get_properties()
        props.visual_size = vector.new(30, 100, 30) * (math.random() * 2 + 1)
        self.object:set_properties(props)
        minetest.after(5, function() self.object:remove() end)
    end,
    on_step = function(self, dtime)
        if self and self.object and self.object:get_rotation() then
            self.object:set_rotation(self.object:get_rotation() + vector.new(0, self._rotation_speed * dtime, 0))
        end
    end
})