ITEM.name = "Health Kit"
ITEM.category = "Medical"
ITEM.desc = "A large medical kit capable of more healing."
ITEM.model = Model("models/items/healthkit.mdl")
ITEM.useSound = "items/medshot4.wav"
ITEM:AddQuery("on use: give 50 health")
ITEM.flag = "V"
ITEM.price = 60