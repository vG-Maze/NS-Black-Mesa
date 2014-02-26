PLUGIN.name = "Handcuffs"
PLUGIN.author = "Chessnut"
PLUGIN.desc = "Adds the ability for players to cuff others."

if (SERVER) then
	function PLUGIN:PlayerInteract(client, target)
		if (target:IsPlayer() and target:GetNetVar("tied")) then
			if (target:GetNutVar("beingTied") or target:GetNutVar("beingUnTied")) then
				nut.util.Notify("You can not uncuff this player right now.", client)

				return false
			end

			local i = 0

			target:SetMainBar("You are being uncuffed by "..client:Name()..".", 5)
			target:SetNutVar("beingUnTied", true)
			client:SetMainBar("You are uncuffing "..target:Name()..".", 5)

			local uniqueID = "nut_UnTieing"..target:UniqueID()

			timer.Create(uniqueID, 0.25, 20, function()
				i = i + 1

				if (!IsValid(client) or client:GetEyeTraceNoCursor().Entity != target or target:GetPos():Distance(client:GetPos()) > 128) then
					if (IsValid(target)) then
						target:SetMainBar()
						target:SetNutVar("beingUnTied", false)
					end

					if (IsValid(client)) then
						client:SetMainBar()
					end

					timer.Remove(uniqueID)

					return
				end

				if (i == 20) then
					target:SetNetVar("tied", false)

					local weapons = target:GetNutVar("tiedWeapons", {})

					for k, v in pairs(weapons) do
						target:Give(v)
					end

					target:SetNutVar("tiedWeapons", nil)
					target:SetNutVar("beingUnTied", false)
				end
			end)
		end
	end
end