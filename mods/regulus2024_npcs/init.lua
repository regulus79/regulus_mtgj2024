regulus2024_npcs = {}


minetest.register_chatcommand("spawn_npc", {
    description = "spawn npc",
    func = function(name, param)
        minetest.add_entity(minetest.get_player_by_name(name):get_pos(), "regulus2024_npcs:"..param)
    end
})


local update_head_direction = function(self, target_pos, interpolation, exponential_interpolation_dtime)
    local relative_pos = (target_pos - self.object:get_pos()):rotate(-self.object:get_rotation())
    local up = vector.rotate(vector.new(0, 1, 0), self.object:get_rotation())
    up = -up:cross(relative_pos):cross(relative_pos):normalize()
    local rotation = -vector.dir_to_rotation(relative_pos, up)
    -- Add bounds to yaw
    rotation.y = math.min(math.max(-math.pi/2, rotation.y), math.pi/2)
    if exponential_interpolation_dtime > 0 then
        local current_rotation = self.object:get_bone_override("Head").rotation.vec
        self.object:set_bone_override("Head", {
            rotation = {vec = current_rotation + (rotation - current_rotation) * (interpolation) * exponential_interpolation_dtime}, -- aaa need to do the dtime right
        })
    else
        self.object:set_bone_override("Head", {
            rotation = {vec = rotation, interpolation = interpolation},
        })
    end
end


local get_leg_back_and_forth = function(t)
    t = t - math.floor(t)
    if t < 0.5 then
        return t
    else
        return 0.5 - (t - 0.5)
    end
end


regulus2024_npcs.register_npc = function(name, def)
    minetest.register_entity(name, {
        initial_properties = {
            visual = def.visual or "mesh",
            mesh = def.mesh or "regulus2024_player2.glb",
            physical = def.physical or true,
            collide_with_objects = def.collide_with_objects or true,
            collisionbox = def.collisionbox or {-0.3, 0, -0.3, 0.3, 1.8, 0.3},
            selectionbox = def.selectionbox or {-0.3, 0, -0.3, 0.3, 1.8, 0.3},
            pointable = def.pointable or true,
            visual_size = def.collide_with_objects or vector.new(1, 1, 1),
            textures = def.collide_with_objects or {"regulus2024_player_template.png"},
            use_texture_alpha = def.collide_with_objects or true,
            automatic_face_movement_dir = -90,
            automatic_face_movement_max_rotation_per_sec = 360
            --- PLEAE ADD MORE
        },
        _state = "idle",
        _look_target = vector.new(0, 0, 1),
        _average_time_per_look_update = def._average_time_per_look_update or 1,
        _lose_notice_dist = def._lose_notice_dist or 8,
        _gain_notice_dist = def._gain_notice_dist or 4,
        _walk_target = nil,
        _target_velocity = nil,
        _average_time_per_walk_target_update = def._average_time_per_walk_target_update or 5,
        _walk_speed = def._walk_speed or 2,
        _min_speed = 0.5,
        _max_speed = def._max_speed or 3,
        _walk_cycle_position = 0,
        _stride_length = def._stride_length or 1,
        _leg_length = def._leg_length or 0.6985,
        on_step = def.on_step or function(self, dtime)

            -- LOOK DIRECTION

            if self._state == "idle" then
                if type(self._look_target) == "userdata" and self._look_target:get_pos():distance(self.object:get_pos()) > self._lose_notice_dist then
                    self._look_target = nil
                end
                for _, player in pairs(minetest.get_connected_players()) do
                    if player:get_pos():distance(self.object:get_pos()) < self._gain_notice_dist then
                        self._look_target = player
                    end
                end
            end
            if type(self._look_target) == "userdata" then
                update_head_direction(self, self._look_target:get_pos(), 8, dtime)
            else
                update_head_direction(self, self._look_target, 2, dtime) 
                -- If not focused on a player, pick a new target every so often
                if math.random() < 1 / self._average_time_per_look_update * dtime then
                    self._look_target = self.object:get_pos() + vector.new(math.random() * 5 - 2.5, math.random() - 0.5, math.random() * 10 + 2):rotate(self.object:get_rotation())
                end
            end

            -- WALKING

            if self._state == "idle_walk" then
                if math.random() < dtime / self._average_time_per_walk_target_update then
                    self._walk_target = self.object:get_pos() + vector.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5) * 10
                end
            end

            if self._walk_target then
                self._target_velocity = (self._walk_target - self.object:get_pos()):normalize() * self._walk_speed
            end

            -- APPLY MOVEMENT

            local new_vel = self._target_velocity or vector.new(0,0,0)
            new_vel = new_vel:normalize() * math.min(self._max_speed, new_vel:length())
            new_vel.y = self.object:get_velocity().y
            self.object:set_velocity(new_vel)

            -- DO LEG ANIMATION
            -- very simple stuff here, I want to work on a beautiful physics-based foot placement system in the future for other games, but for now this will ahve to do.
            local horizontal_vel = self.object:get_velocity()
            horizontal_vel.y = 0

            if horizontal_vel:length() > self._min_speed then
                self._walk_cycle_position = self._walk_cycle_position + dtime * horizontal_vel:length() / self._stride_length / self._leg_length / 2

                local angle_left = (get_leg_back_and_forth(self._walk_cycle_position) - 0.25) * math.pi
                local angle_right = (get_leg_back_and_forth(self._walk_cycle_position + 0.5) - 0.25)* math.pi

                self.object:set_bone_override("LegL", {
                    rotation = {vec = vector.new(angle_left, 0, 0), absolute = true}
                })
                self.object:set_bone_override("LegR", {
                    rotation = {vec = vector.new(angle_right, 0, 0), absolute = true}
                })
                self.object:set_bone_override("ArmL", {
                    rotation = {vec = vector.new(angle_right/2, 0, 0), absolute = true}
                })
                self.object:set_bone_override("ArmR", {
                    rotation = {vec = vector.new(angle_left/2, 0, 0), absolute = true}
                })
            else
                self.object:set_velocity(vector.new(0, self.object:get_velocity().y, 0)) --- BAd idea, not good, migth want to use vel in other code
                self.object:set_bone_override("LegL", {
                    rotation = {vec = vector.new(0, 0, 0), absolute = true, interpolation = 0.25}
                })
                self.object:set_bone_override("LegR", {
                    rotation = {vec = vector.new(0, 0, 0), absolute = true, interpolation = 0.25}
                })
                self.object:set_bone_override("ArmL", {
                    rotation = {vec = vector.new(0, 0, 0), absolute = true, interpolation = 0.25}
                })
                self.object:set_bone_override("ArmR", {
                    rotation = {vec = vector.new(0, 0, 0), absolute = true, interpolation = 0.25}
                })
            end

            if def.extra_on_step then
                def.extra_on_step(self, dtime)
            end
        end,
        on_rightclick = def.on_rightclick or function(self, clicker)
            self._look_target = clicker
            
            if def.extra_on_rightclick then
                def.extra_on_rightclick(self, clicker)
            end
        end
    })
end


regulus2024_npcs.register_spawner = function(npc, def)
    minetest.register_node(npc .. "_spawner", {
        description = "Spawner for " .. npc,
        tiles = minetest.is_creative_enabled() and def.tiles or nil,
        pointable = minetest.is_creative_enabled(),
        walkable = false,
        groups = {unbreakable = 1},
    })
    minetest.register_abm({
        label = "Run spawner for " .. npc,
        nodenames = {npc .. "_spawner"},
        interval = 3,
        chance = 1,
        action = function(pos)
            local meta = minetest.get_meta(pos)
            if meta:get_int("triggered") == 0 then
                minetest.add_entity(pos - vector.new(0, 0.5, 0), npc)
                meta:set_int("triggered", 1)
            end
        end
    })
end


dofile(minetest.get_modpath("regulus2024_npcs") .. "/npcs.lua")