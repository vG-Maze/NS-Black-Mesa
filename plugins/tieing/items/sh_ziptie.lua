ITEM.name = "Handcuffs"
ITEM.desc = "A metal pair of handcuffs."
ITEM.model = Model("models/items/crossbowrounds.mdl")
ITEM.price = 25
ITEM.functions = {}
ITEM.functions.Use = {
	text = "Cuff",
	icon = "icon16/link.png",
	run = function(item)
		if (CLIENT) then return end

		local client = item.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local trace = util.TraceLine(data)
		local target = trace.Entity

		if (IsValid(target)) then
			if (target:GetNutVar("beingTied") or target:GetNutVar("beingUnTied")) then
				nut.util.Notify("You can not cuff this player right now.", client)

				return false
			end

			local i = 0

			target:SetMainBar("You are being cuffed by "..client:Name()..".", 5)
			target:SetNutVar("beingTied", true)
			client:SetMainBar("You are cuffing "..target:Name()..".", 5)

			local uniqueID = "nut_Tieing"..target:UniqueID()

			timer.Create(uniqueID, 0.25, 20, function()
				i = i + 1

				if (!IsValid(client) or client:GetEyeTraceNoCursor().Entity != target or target:GetPos():Distance(client:GetPos()) > 128) then
					if (IsValid(target)) then
						target:SetMainBar()
						target:SetNutVar("beingTied", false)
					end

					if (IsValid(client)) then
						client:SetMainBar()
						client:UpdateInv("handcuffs")
					end

					timer.Remove(uniqueID)

					return
				end

				if (i == 20) then
					target:SetNetVar("tied", true)

					local weapons = {}

					for k, v in pairs(target:GetWeapons()) do
						weapons[#weapons + 1] = v:GetClass()
					end

					target:SetNutVar("tiedWeapons", weapons)
					target:StripWeapons()
					target:SetNutVar("beingTied", false)
				end
			end)
		else
			nut.util.Notify("You must be looking at a valid player.", client)

			return false
		end
	end
}