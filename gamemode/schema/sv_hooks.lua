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

	
	/*
	================================================================================================
									FRONT DOOR OF BLACK MESA
	================================================================================================
	*/
	
	if trace.Entity:GetName() == "controlroom scanner 1699" or trace.Entity:GetName() == "controlroom scanner 169" or trace.Entity:GetName() == "outsidedoors" then
		
		if ply:HasFlag("c1") then
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

	/*
	================================================================================================
									ENTRANCE FROM TRAM STATION
	================================================================================================
	*/			
		
		if trace.Entity:GetName() == "lambdalab scanner" or trace.Entity:GetName() == "lambdalab doors" then
		
		if ply:HasFlag("c1") then
			return true
		else
		
			if antispam2 == 0 then
				timer.Create( "VOXDeny14", 0.1, 1, function()
				antispam2 = 1
					
					timer.Create( "AntiSpam04", 3, 1, function()
						antispam2 = 0
					end)
					
				trace.Entity:EmitSound("vox/access.wav", 80, 100)
						timer.Create( "VoxDeny24", 0.8, 1, function()
						trace.Entity:EmitSound("vox/denied.wav", 80, 100)
					end)
				end)
				else 
				return false 
			end
				return false 
		end
		
		end	
		
	/*
	================================================================================================
									AMS SCANNERS
	================================================================================================
	*/					
		
				if trace.Entity:GetName() == "controlroom scanner 1" or trace.Entity:GetName() == "controlroom scanner door" or trace.Entity:GetName() == "controlroom scanner 2" or trace.Entity:GetName() == "chamber scanner"  then
		
		if ply:HasFlag("c3") then
			return true
		else
		
			if antispam3 == 0 then
				timer.Create( "VOXDeny13", 0.1, 1, function()
				antispam3 = 1
					
					timer.Create( "AntiSpam03", 3, 1, function()
						antispam3 = 0
					end)
					
				trace.Entity:EmitSound("vox/access.wav", 80, 100)
						timer.Create( "VoxDeny23", 0.8, 1, function()
						trace.Entity:EmitSound("vox/denied.wav", 80, 100)
					end)
				end)
				else 
				return false 
			end
				return false 
		end
		
		end	
		
	/*
	================================================================================================
								MAIN TELEPORTER BUTTONS
	================================================================================================
	*/				


		if trace.Entity:GetName() == "lambdalab poweroff" or trace.Entity:GetName() == "lambdalab mainbutton 1" or trace.Entity:GetName() == "lambdalab mainbutton 2" then
		
		if ply:HasFlag("c3") then
			return true
		else
		
			if antispam4 == 0 then
				timer.Create( "VOXDeny12", 0.1, 1, function()
				antispam4 = 1
					
					timer.Create( "AntiSpam02", 3, 1, function()
						antispam4 = 0
					end)
					
				trace.Entity:EmitSound("buttons/button2.wav", 80, 100)
						timer.Create( "VoxDeny22", 0.8, 1, function()
						--trace.Entity:EmitSound("vox/denied.wav", 80, 100)
					end)
				end)
				else 
				return false 
			end
				return false 
		end
		
		end			
		
	/*
	================================================================================================
										AMS BUTTONS
	================================================================================================
	*/			
		
		if trace.Entity:GetName() == "cartbutton" or trace.Entity:GetName() == "keypad1" or trace.Entity:GetName() == "secondbutton" then
		
		if ply:HasFlag("c3") then
			return true
		else
		
			if antispam5 == 0 then
				timer.Create( "VOXDeny15", 0.1, 1, function()
				antispam5 = 1
					
					timer.Create( "AntiSpam05", 2, 1, function()
						antispam5 = 0
					end)
					
				trace.Entity:EmitSound("buttons/button2.wav", 80, 100)
						timer.Create( "VoxDeny25", 0.8, 1, function()
						
					end)
				end)
				else 
				return false 
			end
				return false 
		end
		
		end
		
		
	/*
	================================================================================================
									MAIN ROTOR BUTTON AMS
	================================================================================================
	*/			
		
		
		if trace.Entity:GetName() == "motor_button" then
		
		if ply:HasFlag("c3") then
			return true
		else
		
			if antispammotor == 0 then
				timer.Create( "VOXDenyMotor", 0.1, 1, function()
				antispammotor = 1
					
					timer.Create( "AntiSpamMotor", 2, 1, function()
						antispammotor = 0
					end)
					
				trace.Entity:EmitSound("buttons/button2.wav", 80, 100)
						timer.Create( "VoxDenyMotor", 0.8, 1, function()
						
					end)
				end)
				else 
				return false 
			end
				return false 
		end
		
		end				
		
	/*
	================================================================================================
									CONTROL ROOM SCANNER
	================================================================================================
	*/			
		

		if trace.Entity:GetName() == "controlroom scanner 135"  or trace.Entity:GetName() == "lk134" then
		
		--if ply:Team() == TEAM_PHYSICIST or ply:Team() == TEAM_MAYOR or ply:Team() == TEAM_BIOWORKER or ply:Team() == TEAM_HES or ply:Team() == TEAM_SCIINSTRUCTOR or ply:Team() == TEAM_HEADPHYSICIST or ply:Team() == TEAM_SECURITY or ply:Team() == TEAM_SECINSTRUCTOR or ply:Team() == TEAM_SECURITYADMIN then
		if ply:HasFlag("c3") then
			return true
		else
		
			if antispam6 == 0 then
				timer.Create( "VOXDeny16", 0.1, 1, function()
				antispam6 = 1
					
					timer.Create( "AntiSpam06", 3, 1, function()
						antispam6 = 0
					end)
					
				trace.Entity:EmitSound("vox/access.wav", 80, 100)
						timer.Create( "VoxDeny26", 0.8, 1, function()
						trace.Entity:EmitSound("vox/denied.wav", 80, 100)
					end)
				end)
				else 
				return false 
			end
				return false 
		end
		
		end			


	/*
	================================================================================================
									SECTOR C ACCESS SCANNER
	================================================================================================
	*/					
		

		if trace.Entity:GetName() == "sector c access scanner" then
		
		if ply:HasFlag("c2") then
			return true
		else
		
			if antispam7 == 0 then
				timer.Create( "VOXDeny71", 0.1, 1, function()
				antispam7 = 1
					
					timer.Create( "AntiSpam07", 3, 1, function()
						antispam7 = 0
					end)
					
				trace.Entity:EmitSound("vox/access.wav", 80, 100)
						timer.Create( "VoxDeny27", 0.8, 1, function()
						trace.Entity:EmitSound("vox/denied.wav", 80, 100)
					end)
				end)
				else 
				return false 
			end
				return false 
		end
		
		end		


	/*
	================================================================================================
									SECURITY STATION SCANNER
	================================================================================================
	*/			

		if trace.Entity:GetName() == "secdoor scanner" then
		
		if ply:HasFlag("cs") then
			return true
		else
		
			if antispam8 == 0 then
				timer.Create( "VOXDeny20", 0.1, 1, function()
				antispam8 = 1
					
					timer.Create( "AntiSpam20", 3, 1, function()
						antispam8 = 0
					end)
					
				trace.Entity:EmitSound("vox/access.wav", 80, 100)
						timer.Create( "VoxDeny242", 0.8, 1, function()
						trace.Entity:EmitSound("vox/denied.wav", 80, 100)
					end)
				end)
				else 
				return false 
			end
				return false 
		end
		
		end			
		
	/*
	================================================================================================
									OUTDOOR DOORS + BUTTON
	================================================================================================
	*/					
		
		
		if trace.Entity:GetName() == "outdoor_doors locker" or trace.Entity:GetName() == "carenterlocker" then
			return true
		end					

	if trace.Entity:GetClass() == "func_recharge" then
		if ply:GetPData("suitedup") == "1" then
			return true
		else
			return false
		end	
	end	
	
	if trace.Entity:GetName() ~= "controlroom scanner 1699" then
		return true
	end
	
end