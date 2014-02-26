SCHEMA.name = "Black Mesa"
SCHEMA.author = "Riekelt"
SCHEMA.desc = "Roleplaying in the Black Mesa Research Facility."
SCHEMA.uniqueID = "bmrp"
nut.currency.SetUp("dollar", "dollars")

nut.util.Include("sv_hooks.lua")

nut.chat.Register("request", {
	canHear = function(ply)
		if(ply:HasItem("pager")) then
			return true
		else
			return false
		end
	end,
	canSay = function(speaker)
		if (!speaker:HasItem("pager")) then
			nut.util.Notify(nut.lang.Get("no_perm", speaker:Name()), speaker)

			return
		end

		if (speaker:GetNutVar("nextReq", 0) < CurTime()) then
			speaker:SetNutVar("nextReq", CurTime() + 5)
		else
			nut.util.Notify("Please wait before sending another request.", speaker)
		end

		speaker:EmitSound("buttons/blip1.wav", 60)

		return true
	end,
	onSaid = function(speaker, text)
		chat.AddText(Color(220, 220, 220), "[REQUEST] ", Color(132, 98, 128), speaker..": " ..text)
	end,
	prefix = {"/req", "/request"}
})

-- Voor Cuffs Plugin
function SCHEMA:IsCombine ()
	return false
end