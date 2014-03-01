--[[
	Purpose: Called to allow items to be added to a character during
	character creation. The inventory table is passed which contains
	an inventory:Add(uniqueID, quantity, data) method which is similar
	to client:UpdateInv(), the player who created the character is passed
	as the 2nd argument, and the character creation data is passed as the
	3rd argument.
--]]
function SCHEMA:GetDefaultInv(inventory, client, data)
	-- PrintTable(data) to see what information it contains.
	
	if (data.faction == FACTION_SCU) then
		inventory:Add("cid", 1, {
			Owner = data.charname,
			Digits = math.random(1111,9999),
			Clearance = SCHEMA:StringClearances(client)
		})
		inventory:Add("radio", 1)
		inventory:Add("flashlight", 1)
		inventory:Add("cuffs", 1)
		inventory:Add("pager", 1)
		client:GiveFlag("c1")
		client:GiveFlag("c2")
		client:GiveFlag("cs")
	end
	if (data.faction == FACTION_CIV) then
		inventory:Add("cid", 1, {
			Owner = data.charname,
			Digits = math.random(1111,9999),
			Clearance = SCHEMA:StringClearances(client)
		})
	end
	if (data.faction == FACTION_SCN) then
		inventory:Add("cid", 1, {
			Owner = data.charname,
			Digits = math.random(1111,9999),
			Clearance = SCHEMA:StringClearances(client)
		})
		inventory:Add("pager", 1)
		client:GiveFlag("c1")
		client:GiveFlag("c2")
	end
	if (data.faction == FACTION_SEV) then
		inventory:Add("cid", 1, {
			Owner = data.charname,
			Digits = math.random(1111,9999),
			Clearance = SCHEMA:StringClearances(client)
		})
		inventory:Add("radio", 1)
		inventory:Add("pager", 1)
		client:GiveFlag("c1")
	end
	if (data.faction == FACTION_ADM) then
		inventory:Add("cid", 1, {
			Owner = data.charname,
			Digits = math.random(1111,9999),
			Clearance = SCHEMA:StringClearances(client)
		})
		inventory:Add("radio", 1)
		inventory:Add("pager", 1)
		client:GiveFlag("c1")
		client:GiveFlag("c2")
		client:GiveFlag("cs")
		client:GiveFlag("cx")
	end
	if (data.faction == FACTION_MED) then
		inventory:Add("cid", 1, {
			Owner = data.charname,
			Digits = math.random(1111,9999),
			Clearance = SCHEMA:StringClearances(client)
		})
		inventory:Add("radio", 1)
		inventory:Add("pager", 1)
		inventory:Add("health_kit", 1)
		inventory:Add("health_boost", 1)
		client:GiveFlag("c1")
		client:GiveFlag("c2")
	end
end

--[[
	Purpose: Called when the player has spawned with a valid character.
--]]
function SCHEMA:PlayerSpawn(client)
	
end

function SCHEMA:StringClearances (client)
	local clearancestring
	if client:HasFlag("c1") then
		clearancestring = clearancestring + "1"
	end
	if client:HasFlag("c2") then
		clearancestring = clearancestring + ",2"
	end
	if client:HasFlag("c3") then
		clearancestring = clearancestring + ",3"
	end
	if client:HasFlag("cs") then
		clearancestring = clearancestring + ",S"
	end
	
	
	return clearancestring
end

function SCHEMA:PlayerUse(ply, cmd, args, entity)

	if ply:EntIndex() == 0 then
		return
	end

	local trace = ply:GetEyeTrace()

	if not IsValid(trace.Entity) or ply:EyePos():Distance(trace.Entity:GetPos()) > 200 then
		return
	end
	
	--print(trace.Entity:GetName())
	
	if trace.Entity:GetName() == "ams_controlroom_door2" or trace.Entity:GetName() == "ams_controlroom_door1" then
		
		if ply:HasFlag("c3") then
			return true
		else
			if antispam == 0 then
				timer.Create( "VOXDeny1", 0.1, 1, function()
					ply:ChatPrint("Access Denied. Visitors must contact Security personnel for entry.")
					antispam = 1
					
					timer.Create( "AntiSpam0", 3, 1, function()
					antispam = 0
					end)
					
					trace.Entity:EmitSound("vox/access.wav", 80, 100)
					timer.Create( "VoxDeny2", 0.8, 1, function()
						trace.Entity:EmitSound("vox/denied.wav", 80, 100)
					end)
				end)
				
			else 
				return false 
			end
		return false 
		end		
	end	
end