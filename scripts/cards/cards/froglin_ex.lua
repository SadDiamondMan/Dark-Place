local Forest, super = Class(Card, "froglin_ex")

function Forest:init()
	super:init(self)
	
	self.image = "cards/froglin_ex"
	-- self.back = "cards/ex_back"				-- Technically not required since it's this by default anyways
	
	self.value = 2
	self.cost = 4
	
	self.attack = true
	self.defense = true
	
	self.status = { "poison" }
	
	self.sprite:setSprite(self.back)
end

return Forest