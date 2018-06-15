-- put in this folder:
-- Simply Love/BGAnimations/ScreenEvaluation common/PerPlayer/

if SL.Global.GameMode ~= "StomperZ" then
	local pn = ...

	local playerStats = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
	local grade = playerStats:GetGrade()

	-- "I passd with a q though."
	local title = GAMESTATE:GetCurrentSong():GetDisplayFullTitle()
	if title == "D" then grade = "Grade_Tier99" end

	-- added
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
	end
	-- added end

	return LoadActor(THEME:GetPathG("", "_grades/"..grade..".lua"), playerStats)..{
		InitCommand=cmd(xy, 70, _screen.cy-134),
		OnCommand=function(self)
			self:zoom(0.4)
			if pn == PLAYER_1 then
				self:x( self:GetX() * -1 )
			end

			-- added
			if FCcolor ~= nil then
				self:diffuseshift():effectperiod(1.5)
				self:effectcolor1( color("#FFFFFF") )
				self:effectcolor2( FCcolor )
			end
			-- added end
		end
	}
end