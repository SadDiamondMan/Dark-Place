local Player2, super = Class(Character)

function Player2:init(chara, x, y, other)
    super.init(self, chara, x, y, other)

    self.is_player2 = true

    self.slide_sound = Assets.newSound("paper_surf")
    self.slide_sound:setLooping(true)

    self.state_manager = StateManager("WALK", self, true)
    self.state_manager:addState("WALK", {update = self.updateWalk})
    self.state_manager:addState("SLIDE", {update = self.updateSlide, enter = self.beginSlide, leave = self.endSlide})

    self.force_run = false
    self.force_walk = false
    self.run_timer = 0
    self.run_timer_grace = 0

    self.auto_moving = false

    self.current_slide_area = nil
    self.slide_in_place = false
    self.slide_lock_movement = false
    self.slide_dust_timer = 0
    self.slide_land_timer = 0

    self.hurt_timer = 0

    self.moving_x = 0
    self.moving_y = 0
    self.walk_speed = 4

    self.last_move_x = self.x
    self.last_move_y = self.y

    self.history_time = 0
    self.history = {}

    self.battle_canvas = love.graphics.newCanvas(320, 240)
    self.battle_alpha = 0

    self.persistent = true
    self.noclip = false

    self.outlinefx = self:addFX(BattleOutlineFX())
    self.outlinefx:setAlpha(self.battle_alpha)
    self.state_manager:addState("HOP", {enter = self.beginHop, update = self.updateHop, leave = self.endHop})
end

function Player2:getDebugInfo()
    local info = super.getDebugInfo(self)
    table.insert(info, "State: " .. self.state)
    table.insert(info, "Walk speed: " .. self.walk_speed)
    table.insert(info, "Run timer: " .. self.run_timer)
    table.insert(info, "Hurt timer: " .. self.hurt_timer)
    table.insert(info, "Slide in place: " .. (self.slide_in_place and "True" or "False"))
    return info
end

function Player2:getDebugOptions(context)
    context = super.getDebugOptions(self, context)
    context:addMenuItem("Toggle force run", "Toggle if the player2 is forced to run or not", function() self.force_run = not self.force_run end)
    context:addMenuItem("Toggle force walk", "Toggle if the player2 is forced to walk or not", function() self.force_walk = not self.force_walk end)
    return context
end

function Player2:onAdd(parent)
    super.onAdd(self, parent)

    if parent:includes(World) and not parent.player2 then
        parent.player2 = self
    end
end

function Player2:onRemove(parent)
    super.onRemove(self, parent)

    self.slide_sound:stop()
    if parent:includes(World) and parent.player2 == self then
        parent.player2 = nil
    end
end

function Player2:onRemoveFromStage(stage)
    super.onRemoveFromStage(stage)
    self.slide_sound:stop()
end

function Player2:setActor(actor)
    super.setActor(self, actor)

    local hx, hy, hw, hh = self.collider.x, self.collider.y, self.collider.width, self.collider.height

    self.interact_collider = {
        ["left"] = Hitbox(self, hx - 13, hy, hw/2 + 13, hh),
        ["right"] = Hitbox(self, hx + hw/2, hy, hw/2 + 13, hh),
        ["up"] = Hitbox(self, hx, hy - 19, hw, hh/2 + 19),
        ["down"] = Hitbox(self, hx, hy + hh/2, hw, hh/2 + 14)
    }
end

function Player2:interact()
    local col = self.interact_collider[self.facing]

    local interactables = {}
    for _,obj in ipairs(self.world.children) do
        if obj.onInteract and obj:collidesWith(col) then
            local rx, ry = obj:getRelativePos(obj.width/2, obj.height/2, self.parent)
            table.insert(interactables, {obj = obj, dist = Utils.dist(self.x,self.y, rx,ry)})
        end
    end
    table.sort(interactables, function(a,b) return a.dist < b.dist end)
    for _,v in ipairs(interactables) do
        if v.obj:onLiteInteract(self, self.facing) then
            return true
        else
        end
    end

    return false
end

function Player2:setState(state, ...)
    self.state_manager:setState(state, ...)
end

function Player2:isCameraAttachable()
    return not (self.state == "SLIDE" and self.slide_in_place)
end

function Player2:isMovementEnabled()
    return not OVERLAY_OPEN
        and not Game.lock_movement
        and not self.slide_lock_movement
        and Game.state == "OVERWORLD"
        and self.world.state == "GAMEPLAY"
        and self.hurt_timer == 0
end

function Player2:handleMovement()
    local walk_x = 0
    local walk_y = 0

    if Input.down("l") then walk_x = walk_x + 1 end
    if Input.down("j") then walk_x = walk_x - 1 end
    if Input.down("k") then walk_y = walk_y + 1 end
    if Input.down("i") then walk_y = walk_y - 1 end

    if Input.pressed("u") and Game.world.player2 then
	
        if self:interact() then
            Input.clear("u")
        else
            --self:croak()
        end
    end

    self.moving_x = walk_x
    self.moving_y = walk_y

    local running = (Input.down("o") or self.force_run) and not self.force_walk
    if Kristal.Config["autoRun"] and not self.force_run and not self.force_walk then
        running = not running
    end

    local speed = self.walk_speed
    if running then
        if self.run_timer > 60 then
            speed = speed * 2.25
        elseif self.run_timer > 10 then
            speed = speed * 2
        else
            speed = speed * 1.5
        end
    end

    self:move(walk_x, walk_y, speed * DTMULT)

    if not running or self.last_collided_x or self.last_collided_y then
        self.run_timer = 0
    elseif running then
        if walk_x ~= 0 or walk_y ~= 0 then
            self.run_timer = self.run_timer + DTMULT
            self.run_timer_grace = 0
        else
            -- Dont reset running until 2 frames after you release the movement keys
            if self.run_timer_grace >= 2 then
                self.run_timer = 0
            end
            self.run_timer_grace = self.run_timer_grace + DTMULT
        end
    end
end

function Player2:updateWalk()
    if self:isMovementEnabled() then
        self:handleMovement()
    end

    super.updateWalk(self)

    if not self:isMovementEnabled() then return end

    if Input.pressed("a") and (self.actor.id == "YOU" or self.actor.id == "YOU_lw") and Mod.can_croak ~= false then
        self:croak()
    end
end

function Player2:onKeyPressed(key)

end

function Player2:isMoving()
    return self.moving_x ~= 0 or self.moving_y ~= 0
end

function Player2:beginSlide(last_state, in_place, lock_movement)
    self.slide_sound:play()
    self.auto_moving = true
    self.slide_in_place = in_place or false
    self.slide_lock_movement = lock_movement or false
    self.slide_land_timer = 0
    self.sprite:setAnimation("slide")
end
function Player2:updateSlideDust()
    self.slide_dust_timer = Utils.approach(self.slide_dust_timer, 0, DTMULT)

    if self.slide_dust_timer == 0 then
        self.slide_dust_timer = 3

        local dust = Sprite("effects/slide_dust")
        dust:play(1/15, false, function() dust:remove() end)
        dust:setOrigin(0.5, 0.5)
        dust:setScale(2, 2)
        dust:setPosition(self.x, self.y)
        dust.layer = self.layer - 0.01
        dust.physics.speed_y = -6
        dust.physics.speed_x = Utils.random(-1, 1)
    end
end
function Player2:updateSlide()
    local slide_x = 0
    local slide_y = 0

    if Game.world.player:isMovementEnabled() then
        if Input.down("l") then slide_x = slide_x + 1 end
        if Input.down("j") then slide_x = slide_x - 1 end
        if Input.down("k") then slide_y = slide_y + 1 end
        if Input.down("i") then slide_y = slide_y - 1 end
    end

    if not self.slide_in_place then
        slide_y = 2
    end

    self.run_timer = 50
    local speed = self.walk_speed + 4

    self:move(slide_x, slide_y, speed * DTMULT)

    self:updateSlideDust()
end
function Player2:endSlide(next_state)
    if self.slide_lock_movement then
        self.slide_land_timer = 4
    else
        self.slide_sound:stop()
        self.sprite:resetSprite()
    end
    self.auto_moving = false
end

function Player2:update()
    if self.hurt_timer > 0 then
        self.hurt_timer = Utils.approach(self.hurt_timer, 0, DTMULT)
    end

    if self.slide_land_timer > 0 and self.state ~= "SLIDE" then
        self.slide_land_timer = Utils.approach(self.slide_land_timer, 0, DTMULT)
        if self.slide_land_timer == 0 then
            self.slide_sound:stop()
            self.sprite:resetSprite()
            self.slide_lock_movement = false
        end
    end

    self.state_manager:update()

    self.world.in_battle_area = false
    for _,area in ipairs(self.world.map.battle_areas) do
        if area:collidesWith(self.collider) then
            if not self.world.in_battle_area then
                self.world.in_battle_area = true
            end
            break
        end
    end

    if self.world:inBattle() then
        self.battle_alpha = math.min(self.battle_alpha + (0.04 * DTMULT), 0.8)
    else
        self.battle_alpha = math.max(self.battle_alpha - (0.08 * DTMULT), 0)
    end

    if not Game.party[2] then
        self:remove()
    end

    self.outlinefx:setAlpha(self.battle_alpha)

    -- Holding run with the Pizza Toque equipped (or if the file name is "PEPPINO") will cause a gradual increase in speed.
    local toque_equipped = false
    for _,party in ipairs(Game.party) do
        if party:checkArmor("pizza_toque") then toque_equipped = true end
    end
    local player_name = Game.save_name:upper()
    if Game.world.map.id ~= "everhall" and Game.world.map.id ~= "everhall_entry" and toque_equipped == true or player_name == "PEPPINO" then
        if self.run_timer > 60 then
            self.walk_speed = self.walk_speed + DT
        elseif self.walk_speed > 4 then
            self.walk_speed = 4
        end
    end

    -- Hitting a wall at a speed of 10 or higher will do a small collision effect
    if toque_equipped or player_name == "PEPPINO" then
        if self.last_collided_x or self.last_collided_y then
            if self.walk_speed >= 10 then
                Game.world.player2:shake(4, 0)
            end
        end
    end

    super.update(self)

end

function Player2:croak()
    Assets.stopAndPlaySound("croak", nil, 0.8 + Utils.random(0.4))

    local bubble = Sprite("croak", nil, nil, nil, nil, "party/you")
    bubble:setOriginExact(60, 23) -- center??
    bubble:setPosition(self.width/2 + 2.5, -20.5)
    bubble.physics.speed_y = -0.8
    bubble:fadeOutSpeedAndRemove(0.065)
    self:addChild(bubble)
end

function Player2:beginHop(last_state, tx, ty, hop_time, hop_height)
    self.auto_moving = true
    Assets.playSound("smalljump")
    self.hop_timer = 0
    self.hop_walk_speed = self.sprite.walk_speed
    self.hop_start_x = self.x
    self.hop_start_y = self.y
    self.hop_target_x = tx or self.x
    self.hop_target_y = ty or self.y
    self.hop_speed = hop_time or 0.5
    self.hop_height = hop_height or 20
end
function Player2:updateHop()
    self.hop_timer = self.hop_timer + DT

    self.x = Utils.lerp(self.hop_start_x, self.hop_target_x, self.hop_timer / self.hop_speed)
    self.y = Utils.lerp(self.hop_start_y, self.hop_target_y, self.hop_timer / self.hop_speed)

    local half_hop = self.hop_speed / 2
    if self.hop_timer < half_hop then
        self.sprite.y = Utils.ease(0, -self.hop_height, self.hop_timer / half_hop, "out-cubic")
    elseif self.hop_timer < self.hop_speed then
        self.sprite.y = Utils.ease(-self.hop_height, 0, (self.hop_timer - half_hop) / half_hop, "in-cubic")
    end

    self.moved = math.max(4, self.hop_walk_speed)

    --self:moveCamera(100)

    if self.hop_timer >= self.hop_speed then
        self:setState("WALK")
    end
end
function Player2:endHop()
    self.auto_moving = false
    self.x = self.hop_target_x
    self.y = self.hop_target_y
    self.sprite.y = 0
end

function Player2:draw()
    -- Draw the player
    super.draw(self)

    local col = self.interact_collider[self.facing]
    if DEBUG_RENDER then
        col:draw(1, 0, 0, 0.5)
    end
end

return Player2