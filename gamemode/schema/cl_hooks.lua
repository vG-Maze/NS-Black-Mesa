function SCHEMA:ModifyColorCorrection(color)
	local viewEntity = LocalPlayer():GetViewEntity()

	if (IsValid(nut.gui.charMenu)) then
		color["$pp_colour_brightness"] = -0.4
		color["$pp_colour_colour"] = 0
		color["$pp_colour_contrast"] = 1.5
	end

	self.color = LocalPlayer():GetNetVar("noDepress") or 0
	self.deltaColor = math.Approach(self.deltaColor, self.color, FrameTime() * 0.25)
	color["$pp_colour_colour"] = math.max(color["$pp_colour_colour"] + self.deltaColor, 0)
end