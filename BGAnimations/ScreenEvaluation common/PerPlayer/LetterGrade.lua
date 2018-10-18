if SL.Global.GameMode ~= "StomperZ" then
	local pn = ...

	local playerStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
	local grade = playerStats:GetGrade()

	-- "I passd with a q though."
	local title = GAMESTATE:GetCurrentSong():GetDisplayFullTitle()
	if title == "D" then grade = "Grade_Tier99" end

	-- Sangyeol's additions
	-- only applies to letter grades since stars won't animate properly
	local mode = SL.Global.GameMode
	local Blue, Gold, Green = "#21CCE8", "#E29C18", "#66C955"
	local FCglow = nil
	local FCcolors = {
		Casual = {Blue, Gold, Green, nil},
		Competitive = {Blue, Gold, Green, nil},
		ECFA = {Blue, Blue, Gold, Green}
	}

	local isStarRating = false
	for i=1,4 do
		if (grade == ("Grade_Tier0"..i)) then
			isStarRating = true
			break
		end
	end

	if grade ~= "Grade_Failed" and (isStarRating == false) then
		for i=1,4 do
			if playerStats:FullComboOfScore('TapNoteScore_W'..i) then
				FCglow = FCcolors[mode][i]
				break
			end
		end
	end
	-- end of additions
	
	local t = Def.ActorFrame{}

	t[#t+1] = LoadActor(THEME:GetPathG("", "_grades/"..grade..".lua"), playerStats)..{
		InitCommand=cmd(xy, 70, _screen.cy-134),
		OnCommand=function(self)
			self:zoom(0.4)
			if pn == PLAYER_1 then
				self:x( self:GetX() * -1 )
			end

			-- additions
			if FCglow ~= nil then
				self:diffuseshift()
				self:effectcolor1(color("#FFFFFF"))
				self:effectcolor2(color(FCglow))
				self:effectperiod(1.25)
			end
			-- end additions
		end
	}

	if ThemePrefs.Get("nice") > 0 then
		t[#t+1] = LoadActor("nice.lua", pn)
	end

	return t

end
