-- put in this folder:
-- Simply Love/Graphics/_grades/

local pss = ...
local t = Def.ActorFrame{}

-- added
local mode = SL.Global.GameMode
local isECFA = (mode == "ECFA")
local glowColor = nil
local Blue, Gold, Green = "#21CCE8", "#E29C18", "#66C955"
local FCcolor = {
   Casual={ Blue, Gold, Green, nil },
   Competitive={ Blue, Gold, Green, nil },
   ECFA={ Blue, Blue, Gold, Green }
}

-- flag (all fantastics except 1 ex): stars
t[#t+1] = LoadActor("./assets/star.png")..{
	OnCommand=function(self)
		if pss ~= nil and pss:GetTapNoteScores('TapNoteScore_Miss') == 0 and
				pss:GetTapNoteScores('TapNoteScore_W5') == 0 and
				pss:GetTapNoteScores('TapNoteScore_W4') == 0 and
				pss:GetTapNoteScores('TapNoteScore_W3') == 0 and
				pss:GetTapNoteScores('TapNoteScore_W2') == 1 then
			self:sleep(2)
			self:queuecommand('Animate')
		elseif pss ~= nil and isECFA and
			-- all blue fantastics (ECFA only)
			pss:GetTapNoteScores('TapNoteScore_Miss') == 0 and
			pss:GetTapNoteScores('TapNoteScore_W5') == 0 and
			pss:GetTapNoteScores('TapNoteScore_W4') == 0 and
			pss:GetTapNoteScores('TapNoteScore_W3') == 0 and
			pss:GetTapNoteScores('TapNoteScore_W2') == 0 and
			pss:GetTapNoteScores('TapNoteScore_W1') > 0 and
			pss:GetHoldNoteScores('HoldNoteScore_LetGo') == 0 and
			pss:GetTapNoteScores('TapNoteScore_HitMine') == 0 then
			self:rainbow()
			self:effectperiod(2 + 1.5 * math.random())
		else
			-- glow grades
			if pss ~= nil and
				pss:GetHoldNoteScores('HoldNoteScore_LetGo') == 0 and
				pss:GetTapNoteScores('TapNoteScore_Miss') == 0 and
				pss:GetTapNoteScores('TapNoteScore_W5') == 0 then
				for k=4,1,-1 do
					if pss:GetTapNoteScores('TapNoteScore_W'..k) > 0 then
						glowColor = FCcolor[mode][k]
						break
					end
				end
			end

			if glowColor ~= nil then
				self:diffuseshift()
				self:effectperiod(1.25)
				self:effectcolor1(color("#FFFFFF"))
				self:effectcolor2(color(glowColor))
			end
			-- end of my additions
		end
	end,
	AnimateCommand=function(self)
		self:rainbow()
		self:effectperiod(2 + 2 * math.random())
	end,
}

t[#t+1] = LoadActor("./assets/star.png")..{
	OnCommand=function(self)
		self:visible(false)
		if pss ~= nil and pss:GetTapNoteScores('TapNoteScore_Miss') == 0 and
				pss:GetTapNoteScores('TapNoteScore_W5') == 0 and
				pss:GetTapNoteScores('TapNoteScore_W4') == 0 and
				pss:GetTapNoteScores('TapNoteScore_W3') == 0 and
				pss:GetTapNoteScores('TapNoteScore_W2') == 1 and
				pss:GetHoldNoteScores('HoldNoteScore_LetGo') == 0 and
				pss:GetTapNoteScores('TapNoteScore_HitMine') == 0 then
			self:sleep(9)
			self:queuecommand('Appear')
		end
	end,
	AppearCommand=function(self)
		self:visible(true)
		self:MaskSource(true)
		self:sleep(5)
		self:queuecommand('Animate')
	end,
	AnimateCommand=function(self)
		self:vibrate()
		local m = self:GetZoomedWidth() / 20
		self:effectmagnitude(m, m, m)
		self:sleep(5)
		self:queuecommand('Animate2')
	end,
	Animate2Command=function(self)
		local m = self:GetZoomedWidth() / 5
		self:effectmagnitude(m, m, m)
	end,
}

t[#t+1] = LoadActor("./assets/affluent.png")..{
	OnCommand=function(self)
		self:y(10)
		self:zoom(1.2)
		self:diffusealpha(0)
		self.rotatepos = math.random() * 360
		self:rotationz(self.rotatepos)
		if pss ~= nil and pss:GetTapNoteScores('TapNoteScore_Miss') == 0 and
				pss:GetTapNoteScores('TapNoteScore_W5') == 0 and
				pss:GetTapNoteScores('TapNoteScore_W4') == 0 and
				pss:GetTapNoteScores('TapNoteScore_W3') == 0 and
				pss:GetTapNoteScores('TapNoteScore_W2') == 1 then
			self:sleep(9)
			self:queuecommand('Appear')
		end
	end,
	AppearCommand=function(self)
		self:linear(3)
		self:diffusealpha(0.7)
		self:ztestmode('WriteOnFail')
		self:sleep(2)
		self.rotatespeed = 0.6 + 0.4 * math.random()
		self:queuecommand('AnimateLoop')
	end,
	AnimateLoopCommand=function(self)
		self:rotationz(self.rotatepos)
		self:accelerate(self.rotatespeed)
		self:rotationz(self.rotatepos-180)
		self:sleep(0)
		self:decelerate(self.rotatespeed)
		self:rotationz(self.rotatepos-360)
		self:queuecommand('AnimateLoop')
	end,
}

t[#t+1] = LoadActor("./assets/goldstar (stretch).png")..{
	InitCommand=function(self)
		self:visible(false)
	end,
	OnCommand=function(self)
		self:draworder(100)
		if pss == nil or pss:GetTapNoteScores('TapNoteScore_Miss') > 0 or
				pss:GetTapNoteScores('TapNoteScore_W5') > 0 or
				pss:GetTapNoteScores('TapNoteScore_W4') > 0 or
				pss:GetTapNoteScores('TapNoteScore_W3') > 1 then
			-- Nothing special
			self:visible(false)
		elseif pss:GetTapNoteScores('TapNoteScore_W3') == 1 then
			-- Black flag
			self:visible(true)
			self:diffuse(Color.Black)
		elseif pss:GetTapNoteScores('TapNoteScore_W2') == 1 then
			-- Lol
			self:visible(true)
			self:diffuse(Color.Black)
			self:sleep(2)
			self:queuecommand('Animate')
		else
			-- Nothing worth taunting over
			self:visible(false)
		end
	end,
	AnimateCommand=function(self)
		self:diffuse(Color.White)
		self:wag()
		self:linear(3)
		self:zoom(5)
		self:queuecommand('Animate2')
	end,
	Animate2Command=function(self)
		self:linear(1)
		self:zoom(1.6)
		self:queuecommand('Animate3')
	end,
	Animate3Command=function(self)
		self:texcoordvelocity(1,0)
	end,
}

return t
