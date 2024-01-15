---@class you_plush : Pickup
---@overload fun(...) : you_plush
local you_plush, super = Class(Event, "you_plush")

function you_plush:init(data)
	super.init(self, data.x, data.y, data.w, data.h)

    local properties = data.properties or {}

    self:setOrigin(0.5, 0.5)
    self:setScale(2)
	
    self.sprite = Sprite("world/events/pickup_plush/you_plush")
    self:addChild(self.sprite)

    self:setSize(self.sprite:getSize())
    self:setHitbox(1, 2, 18, 17)

    self.solid = true
	
	self.held = false
	
	self.place_math = {
		["up"] = {0, -42},
		["down"] = {0, 20},
		["left"] = {-42, -20},
		["right"] = {42, -20},
	}
end

function you_plush:postLoad()
	self.old_parent = self.parent
end

function you_plush:onInteract(player, dir)
	Assets.playSound("croak")
    self:setParent(player)
	self.x = player.width/2
	self.y = -6
	self:setScale(1,1)
	
	self.held = true
	player.holding = self

    return true
end

function you_plush:onLiteInteract(player2, dir)
	Assets.playSound("croak")
    self:setParent(player2)
	self.x = player2.width/2
	self.y = -6
	self:setScale(1,1)
	
	self.held2 = true
	player2.holding = self

    return true
end

function you_plush:update()
	super.update(self)
	
	if self.held and Input.pressed("confirm") and self:canPlace(Game.world.player) then
		Assets.playSound("croak")
		self:setParent(Game.world)
		self.held = false
		Game.world.player.holding = nil
		self.x = Game.world.player.x + self.place_math[Game.world.player.facing][1]
		self.y = Game.world.player.y + self.place_math[Game.world.player.facing][2]
		self:setScale(2,2)
	elseif self.held2 and Input.pressed("u") and self:canPlace(Game.world.player2) then
		Assets.playSound("croak")
		self:setParent(Game.world)
		self.held2 = false
		Game.world.player2.holding = nil
		self.x = Game.world.player2.x + self.place_math[Game.world.player2.facing][1]
		self.y = Game.world.player2.y + self.place_math[Game.world.player2.facing][2]
		self:setScale(2,2)
	end
end

function you_plush:canPlace(player)
	return not Game.world:checkCollision(player.interact_collider[player.facing])

end

function you_plush:onRemove(parent)
	self.data = nil
    if parent:includes(World) or parent.world then
        self.world = nil
    end
end

return you_plush