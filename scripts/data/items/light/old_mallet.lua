local item, super = Class(LightEquipItem, "light/old_mallet")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Old Mallet"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Whether this item is for the light world
    self.light = true

    -- Default shop sell price
    self.sell_price = 150

    -- Item description text (unused by light items outside of debug menu)
    self.description = "A mallet that has seen better days."

    -- Light world check text
    self.check = "Weapon AT 0\n* A mallet that has seen\nbetter days."

    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
end

function item:convertToDark(inventory)
    return "basic_hammer"
end

return item