regulus2024_npcs = {}

local villages = dofile(minetest.get_modpath("regulus2024_mapgen") .. "/mapdata.lua")


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


--~~=%#* WAYPOINT PATHFINDING *#%=~~--

-- Find the shortest path via recursion!
-- yeaaaa this isn't great. but it should work.
local pathfinding_min_dist_recursion
pathfinding_min_dist_recursion = function(visited_waypoints, current_waypoint, target_waypoint)
    if current_waypoint.pos == target_waypoint.pos then
        return 0
    end
    local village = current_waypoint.village
    -- AAAAAA we are using hashing for the indicies of the visited waypoints. I guess that's fine?
    local min_dist = math.huge
    visited_waypoints[minetest.hash_node_position(current_waypoint.pos)] = -1 -- temporary setting so that the next recursions see that we've already been here.
    for _, neighbor_id in pairs(current_waypoint.neighbors) do
        local neighbor = villages[village].waypoints[neighbor_id]
        local dist_to_neighbor = current_waypoint.pos:distance(neighbor.pos)
        if visited_waypoints[minetest.hash_node_position(neighbor.pos)] == nil then
            min_dist = math.min(min_dist, dist_to_neighbor + pathfinding_min_dist_recursion(visited_waypoints, neighbor, target_waypoint))
        elseif visited_waypoints[minetest.hash_node_position(neighbor.pos)] > 0 then
            min_dist = math.min(min_dist, dist_to_neighbor + visited_waypoints[minetest.hash_node_position(neighbor.pos)])
        end
    end
    visited_waypoints[minetest.hash_node_position(current_waypoint.pos)] = min_dist
    return min_dist
end

-- Check the min dist from each of the neighbors, then pick the least one
-- is there a name for this algorithm?
-- oh and yeah before ayone asks, yes we are wasting a lot of compute by recalculiting the best path all the time, but
-- that could be a good thing if the path changes or something i don't really know I don't want to fix it help me
local get_next_waypoint = function(current_waypoint, target_waypoint)
    local village = current_waypoint.village
    local best_next_waypoint = nil
    local best_min_dist = math.huge
    for _, neighbor_id in pairs(current_waypoint.neighbors) do
        local neighbor = villages[village].waypoints[neighbor_id]
        local dist_to_neighbor = current_waypoint.pos:distance(neighbor.pos)
        local visited_waypoints = {[minetest.hash_node_position(current_waypoint.pos)] = math.huge}
        local min_dist = dist_to_neighbor + pathfinding_min_dist_recursion(visited_waypoints, neighbor, target_waypoint)
        if min_dist < best_min_dist then
            best_min_dist = min_dist
            best_next_waypoint = neighbor
        end
    end
    return best_next_waypoint
end

local get_nearest_waypoint = function(pos)
    local nearest_waypoint = nil
    local min_dist = math.huge
    for _, village in pairs(villages) do
        if village.waypoints then
            for _, waypoint in pairs(village.waypoints) do
                local dist = pos:distance(waypoint.pos)
                if dist < min_dist then
                    min_dist = dist
                    nearest_waypoint = waypoint
                end
            end
        end
    end
    return nearest_waypoint, min_dist
end


regulus2024_npcs.register_npc = function(name, def)
    minetest.register_entity(name, {
        initial_properties = {
            visual = def.visual or "mesh",
            mesh = def.mesh or "regulus2024_player2.glb",
            physical = def.physical or true,
            collide_with_objects = def.collide_with_objects or false,
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
        _average_time_per_look_update = def._average_time_per_look_update or 0.5,
        _lose_notice_dist = def._lose_notice_dist or 8,
        _gain_notice_dist = def._gain_notice_dist or 4,
        _target_waypoint = nil,
        _next_waypoint = nil,
        _prev_waypoint = nil,
        _general_walk_target = nil,
        _pace_around_walk_target = def._pace_around_walk_target or false,
        _walk_target = nil,
        _target_velocity = nil,
        _average_time_per_walk_target_update = def._average_time_per_walk_target_update or 5,
        _walk_speed = def._walk_speed or 2,
        _min_speed = 0.5,
        _max_speed = def._max_speed or 3,
        _walk_cycle_position = 0,
        _stride_length = def._stride_length or 1,
        _leg_length = def._leg_length or 0.6985,
        _eye_height = def._eye_height or 1.625,
        _scale = def._scale or 1, -- not the scale of the model, you have to set that manually SORRY I"M JUST RUSHING RIGHT NOW
        _awake = def._awake or true,
        _force_disappear = false,
        _queued_to_appear = false,
        _queued_to_disappear = false,
        _awake_time = def._awake_time or nil,

        on_activate = def.on_activate or function(self, dtime, staticdata)
            if def.extra_on_activate then
                def.extra_on_activate(self, dtime, staticdata)
            end
        end,
        on_step = def.on_step or function(self, dtime)
            -- QUEUED TO APPEAR/DISAPPEAR
            -- check if player is watching
            local is_player_watching = true
            for _, player in pairs(minetest.get_connected_players()) do
                if player:get_look_dir():dot(self.object:get_pos() - player:get_pos()) < 0 then
                    is_player_watching = false
                end
            end
            if not is_player_watching then
                if self._queued_to_appear then
                    local props = self.object:get_properties()
                    props.is_visible = true
                    self.object:set_properties(props)
                    self._queued_to_appear = false
                elseif self._queued_to_disappear then
                    local props = self.object:get_properties()
                    props.is_visible = false
                    self.object:set_properties(props)
                    self._queued_to_disappear = false
                end
            end

            -- SLEEPING/WAKING
            if self._awake_time then
                if self._awake_time.wake_up < self._awake_time.fall_asleep then
                    if minetest.get_timeofday() > self._awake_time.wake_up and minetest.get_timeofday() < self._awake_time.fall_asleep then
                        self._awake = true
                    else
                        self._awake = false
                    end
                else
                    if minetest.get_timeofday() < self._awake_time.wake_up and minetest.get_timeofday() > self._awake_time.fall_asleep then
                        self._awake = false
                    else
                        self._awake = true
                    end
                end
            end
            local props = self.object:get_properties()
            if not props.is_visible and self._awake and not self._force_disappear then
                self._queued_to_appear = true
            elseif props.is_visible and not self._awake  or self._force_disappear then
                self._queued_to_disappear = true
            end


            -- LOOK DIRECTION

            if type(self._look_target) == "userdata" and self._look_target:get_pos() and self._look_target:get_pos():distance(self.object:get_pos()) > self._lose_notice_dist then
                self._look_target = nil
                self._look_target = self.object:get_pos() + vector.new(math.random() * 0.5 - 0.25, math.random() - 0.5, math.random() + 2):rotate(self.object:get_rotation()) * math.random(5,20)
            end
            for _, player in pairs(minetest.get_connected_players()) do
                if player:get_pos():distance(self.object:get_pos()) < self._gain_notice_dist  and self._look_target ~= player then
                    self._look_target = player
                    self.object:set_yaw(vector.dir_to_rotation(player:get_pos():direction(self.object:get_pos())).y + math.pi)
                end
            end
            
            if type(self._look_target) == "userdata" then
                update_head_direction(self, self._look_target:get_pos() + vector.new(0,1,0) * self._look_target:get_properties().eye_height - vector.new(0,1,0) * self._eye_height, 8, dtime)
            else
                update_head_direction(self, self._look_target, 2, dtime) 
                -- If not focused on a player, pick a new target every so often
                if math.random() < 1 / self._average_time_per_look_update * dtime then
                    self._look_target = self.object:get_pos() + vector.new(math.random() * 0.5 - 0.25, math.random() - 0.5, math.random() + 2):rotate(self.object:get_rotation()) * math.random(5,20)
                end
            end

            -- WALKING

            if self._state == "idle_walk" then
                if math.random() < dtime / self._average_time_per_walk_target_update then
                    self._walk_target = self.object:get_pos() + vector.new(math.random() - 0.5, 0, math.random() - 0.5) * 10
                end
            elseif self._state == "idle" and self._pace_around_walk_target and self._general_walk_target then
                if math.random() < dtime / self._average_time_per_walk_target_update then
                    self._walk_target = self._general_walk_target + vector.new(math.random() - 0.5, 0, math.random() - 0.5) * self._pace_around_walk_target
                end
            elseif self._state == "walk_to_waypoint" then
                if self._target_waypoint then
                    if self._walk_target ~= nil then
                        -- dist to next waypoint, if we choose to randomly walk nearby waypoints not directly towards them.
                        local offset_to_walk_target = self.object:get_pos() - self._walk_target
                        offset_to_walk_target.y = 0
                        local dist_to_walk_target = offset_to_walk_target:length()
                        if dist_to_walk_target < 1 then
                            -- Arrived, time to pick next pos
                            -- Emit Callback if we made it to the end
                            if self._next_waypoint and self._next_waypoint.pos == self._target_waypoint.pos then
                                if def.on_reach_target_waypoint then
                                    self._target_waypoint = nil
                                    def.on_reach_target_waypoint(self)
                                end
                            else
                                self._prev_waypoint = get_nearest_waypoint(self.object:get_pos())
                                self._next_waypoint = get_next_waypoint(self._prev_waypoint, self._target_waypoint)
                                if self._next_waypoint then
                                    self._walk_target = self._next_waypoint.pos + vector.new(math.random() - 0.5, 0, math.random() - 0.5):normalize() * self._next_waypoint.radius
                                end
                            end
                        end
                    else
                        self._next_waypoint = get_nearest_waypoint(self.object:get_pos())
                        self._walk_target = self._next_waypoint.pos + vector.new(math.random() - 0.5, 0, math.random() - 0.5):normalize() * self._next_waypoint.radius
                    end
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
                self._walk_cycle_position = self._walk_cycle_position + dtime * horizontal_vel:length() / (self._stride_length * self._scale) / (self._leg_length * self._scale) / 2

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
        tiles = def.tiles,
        pointable = minetest.is_creative_enabled(),
        walkable = false,
        paramtype2 = "facedir",
        drawtype = minetest.is_creative_enabled() and "normal" or "airlike",
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
                local obj = minetest.add_entity(pos - vector.new(0, 0.5, 0), npc)
                local rotation = -minetest.get_node(pos).param2 % 4 * math.pi/2 + math.pi
                obj:set_rotation(vector.new(0, rotation, 0))
                meta:set_int("triggered", 1)
            end
        end
    })
end


minetest.register_node("regulus2024_npcs:waypoint_debug", {
    description = "Debug node for waypoints",
    tiles = {"regulus2024_waypoint_debug.png"},
    walkable = false,
    pointable = minetest.is_creative_enabled(),
    drawtype = minetest.is_creative_enabled() and "normal" or "airlike",
    groups = {unbreakable = 1},
})


dofile(minetest.get_modpath("regulus2024_npcs") .. "/npcs.lua")