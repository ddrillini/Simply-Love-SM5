if SL.Global.GameMode ~= "StomperZ" then
	local pn = ...

	local playerStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
	local grade = playerStats:GetGrade()

	-- "I passd with a q though."
	local title = GAMESTATE:GetCurrentSong():GetDisplayFullTitle()
	if title == "D" then grade = "Grade_Tier99" end

	-- Glowing grades, by Sangyeol Baek
	local FCcolor = nil
	local isStarRating = (grade == "Grade_Tier01") or (grade == "Grade_Tier02") or (grade == "Grade_Tier03") or (grade == "Grade_Tier04")
	local failed = (grade == "Grade_Failed")
	if (isStarRating == false) and (failed == false) then
		if SL.Global.GameMode == "ECFA" then
			if playerStats:FullComboOfScore('TapNoteScore_W1') then
				FCcolor = color("#6BF0FF") -- blue
			elseif playerStats:FullComboOfScore('TapNoteScore_W2') then
				FCcolor = color("#6BF0FF") -- blue
			elseif playerStats:FullComboOfScore('TapNoteScore_W3') then
				FCcolor = color("#FDDB85") -- gold
			elseif playerStats:FullComboOfScore('TapNoteScore_W4') then
				FCcolor = color("#94FEC1") -- green
			else
				FCcolor = nil -- nothing
			end
		else
			if playerStats:FullCombo() then
				if playerStats:FullComboOfScore('TapNoteScore_W1') then
					FCcolor = color("#6BF0FF") -- blue
				elseif playerStats:FullComboOfScore('TapNoteScore_W2') then
					FCcolor = color("#FDDB85") -- gold
				else
					FCcolor = color("#94FEC1") -- green
				end
			end
		end
	end -- end glowing grades logic

	local t = Def.ActorFrame{}

	t[#t+1] = LoadActor(THEME:GetPathG("", "_grades/"..grade..".lua"), playerStats)..{
		InitCommand=cmd(xy, 70, _screen.cy-134),
		OnCommand=function(self)
			self:zoom(0.4)
			if pn == PLAYER_1 then
				self:x( self:GetX() * -1 )
			end
		end
	}

	if ThemePrefs.Get("nice") > 0 then
		t[#t+1] = LoadActor("nice.lua", pn)
	end

	return t

end
