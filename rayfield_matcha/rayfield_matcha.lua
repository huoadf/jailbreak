-- [[ Rayfield UI Library for Matcha LuaVM ]] --


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")

Rayfield = {}
local Library = Rayfield
_G.Rayfield = Rayfield

Library.Flags = {}

-- Theme Definitions (Ported directly from Rayfield)
Library.Theme = {
	Default = {
		TextColor = Color3.fromRGB(240, 240, 240),
		Background = Color3.fromRGB(25, 25, 25),
		Topbar = Color3.fromRGB(34, 34, 34),
		Shadow = Color3.fromRGB(20, 20, 20),
		NotificationBackground = Color3.fromRGB(20, 20, 20),
		NotificationActionsBackground = Color3.fromRGB(230, 230, 230),
		TabBackground = Color3.fromRGB(80, 80, 80),
		TabStroke = Color3.fromRGB(85, 85, 85),
		TabBackgroundSelected = Color3.fromRGB(210, 210, 210),
		TabTextColor = Color3.fromRGB(240, 240, 240),
		SelectedTabTextColor = Color3.fromRGB(50, 50, 50),
		ElementBackground = Color3.fromRGB(35, 35, 35),
		ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
		SecondaryElementBackground = Color3.fromRGB(25, 25, 25),
		ElementStroke = Color3.fromRGB(50, 50, 50),
		SecondaryElementStroke = Color3.fromRGB(40, 40, 40),
		SliderBackground = Color3.fromRGB(50, 138, 220),
		SliderProgress = Color3.fromRGB(50, 138, 220),
		SliderStroke = Color3.fromRGB(58, 163, 255),
		ToggleBackground = Color3.fromRGB(30, 30, 30),
		ToggleEnabled = Color3.fromRGB(0, 146, 214),
		ToggleDisabled = Color3.fromRGB(100, 100, 100),
		ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
		ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
		ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
		ToggleDisabledOuterStroke = Color3.fromRGB(65, 65, 65),
		DropdownSelected = Color3.fromRGB(40, 40, 40),
		DropdownUnselected = Color3.fromRGB(30, 30, 30),
		InputBackground = Color3.fromRGB(30, 30, 30),
		InputStroke = Color3.fromRGB(65, 65, 65),
		PlaceholderColor = Color3.fromRGB(178, 178, 178)
	},
	Ocean = {
		TextColor = Color3.fromRGB(230, 240, 240),
		Background = Color3.fromRGB(20, 30, 30),
		Topbar = Color3.fromRGB(25, 40, 40),
		Shadow = Color3.fromRGB(15, 20, 20),
		NotificationBackground = Color3.fromRGB(25, 35, 35),
		NotificationActionsBackground = Color3.fromRGB(230, 240, 240),
		TabBackground = Color3.fromRGB(40, 60, 60),
		TabStroke = Color3.fromRGB(50, 70, 70),
		TabBackgroundSelected = Color3.fromRGB(100, 180, 180),
		TabTextColor = Color3.fromRGB(210, 230, 230),
		SelectedTabTextColor = Color3.fromRGB(20, 50, 50),
		ElementBackground = Color3.fromRGB(30, 50, 50),
		ElementBackgroundHover = Color3.fromRGB(40, 60, 60),
		SecondaryElementBackground = Color3.fromRGB(30, 45, 45),
		ElementStroke = Color3.fromRGB(45, 70, 70),
		SecondaryElementStroke = Color3.fromRGB(40, 65, 65),
		SliderBackground = Color3.fromRGB(0, 110, 110),
		SliderProgress = Color3.fromRGB(0, 140, 140),
		SliderStroke = Color3.fromRGB(0, 160, 160),
		ToggleBackground = Color3.fromRGB(30, 50, 50),
		ToggleEnabled = Color3.fromRGB(0, 130, 130),
		ToggleDisabled = Color3.fromRGB(70, 90, 90),
		ToggleEnabledStroke = Color3.fromRGB(0, 160, 160),
		ToggleDisabledStroke = Color3.fromRGB(85, 105, 105),
		ToggleEnabledOuterStroke = Color3.fromRGB(50, 100, 100),
		ToggleDisabledOuterStroke = Color3.fromRGB(45, 65, 65),
		DropdownSelected = Color3.fromRGB(30, 60, 60),
		DropdownUnselected = Color3.fromRGB(25, 40, 40),
		InputBackground = Color3.fromRGB(30, 50, 50),
		InputStroke = Color3.fromRGB(50, 70, 70),
		PlaceholderColor = Color3.fromRGB(140, 160, 160)
	},
	AmberGlow = {
		TextColor = Color3.fromRGB(255, 245, 230),
		Background = Color3.fromRGB(45, 30, 20),
		Topbar = Color3.fromRGB(55, 40, 25),
		Shadow = Color3.fromRGB(35, 25, 15),
		NotificationBackground = Color3.fromRGB(50, 35, 25),
		NotificationActionsBackground = Color3.fromRGB(245, 230, 215),
		TabBackground = Color3.fromRGB(75, 50, 35),
		TabStroke = Color3.fromRGB(90, 60, 45),
		TabBackgroundSelected = Color3.fromRGB(230, 180, 100),
		TabTextColor = Color3.fromRGB(250, 220, 200),
		SelectedTabTextColor = Color3.fromRGB(50, 30, 10),
		ElementBackground = Color3.fromRGB(60, 45, 35),
		ElementBackgroundHover = Color3.fromRGB(70, 50, 40),
		SecondaryElementBackground = Color3.fromRGB(55, 40, 30),
		ElementStroke = Color3.fromRGB(85, 60, 45),
		SecondaryElementStroke = Color3.fromRGB(75, 50, 35),
		SliderBackground = Color3.fromRGB(220, 130, 60),
		SliderProgress = Color3.fromRGB(250, 150, 75),
		SliderStroke = Color3.fromRGB(255, 170, 85),
		ToggleBackground = Color3.fromRGB(55, 40, 30),
		ToggleEnabled = Color3.fromRGB(240, 130, 30),
		ToggleDisabled = Color3.fromRGB(90, 70, 60),
		ToggleEnabledStroke = Color3.fromRGB(255, 160, 50),
		ToggleDisabledStroke = Color3.fromRGB(110, 85, 75),
		ToggleEnabledOuterStroke = Color3.fromRGB(200, 100, 50),
		ToggleDisabledOuterStroke = Color3.fromRGB(75, 60, 55),
		DropdownSelected = Color3.fromRGB(70, 50, 40),
		DropdownUnselected = Color3.fromRGB(55, 40, 30),
		InputBackground = Color3.fromRGB(60, 45, 35),
		InputStroke = Color3.fromRGB(90, 65, 50),
		PlaceholderColor = Color3.fromRGB(190, 150, 130)
	},
	Light = {
		TextColor = Color3.fromRGB(40, 40, 40),
		Background = Color3.fromRGB(245, 245, 245),
		Topbar = Color3.fromRGB(230, 230, 230),
		Shadow = Color3.fromRGB(200, 200, 200),
		NotificationBackground = Color3.fromRGB(250, 250, 250),
		NotificationActionsBackground = Color3.fromRGB(240, 240, 240),
		TabBackground = Color3.fromRGB(235, 235, 235),
		TabStroke = Color3.fromRGB(215, 215, 215),
		TabBackgroundSelected = Color3.fromRGB(255, 255, 255),
		TabTextColor = Color3.fromRGB(80, 80, 80),
		SelectedTabTextColor = Color3.fromRGB(0, 0, 0),
		ElementBackground = Color3.fromRGB(240, 240, 240),
		ElementBackgroundHover = Color3.fromRGB(225, 225, 225),
		SecondaryElementBackground = Color3.fromRGB(235, 235, 235),
		ElementStroke = Color3.fromRGB(210, 210, 210),
		SecondaryElementStroke = Color3.fromRGB(210, 210, 210),
		SliderBackground = Color3.fromRGB(150, 180, 220),
		SliderProgress = Color3.fromRGB(100, 150, 200), 
		SliderStroke = Color3.fromRGB(120, 170, 220),
		ToggleBackground = Color3.fromRGB(220, 220, 220),
		ToggleEnabled = Color3.fromRGB(0, 146, 214),
		ToggleDisabled = Color3.fromRGB(150, 150, 150),
		ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
		ToggleDisabledStroke = Color3.fromRGB(170, 170, 170),
		ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
		ToggleDisabledOuterStroke = Color3.fromRGB(180, 180, 180),
		DropdownSelected = Color3.fromRGB(230, 230, 230),
		DropdownUnselected = Color3.fromRGB(220, 220, 220),
		InputBackground = Color3.fromRGB(240, 240, 240),
		InputStroke = Color3.fromRGB(180, 180, 180),
		PlaceholderColor = Color3.fromRGB(140, 140, 140)
	},
	Amethyst = {
		TextColor = Color3.fromRGB(240, 240, 240),
		Background = Color3.fromRGB(30, 20, 40),
		Topbar = Color3.fromRGB(40, 25, 50),
		Shadow = Color3.fromRGB(20, 15, 30),
		NotificationBackground = Color3.fromRGB(35, 20, 40),
		NotificationActionsBackground = Color3.fromRGB(240, 240, 250),
		TabBackground = Color3.fromRGB(60, 40, 80),
		TabStroke = Color3.fromRGB(70, 45, 90),
		TabBackgroundSelected = Color3.fromRGB(180, 140, 200),
		TabTextColor = Color3.fromRGB(230, 230, 240),
		SelectedTabTextColor = Color3.fromRGB(50, 20, 50),
		ElementBackground = Color3.fromRGB(45, 30, 60),
		ElementBackgroundHover = Color3.fromRGB(50, 35, 70),
		SecondaryElementBackground = Color3.fromRGB(40, 30, 55),
		ElementStroke = Color3.fromRGB(70, 50, 85),
		SecondaryElementStroke = Color3.fromRGB(65, 45, 80),
		SliderBackground = Color3.fromRGB(100, 60, 150),
		SliderProgress = Color3.fromRGB(130, 80, 180),
		SliderStroke = Color3.fromRGB(150, 100, 200),
		ToggleBackground = Color3.fromRGB(45, 30, 55),
		ToggleEnabled = Color3.fromRGB(120, 60, 150),
		ToggleDisabled = Color3.fromRGB(94, 47, 117),
		ToggleEnabledStroke = Color3.fromRGB(140, 80, 170),
		ToggleDisabledStroke = Color3.fromRGB(124, 71, 150),
		ToggleEnabledOuterStroke = Color3.fromRGB(90, 40, 120),
		ToggleDisabledOuterStroke = Color3.fromRGB(80, 50, 110),
		DropdownSelected = Color3.fromRGB(50, 35, 70),
		DropdownUnselected = Color3.fromRGB(35, 25, 50),
		InputBackground = Color3.fromRGB(45, 30, 60),
		InputStroke = Color3.fromRGB(80, 50, 110),
		PlaceholderColor = Color3.fromRGB(178, 150, 200)
	},
	Green = {
		TextColor = Color3.fromRGB(30, 60, 30),
		Background = Color3.fromRGB(235, 245, 235),
		Topbar = Color3.fromRGB(210, 230, 210),
		Shadow = Color3.fromRGB(200, 220, 200),
		NotificationBackground = Color3.fromRGB(240, 250, 240),
		NotificationActionsBackground = Color3.fromRGB(220, 235, 220),
		TabBackground = Color3.fromRGB(215, 235, 215),
		TabStroke = Color3.fromRGB(190, 210, 190),
		TabBackgroundSelected = Color3.fromRGB(245, 255, 245),
		TabTextColor = Color3.fromRGB(50, 80, 50),
		SelectedTabTextColor = Color3.fromRGB(20, 60, 20),
		ElementBackground = Color3.fromRGB(225, 240, 225),
		ElementBackgroundHover = Color3.fromRGB(210, 225, 210),
		SecondaryElementBackground = Color3.fromRGB(235, 245, 235), 
		ElementStroke = Color3.fromRGB(180, 200, 180),
		SecondaryElementStroke = Color3.fromRGB(180, 200, 180),
		SliderBackground = Color3.fromRGB(90, 160, 90),
		SliderProgress = Color3.fromRGB(70, 130, 70),
		SliderStroke = Color3.fromRGB(100, 180, 100),
		ToggleBackground = Color3.fromRGB(215, 235, 215),
		ToggleEnabled = Color3.fromRGB(60, 130, 60),
		ToggleDisabled = Color3.fromRGB(150, 175, 150),
		ToggleEnabledStroke = Color3.fromRGB(80, 150, 80),
		ToggleDisabledStroke = Color3.fromRGB(130, 150, 130),
		ToggleEnabledOuterStroke = Color3.fromRGB(100, 160, 100),
		ToggleDisabledOuterStroke = Color3.fromRGB(160, 180, 160),
		DropdownSelected = Color3.fromRGB(225, 240, 225),
		DropdownUnselected = Color3.fromRGB(210, 225, 210),
		InputBackground = Color3.fromRGB(235, 245, 235),
		InputStroke = Color3.fromRGB(180, 200, 180),
		PlaceholderColor = Color3.fromRGB(120, 140, 120)
	},
	Bloom = {
		TextColor = Color3.fromRGB(60, 40, 50),
		Background = Color3.fromRGB(255, 240, 245),
		Topbar = Color3.fromRGB(250, 220, 225),
		Shadow = Color3.fromRGB(230, 190, 195),
		NotificationBackground = Color3.fromRGB(255, 235, 240),
		NotificationActionsBackground = Color3.fromRGB(245, 215, 225),
		TabBackground = Color3.fromRGB(240, 210, 220),
		TabStroke = Color3.fromRGB(230, 200, 210),
		TabBackgroundSelected = Color3.fromRGB(255, 225, 235),
		TabTextColor = Color3.fromRGB(80, 40, 60),
		SelectedTabTextColor = Color3.fromRGB(50, 30, 50),
		ElementBackground = Color3.fromRGB(255, 235, 240),
		ElementBackgroundHover = Color3.fromRGB(245, 220, 230),
		SecondaryElementBackground = Color3.fromRGB(255, 235, 240), 
		ElementStroke = Color3.fromRGB(230, 200, 210),
		SecondaryElementStroke = Color3.fromRGB(230, 200, 210),
		SliderBackground = Color3.fromRGB(240, 130, 160),
		SliderProgress = Color3.fromRGB(250, 160, 180),
		SliderStroke = Color3.fromRGB(255, 180, 200),
		ToggleBackground = Color3.fromRGB(240, 210, 220),
		ToggleEnabled = Color3.fromRGB(255, 140, 170),
		ToggleDisabled = Color3.fromRGB(200, 180, 185),
		ToggleEnabledStroke = Color3.fromRGB(250, 160, 190),
		ToggleDisabledStroke = Color3.fromRGB(210, 180, 190),
		ToggleEnabledOuterStroke = Color3.fromRGB(220, 160, 180),
		ToggleDisabledOuterStroke = Color3.fromRGB(190, 170, 180),
		DropdownSelected = Color3.fromRGB(250, 220, 225),
		DropdownUnselected = Color3.fromRGB(240, 210, 220),
		InputBackground = Color3.fromRGB(255, 235, 240),
		InputStroke = Color3.fromRGB(220, 190, 200),
		PlaceholderColor = Color3.fromRGB(170, 130, 140)
	},
	DarkBlue = {
		TextColor = Color3.fromRGB(230, 230, 230),
		Background = Color3.fromRGB(20, 25, 30),
		Topbar = Color3.fromRGB(30, 35, 40),
		Shadow = Color3.fromRGB(15, 20, 25),
		NotificationBackground = Color3.fromRGB(25, 30, 35),
		NotificationActionsBackground = Color3.fromRGB(45, 50, 55),
		TabBackground = Color3.fromRGB(35, 40, 45),
		TabStroke = Color3.fromRGB(45, 50, 60),
		TabBackgroundSelected = Color3.fromRGB(40, 70, 100),
		TabTextColor = Color3.fromRGB(200, 200, 200),
		SelectedTabTextColor = Color3.fromRGB(255, 255, 255),
		ElementBackground = Color3.fromRGB(30, 35, 40),
		ElementBackgroundHover = Color3.fromRGB(40, 45, 50),
		SecondaryElementBackground = Color3.fromRGB(35, 40, 45), 
		ElementStroke = Color3.fromRGB(45, 50, 60),
		SecondaryElementStroke = Color3.fromRGB(40, 45, 55),
		SliderBackground = Color3.fromRGB(0, 90, 180),
		SliderProgress = Color3.fromRGB(0, 120, 210),
		SliderStroke = Color3.fromRGB(0, 150, 240),
		ToggleBackground = Color3.fromRGB(35, 40, 45),
		ToggleEnabled = Color3.fromRGB(0, 120, 210),
		ToggleDisabled = Color3.fromRGB(70, 70, 80),
		ToggleEnabledStroke = Color3.fromRGB(0, 150, 240),
		ToggleDisabledStroke = Color3.fromRGB(75, 75, 85),
		ToggleEnabledOuterStroke = Color3.fromRGB(20, 100, 180), 
		ToggleDisabledOuterStroke = Color3.fromRGB(55, 55, 65),
		DropdownSelected = Color3.fromRGB(30, 70, 90),
		DropdownUnselected = Color3.fromRGB(25, 30, 35),
		InputBackground = Color3.fromRGB(25, 30, 35),
		InputStroke = Color3.fromRGB(45, 50, 60), 
		PlaceholderColor = Color3.fromRGB(150, 150, 160)
	},
	Serenity = {
		TextColor = Color3.fromRGB(50, 55, 60),
		Background = Color3.fromRGB(240, 245, 250),
		Topbar = Color3.fromRGB(215, 225, 235),
		Shadow = Color3.fromRGB(200, 210, 220),
		NotificationBackground = Color3.fromRGB(210, 220, 230),
		NotificationActionsBackground = Color3.fromRGB(225, 230, 240),
		TabBackground = Color3.fromRGB(200, 210, 220),
		TabStroke = Color3.fromRGB(180, 190, 200),
		TabBackgroundSelected = Color3.fromRGB(175, 185, 200),
		TabTextColor = Color3.fromRGB(50, 55, 60),
		SelectedTabTextColor = Color3.fromRGB(30, 35, 40),
		ElementBackground = Color3.fromRGB(210, 220, 230),
		ElementBackgroundHover = Color3.fromRGB(220, 230, 240),
		SecondaryElementBackground = Color3.fromRGB(200, 210, 220),
		ElementStroke = Color3.fromRGB(190, 200, 210),
		SecondaryElementStroke = Color3.fromRGB(180, 190, 200),
		SliderBackground = Color3.fromRGB(200, 220, 235),
		SliderProgress = Color3.fromRGB(70, 130, 180),
		SliderStroke = Color3.fromRGB(150, 180, 220),
		ToggleBackground = Color3.fromRGB(210, 220, 230),
		ToggleEnabled = Color3.fromRGB(70, 160, 210),
		ToggleDisabled = Color3.fromRGB(180, 180, 180),
		ToggleEnabledStroke = Color3.fromRGB(60, 150, 200),
		ToggleDisabledStroke = Color3.fromRGB(140, 140, 140),
		ToggleEnabledOuterStroke = Color3.fromRGB(100, 120, 140),
		ToggleDisabledOuterStroke = Color3.fromRGB(120, 120, 130),
		DropdownSelected = Color3.fromRGB(220, 230, 240),
		DropdownUnselected = Color3.fromRGB(200, 210, 220),
		InputBackground = Color3.fromRGB(220, 230, 240),
		InputStroke = Color3.fromRGB(180, 190, 200),
		PlaceholderColor = Color3.fromRGB(150, 150, 150)
	}
}

local Theme = Library.Theme.Default

-- Configuration Settings
local CFileName = nil
local CEnabled = false
local ConfigurationFolder = "Rayfield"
local ConfigurationExtension = ".json"
local globalLoaded = false

-- Spring System (for smooth interpolation)
local function newSpring(v, speed)
	return { v = v, goal = v, speed = speed or 16 }
end

local function springStep(s, dt)
	s.v = s.v + (s.goal - s.v) * (1 - math.exp(-s.speed * dt))
	return s.v
end

local function lerp(a, b, t)
	return a + (b - a) * t
end

local function lerpColor(a, b, t)
	return Color3.new(lerp(a.R, b.R, t), lerp(a.G, b.G, t), lerp(a.B, b.B, t))
end

-- Key Mapping Helpers
local KeyName = {
	[0x41]="A",[0x42]="B",[0x43]="C",[0x44]="D",[0x45]="E",[0x46]="F",[0x47]="G",[0x48]="H",[0x49]="I",[0x4A]="J",
	[0x4B]="K",[0x4C]="L",[0x4D]="M",[0x4E]="N",[0x4F]="O",[0x50]="P",[0x51]="Q",[0x52]="R",[0x53]="S",[0x54]="T",
	[0x55]="U",[0x56]="V",[0x57]="W",[0x58]="X",[0x59]="Y",[0x5A]="Z",
	[0x30]="0",[0x31]="1",[0x32]="2",[0x33]="3",[0x34]="4",[0x35]="5",[0x36]="6",[0x37]="7",[0x38]="8",[0x39]="9",
	[0x70]="F1",[0x71]="F2",[0x72]="F3",[0x73]="F4",[0x74]="F5",[0x75]="F6",[0x76]="F7",[0x77]="F8",[0x78]="F9",[0x79]="F10",[0x7A]="F11",[0x7B]="F12",
	[0x10]="Shift",[0x11]="Ctrl",[0x12]="Alt",[0x20]="Space",[0x09]="Tab",[0x1B]="Esc",
	[0x23]="End",[0x24]="Home",[0x2D]="Insert",[0x2E]="Delete",
	[0x25]="Left",[0x26]="Up",[0x27]="Right",[0x28]="Down",
	[0x01]="MB1",[0x02]="MB2",[0x05]="Mouse4",[0x06]="Mouse5",
}

local KeyAlias = {
	LeftControl = 0x11, RightControl = 0x11, Control = 0x11, Ctrl = 0x11,
	LeftShift = 0x10, RightShift = 0x10, Shift = 0x10,
	LeftAlt = 0x12, RightAlt = 0x12, Alt = 0x12,
	MB1 = 0x01, MB2 = 0x02, Mouse1 = 0x01, Mouse2 = 0x02,
	Return = 0x0D, Enter = 0x0D, Escape = 0x1B, Backspace = 0x08, Spacebar = 0x20,
}

local function resolveKey(v)
	if not v then return nil, "None" end
	if type(v) == "userdata" or type(v) == "table" then
		pcall(function() v = v.Name or tostring(v) end)
	end
	if type(v) == "number" then return v, KeyName[v] or tostring(v) end
	if type(v) == "string" or type(v) == "userdata" then
		v = tostring(v)
		local up = v:upper()
		if KeyAlias[v] then return KeyAlias[v], KeyName[KeyAlias[v]] or v end
		for vk, name in pairs(KeyName) do if name:upper() == up then return vk, name end end
	end
	return nil, "None"
end

local ScanList = {}
for vk in pairs(KeyName) do ScanList[#ScanList + 1] = vk end

local CharMap = {}
for vk = 0x41, 0x5A do CharMap[vk] = { string.char(vk + 32), string.char(vk) } end
do
	local d = { [0x30]={"0",")"},[0x31]={"1","!"},[0x32]={"2","@"},[0x33]={"3","#"},[0x34]={"4","$"},
				[0x35]={"5","%"},[0x36]={"6","^"},[0x37]={"7","&"},[0x38]={"8","*"},[0x39]={"9","("} }
	for vk, m in pairs(d) do CharMap[vk] = m end
	CharMap[0x20]={" "," "}; CharMap[0xBA]={";",":"}; CharMap[0xBB]={"=","+"}; CharMap[0xBC]={",","<"}
	CharMap[0xBD]={"-","_"}; CharMap[0xBE]={".",">"}; CharMap[0xBF]={"/","?"}; CharMap[0xC0]={"`","~"}
	CharMap[0xDB]={"[","{"}; CharMap[0xDC]={"\\","|"}; CharMap[0xDD]={"]","}"}; CharMap[0xDE]={"'","\""}
end
local CharScanList = {}
for vk in pairs(CharMap) do CharScanList[#CharScanList + 1] = vk end

-- Drawing Object Cache (IMGUI pattern on top of retained Drawing instances)
local Cache = {}
local Visible = {}
local CurTick = 0

local function eq(a, b)
	if a == b then return true end
	local ta = typeof(a)
	if ta ~= typeof(b) then return false end
	if ta == "Color3" then return a.R == b.R and a.G == b.G and a.B == b.B end
	if ta == "Vector2" then return a.X == b.X and a.Y == b.Y end
	return false
end

local function Draw(id, dtype, props)
	local c = Cache[id]
	if not c then
		local obj
		local ok = pcall(function()
			obj = Drawing.new(dtype)
		end)
		if not ok or not obj then
			obj = setmetatable({}, {
				__newindex = function() end,
				__index = function() return function() end end
			})
		end
		c = { Obj = obj, P = {} }
		Cache[id] = c
	end
	local obj, P = c.Obj, c.P
	local vis = props.Visible
	if vis == nil then vis = true end
	if P.Visible ~= vis then 
		pcall(function() obj.Visible = vis end)
		P.Visible = vis 
	end
	if vis then
		for k, v in pairs(props) do
			if k ~= "Visible" and not eq(P[k], v) then
				pcall(function() obj[k] = v end)
				P[k] = v
			end
		end
		Visible[id] = true
	else
		Visible[id] = nil
	end
	c.Tick = CurTick
	return obj
end

local function cleanupDrawings()
	for id in pairs(Visible) do
		local c = Cache[id]
		if c and c.Tick ~= CurTick and c.P.Visible then
			pcall(function() c.Obj.Visible = false end)
			c.P.Visible = false
			Visible[id] = nil
		end
	end
end

-- Render Helper Functions
local function rect(id, x, y, w, h, color, op, z, corner)
	Draw(id, "Square", { Filled = true, Color = color, Transparency = op or 1, ZIndex = z or 1,
		Position = Vector2.new(x, y), Size = Vector2.new(w, h), Corner = corner or 0 })
end

local function outline(id, x, y, w, h, color, op, z, corner)
	Draw(id, "Square", { Filled = false, Color = color, Transparency = op or 1, ZIndex = z or 1,
		Position = Vector2.new(x, y), Size = Vector2.new(w, h), Corner = corner or 0 })
end

local function text(id, str, x, y, size, color, z, center, op, hasOutline)
	if hasOutline == nil then hasOutline = true end
	Draw(id, "Text", { Text = str, Size = size, Font = 1, Color = color, Center = center or false,
		Transparency = op or 1, ZIndex = z or 1, Position = Vector2.new(x, y), Outline = hasOutline })
end

local function circle(id, cx, cy, r, color, op, z)
	Draw(id, "Circle", { Filled = true, Color = color, Transparency = op or 1, ZIndex = z or 1,
		Position = Vector2.new(cx, cy), Radius = r, NumSides = 32 })
end

local function line(id, x1, y1, x2, y2, color, op, z)
	Draw(id, "Line", { Color = color, Transparency = op or 1, ZIndex = z or 1,
		From = Vector2.new(x1, y1), To = Vector2.new(x2, y2), Thickness = 1 })
end

local function image(id, data, x, y, w, h, op, z, rounding)
	Draw(id, "Image", { Data = data, Size = Vector2.new(w, h), Position = Vector2.new(x, y),
		Transparency = op or 1, ZIndex = z or 1, Rounding = rounding or 0 })
end

local function textW(str, size)
	return #tostring(str) * size * 0.52
end

local function safeIsKeyPressed(vk)
	if not vk or vk <= 0 or vk > 255 then return false end
	local pressed = false
	pcall(function()
		if iskeypressed then
			pressed = iskeypressed(vk)
		end
	end)
	return pressed
end

local function safeIsMouse1Pressed()
	local pressed = false
	pcall(function()
		if ismouse1pressed then
			pressed = ismouse1pressed()
		end
	end)
	return pressed
end

-- Input Manager
local Input = { mx = 0, my = 0, down = false, prevDown = false, clicked = false, keys = {} }

local function inBounds(x, y, w, h)
	return Input.mx >= x and Input.mx <= x + w and Input.my >= y and Input.my <= y + h
end

local function pollInput()
	Input.mx, Input.my = Mouse.X, Mouse.Y
	Input.down = safeIsMouse1Pressed()
	Input.clicked = Input.down and not Input.prevDown
end

-- Key State Polling
local function keyEdge(vk)
	if not vk or vk <= 0 or vk > 255 then return false end
	local k = Input.keys[vk]
	if not k then k = { held = false }; Input.keys[vk] = k end
	local p = safeIsKeyPressed(vk)
	local click = p and not k.held
	k.held = p
	return click
end

-- Global Window and Library States
local State = {
	Win = { x = 100, y = 100, w = 560, h = 400 },
	Drag = false, DragOff = Vector2.new(0, 0),
	ActiveTab = 1,
	ToggleKey = 0x23, -- End Key (VK_END)
	Minimized = false,
	Overlay = nil,
	Dialog = nil,
	KBListening = nil,
	Focused = nil,
	Vw = 1920, Vh = 1080,
	LastTime = nil,
	Running = false, Token = nil,
	Loaded = false,
	Unloaded = false,
}

local Tabs = {}
local Notifs = {}
local NotifId = 0
local AllKeybinds = {}

-- Loader / Splash Screen
local Loader = {
	Active = false,
	Born = 0,
	Title = "Rayfield",
	Subtitle = "Interface Suite",
	Progress = newSpring(0, 4),
	Alpha = newSpring(1, 8),
}

-- Center Window relative to Viewport
local function centerWindow()
	pcall(function()
		local vp = workspace.CurrentCamera.ViewportSize
		State.Win.x = math.floor((vp.X - State.Win.w) / 2)
		State.Win.y = math.floor((vp.Y - State.Win.h) / 2)
	end)
end

local function getViewportSize()
	local vw, vh = 1920, 1080
	pcall(function()
		local v = workspace.CurrentCamera.ViewportSize
		vw, vh = v.X, v.Y
	end)
	return vw, vh
end

local function safe(fn, ...)
	if type(fn) ~= "function" then return end
	local ok, err = pcall(fn, ...)
	if not ok then
		warn("[Rayfield] callback error: " .. tostring(err))
	end
end

-- Visibility toggle API (for external callers like powerplant_solver)
function Library:SetVisibility(visible)
	State.Minimized = not visible
	if visible then
		-- Clear overlay/dialog when showing
		State.Overlay = nil
	end
end

function Library:IsVisible()
	return not State.Minimized
end

function Library:ToggleVisibility()
	State.Minimized = not State.Minimized
	if not State.Minimized then
		State.Overlay = nil
	end
end

function Library:SetToggleKey(vkCode)
	if type(vkCode) == "number" then
		State.ToggleKey = vkCode
	end
end

-- Notification Manager
function Library:Notify(cfg)
	cfg = cfg or {}
	NotifId = NotifId + 1
	local lines = {}
	for ln in (tostring(cfg.Content or "") .. "\n"):gmatch("(.-)\n") do
		table.insert(lines, ln)
	end
	if #lines > 0 and lines[#lines] == "" then table.remove(lines) end
	
	local n = {
		id = NotifId,
		title = cfg.Title or "Notification",
		lines = lines,
		duration = cfg.Duration or 5,
		born = tick(),
		slide = newSpring(1, 10),
		alpha = newSpring(0, 10),
		dying = false,
	}
	n.slide.goal = 0
	n.alpha.goal = 1
	table.insert(Notifs, n)
	return n
end

-- Save/Load Configuration System
local function PackColor(color)
	return { R = math.floor(color.R * 255), G = math.floor(color.G * 255), B = math.floor(color.B * 255) }
end

local function UnpackColor(tbl)
	if not tbl then return Color3.fromRGB(255, 255, 255) end
	return Color3.fromRGB(tbl.R or 255, tbl.G or 255, tbl.B or 255)
end

local function SaveConfiguration()
	if not CEnabled or not globalLoaded then return end
	local Data = {}
	for flag, el in pairs(Library.Flags) do
		if el.kind == "colorpicker" then
			Data[flag] = PackColor(el.value)
		else
			Data[flag] = el.value
		end
	end
	
	pcall(function()
		local path = ConfigurationFolder .. "/" .. (Library.ConfigFileName or CFileName) .. ConfigurationExtension
		writefile(path, HttpService:JSONEncode(Data))
	end)
end

function Library:SaveConfiguration()
	SaveConfiguration()
end

local function LoadConfiguration(jsonStr)
	local success, Data = pcall(function() return HttpService:JSONDecode(jsonStr) end)
	if not success or type(Data) ~= "table" then return false end
	
	for flag, val in pairs(Data) do
		local el = Library.Flags[flag]
		if el then
			if el.kind == "colorpicker" then
				el:SetValue(UnpackColor(val))
			else
				el:SetValue(val)
			end
		end
	end
	return true
end

function Library:LoadConfiguration()
	if not CEnabled then return end
	pcall(function()
		local path = ConfigurationFolder .. "/" .. (Library.ConfigFileName or CFileName) .. ConfigurationExtension
		if isfile(path) then
			local content = readfile(path)
			if content and content ~= "" then
				local loaded = LoadConfiguration(content)
				if loaded then
					Library:Notify({ Title = "Configurations", Content = "Configuration loaded successfully.", Duration = 4 })
				end
			end
		end
	end)
	globalLoaded = true
end

-- Window dragging logic
local function handleDragging()
	local win = State.Win
	local topBarH = 40
	local hovered = inBounds(win.x, win.y, win.w, topBarH)
	
	if Input.down then
		if not State.Drag and hovered then
			State.Drag = true
			State.DragOff = Vector2.new(Input.mx - win.x, Input.my - win.y)
		end
		if State.Drag then
			win.x = math.floor(Input.mx - State.DragOff.X)
			win.y = math.floor(Input.my - State.DragOff.Y)
		end
	else
		State.Drag = false
	end
end

-- Dynamic height calculated per element
local function cardHeight(el)
	if el.kind == "section" then return 22 end
	if el.kind == "divider" then return 6 end
	if el.kind == "label" then return 28 end
	if el.kind == "paragraph" then return 24 + 18 + #el.lines * 15 end
	if el.kind == "slider" then return 48 end
	return 38
end

-- Render elements inside the active tab
local function processEl(el, idp, x, y, w, h, dt, z, block)
	local hovered = inBounds(x, y, w, h) and not State.Drag and not block
	local interactive = (el.kind ~= "section" and el.kind ~= "divider" and el.kind ~= "label" and el.kind ~= "paragraph")
	
	if interactive then
		el.hover.goal = hovered and 1 or 0
		springStep(el.hover, dt)
		rect(idp .. ".bg", x, y, w, h, Theme.ElementBackground, lerp(0.98, 1, el.hover.v), z, 6)
		outline(idp .. ".bd", x, y, w, h, hovered and Theme.TabBackground or Theme.ElementStroke, 0.4, z + 1, 6)
	end
	
	-- 1. Section widget
	if el.kind == "section" then
		text(idp .. ".t", el.title:upper(), x + 10, y + 4, 11, Theme.TextColor, z + 2)
		
	-- 2. Divider widget
	elseif el.kind == "divider" then
		line(idp .. ".l", x + 10, y + 3, x + w - 10, y + 3, Theme.SecondaryElementStroke, 0.4, z + 2)
		
	-- 3. Label widget
	elseif el.kind == "label" then
		text(idp .. ".t", el.title, x + 10, y + 6, 12, el.color or Theme.TextColor, z + 2)
		
	-- 4. Paragraph widget
	elseif el.kind == "paragraph" then
		rect(idp .. ".bg", x, y, w, h, Theme.SecondaryElementBackground, 0.98, z, 6)
		outline(idp .. ".bd", x, y, w, h, Theme.SecondaryElementStroke, 0.4, z + 1, 6)
		text(idp .. ".t", el.title, x + 14, y + 10, 13, Theme.TextColor, z + 2)
		local ly = y + 28
		for i, ln in ipairs(el.lines) do
			text(idp .. ".l" .. i, ln, x + 14, ly, 12, Color3.fromRGB(180, 180, 180), z + 2)
			ly = ly + 15
		end
		
	-- 5. Button widget
	elseif el.kind == "button" then
		text(idp .. ".t", el.title, x + 14, y + 11, 13, Theme.TextColor, z + 2)
		local btnX = x + w - 28
		local btnY = y + 11
		text(idp .. ".ic", ">", btnX, btnY, 13, Theme.TextColor, z + 3)
		if hovered and Input.clicked then
			safe(el.callback)
		end
		
	-- 6. Toggle widget
	elseif el.kind == "toggle" then
		text(idp .. ".t", el.title, x + 14, y + 11, 13, Theme.TextColor, z + 2)
		local pillW, pillH = 34, 18
		local px = x + w - 12 - pillW
		local py = y + math.floor((h - pillH) / 2)
		
		if hovered and Input.clicked then
			el.value = not el.value
			el.anim.goal = el.value and 1 or 0
			safe(el.callback, el.value)
			SaveConfiguration()
		end
		
		springStep(el.anim, dt)
		local t = el.anim.v
		rect(idp .. ".pill", px, py, pillW, pillH, lerpColor(Theme.ToggleBackground, Theme.ToggleEnabled, t), 0.98, z + 2, 9)
		outline(idp .. ".pilb", px, py, pillW, pillH, lerpColor(Theme.ToggleDisabledOuterStroke, Theme.ToggleEnabledStroke, t), 0.5, z + 3, 9)
		circle(idp .. ".knob", px + lerp(9, 25, t), py + pillH / 2, 6, Color3.fromRGB(240, 240, 240), 1, z + 4)
		
	-- 7. Slider widget
	elseif el.kind == "slider" then
		local tx, tw = x + 14, w - 28
		local ty = y + 34
		local editing = (State.Focused and State.Focused.owner == el)
		local vs = tostring(el.value) .. (el.suffix and (" " .. el.suffix) or "")
		
		text(idp .. ".t", el.title, x + 14, y + 8, 13, Theme.TextColor, z + 2)
		
		local vwid = textW(vs, 12)
		local vx = x + w - 14 - vwid
		local vHover = not block and inBounds(vx - 4, y + 6, vwid + 8, 16)
		
		text(idp .. ".v", vs, vx, y + 8, 12, editing and Theme.SliderStroke or Theme.TextColor, z + 2)
		
		if not editing and Input.down and not block and (el.dragging or (Input.clicked and not vHover and inBounds(tx - 4, ty - 6, tw + 8, 12))) then
			el.dragging = true
			local f = clamp((Input.mx - tx) / tw, 0, 1)
			local raw = el.min + f * (el.max - el.min)
			local stepSize = el.increment or 1
			local v = clamp(math.floor(raw / stepSize + 0.5) * stepSize, el.min, el.max)
			if v ~= el.value then
				el.value = v
				el.frac.goal = (el.value - el.min) / math.max(1e-6, el.max - el.min)
				safe(el.callback, v)
				SaveConfiguration()
			end
		elseif not Input.down then
			el.dragging = false
		end
		
		if not editing and vHover and Input.clicked then
			State.KBListening = nil; State.Overlay = nil; el.dragging = false
			State.Focused = { owner = el, buf = tostring(el.value), numeric = true,
				onCommit = function(buf)
					local n = tonumber(buf)
					if n then
						el:SetValue(n)
					end
				end
			}
		end
		
		springStep(el.frac, dt)
		local f = clamp(el.frac.v, 0, 1)
		rect(idp .. ".trk", tx, ty, tw, 4, Theme.SecondaryElementBackground, 0.4, z + 2, 2)
		rect(idp .. ".fil", tx, ty, math.max(0, tw * f), 4, Theme.SliderProgress, 1, z + 3, 2)
		circle(idp .. ".knb", tx + tw * f, ty + 2, 5, Theme.TextColor, 1, z + 4)
		
	-- 8. Input widget
	elseif el.kind == "input" then
		text(idp .. ".t", el.title, x + 14, y + 11, 13, Theme.TextColor, z + 2)
		local boxH = 24
		local boxW = math.min(140, math.floor(w * 0.4))
		local bx = x + w - 12 - boxW
		local by = y + math.floor((h - boxH) / 2)
		local focused = (State.Focused and State.Focused.owner == el)
		local bHover = not block and inBounds(bx, by, boxW, boxH)
		
		rect(idp .. ".ib", bx, by, boxW, boxH, Theme.InputBackground, 0.98, z + 2, 5)
		outline(idp .. ".ibd", bx, by, boxW, boxH, focused and Theme.SliderStroke or Theme.InputStroke, 0.5, z + 3, 5)
		
		local raw = focused and State.Focused.buf or el.value or ""
		local caret = (focused and math.floor(tick() * 2) % 2 == 0) and "|" or ""
		local shown = (raw ~= "" and (raw .. caret)) or (caret ~= "" and caret) or (el.placeholder or "")
		
		text(idp .. ".it", shown, bx + 8, by + 5, 12, raw ~= "" and Theme.TextColor or Color3.fromRGB(150, 150, 150), z + 3)
		
		if bHover and Input.clicked then
			State.KBListening = nil; State.Overlay = nil
			State.Focused = { owner = el, buf = el.value, numeric = false,
				onType = function(buf)
					el.value = buf
					safe(el.callback, buf)
					SaveConfiguration()
				end,
				onCommit = function(buf)
					el.value = buf
					safe(el.callback, buf)
					SaveConfiguration()
					if el.clearOnFocusLost then el.value = "" end
				end
			}
		end
		
	-- 9. Dropdown widget
	elseif el.kind == "dropdown" then
		text(idp .. ".t", el.title, x + 14, y + 11, 13, Theme.TextColor, z + 2)
		local boxH = 24
		local boxW = math.min(140, math.floor(w * 0.4))
		local bx = x + w - 12 - boxW
		local by = y + math.floor((h - boxH) / 2)
		local bHover = not block and inBounds(bx, by, boxW, boxH)
		
		rect(idp .. ".db", bx, by, boxW, boxH, Theme.DropdownUnselected, 0.98, z + 2, 5)
		outline(idp .. ".dbd", bx, by, boxW, boxH, Theme.ElementStroke, 0.5, z + 3, 5)
		
		local dispStr = el.value
		if el.multi then
			local count = 0
			for _ in pairs(el.selectedMap) do count = count + 1 end
			dispStr = count .. " items"
		end
		
		text(idp .. ".dt", dispStr, bx + 8, by + 5, 12, Theme.TextColor, z + 3)
		text(idp .. ".dc", "v", bx + boxW - 14, by + 5, 11, Color3.fromRGB(150, 150, 150), z + 3)
		
		if bHover and Input.clicked then
			State.Overlay = { kind = "dropdown", el = el, x = bx, y = by + boxH + 4, w = boxW, openedFrame = CurTick }
		end
		
	-- 10. Keybind widget
	elseif el.kind == "keybind" then
		text(idp .. ".t", el.title, x + 14, y + 11, 13, Theme.TextColor, z + 2)
		local boxH, boxW = 24, 76
		local bx = x + w - 12 - boxW
		local by = y + math.floor((h - boxH) / 2)
		local listening = (State.KBListening == el)
		local bHover = not block and inBounds(bx, by, boxW, boxH)
		
		rect(idp .. ".kb", bx, by, boxW, boxH, Theme.InputBackground, 0.98, z + 2, 5)
		outline(idp .. ".kbd", bx, by, boxW, boxH, listening and Theme.SliderStroke or Theme.InputStroke, 0.5, z + 3, 5)
		
		local keyStr = listening and "..." or ("[" .. el.value .. "]")
		text(idp .. ".kt", keyStr, bx + boxW / 2, by + boxH / 2, 12, listening and Theme.SliderStroke or Theme.TextColor, z + 3, true)
		
		if bHover and Input.clicked then
			State.KBListening = el
		end
		
	-- 11. Colorpicker widget
	elseif el.kind == "colorpicker" then
		text(idp .. ".t", el.title, x + 14, y + 11, 13, Theme.TextColor, z + 2)
		local sw, swh = 30, 20
		local bx = x + w - 12 - sw
		local by = y + math.floor((h - swh) / 2)
		local bHover = not block and inBounds(bx, by, sw, swh)
		
		rect(idp .. ".cw", bx, by, sw, swh, el.value, 1, z + 2, 5)
		outline(idp .. ".cwd", bx, by, sw, swh, Theme.ElementStroke, 0.5, z + 3, 5)
		
		if bHover and Input.clicked then
			State.Overlay = { kind = "colorpicker", el = el, ax = bx + sw, ay = by + swh + 4,
				origH = el.h, origS = el.s, origV = el.v, openedFrame = CurTick }
		end
	end
end

-- Render active dropdowns and colorpickers overlays
local function renderOverlay(dt)
	local ov = State.Overlay
	if not ov then return false end
	local Z = 10000
	
	if ov.kind == "dropdown" then
		local el = ov.el
		local opts = el.options
		local rowH = 26
		local pad = 4
		local visN = math.min(#opts, 6)
		local needBar = #opts > visN
		local barW = needBar and 6 or 0
		local listH = visN * rowH
		
		-- Dynamically calculate the maximum width based on option texts to prevent text overflow
		local maxOptW = ov.w
		for _, opt in ipairs(opts) do
			local ow = textW(tostring(opt), 12) + 24
			if ow > maxOptW then
				maxOptW = ow
			end
		end
		local panelW = maxOptW
		local panelH = pad * 2 + listH
		
		-- Align to the right edge of the dropdown box if the options panel is wider
		local panelX = ov.x
		if panelW > ov.w then
			panelX = (ov.x + ov.w) - panelW
		end
		
		local maxScroll = math.max(0, #opts - visN)
		el.scroll = clamp(el.scroll or 0, 0, maxScroll)
		
		ov.anim = ov.anim or newSpring(0, 24)
		ov.anim.goal = ov.closing and 0 or 1
		local a = springStep(ov.anim, dt)
		
		if ov.closing and a < 0.04 then
			State.Overlay = nil
			return true
		end
		
		rect("ov.bg", panelX, ov.y, panelW, panelH, Theme.Topbar, a * 0.98, Z, 5)
		outline("ov.bd", panelX, ov.y, panelW, panelH, Theme.ElementStroke, a * 0.5, Z + 1, 5)
		
		local listTop = ov.y + pad
		for i = 1, visN do
			local opt = opts[i + el.scroll]
			if opt then
				local ry = listTop + (i - 1) * rowH
				local rHover = inBounds(panelX, ry, panelW - barW, rowH) and not ov.closing
				local selected = el.multi and el.selectedMap[opt] or (not el.multi and el.value == opt)
				
				if selected then
					rect("ov.r" .. i, panelX + 2, ry, panelW - 4 - barW, rowH - 2, Theme.DropdownSelected, a, Z + 2, 4)
				elseif rHover then
					rect("ov.r" .. i, panelX + 2, ry, panelW - 4 - barW, rowH - 2, Theme.ElementBackgroundHover, a * 0.3, Z + 2, 4)
				end
				
				text("ov.t" .. i, tostring(opt), panelX + 10, ry + 6, 12, selected and Theme.SliderStroke or Theme.TextColor, Z + 3, false, a)
				
				if rHover and Input.clicked then
					if el.multi then
						el.selectedMap[opt] = not el.selectedMap[opt] or nil
						safe(el.callback, el.selectedMap)
						SaveConfiguration()
					else
						el.value = opt
						safe(el.callback, opt)
						SaveConfiguration()
						ov.closing = true
					end
				end
			end
		end
		
		if needBar then
			local trackX = panelX + panelW - barW
			local thumbH = math.max(16, listH * visN / #opts)
			local thumbY = listTop + (el.scroll / maxScroll) * (listH - thumbH)
			rect("ov.sbtk", trackX, listTop, barW, listH, Theme.Background, a * 0.5, Z + 2, 2)
			rect("ov.sbth", trackX, thumbY, barW, thumbH, Theme.SliderProgress, a, Z + 3, 2)
			
			if Input.down and (ov.dragBar or (Input.clicked and inBounds(trackX, listTop, barW, listH))) then
				ov.dragBar = true
				local f = clamp((Input.my - listTop - thumbH/2) / (listH - thumbH), 0, 1)
				el.scroll = math.floor(f * maxScroll + 0.5)
			elseif not Input.down then
				ov.dragBar = false
			end
		end
		
		if Input.clicked and not ov.closing and ov.openedFrame ~= CurTick and not inBounds(panelX, ov.y, panelW, panelH) then
			ov.closing = true
		end
		return true
		
	elseif ov.kind == "colorpicker" then
		local el = ov.el
		local pad, sv = 8, 100
		local hueW = 12
		local panelW = pad * 3 + sv + hueW
		local panelH = pad * 3 + sv + 22
		
		local px = clamp(ov.ax - panelW, State.Win.x + 4, State.Win.x + State.Win.w - panelW - 4)
		local py = clamp(ov.ay, State.Win.y + 40, State.Win.y + State.Win.h - panelH - 4)
		
		local svx, svy = px + pad, py + pad
		local hx = svx + sv + pad
		local btnY = svy + sv + pad
		
		rect("ov.bg", px, py, panelW, panelH, Theme.Topbar, 0.98, Z, 6)
		outline("ov.bd", px, py, panelW, panelH, Theme.ElementStroke, 0.5, Z + 1, 6)
		
		if Input.down then
			if Input.clicked and inBounds(svx, svy, sv, sv) then ov.drag = "sv"
			elseif Input.clicked and inBounds(hx, svy, hueW, sv) then ov.drag = "hue" end
		else
			ov.drag = nil
		end
		
		if ov.drag == "sv" then
			el.s = clamp((Input.mx - svx) / sv, 0, 1)
			el.v = 1 - clamp((Input.my - svy) / sv, 0, 1)
		elseif ov.drag == "hue" then
			el.h = 1 - clamp((Input.my - svy) / sv, 0, 1)
		end
		
		if ov.drag then
			el.value = Color3.fromHSV(el.h, el.s, el.v)
			safe(el.callback, el.value)
			SaveConfiguration()
		end
		
		-- Draw Saturation/Value box
		local svN = 25
		local cell = sv / svN
		local k = 0
		for gx = 0, svN - 1 do
			for gy = 0, svN - 1 do
				k = k + 1
				rect("ov.sv" .. k, math.floor(svx + gx * cell), math.floor(svy + gy * cell), math.ceil(cell), math.ceil(cell),
					Color3.fromHSV(el.h, (gx + 0.5) / svN, 1 - (gy + 0.5) / svN), 1, Z + 2, 0)
			end
		end
		
		-- Draw Hue Bar
		local hcN = 50
		local hcell = sv / hcN
		for i = 0, hcN - 1 do
			rect("ov.hu" .. i, hx, math.floor(svy + i * hcell), hueW, math.ceil(hcell), Color3.fromHSV(1 - i / hcN, 1, 1), 1, Z + 2, 0)
		end
		
		-- Handles
		outline("ov.svc", svx + el.s * sv - 3, svy + (1 - el.v) * sv - 3, 6, 6, Color3.fromRGB(255, 255, 255), 1, Z + 3, 0)
		rect("ov.huc", hx - 2, svy + (1 - el.h) * sv - 1, hueW + 4, 2, Color3.fromRGB(255, 255, 255), 1, Z + 3, 0)
		
		-- Done Button
		local btnW = panelW - pad * 2
		local doneHov = inBounds(px + pad, btnY, btnW, 20)
		rect("ov.done", px + pad, btnY, btnW, 20, Theme.TabBackgroundSelected, 0.9, Z + 2, 4)
		text("ov.donet", "Close", px + pad + btnW/2 - textW("Close", 11)/2, btnY + 4, 11, Theme.SelectedTabTextColor, Z + 3)
		
		if doneHov and Input.clicked then
			State.Overlay = nil
			return true
		end
		
		if Input.clicked and not ov.drag and ov.openedFrame ~= CurTick and not inBounds(px, py, panelW, panelH) then
			State.Overlay = nil
		end
		return true
	end
	return false
end

-- Keyboard action polling
local function pollKeybinds(ck)
	if State.KBListening then
		local el = State.KBListening
		for _, vk in ipairs(ScanList) do
			if vk ~= 0x01 and ck(vk) then
				if vk == 0x1B then -- Escape key
					State.KBListening = nil
				elseif vk == 0x2E then -- Delete key to clear
					el.value = "None"
					el.key = nil
					State.KBListening = nil
					safe(el.callback, "None")
				else
					el.key = vk
					el.value = KeyName[vk] or tostring(vk)
					State.KBListening = nil
					safe(el.callback, el.value)
				end
				SaveConfiguration()
				break
			end
		end
		return
	end
	
	-- Fire actions for active keybinds
	for _, el in ipairs(AllKeybinds) do
		if el.key and ck(el.key) then
			safe(el.callback, el.value)
		end
	end
end

-- Text box input action polling
local function pollTextInput(ck)
	local f = State.Focused
	if not f then return end
	if ck(0x0D) then -- Enter
		if f.onCommit then f.onCommit(f.buf) end
		State.Focused = nil
		return
	end
	if ck(0x1B) then -- Escape
		State.Focused = nil
		return
	end
	
	local changed = false
	if ck(0x08) then -- Backspace
		if #f.buf > 0 then f.buf = f.buf:sub(1, -2); changed = true end
	end
	
	local shift = safeIsKeyPressed(0x10) or safeIsKeyPressed(0xA0) or safeIsKeyPressed(0xA1)
	for _, vk in ipairs(CharScanList) do
		if ck(vk) then
			local m = CharMap[vk]
			local chr = m and (shift and m[2] or m[1])
			if chr then
				f.buf = f.buf .. chr
				changed = true
			end
			break
		end
	end
	
	if changed and f.onType then
		f.onType(f.buf)
	end
end

local function blurField()
	local f = State.Focused
	if f and f.onCommit then f.onCommit(f.buf) end
	State.Focused = nil
end

-- Render the Rayfield Loader
local function renderLoader(dt)
	local vw, vh = State.Vw, State.Vh
	local w, h = 320, 200
	local x = math.floor((vw - w) / 2)
	local y = math.floor((vh - h) / 2)
	
	Loader.Progress.goal = math.min((tick() - Loader.Born) / 1.5, 1)
	springStep(Loader.Progress, dt)
	
	if Loader.Progress.v > 0.99 then
		Loader.Alpha.goal = 0
	end
	
	local a = springStep(Loader.Alpha, dt)
	if a < 0.01 then
		Loader.Active = false
		return
	end
	
	-- Panel Background
	rect("ld.bg", x, y, w, h, Theme.Background, a * 0.98, 100, 8)
	outline("ld.bd", x, y, w, h, Theme.ElementStroke, a * 0.4, 101, 8)
	
	-- Titles
	text("ld.t", Loader.Title, x + w / 2, y + 55, 20, Theme.TextColor, 102, true, a)
	text("ld.st", Loader.Subtitle, x + w / 2, y + 85, 12, Color3.fromRGB(150, 150, 150), 102, true, a)
	
	-- Progress Bar
	local pbx, pby, pbw, pbh = x + 35, y + 130, 250, 5
	rect("ld.pbbg", pbx, pby, pbw, pbh, Color3.fromRGB(45, 45, 45), a * 0.5, 102, 2)
	rect("ld.pbfil", pbx, pby, math.floor(pbw * Loader.Progress.v), pbh, Theme.SliderProgress, a, 103, 2)
end

-- Render the Main Rayfield Window Frame, Scrollbar, and Tabs
local function renderWindow(dt)
	local win = State.Win
	local topBarH = 40
	local sideBarW = 140
	
	handleDragging()
	
	-- Base Window Background
	rect("win.bg", win.x, win.y, win.w, win.h, Theme.Background, 0.98, 10, 8)
	outline("win.bd", win.x, win.y, win.w, win.h, Theme.ElementStroke, 0.35, 11, 8)
	
	-- Topbar separator
	line("win.tbl", win.x, win.y + topBarH, win.x + win.w, win.y + topBarH, Theme.SecondaryElementStroke, 0.5, 12)
	
	-- Sidebar right separator
	line("win.sbl", win.x + sideBarW, win.y + topBarH, win.x + sideBarW, win.y + win.h, Theme.SecondaryElementStroke, 0.5, 12)
	
	-- Window Title
	text("win.t", Loader.Title, win.x + 15, win.y + 12, 14, Theme.TextColor, 12, false)
	
	-- Topbar Action Buttons (Close and Minimize)
	local closeX = win.x + win.w - 30
	local closeY = win.y + 13
	local closeHov = inBounds(closeX, closeY, 15, 15)
	text("win.close", "x", closeX, closeY, 13, closeHov and Color3.fromRGB(255, 80, 80) or Theme.TextColor, 13)
	if closeHov and Input.clicked then
		Library:Destroy()
		return
	end
	
	local minX = win.x + win.w - 55
	local minY = win.y + 11
	local minHov = inBounds(minX, minY, 15, 15)
	text("win.min", "-", minX, minY, 15, minHov and Theme.SliderStroke or Theme.TextColor, 13)
	if minHov and Input.clicked then
		State.Minimized = true
	end
	
	-- Draw Tabs Sidebar
	local tabY0 = win.y + topBarH + 12
	for i, tabObj in ipairs(Tabs) do
		local ty = tabY0 + (i - 1) * 36
		local active = (State.ActiveTab == i)
		local tHover = inBounds(win.x + 10, ty, sideBarW - 20, 28)
		
		-- Tab highlight background
		if active then
			rect("tab.bg" .. i, win.x + 10, ty, sideBarW - 20, 28, Theme.TabBackgroundSelected, 0.98, 13, 6)
			outline("tab.bd" .. i, win.x + 10, ty, sideBarW - 20, 28, Theme.TabStroke, 0.15, 14, 6)
		elseif tHover then
			rect("tab.bg" .. i, win.x + 10, ty, sideBarW - 20, 28, Theme.ElementBackgroundHover, 0.25, 13, 6)
		end
		
		-- Tab Text
		text("tab.tx" .. i, tabObj.name, win.x + 20, ty + 7, 13, active and Theme.SelectedTabTextColor or Theme.TabTextColor, 15, false, 1, not active)
		
		if tHover and Input.clicked then
			State.ActiveTab = i
			blurField()
			State.Overlay = nil
		end
	end
	
	-- Draw Elements Container with Scrollbar
	local containerX = win.x + sideBarW + 12
	local containerY = win.y + topBarH + 12
	local containerW = win.w - sideBarW - 24
	local containerH = win.h - topBarH - 24
	
	local activeTabObj = Tabs[State.ActiveTab]
	if activeTabObj then
		local totalHeight = 0
		local spacing = 8
		for _, el in ipairs(activeTabObj.elements) do
			el.height = cardHeight(el)
			totalHeight = totalHeight + el.height + spacing
		end
		if totalHeight > 0 then totalHeight = totalHeight - spacing end
		
		local maxScroll = math.max(0, totalHeight - containerH)
		activeTabObj.scroll = clamp(activeTabObj.scroll or 0, 0, maxScroll)
		
		local needScrollbar = maxScroll > 0
		local trackW = 4
		local trackX = win.x + win.w - 10
		local trackY = containerY
		local trackH = containerH
		
		-- Overlay blocker
		local block = (State.Overlay ~= nil)
		
		if needScrollbar then
			local thumbH = math.max(16, (trackH / totalHeight) * trackH)
			local maxThumbY = trackH - thumbH
			local trackHovered = inBounds(trackX - 4, trackY, trackW + 8, trackH)
			
			rect("win.sptrack", trackX, trackY, trackW, trackH, Color3.fromRGB(45, 45, 45), 0.3, 20, 2)
			
			if Input.down and not block then
				if not State.ScrollDrag and trackHovered then
					State.ScrollDrag = true
				end
				if State.ScrollDrag then
					local f = clamp((Input.my - trackY - thumbH/2) / maxThumbY, 0, 1)
					activeTabObj.scroll = f * maxScroll
				end
			else
				State.ScrollDrag = false
			end
			
			local thumbY = trackY + (activeTabObj.scroll / maxScroll) * maxThumbY
			rect("win.spthumb", trackX, thumbY, trackW, thumbH, Theme.SliderProgress, 0.8, 21, 2)
		end
		
		-- Render elements within viewport boundaries (dynamic clipping)
		local accY = 0
		for idx, el in ipairs(activeTabObj.elements) do
			local elY = containerY + accY - activeTabObj.scroll
			local isVisible = (elY + el.height > containerY) and (elY < containerY + containerH)
			local idp = "el_" .. State.ActiveTab .. "_" .. idx
			
			if isVisible then
				processEl(el, idp, containerX, elY, containerW - (needScrollbar and 10 or 0), el.height, dt, 20, block)
			end
			accY = accY + el.height + spacing
		end
	end
end

-- Render minimized bubble/pill
local function renderMinimizedBubble()
	local w, h = 120, 32
	local x, y = 30, 30
	local hovered = inBounds(x, y, w, h)
	rect("bub.bg", x, y, w, h, Theme.Background, 0.98, 90, 8)
	outline("bub.bd", x, y, w, h, hovered and Theme.SliderStroke or Theme.ElementStroke, 0.4, 91, 8)
	circle("bub.dot", x + 15, y + 16, 4, Theme.SliderProgress, 1, 92)
	text("bub.tx", Loader.Title, x + 28, y + 9, 13, Theme.TextColor, 92)
	if hovered and Input.clicked then
		State.Minimized = false
	end
end

-- Render active notifications
local function renderNotifs(dt)
	if #Notifs == 0 then return end
	local vw, vh = State.Vw, State.Vh
	local margin, w, Z = 16, 280, 200
	local now = tick()
	local y = vh - margin
	
	for idx = #Notifs, 1, -1 do
		local n = Notifs[idx]
		if not n.dying and (now - n.born) > n.duration then
			n.dying = true
			n.diedAt = now
			n.slide.goal = 1
			n.alpha.goal = 0
		end
		
		if n.dying and (now - (n.diedAt or now)) > 0.4 then
			table.remove(Notifs, idx)
		else
			springStep(n.slide, dt)
			springStep(n.alpha, dt)
			
			local hh = 14 + 18 + #n.lines * 15 + 16
			y = y - hh
			
			local x = vw - margin - w + n.slide.v * (w + margin + 8)
			local a = n.alpha.v
			
			-- Background Panel
			rect("nf.bg" .. n.id, x, y, w, hh, Theme.NotificationBackground, a * 0.98, Z, 6)
			outline("nf.bd" .. n.id, x, y, w, hh, Theme.ElementStroke, a * 0.3, Z + 1, 6)
			
			-- Title
			text("nf.t" .. n.id, n.title, x + 14, y + 10, 13, Theme.TextColor, Z + 2, false, a)
			
			-- Close Action
			local cx, cy = x + w - 22, y + 9
			text("nf.x" .. n.id, "x", cx, cy, 13, Color3.fromRGB(150, 150, 150), Z + 3, false, a)
			if not n.dying and Input.clicked and inBounds(cx - 4, cy - 2, 16, 16) then
				n.dying = true
				n.diedAt = now
				n.slide.goal = 1
				n.alpha.goal = 0
			end
			
			-- Content Lines
			local ly = y + 28
			for li, ln in ipairs(n.lines) do
				text("nf.c" .. n.id .. "_" .. li, ln, x + 14, ly, 12, Color3.fromRGB(180, 180, 180), Z + 2, false, a)
				ly = ly + 15
			end
			
			-- Lifespan progress bar at the bottom
			local elapsed = clamp((now - n.born) / n.duration, 0, 1)
			local lineW = math.floor(w * (1 - elapsed))
			rect("nf.line" .. n.id, x, y + hh - 3, lineW, 3, Theme.SliderProgress, a, Z + 3, 1)
			
			y = y - 10
		end
	end
end

-- Clamp helper function
function clamp(v, lo, hi)
	if v < lo then return lo elseif v > hi then return hi end return v
end

-- The core frame-by-frame loop step
local function step()
	local active = true
	pcall(function()
		if isrbxactive then
			active = isrbxactive()
		end
	end)
	if not active then return end
	CurTick = CurTick + 1
	
	local now = tick()
	local dt = State.LastTime and (now - State.LastTime) or 0.016
	if dt > 0.1 then dt = 0.1 elseif dt < 0.001 then dt = 0.016 end
	State.LastTime = now
	
	pollInput()
	
	local clicks = {}
	local function ck(vk)
		local c = clicks[vk]
		if c == nil then c = keyEdge(vk); clicks[vk] = c end
		return c
	end
	
	-- Toggle visibility key
	if ck(State.ToggleKey) then
		State.Minimized = not State.Minimized
		blurField()
		State.Overlay = nil
	end
	
	pollKeybinds(ck)
	pollTextInput(ck)
	
	if #Notifs > 0 or Loader.Active then
		State.Vw, State.Vh = getViewportSize()
	end
	
	if Loader.Active then
		renderLoader(dt)
	elseif State.Minimized then
		renderMinimizedBubble()
	else
		renderWindow(dt)
		renderOverlay(dt)
	end
	
	renderNotifs(dt)
	cleanupDrawings()
end

-- CreateWindow Function
function Library:CreateWindow(Settings)
	-- Automatic cleanup of previous instance to prevent double-draw duplicate bugs
	if _G.__Rayfield then
		pcall(function() _G.__Rayfield:Destroy() end)
	end
	_G.__Rayfield = Library
	_G.__RayfieldState = State -- expose State so external scripts can sync ToggleKey

	Settings = Settings or {}
	Loader.Title = Settings.Name or "Rayfield"
	Loader.Subtitle = Settings.LoadingSubtitle or "Interface Suite"
	Loader.Born = tick()
	Loader.Progress.v = 0
	Loader.Progress.goal = 0
	Loader.Alpha.v = 1
	Loader.Alpha.goal = 1
	Loader.Active = true
	
	-- Setup config theme
	if Settings.Theme then
		local newTheme = Library.Theme[Settings.Theme]
		if newTheme then
			Theme = newTheme
		end
	end
	
	if Settings.ToggleUIKeybind then
		local key, name = resolveKey(Settings.ToggleUIKeybind)
		if key then
			State.ToggleKey = key
		end
	end
	
	-- Configuration Saving
	if Settings.ConfigurationSaving then
		CEnabled = Settings.ConfigurationSaving.Enabled
		CFileName = Settings.ConfigurationSaving.FileName or tostring(game.PlaceId)
		ConfigurationFolder = Settings.ConfigurationSaving.FolderName or ConfigurationFolder
		
		if CEnabled then
			pcall(function()
				if not isfolder(ConfigurationFolder) then
					makefolder(ConfigurationFolder)
				end
			end)
		end
	end
	
	centerWindow()
	
	-- Start the execution loop automatically
	if not State.Running then
		local token = {}
		State.Token = token
		State.Running = true
		State.Loaded = true
		State.Unloaded = false
		task.spawn(function()
			while State.Token == token do
				local ok, err = pcall(step)
				if not ok then
					warn("[Rayfield] step error: " .. tostring(err))
				end
				Input.prevDown = Input.down
				task.wait()
			end
			State.Running = false
			State.Loaded = false
			Library:_removeAllDrawings()
		end)
	end
	
	local Window = {}
	
	-- Tab Creation API
	function Window:CreateTab(Name, Icon)
		local tabObj = {
			name = Name or "Tab",
			icon = Icon,
			elements = {},
			scroll = 0,
		}
		table.insert(Tabs, tabObj)
		
		-- Element Creation API on individual Tab
		local tabAPI = {}
		
		function tabAPI:CreateSection(text)
			local el = { kind = "section", title = text }
			table.insert(tabObj.elements, el)
			return el
		end
		
		function tabAPI:CreateDivider()
			local el = { kind = "divider" }
			table.insert(tabObj.elements, el)
			return el
		end
		
		function tabAPI:CreateLabel(text, icon, color, ignoreTheme)
			local el = { kind = "label", title = text, icon = icon, color = color }
			table.insert(tabObj.elements, el)
			return el
		end
		
		function tabAPI:CreateParagraph(c)
			c = c or {}
			local lines = {}
			for ln in (tostring(c.Content or "") .. "\n"):gmatch("(.-)\n") do
				table.insert(lines, ln)
			end
			if #lines > 0 and lines[#lines] == "" then table.remove(lines) end
			
			local el = { kind = "paragraph", title = c.Title or "Paragraph", value = c.Content or "", lines = lines }
			
			local handle = {}
			function handle:Set(newCfg)
				if type(newCfg) == "table" then
					el.title = newCfg.Title or el.title
					el.value = newCfg.Content or el.value
				else
					el.value = tostring(newCfg)
				end
				local newLines = {}
				for ln in (tostring(el.value) .. "\n"):gmatch("(.-)\n") do
					table.insert(newLines, ln)
				end
				if #newLines > 0 and newLines[#newLines] == "" then table.remove(newLines) end
				el.lines = newLines
			end
			
			table.insert(tabObj.elements, el)
			return handle
		end
		
		function tabAPI:CreateButton(c)
			c = c or {}
			local el = { kind = "button", title = c.Name or "Button", callback = c.Callback, hover = newSpring(0, 16) }
			
			local handle = {}
			function handle:Set(newName)
				el.title = newName
			end
			
			table.insert(tabObj.elements, el)
			return handle
		end
		
		function tabAPI:CreateToggle(c)
			c = c or {}
			local el = {
				kind = "toggle",
				title = c.Name or "Toggle",
				value = c.CurrentValue and true or false,
				callback = c.Callback,
				flag = c.Flag,
				hover = newSpring(0, 16),
				anim = newSpring(c.CurrentValue and 1 or 0, 18),
			}
			
			local handle = {}
			function handle:Set(newVal)
				el.value = not not newVal
				el.anim.goal = el.value and 1 or 0
				safe(el.callback, el.value)
				SaveConfiguration()
			end
			
			if c.Flag then
				Library.Flags[c.Flag] = handle
			end
			
			table.insert(tabObj.elements, el)
			return handle
		end
		
		function tabAPI:CreateSlider(c)
			c = c or {}
			local range = c.Range or {0, 100}
			local val = clamp(c.CurrentValue or range[1], range[1], range[2])
			local el = {
				kind = "slider",
				title = c.Name or "Slider",
				min = range[1],
				max = range[2],
				value = val,
				increment = c.Increment or 1,
				suffix = c.Suffix,
				callback = c.Callback,
				flag = c.Flag,
				hover = newSpring(0, 16),
				frac = newSpring((val - range[1]) / math.max(1e-6, range[2] - range[1]), 20),
			}
			
			local handle = {}
			function handle:Set(newVal)
				el.value = clamp(newVal, el.min, el.max)
				el.frac.goal = (el.value - el.min) / math.max(1e-6, el.max - el.min)
				safe(el.callback, el.value)
				SaveConfiguration()
			end
			
			if c.Flag then
				Library.Flags[c.Flag] = handle
			end
			
			table.insert(tabObj.elements, el)
			return handle
		end
		
		function tabAPI:CreateInput(c)
			c = c or {}
			local el = {
				kind = "input",
				title = c.Name or "Input",
				value = c.CurrentValue or "",
				placeholder = c.PlaceholderText or "Type...",
				clearOnFocusLost = c.RemoveTextAfterFocusLost or false,
				callback = c.Callback,
				flag = c.Flag,
				hover = newSpring(0, 16),
			}
			
			local handle = {}
			function handle:Set(newVal)
				el.value = tostring(newVal)
				safe(el.callback, el.value)
				SaveConfiguration()
			end
			
			if c.Flag then
				Library.Flags[c.Flag] = handle
			end
			
			table.insert(tabObj.elements, el)
			return handle
		end
		
		function tabAPI:CreateDropdown(c)
			c = c or {}
			local el = {
				kind = "dropdown",
				title = c.Name or "Dropdown",
				options = c.Options or {"Option 1"},
				value = c.CurrentValue or c.CurrentOption or c.Options[1] or "Option 1",
				multi = c.MultipleOptions or false,
				callback = c.Callback,
				flag = c.Flag,
				hover = newSpring(0, 16),
				selectedMap = {},
				scroll = 0,
			}
			
			if el.multi then
				local initVal = c.CurrentValue or c.CurrentOption
				if type(initVal) == "table" then
					for _, v in ipairs(initVal) do el.selectedMap[v] = true end
				elseif type(initVal) == "string" then
					el.selectedMap[initVal] = true
				end
			end
			
			local handle = {}
			function handle:Set(newVal)
				if el.multi then
					el.selectedMap = {}
					if type(newVal) == "table" then
						for _, v in ipairs(newVal) do el.selectedMap[v] = true end
					elseif type(newVal) == "string" then
						el.selectedMap[newVal] = true
					end
					safe(el.callback, el.selectedMap)
				else
					el.value = tostring(newVal)
					safe(el.callback, el.value)
				end
				SaveConfiguration()
			end
			
			function handle:Refresh(optionsTable, resetValue)
				el.options = optionsTable or el.options
				el.scroll = 0
				if resetValue then
					if el.multi then
						el.selectedMap = {}
					else
						el.value = el.options[1] or "None"
					end
				end
			end
			
			if c.Flag then
				Library.Flags[c.Flag] = handle
			end
			
			table.insert(tabObj.elements, el)
			return handle
		end
		
		function tabAPI:CreateKeybind(c)
			c = c or {}
			local key, name = resolveKey(c.CurrentValue or c.CurrentKeybind)
			local el = {
				kind = "keybind",
				title = c.Name or "Keybind",
				key = key,
				value = name,
				callback = c.Callback,
				flag = c.Flag,
				hover = newSpring(0, 16),
			}
			
			local handle = {}
			function handle:Set(newVal)
				local k, n = resolveKey(newVal)
				if k then
					el.key = k
					el.value = n
					safe(el.callback, el.value)
					SaveConfiguration()
				end
			end
			
			if c.Flag then
				Library.Flags[c.Flag] = handle
			end
			
			table.insert(AllKeybinds, el)
			table.insert(tabObj.elements, el)
			return handle
		end
		
		function tabAPI:CreateColorPicker(c)
			c = c or {}
			local color = c.CurrentValue or c.Color or Color3.fromRGB(255, 255, 255)
			local h, s, v = rgbToHsv(color)
			local el = {
				kind = "colorpicker",
				title = c.Name or "Color Picker",
				value = color,
				h = h, s = s, v = v,
				callback = c.Callback,
				flag = c.Flag,
				hover = newSpring(0, 16),
			}
			
			local handle = {}
			function handle:Set(newCol)
				if typeof(newCol) == "Color3" then
					el.value = newCol
					el.h, el.s, el.v = rgbToHsv(newCol)
					safe(el.callback, el.value)
					SaveConfiguration()
				end
			end
			
			if c.Flag then
				Library.Flags[c.Flag] = handle
			end
			
			table.insert(tabObj.elements, el)
			return handle
		end
		
		return tabAPI
	end
	
	-- Delayed config load
	task.spawn(function()
		task.wait(1.5) -- wait for loader splash
		Library:LoadConfiguration()
	end)
	
	return Window
end

-- RGB to HSV Conversion Utility
function rgbToHsv(c)
	local r, g, b = c.R, c.G, c.B
	local mx, mn = math.max(r, g, b), math.min(r, g, b)
	local d = mx - mn
	local h, s, v = 0, (mx == 0 and 0 or d / mx), mx
	if d ~= 0 then
		if mx == r then h = ((g - b) / d) % 6
		elseif mx == g then h = (b - r) / d + 2
		else h = (r - g) / d + 4 end
		h = h / 6
	end
	return h, s, v
end

-- Close / remove all cached drawings
function Library:_removeAllDrawings()
	for _, c in pairs(Cache) do
		if c.Obj and c.Obj.Remove then
			pcall(function() c.Obj:Remove() end)
		end
	end
	Cache = {}
	Visible = {}
end

-- Destroy Library
function Library:Destroy()
	if _G.__Rayfield == Library then
		_G.__Rayfield = nil
	end
	State.Token = nil
	State.Unloaded = true
	State.Loaded = false
	Library:_removeAllDrawings()
end

return Rayfield
