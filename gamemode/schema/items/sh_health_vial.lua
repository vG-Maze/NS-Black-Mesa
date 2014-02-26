ITEM.name = "Health Boost"
ITEM.category = "Medical"
ITEM.desc = "A small injection device with green liquid."
ITEM.model = Model("models/healthvial.mdl")
ITEM.useSound = "items/medshot4.wav"
ITEM:AddQuery("on use: give 25 health")
ITEM.flag = "V"
ITEM.price = 40