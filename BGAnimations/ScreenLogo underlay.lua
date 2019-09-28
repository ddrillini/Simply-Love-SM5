local image = ThemePrefs.Get("VisualTheme")
local game = GAMESTATE:GetCurrentGame():GetName()
if game ~= "dance" and game ~= "pump" then
	game = "techno"
end

local ddrillini_letters = { 'd_1', 'd_2', 'r', 'i_1', 'l_1', 'l_2', 'i_2', 'n', 'i_3' }

-- This file renders SIMPLY XXXX on the attract loop.
-- `ScreenTitleMenu underlay` renders SIMPLY XXXX when credits have been inserted.
local t = Def.ActorFrame{
	InitCommand=function(self)
		self:xy(_screen.cx, _screen.cy-16):zoom( game=="pump" and 0.2 or 0.205 ):cropright(1)
	end,
}

-- Draw DDRIllini letters
-- for i=1,9 do
	t[#t+1] = Def.ActorFrame {
		-- LoadActor("ScreenTitleMenu underlay/ddrillini/" .. ddrillini_letters[i] .. ".png") .. {
		LoadActor("ddrillini_logo_cut_up.mp4") .. {
			InitCommand=function(self)
				self
				-- positioning, sizing, shadow
				:Center() :y(0) :x(-60) -- ??
				:shadowlength(1)
				-- fading in
				:diffusealpha(0)
				:blend("add")
				:GetTexture("ddrillini.png")
			end,

			OnCommand=function(self)
				self
				-- delay each letter by a bit more each time
				-- :sleep(i*0.1 + 0.2)
				:linear(.75)
				:diffusealpha(1)
			end,

			OffCommand=function(self)
				self
				-- fading out
				:linear(0.5)
				:shadowlength(0)
			end,


		}
	}
-- end

return t
