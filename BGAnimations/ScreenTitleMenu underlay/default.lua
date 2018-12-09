local TextColor = ThemePrefs.Get("RainbowMode") and Color.Black or Color.White

local SongStats = SONGMAN:GetNumSongs() .. " songs in "
SongStats = SongStats .. SONGMAN:GetNumSongGroups() .. " groups, "
SongStats = SongStats .. #SONGMAN:GetAllCourses(PREFSMAN:GetPreference("AutogenGroupCourses")) .. " courses"

-- - - - - - - - - - - - - - - - - - - - -

local game = GAMESTATE:GetCurrentGame():GetName();
if game ~= "dance" and game ~= "pump" then
	game = "techno"
end

-- - - - - - - - - - - - - - - - - - - - -
local sm_version = ""
local sl_version = GetThemeVersion()

if ProductVersion():find("git") then
	local date = VersionDate()
	local year = date:sub(1,4)
	local month = date:sub(5,6)
	if month:sub(1,1) == "0" then month = month:gsub("0", "") end
	month = THEME:GetString("Months", "Month"..month)
	local day = date:sub(7,8)

	sm_version = ProductID() .. ", Built " .. month .. " " .. day .. ", " .. year
else
	sm_version = ProductID() .. sm_version
end
-- - - - - - - - - - - - - - - - - - - - -
local image = ThemePrefs.Get("VisualTheme")

if image == "Spooky" then  --SSHHHH dont tell anyone ;)
	image = (math.random(1,100) > 11 and "Spooky" or "Spoopy")
end

local ddrillini_letters = { 'd_1', 'd_2', 'r', 'i_1', 'l_1', 'l_2', 'i_2', 'n', 'i_3' }

local af = Def.ActorFrame{
	InitCommand=function(self)
		--see: ./Scripts/SL_Initialize.lua
		InitializeSimplyLove()

		self:Center()
	end,
	OffCommand=cmd(linear,0.5; diffusealpha, 0),

	-- how many songs / courses
	-- Def.ActorFrame{
	-- 	InitCommand=function(self) self:zoom(0.8):y(-120):diffusealpha(0) end,
	-- 	OnCommand=function(self) self:sleep(0.2):linear(0.4):diffusealpha(1) end,

	-- 	Def.BitmapText{
	-- 		Font="_miso",
	-- 		Text=sm_version,
	-- 		InitCommand=function(self) self:y(-20):diffuse(TextColor) end,
	-- 	},
	-- 	Def.BitmapText{
	-- 		Font="_miso",
	-- 		Text=SongStats,
	-- 		InitCommand=function(self) self:diffuse(TextColor) end,
	-- 	}
	-- },

	-- the rainbow arrows
	-- LoadActor(THEME:GetPathG("", "_logos/" .. game))..{
	-- 	InitCommand=function(self)
	-- 		self:y(-16):zoom( game=="pump" and 0.2 or 0.205 )
	-- 	end
	-- },

	-- SIMPLY XXXXX where XXXXX = love, arrows, spooky, etc
	-- ScreenLogo underlay.lua also does this.
	-- LoadActor("Simply".. image .." (doubleres).png") .. {
	-- LoadActor("ddrillini/ddrillini.png") .. {
	-- 	InitCommand=function(self) self:x(2):zoom(0.7):shadowlength(0.75) end,
	-- 	OffCommand=function(self) self:linear(0.5):shadowlength(0) end
	-- },
}

for i=1,9 do
	af[#af+1] = Def.ActorFrame {
		LoadActor("ddrillini/" .. ddrillini_letters[i] .. ".png") .. {
	-- There appear to be two different syntaxes: `function(self)` and `cmd`.
			InitCommand=function(self)
				self
				-- positioning, sizing, shadow
				:x(2) :zoom(0.7) :shadowlength(0.75)
				-- fading in
				:diffusealpha(0)
			end,

			OnCommand=function(self)
				self
				-- delay each letter by a bit more each time
				:sleep(i*0.1 + 0.2)
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
end

-- the best way to spread holiday cheer is singing loud for all to hear
if PREFSMAN:GetPreference("EasterEggs") and MonthOfYear()==11 then
	af[#af+1] = Def.Sprite{
		Texture=THEME:GetPathB("ScreenTitleMenu", "underlay/hat.png"),
		InitCommand=function(self) self:zoom(0.225):xy( 130, -self:GetHeight()/2 ):rotationz(15):queuecommand("Drop") end,
		DropCommand=function(self) self:decelerate(1.333):y(-110) end,
	}
end

return af
