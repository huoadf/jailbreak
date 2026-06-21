-- [[ Rayfield UI Library for Matcha LuaVM ]] --
-- Created for universal compatibility using pure Drawing API

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

Rayfield = {}
local Library = Rayfield
_G.Rayfield = Rayfield

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
		ToggleEnabledOuterStroke = Color3.fromRGB(20, 100, 50),
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
		Shadow = Color3.fromRGB(20, 60, 20),
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
		c = { Obj = Drawing.new(dtype), P = {} }
		Cache[id] = c
	end
	local obj, P = c.Obj, c.P
	local vis = props.Visible
	if vis == nil then vis = true end
	if P.Visible ~= vis then obj.Visible = vis; P.Visible = vis end
	if vis then
		for k, v in pairs(props) do
			if k ~= "Visible" and not eq(P[k], v) then
				obj[k] = v
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
			c.Obj.Visible = false
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

local function textW(str, size)
	return #tostring(str) * size * 0.52
end

-- Input Manager
local Input = { mx = 0, my = 0, down = false, prevDown = false, clicked = false, keys = {} }

local function inBounds(x, y, w, h)
	return Input.mx >= x and Input.mx <= x + w and Input.my >= y and Input.my <= y + h
end

local function pollInput()
	Input.mx, Input.my = Mouse.X, Mouse.Y
	Input.down = ismouse1pressed()
	Input.clicked = Input.down and not Input.prevDown
end

-- Key State Polling
local function keyEdge(vk)
	local k = Input.keys[vk]
	if not k then k = { held = false }; Input.keys[vk] = k end
	local p = iskeypressed(vk)
	local click = p and not k.held
	k.held = p
	return click
end

-- Alphanumeric / Symbols keycode map for inputs
local KeyMap = {}
pcall(function()
	local function addKey(enumItem, char)
		if enumItem ~= nil then
			KeyMap[enumItem] = char
		end
	end
	
	-- Letters
	addKey(Enum.KeyCode.A, "a") addKey(Enum.KeyCode.B, "b") addKey(Enum.KeyCode.C, "c") addKey(Enum.KeyCode.D, "d")
	addKey(Enum.KeyCode.E, "e") addKey(Enum.KeyCode.F, "f") addKey(Enum.KeyCode.G, "g") addKey(Enum.KeyCode.H, "h")
	addKey(Enum.KeyCode.I, "i") addKey(Enum.KeyCode.J, "j") addKey(Enum.KeyCode.K, "k") addKey(Enum.KeyCode.L, "l")
	addKey(Enum.KeyCode.M, "m") addKey(Enum.KeyCode.N, "n") addKey(Enum.KeyCode.O, "o") addKey(Enum.KeyCode.P, "p")
	addKey(Enum.KeyCode.Q, "q") addKey(Enum.KeyCode.R, "r") addKey(Enum.KeyCode.S, "s") addKey(Enum.KeyCode.T, "t")
	addKey(Enum.KeyCode.U, "u") addKey(Enum.KeyCode.V, "v") addKey(Enum.KeyCode.W, "w") addKey(Enum.KeyCode.X, "x")
	addKey(Enum.KeyCode.Y, "y") addKey(Enum.KeyCode.Z, "z")
	
	-- Numbers
	addKey(Enum.KeyCode.Zero, "0") addKey(Enum.KeyCode.One, "1") addKey(Enum.KeyCode.Two, "2") addKey(Enum.KeyCode.Three, "3")
	addKey(Enum.KeyCode.Four, "4") addKey(Enum.KeyCode.Five, "5") addKey(Enum.KeyCode.Six, "6") addKey(Enum.KeyCode.Seven, "7")
	addKey(Enum.KeyCode.Eight, "8") addKey(Enum.KeyCode.Nine, "9")
	
	-- Special characters
	addKey(Enum.KeyCode.Minus, "-") addKey(Enum.KeyCode.Equals, "=") addKey(Enum.KeyCode.LeftBracket, "[")
	addKey(Enum.KeyCode.RightBracket, "]") addKey(Enum.KeyCode.Semicolon, ";") addKey(Enum.KeyCode.Quote, "'")
	addKey(Enum.KeyCode.Comma, ",") addKey(Enum.KeyCode.Period, ".") addKey(Enum.KeyCode.Slash, "/")
	addKey(Enum.KeyCode.BackSlash, "\\")
end)

local ShiftMap = {
	["a"] = "A", ["b"] = "B", ["c"] = "C", ["d"] = "D", ["e"] = "E", ["f"] = "F", ["g"] = "G", ["h"] = "H",
	["i"] = "I", ["j"] = "J", ["k"] = "K", ["l"] = "L", ["m"] = "M", ["n"] = "N", ["o"] = "O", ["p"] = "P",
	["q"] = "Q", ["r"] = "R", ["s"] = "S", ["t"] = "T", ["u"] = "U", ["v"] = "V", ["w"] = "W", ["x"] = "X",
	["y"] = "Y", ["z"] = "Z",
	["1"] = "!", ["2"] = "@", ["3"] = "#", ["4"] = "$", ["5"] = "%", ["6"] = "^", ["7"] = "&", ["8"] = "*",
	["9"] = "(", ["0"] = ")", ["-"] = "_", ["="] = "+", ["["] = "{", ["]"] = "}", [";"] = ":", ["'"] = "\"",
	[","] = "<", ["."] = ">", ["/"] = "?", ["\\"] = "|",
}

local VK_Names = {
	[0x0D] = "Enter", [0x20] = "Space", [0x23] = "End", [0x2D] = "Insert",
	[0x10] = "Shift", [0x11] = "Ctrl", [0x12] = "Alt",
	[0x25] = "Left", [0x26] = "Up", [0x27] = "Right", [0x28] = "Down",
	[0x70] = "F1", [0x71] = "F2", [0x72] = "F3", [0x73] = "F4", [0x74] = "F5",
	[0x75] = "F6", [0x76] = "F7", [0x77] = "F8", [0x78] = "F9", [0x79] = "F10",
	[0x7A] = "F11", [0x7B] = "F12",
}
for i = 65, 90 do VK_Names[i] = string.char(i) end
for i = 48, 57 do VK_Names[i] = string.char(i) end

local function getVKName(vk)
	return VK_Names[vk] or ("0x" .. string.format("%X", vk))
end

local function getVKFromName(name)
	name = name:upper()
	for vk, n in pairs(VK_Names) do
		if n:upper() == name then return vk end
	end
	if name:sub(1, 2) == "0X" then
		return tonumber(name, 16)
	end
	return nil
end

-- Global Window and Library States
local State = {
	Win = { x = 100, y = 100, w = 560, h = 400 },
	Drag = false, DragOff = Vector2.new(0, 0),
	ActiveTab = 1,
	ToggleKey = 0, -- Disabled by default (let script manage keybinds)
	Minimized = false,
	Overlay = nil,
	Dialog = nil,
	Vw = 1920, Vh = 1080,
	LastTime = nil,
	Running = false, Token = nil,
	Loaded = false,
	Unloaded = false,
	Scrolling = false,
}

local Tabs = {}
local Notifs = {}
local NotifId = 0
local FocusedInput = nil
local InputProcessed = false

-- Config state storage
Library.Flags = {}
local currentConfig = { Enabled = false, Folder = "Rayfield", File = "config" }

local function saveConfig()
	if not currentConfig.Enabled then return end
	local folder = currentConfig.Folder
	local file = currentConfig.File
	local path = folder .. "/" .. file .. ".json"
	
	local data = {}
	for flag, val in pairs(Library.Flags) do
		local t = typeof(val)
		if t == "boolean" or t == "number" or t == "string" then
			data[flag] = val
		elseif t == "Color3" then
			data[flag] = { r = val.R, g = val.G, b = val.B, type = "Color3" }
		end
	end
	
	pcall(function()
		if not isfolder(folder) then
			makefolder(folder)
		end
		writefile(path, HttpService:JSONEncode(data))
	end)
end

local function loadConfig()
	if not currentConfig.Enabled then return end
	local folder = currentConfig.Folder
	local file = currentConfig.File
	local path = folder .. "/" .. file .. ".json"
	
	if not isfile(path) then return end
	
	local ok, content = pcall(readfile, path)
	if not ok or not content then return end
	
	local ok2, data = pcall(function() return HttpService:JSONDecode(content) end)
	if not ok2 or type(data) ~= "table" then return end
	
	for flag, val in pairs(data) do
		if type(val) == "table" and val.type == "Color3" then
			Library.Flags[flag] = Color3.new(val.r or 1, val.g or 1, val.b or 1)
		else
			Library.Flags[flag] = val
		end
	end
end

function Library:SaveConfig(name)
	if name then currentConfig.File = name end
	saveConfig()
end

function Library:LoadConfig(name)
	if name then currentConfig.File = name end
	loadConfig()
end

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

-- Dynamic element heights helper
local function getElementHeight(el)
	if el.type == "Section" then return 28
	elseif el.type == "Divider" then return 10
	elseif el.type == "Label" then return 20
	elseif el.type == "Paragraph" then
		return 24 + #el.lines * 14
	elseif el.type == "Slider" then return 46
	else return 36
	end
end

-- Hide drawings for off-screen scrolled elements
local function hideElementDrawings(el, idx)
	local pfxs = {}
	if el.type == "Section" then
		pfxs = { "sec.t", "sec.l" }
	elseif el.type == "Divider" then
		pfxs = { "div.l" }
	elseif el.type == "Label" then
		pfxs = { "lbl.t" }
	elseif el.type == "Paragraph" then
		pfxs = { "par.bg", "par.t" }
		for li = 1, #el.lines do
			table.insert(pfxs, "par.c" .. idx .. "_" .. li)
		end
	elseif el.type == "Button" then
		pfxs = { "btn.bg", "btn.bd", "btn.t" }
	elseif el.type == "Toggle" then
		pfxs = { "tog.bg", "tog.bd", "tog.t", "tog.sw", "tog.swbd", "tog.kb" }
	elseif el.type == "Slider" then
		pfxs = { "sld.bg", "sld.bd", "sld.t", "sld.v", "sld.tr", "sld.fi", "sld.kb" }
	elseif el.type == "Input" then
		pfxs = { "inp.bg", "inp.bd", "inp.t", "inp.bx", "inp.bxbd", "inp.disp" }
	elseif el.type == "Dropdown" then
		pfxs = { "drp.bg", "drp.bd", "drp.t", "drp.bx", "drp.bxbd", "drp.arrow", "drp.disp" }
	elseif el.type == "Keybind" then
		pfxs = { "kb.bg", "kb.bd", "kb.t", "kb.bx", "kb.bxbd", "kb.disp" }
	elseif el.type == "ColorPicker" then
		pfxs = { "cp.bg", "cp.bd", "cp.t", "cp.bx", "cp.bxbd" }
	end
	
	for _, pfx in ipairs(pfxs) do
		local id = pfx:find("_") and pfx or (pfx .. idx)
		local c = Cache[id]
		if c and c.Obj and c.P.Visible then
			c.Obj.Visible = false
			c.P.Visible = false
			Visible[id] = nil
		end
	end
end

-- Render individual element
local function renderElement(el, x, y, w, h, idx, dt)
	local clickOk = Input.clicked and not InputProcessed
	
	if el.type == "Section" then
		text("sec.t" .. idx, el.name:upper(), x + 5, y + 8, 11, Theme.SliderProgress, 21, false, 1, false)
		line("sec.l" .. idx, x + textW(el.name:upper(), 11) + 15, y + 14, x + w - 5, y + 14, Theme.ElementStroke, 0.3, 21)
	elseif el.type == "Divider" then
		line("div.l" .. idx, x + 5, y + 5, x + w - 5, y + 5, Theme.ElementStroke, 0.35, 21)
	elseif el.type == "Label" then
		text("lbl.t" .. idx, el.name, x + 10, y + 4, 13, Theme.TextColor, 21, false)
	elseif el.type == "Paragraph" then
		rect("par.bg" .. idx, x, y, w, h, Theme.ElementBackground, 0.45, 20, 6)
		text("par.t" .. idx, el.name, x + 12, y + 8, 13, Theme.TextColor, 21)
		local cy = y + 24
		for li, ln in ipairs(el.lines) do
			text("par.c" .. idx .. "_" .. li, ln, x + 12, cy, 12, Color3.fromRGB(160, 160, 160), 21, false)
			cy = cy + 14
		end
	elseif el.type == "Button" then
		local hovered = inBounds(x, y, w, h)
		local bgCol = hovered and Theme.ElementBackgroundHover or Theme.ElementBackground
		rect("btn.bg" .. idx, x, y, w, h, bgCol, 0.9, 20, 6)
		outline("btn.bd" .. idx, x, y, w, h, Theme.ElementStroke, 0.4, 21, 6)
		text("btn.t" .. idx, el.name, x + w / 2, y + 11, 13, Theme.TextColor, 22, true)
		
		if hovered and clickOk then
			task.spawn(el.callback)
		end
	elseif el.type == "Toggle" then
		el.toggleSpring = el.toggleSpring or newSpring(el.value and 1 or 0, 15)
		el.toggleSpring.goal = el.value and 1 or 0
		springStep(el.toggleSpring, dt)
		
		local hovered = inBounds(x, y, w, h)
		local bgCol = hovered and Theme.ElementBackgroundHover or Theme.ElementBackground
		rect("tog.bg" .. idx, x, y, w, h, bgCol, 0.9, 20, 6)
		outline("tog.bd" .. idx, x, y, w, h, Theme.ElementStroke, 0.4, 21, 6)
		text("tog.t" .. idx, el.name, x + 12, y + 11, 13, Theme.TextColor, 22)
		
		local swW, swH = 34, 18
		local swX = x + w - swW - 12
		local swY = y + 9
		local trCol = lerpColor(Theme.ToggleDisabled, Theme.ToggleEnabled, el.toggleSpring.v)
		
		rect("tog.sw" .. idx, swX, swY, swW, swH, trCol, 1, 22, 9)
		outline("tog.swbd" .. idx, swX, swY, swW, swH, lerpColor(Theme.ToggleDisabledStroke, Theme.ToggleEnabledStroke, el.toggleSpring.v), 0.5, 23, 9)
		
		local knobX = swX + 9 + el.toggleSpring.v * 16
		circle("tog.kb" .. idx, knobX, swY + 9, 6, Color3.new(1, 1, 1), 1, 24)
		
		if hovered and clickOk then
			el.value = not el.value
			if el.flag then Library.Flags[el.flag] = el.value; saveConfig() end
			task.spawn(el.callback, el.value)
		end
	elseif el.type == "Slider" then
		local hovered = inBounds(x, y, w, h)
		local bgCol = hovered and Theme.ElementBackgroundHover or Theme.ElementBackground
		rect("sld.bg" .. idx, x, y, w, h, bgCol, 0.9, 20, 6)
		outline("sld.bd" .. idx, x, y, w, h, Theme.ElementStroke, 0.4, 21, 6)
		text("sld.t" .. idx, el.name, x + 12, y + 6, 12, Theme.TextColor, 22)
		
		local valStr = tostring(el.value) .. (el.suffix or "")
		text("sld.v" .. idx, valStr, x + w - 12 - textW(valStr, 12), y + 6, 12, Theme.SliderProgress, 22)
		
		local sX = x + 12
		local sY = y + 28
		local sW = w - 24
		local sH = 6
		
		rect("sld.tr" .. idx, sX, sY, sW, sH, Color3.fromRGB(40, 40, 40), 1, 22, 3)
		
		local trackHovered = inBounds(sX - 5, sY - 5, sW + 10, sH + 10)
		if Input.down and (trackHovered or el.dragging) and not InputProcessed then
			if Input.clicked then el.dragging = true end
		end
		if not Input.down then el.dragging = false end
		
		if el.dragging then
			local pct = clamp((Input.mx - sX) / sW, 0, 1)
			local rawVal = el.min + pct * (el.max - el.min)
			local steps = math.round((rawVal - el.min) / (el.increment or 1))
			local newVal = el.min + steps * (el.increment or 1)
			newVal = clamp(newVal, el.min, el.max)
			if newVal ~= el.value then
				el.value = newVal
				if el.flag then Library.Flags[el.flag] = el.value; saveConfig() end
				task.spawn(el.callback, el.value)
			end
		end
		
		local fillW = math.floor(sW * ((el.value - el.min) / (el.max - el.min)))
		rect("sld.fi" .. idx, sX, sY, fillW, sH, Theme.SliderProgress, 1, 23, 3)
		circle("sld.kb" .. idx, sX + fillW, sY + 3, 5, Color3.new(1, 1, 1), 1, 24)
	elseif el.type == "Input" then
		local hovered = inBounds(x, y, w, h)
		local bgCol = hovered and Theme.ElementBackgroundHover or Theme.ElementBackground
		rect("inp.bg" .. idx, x, y, w, h, bgCol, 0.9, 20, 6)
		outline("inp.bd" .. idx, x, y, w, h, Theme.ElementStroke, 0.4, 21, 6)
		text("inp.t" .. idx, el.name, x + 12, y + 11, 13, Theme.TextColor, 22)
		
		local boxW = 120
		local boxH = 22
		local boxX = x + w - boxW - 12
		local boxY = y + 7
		local isFocused = (FocusedInput == el)
		local boxHovered = inBounds(boxX, boxY, boxW, boxH)
		
		rect("inp.bx" .. idx, boxX, boxY, boxW, boxH, Theme.InputBackground, 1, 22, 4)
		outline("inp.bxbd" .. idx, boxX, boxY, boxW, boxH, isFocused and Theme.SliderStroke or Theme.InputStroke, 0.5, 23, 4)
		
		local dispStr = el.value
		local isPlaceholder = (dispStr == "")
		if isPlaceholder then dispStr = el.placeholder or "" end
		local dispCol = isPlaceholder and Theme.PlaceholderColor or Theme.TextColor
		text("inp.disp" .. idx, dispStr, boxX + 6, boxY + 4, 12, dispCol, 24)
		
		if clickOk and boxHovered then
			FocusedInput = el
		elseif clickOk and not boxHovered and isFocused then
			FocusedInput = nil
			if el.flag then Library.Flags[el.flag] = el.value; saveConfig() end
			task.spawn(el.callback, el.value)
		end
	elseif el.type == "Dropdown" then
		local hovered = inBounds(x, y, w, h)
		local bgCol = hovered and Theme.ElementBackgroundHover or Theme.ElementBackground
		rect("drp.bg" .. idx, x, y, w, h, bgCol, 0.9, 20, 6)
		outline("drp.bd" .. idx, x, y, w, h, Theme.ElementStroke, 0.4, 21, 6)
		text("drp.t" .. idx, el.name, x + 12, y + 11, 13, Theme.TextColor, 22)
		
		local boxW = 120
		local boxH = 22
		local boxX = x + w - boxW - 12
		local boxY = y + 7
		local boxHovered = inBounds(boxX, boxY, boxW, boxH)
		
		rect("drp.bx" .. idx, boxX, boxY, boxW, boxH, Theme.InputBackground, 1, 22, 4)
		outline("drp.bxbd" .. idx, boxX, boxY, boxW, boxH, Theme.InputStroke, 0.5, 23, 4)
		text("drp.arrow" .. idx, "v", boxX + boxW - 14, boxY + 6, 8, Theme.TextColor, 24)
		
		local displayVal = tostring(el.value)
		if #displayVal > 15 then displayVal = displayVal:sub(1, 12) .. "..." end
		text("drp.disp" .. idx, displayVal, boxX + 6, boxY + 4, 12, Theme.TextColor, 24)
		
		if clickOk and boxHovered then
			if State.Overlay and State.Overlay.element == el then
				State.Overlay = nil
			else
				local overH = math.min(#el.options * 24 + 8, 150)
				State.Overlay = {
					type = "Dropdown",
					element = el,
					idx = idx,
					x = boxX,
					y = boxY + boxH + 2,
					w = boxW,
					h = overH,
				}
			end
		end
	elseif el.type == "Keybind" then
		local hovered = inBounds(x, y, w, h)
		local bgCol = hovered and Theme.ElementBackgroundHover or Theme.ElementBackground
		rect("kb.bg" .. idx, x, y, w, h, bgCol, 0.9, 20, 6)
		outline("kb.bd" .. idx, x, y, w, h, Theme.ElementStroke, 0.4, 21, 6)
		text("kb.t" .. idx, el.name, x + 12, y + 11, 13, Theme.TextColor, 22)
		
		local boxW = 60
		local boxH = 22
		local boxX = x + w - boxW - 12
		local boxY = y + 7
		local boxHovered = inBounds(boxX, boxY, boxW, boxH)
		
		rect("kb.bx" .. idx, boxX, boxY, boxW, boxH, Theme.InputBackground, 1, 22, 4)
		outline("kb.bxbd" .. idx, boxX, boxY, boxW, boxH, el.binding and Theme.SliderStroke or Theme.InputStroke, 0.5, 23, 4)
		
		local bindStr = el.binding and "..." or (el.value or "None")
		text("kb.disp" .. idx, bindStr, boxX + boxW / 2, boxY + 4, 12, Theme.TextColor, 24, true)
		
		if clickOk and boxHovered then
			el.binding = true
		end
		
		if el.binding then
			for vk = 0x01, 0xFF do
				if vk ~= 0x01 and vk ~= 0x02 and keyEdge(vk) then
					el.binding = false
					local name = getVKName(vk)
					el.value = name
					if el.flag then Library.Flags[el.flag] = el.value; saveConfig() end
					task.spawn(el.callback, name)
					break
				end
			end
		end
	elseif el.type == "ColorPicker" then
		local hovered = inBounds(x, y, w, h)
		local bgCol = hovered and Theme.ElementBackgroundHover or Theme.ElementBackground
		rect("cp.bg" .. idx, x, y, w, h, bgCol, 0.9, 20, 6)
		outline("cp.bd" .. idx, x, y, w, h, Theme.ElementStroke, 0.4, 21, 6)
		text("cp.t" .. idx, el.name, x + 12, y + 11, 13, Theme.TextColor, 22)
		
		local boxW = 32
		local boxH = 18
		local boxX = x + w - boxW - 12
		local boxY = y + 9
		local boxHovered = inBounds(boxX, boxY, boxW, boxH)
		
		rect("cp.bx" .. idx, boxX, boxY, boxW, boxH, el.value, 1, 22, 3)
		outline("cp.bxbd" .. idx, boxX, boxY, boxW, boxH, Theme.ElementStroke, 0.5, 23, 3)
		
		if clickOk and boxHovered then
			if State.Overlay and State.Overlay.element == el then
				State.Overlay = nil
			else
				State.Overlay = {
					type = "ColorPicker",
					element = el,
					idx = idx,
					x = boxX - 100,
					y = boxY + boxH + 2,
					w = 132,
					h = 92,
				}
			end
		end
	end
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
	rect("ld.bg", x, y, w, h, Theme.Background, a * 0.98, 200, 8)
	outline("ld.bd", x, y, w, h, Theme.ElementStroke, a * 0.4, 201, 8)
	
	-- Titles
	text("ld.t", Loader.Title, x + w / 2, y + 55, 20, Theme.TextColor, 202, true, a)
	text("ld.st", Loader.Subtitle, x + w / 2, y + 85, 12, Color3.fromRGB(150, 150, 150), 202, true, a)
	
	-- Progress Bar
	local pbx, pby, pbw, pbh = x + 35, y + 130, 250, 5
	rect("ld.pbbg", pbx, pby, pbw, pbh, Color3.fromRGB(45, 45, 45), a * 0.5, 202, 2)
	rect("ld.pbfil", pbx, pby, math.floor(pbw * Loader.Progress.v), pbh, Theme.SliderProgress, a, 203, 2)
end

-- Render open Dropdown or Colorpicker Overlay lists
local function renderOverlay()
	if not State.Overlay then return end
	local ov = State.Overlay
	local clickOk = Input.clicked and not InputProcessed
	
	if ov.type == "Dropdown" then
		local el = ov.element
		rect("ov.bg", ov.x, ov.y, ov.w, ov.h, Theme.NotificationBackground, 0.98, 50, 4)
		outline("ov.bd", ov.x, ov.y, ov.w, ov.h, Theme.ElementStroke, 0.5, 51, 4)
		
		local optY = ov.y + 4
		for oidx, opt in ipairs(el.options) do
			if optY + 20 > ov.y + ov.h then break end
			local optHover = inBounds(ov.x, optY, ov.w, 22)
			local optSel = (el.value == opt)
			
			if optSel then
				rect("ov.optbg" .. oidx, ov.x + 4, optY, ov.w - 8, 20, Theme.DropdownSelected, 0.9, 52, 4)
			elseif optHover then
				rect("ov.optbg" .. oidx, ov.x + 4, optY, ov.w - 8, 20, Theme.ElementBackgroundHover, 0.5, 52, 4)
			end
			
			text("ov.opttx" .. oidx, tostring(opt), ov.x + 10, optY + 3, 11, Theme.TextColor, 53)
			
			if optHover and clickOk then
				el.value = opt
				if el.flag then Library.Flags[el.flag] = el.value; saveConfig() end
				task.spawn(el.callback, el.value)
				State.Overlay = nil
				InputProcessed = true
				break
			end
			optY = optY + 24
		end
	elseif ov.type == "ColorPicker" then
		local el = ov.element
		rect("ov.bg", ov.x, ov.y, ov.w, ov.h, Theme.NotificationBackground, 0.98, 50, 4)
		outline("ov.bd", ov.x, ov.y, ov.w, ov.h, Theme.ElementStroke, 0.5, 51, 4)
		
		local h, s, v = Color3.toHSV(el.value)
		local sy = ov.y + 6
		
		local function drawColorSlider(id, label, val, maxVal, displayVal)
			text("ov.l_" .. id, label, ov.x + 8, sy, 10, Theme.TextColor, 52)
			text("ov.v_" .. id, displayVal, ov.x + ov.w - 20, sy, 10, Theme.SliderProgress, 52)
			
			local trackX = ov.x + 8
			local trackY = sy + 14
			local trackW = ov.w - 16
			local trackH = 4
			
			rect("ov.tr_" .. id, trackX, trackY, trackW, trackH, Color3.fromRGB(40, 40, 40), 1, 52, 2)
			
			local fillW = math.floor(trackW * (val / maxVal))
			rect("ov.fi_" .. id, trackX, trackY, fillW, trackH, Theme.SliderProgress, 1, 53, 2)
			circle("ov.kb_" .. id, trackX + fillW, trackY + 2, 3, Color3.new(1, 1, 1), 1, 54)
			
			local hover = inBounds(trackX - 5, trackY - 5, trackW + 10, trackH + 10)
			if Input.down and (hover or ov["dragging_" .. id]) and not InputProcessed then
				ov["dragging_" .. id] = true
				local pct = clamp((Input.mx - trackX) / trackW, 0, 1)
				return pct * maxVal
			end
			if not Input.down then
				ov["dragging_" .. id] = nil
			end
			return val
		end
		
		local newH = drawColorSlider("h", "H", h * 360, 360, string.format("%d", h * 360))
		sy = sy + 24
		local newS = drawColorSlider("s", "S", s * 100, 100, string.format("%d%%", s * 100))
		sy = sy + 24
		local newV = drawColorSlider("v", "V", v * 100, 100, string.format("%d%%", v * 100))
		
		local updatedColor = Color3.fromHSV(newH / 360, newS / 100, newV / 100)
		if updatedColor.R ~= el.value.R or updatedColor.G ~= el.value.G or updatedColor.B ~= el.value.B then
			el.value = updatedColor
			if el.flag then Library.Flags[el.flag] = el.value; saveConfig() end
			task.spawn(el.callback, el.value)
		end
	end
end

-- Render the Main Rayfield Window Frame and Tabs
local function renderWindow(dt)
	local win = State.Win
	local topBarH = 40
	local sideBarW = 140
	local clickOk = Input.clicked and not InputProcessed
	
	handleDragging()
	
	-- Base Windows Background
	rect("win.bg", win.x, win.y, win.w, win.h, Theme.Background, 0.98, 10, 8)
	outline("win.bd", win.x, win.y, win.w, win.h, Theme.ElementStroke, 0.35, 11, 8)
	
	-- Draw sidebar background cover
	rect("win.sbcov", win.x + 1, win.y + topBarH + 1, sideBarW - 1, win.h - topBarH - 2, Theme.Background, 0.98, 24, 0)
	
	-- Draw Topbar cover panel
	rect("win.tbcov", win.x + 1, win.y + 1, win.w - 2, topBarH - 1, Theme.Topbar, 0.98, 25, 0)
	
	-- Draw Bottom cover panel (scrolled elements occlusion)
	rect("win.bbcov", win.x + 1, win.y + win.h - 10, win.w - 2, 9, Theme.Background, 0.98, 25, 0)
	
	-- Topbar separator
	line("win.tbl", win.x, win.y + topBarH, win.x + win.w, win.y + topBarH, Theme.SecondaryElementStroke, 0.5, 26)
	
	-- Sidebar right separator
	line("win.sbl", win.x + sideBarW, win.y + topBarH, win.x + sideBarW, win.y + win.h, Theme.SecondaryElementStroke, 0.5, 26)
	
	-- Window Title
	text("win.t", Loader.Title, win.x + 15, win.y + 12, 14, Theme.TextColor, 27, false)
	
	-- Topbar Action Buttons (Close and Minimize)
	local closeX = win.x + win.w - 30
	local closeY = win.y + 13
	local closeHov = inBounds(closeX, closeY, 15, 15)
	text("win.close", "x", closeX, closeY, 13, closeHov and Color3.fromRGB(255, 80, 80) or Theme.TextColor, 27)
	if closeHov and clickOk then
		Library:Destroy()
		InputProcessed = true
		return
	end
	
	local minX = win.x + win.w - 55
	local minY = win.y + 11
	local minHov = inBounds(minX, minY, 15, 15)
	text("win.min", "-", minX, minY, 15, minHov and Theme.SliderStroke or Theme.TextColor, 27)
	if minHov and clickOk then
		State.Minimized = true
		InputProcessed = true
	end
	
	-- Draw Tabs Sidebar
	local tabY0 = win.y + topBarH + 12
	for i, tabObj in ipairs(Tabs) do
		local ty = tabY0 + (i - 1) * 36
		local active = (State.ActiveTab == i)
		local tHover = inBounds(win.x + 10, ty, sideBarW - 20, 28)
		
		-- Tab highlight background
		if active then
			rect("tab.bg" .. i, win.x + 10, ty, sideBarW - 20, 28, Theme.TabBackgroundSelected, 0.9, 27, 6)
			outline("tab.bd" .. i, win.x + 10, ty, sideBarW - 20, 28, Theme.TabStroke, 0.2, 28, 6)
		elseif tHover then
			rect("tab.bg" .. i, win.x + 10, ty, sideBarW - 20, 28, Theme.ElementBackgroundHover, 0.15, 27, 6)
		end
		
		-- Tab Text
		text("tab.tx" .. i, tabObj.name, win.x + 20, ty + 7, 13, active and Theme.SelectedTabTextColor or Theme.TabTextColor, 29, false, 1, not active)
		
		if tHover and clickOk then
			State.ActiveTab = i
			InputProcessed = true
		end
	end
	
	-- Draw Active Tab Content (Scrollbar Layout)
	local activeTabObj = Tabs[State.ActiveTab]
	if activeTabObj then
		local contentX = win.x + sideBarW + 10
		local contentY = win.y + topBarH + 10
		local contentW = win.w - sideBarW - 20
		local contentH = win.h - topBarH - 20
		
		-- Clear drawings for inactive tabs
		for tIdx, tabObj in ipairs(Tabs) do
			if tIdx ~= State.ActiveTab then
				for elIdx, el in ipairs(tabObj.elements) do
					hideElementDrawings(el, elIdx)
				end
			end
		end
		
		-- Calculate total height
		local totalHeight = 0
		local spacing = 8
		for _, el in ipairs(activeTabObj.elements) do
			totalHeight = totalHeight + getElementHeight(el) + spacing
		end
		if totalHeight > 0 then totalHeight = totalHeight - spacing end
		
		local maxScroll = math.max(0, totalHeight - contentH)
		activeTabObj.scrollOffset = activeTabObj.scrollOffset or 0
		activeTabObj.scrollSpring = activeTabObj.scrollSpring or newSpring(0, 16)
		activeTabObj.scrollSpring.goal = activeTabObj.scrollOffset
		springStep(activeTabObj.scrollSpring, dt)
		
		local currentScroll = activeTabObj.scrollSpring.v
		
		-- Draw elements
		local elW = contentW - 14
		local currentY = contentY - currentScroll
		for idx, el in ipairs(activeTabObj.elements) do
			local elH = getElementHeight(el)
			
			local visible = (currentY + elH >= contentY) and (currentY <= contentY + contentH)
			if visible then
				renderElement(el, contentX, currentY, elW, elH, idx, dt)
			else
				hideElementDrawings(el, idx)
			end
			
			currentY = currentY + elH + spacing
		end
		
		-- Draw Scrollbar track & thumb
		if totalHeight > contentH then
			local sbX = win.x + win.w - 10
			local sbY = contentY
			local sbW = 4
			local sbH = contentH
			
			rect("sb.tr", sbX, sbY, sbW, sbH, Color3.fromRGB(35, 35, 35), 0.5, 24, 2)
			
			local thumbH = math.max(20, math.floor(sbH * (sbH / totalHeight)))
			local thumbY = sbY + (activeTabObj.scrollOffset / maxScroll) * (sbH - thumbH)
			
			local thumbHover = inBounds(sbX - 4, thumbY, sbW + 8, thumbH)
			if Input.down and (thumbHover or State.Scrolling) and not InputProcessed then
				if Input.clicked then State.Scrolling = true end
			end
			if not Input.down then State.Scrolling = false end
			
			if State.Scrolling then
				local relY = Input.my - sbY - thumbH / 2
				local pct = clamp(relY / (sbH - thumbH), 0, 1)
				activeTabObj.scrollOffset = pct * maxScroll
				activeTabObj.scrollSpring.v = activeTabObj.scrollOffset
			end
			
			rect("sb.th", sbX, thumbY, sbW, thumbH, Theme.SliderProgress, 0.9, 25, 2)
		else
			-- Hide scrollbar drawings
			local sbC = Cache["sb.tr"]
			if sbC then sbC.Obj.Visible = false; sbC.P.Visible = false end
			local sbTh = Cache["sb.th"]
			if sbTh then sbTh.Obj.Visible = false; sbTh.P.Visible = false end
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
	if hovered and Input.clicked and not InputProcessed then
		State.Minimized = false
		InputProcessed = true
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
			if not n.dying and Input.clicked and inBounds(cx - 4, cy - 2, 16, 16) and not InputProcessed then
				n.dying = true
				n.diedAt = now
				n.slide.goal = 1
				n.alpha.goal = 0
				InputProcessed = true
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

-- Global input captures
UserInputService.InputChanged:Connect(function(input, gp)
	if input.UserInputType == Enum.UserInputType.MouseWheel then
		local activeTabObj = Tabs[State.ActiveTab]
		if activeTabObj then
			local contentX = State.Win.x + 140 + 10
			local contentY = State.Win.y + 40 + 10
			local contentW = State.Win.w - 140 - 20
			local contentH = State.Win.h - 40 - 20
			
			if inBounds(contentX, contentY, contentW, contentH) then
				local totalHeight = 0
				local spacing = 8
				for _, el in ipairs(activeTabObj.elements) do
					totalHeight = totalHeight + getElementHeight(el) + spacing
				end
				if totalHeight > 0 then totalHeight = totalHeight - spacing end
				local maxScroll = math.max(0, totalHeight - contentH)
				
				local delta = input.Position.Z
				activeTabObj.scrollOffset = clamp(activeTabObj.scrollOffset - delta * 24, 0, maxScroll)
			end
		end
	end
end)

UserInputService.InputBegan:Connect(function(input, gp)
	if not FocusedInput then return end
	if input.UserInputType == Enum.UserInputType.Keyboard then
		local kc = input.KeyCode
		if kc == Enum.KeyCode.Return then
			FocusedInput.callback(FocusedInput.value)
			FocusedInput = nil
		elseif kc == Enum.KeyCode.Backspace then
			FocusedInput.value = string.sub(FocusedInput.value, 1, -2)
			task.spawn(FocusedInput.callback, FocusedInput.value)
		elseif kc == Enum.KeyCode.Space then
			FocusedInput.value = FocusedInput.value .. " "
			task.spawn(FocusedInput.callback, FocusedInput.value)
		else
			local char = KeyMap[kc]
			if char then
				local shift = iskeypressed(0x10) or iskeypressed(0xA0) or iskeypressed(0xA1)
				if shift then
					char = ShiftMap[char] or char
				end
				FocusedInput.value = FocusedInput.value .. char
				task.spawn(FocusedInput.callback, FocusedInput.value)
			end
		end
	end
end)

-- The core frame-by-frame loop step
local function step()
	if not isrbxactive() then return end
	CurTick = CurTick + 1
	InputProcessed = false
	
	local now = tick()
	local dt = State.LastTime and (now - State.LastTime) or 0.016
	if dt > 0.1 then dt = 0.1 elseif dt < 0 then dt = 0.016 end
	State.LastTime = now
	
	pollInput()
	
	-- Close overlay if clicked outside
	if State.Overlay and Input.clicked then
		local ov = State.Overlay
		if not inBounds(ov.x, ov.y, ov.w, ov.h) then
			State.Overlay = nil
			InputProcessed = true
		else
			InputProcessed = true
		end
	end
	
	local clicks = {}
	local function ck(vk)
		local c = clicks[vk]
		if c == nil then c = keyEdge(vk); clicks[vk] = c end
		return c
	end
	
	-- Toggle visibility key
	if ck(State.ToggleKey) then
		State.Minimized = not State.Minimized
	end
	
	if #Notifs > 0 or Loader.Active then
		State.Vw, State.Vh = getViewportSize()
	end
	
	if Loader.Active then
		renderLoader(dt)
	elseif State.Minimized then
		renderMinimizedBubble()
	else
		renderWindow(dt)
		renderOverlay()
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

	Settings = Settings or {}
	Loader.Title = Settings.Name or "Rayfield"
	Loader.Subtitle = Settings.LoadingSubtitle or "Interface Suite"
	Loader.Born = tick()
	Loader.Progress.v = 0
	Loader.Progress.goal = 0
	Loader.Alpha.v = 1
	Loader.Alpha.goal = 1
	Loader.Active = true
	
	-- Setup config mapping
	if Settings.ConfigurationSaving and Settings.ConfigurationSaving.Enabled then
		currentConfig.Enabled = true
		currentConfig.Folder = Settings.ConfigurationSaving.FolderName or "Rayfield"
		currentConfig.File = Settings.ConfigurationSaving.FileName or "config"
		loadConfig()
	end
	
	-- Setup config theme
	if Settings.Theme then
		local newTheme = Library.Theme[Settings.Theme]
		if newTheme then
			Theme = newTheme
		end
	end
	
	if Settings.ToggleUIKeybind then
		if type(Settings.ToggleUIKeybind) == "string" then
			local name = Settings.ToggleUIKeybind:upper()
			local vk = getVKFromName(name)
			if vk then
				State.ToggleKey = vk
			end
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
			scrollOffset = 0,
		}
		table.insert(Tabs, tabObj)
		
		-- SECTION CONSTRUCTOR
		function tabObj:CreateSection(secName)
			local el = { type = "Section", name = secName or "Section" }
			table.insert(tabObj.elements, el)
			return el
		end
		
		-- DIVIDER CONSTRUCTOR
		function tabObj:CreateDivider()
			local el = { type = "Divider" }
			table.insert(tabObj.elements, el)
			return el
		end
		
		-- LABEL CONSTRUCTOR
		function tabObj:CreateLabel(lblText)
			local el = { type = "Label", name = lblText or "Label" }
			table.insert(tabObj.elements, el)
			return el
		end
		
		-- PARAGRAPH CONSTRUCTOR
		function tabObj:CreateParagraph(cfg)
			cfg = cfg or {}
			local lines = {}
			for ln in (tostring(cfg.Content or "") .. "\n"):gmatch("(.-)\n") do
				table.insert(lines, ln)
			end
			if #lines > 0 and lines[#lines] == "" then table.remove(lines) end
			
			local el = {
				type = "Paragraph",
				name = cfg.Title or "Paragraph",
				content = cfg.Content or "",
				lines = lines,
			}
			table.insert(tabObj.elements, el)
			return el
		end
		
		-- BUTTON CONSTRUCTOR
		function tabObj:CreateButton(cfg)
			cfg = cfg or {}
			local el = {
				type = "Button",
				name = cfg.Name or "Button",
				callback = cfg.Callback or function() end,
			}
			table.insert(tabObj.elements, el)
			
			local buttonObj = {}
			function buttonObj:Set(newName)
				el.name = newName
			end
			return buttonObj
		end
		
		-- TOGGLE CONSTRUCTOR
		function tabObj:CreateToggle(cfg)
			cfg = cfg or {}
			local Flag = cfg.Flag
			local defaultVal = cfg.CurrentValue or false
			if Flag and Library.Flags[Flag] ~= nil then
				defaultVal = Library.Flags[Flag]
			elseif Flag then
				Library.Flags[Flag] = defaultVal
			end
			
			local el = {
				type = "Toggle",
				name = cfg.Name or "Toggle",
				value = defaultVal,
				callback = cfg.Callback or function() end,
				flag = Flag,
			}
			table.insert(tabObj.elements, el)
			
			local toggleObj = {}
			function toggleObj:Set(newVal)
				el.value = not not newVal
				if Flag then Library.Flags[Flag] = el.value; saveConfig() end
				task.spawn(el.callback, el.value)
			end
			function toggleObj:Get()
				return el.value
			end
			return toggleObj
		end
		
		-- SLIDER CONSTRUCTOR
		function tabObj:CreateSlider(cfg)
			cfg = cfg or {}
			local range = cfg.Range or { 0, 100 }
			local min = range[1] or 0
			local max = range[2] or 100
			local Flag = cfg.Flag
			local defaultVal = cfg.CurrentValue or min
			if Flag and Library.Flags[Flag] ~= nil then
				defaultVal = Library.Flags[Flag]
			elseif Flag then
				Library.Flags[Flag] = defaultVal
			end
			
			local el = {
				type = "Slider",
				name = cfg.Name or "Slider",
				min = min,
				max = max,
				increment = cfg.Increment or 1,
				suffix = cfg.Suffix or "",
				value = defaultVal,
				callback = cfg.Callback or function() end,
				flag = Flag,
				dragging = false,
			}
			table.insert(tabObj.elements, el)
			
			local sliderObj = {}
			function sliderObj:Set(newVal)
				newVal = clamp(newVal, min, max)
				el.value = newVal
				if Flag then Library.Flags[Flag] = el.value; saveConfig() end
				task.spawn(el.callback, el.value)
			end
			function sliderObj:Get()
				return el.value
			end
			return sliderObj
		end
		
		-- INPUT CONSTRUCTOR
		function tabObj:CreateInput(cfg)
			cfg = cfg or {}
			local Flag = cfg.Flag
			local defaultVal = cfg.CurrentValue or ""
			if Flag and Library.Flags[Flag] ~= nil then
				defaultVal = Library.Flags[Flag]
			elseif Flag then
				Library.Flags[Flag] = defaultVal
			end
			
			local el = {
				type = "Input",
				name = cfg.Name or "Input",
				placeholder = cfg.PlaceholderText or "Type here...",
				value = defaultVal,
				callback = cfg.Callback or function() end,
				flag = Flag,
			}
			table.insert(tabObj.elements, el)
			
			local inputObj = {}
			function inputObj:Set(newVal)
				el.value = tostring(newVal)
				if Flag then Library.Flags[Flag] = el.value; saveConfig() end
				task.spawn(el.callback, el.value)
			end
			function inputObj:Get()
				return el.value
			end
			return inputObj
		end
		
		-- DROPDOWN CONSTRUCTOR
		function tabObj:CreateDropdown(cfg)
			cfg = cfg or {}
			local options = cfg.Options or {}
			local Flag = cfg.Flag
			local defaultVal = cfg.CurrentOption or options[1] or ""
			if Flag and Library.Flags[Flag] ~= nil then
				defaultVal = Library.Flags[Flag]
			elseif Flag then
				Library.Flags[Flag] = defaultVal
			end
			
			local el = {
				type = "Dropdown",
				name = cfg.Name or "Dropdown",
				options = options,
				value = defaultVal,
				callback = cfg.Callback or function() end,
				flag = Flag,
			}
			table.insert(tabObj.elements, el)
			
			local dropdownObj = {}
			function dropdownObj:Set(newVal)
				el.value = newVal
				if Flag then Library.Flags[Flag] = el.value; saveConfig() end
				task.spawn(el.callback, el.value)
			end
			function dropdownObj:Refresh(newOptions, newVal)
				el.options = newOptions or {}
				if newVal then
					el.value = newVal
				else
					el.value = el.options[1] or ""
				end
				if Flag then Library.Flags[Flag] = el.value; saveConfig() end
				task.spawn(el.callback, el.value)
			end
			function dropdownObj:Get()
				return el.value
			end
			return dropdownObj
		end
		
		-- KEYBIND CONSTRUCTOR
		function tabObj:CreateKeybind(cfg)
			cfg = cfg or {}
			local Flag = cfg.Flag
			local defaultVal = cfg.CurrentKeybind or "None"
			if Flag and Library.Flags[Flag] ~= nil then
				defaultVal = Library.Flags[Flag]
			elseif Flag then
				Library.Flags[Flag] = defaultVal
			end
			
			local el = {
				type = "Keybind",
				name = cfg.Name or "Keybind",
				value = defaultVal,
				callback = cfg.Callback or function() end,
				flag = Flag,
				binding = false,
			}
			table.insert(tabObj.elements, el)
			
			local keybindObj = {}
			function keybindObj:Set(newVal)
				el.value = tostring(newVal)
				if Flag then Library.Flags[Flag] = el.value; saveConfig() end
				task.spawn(el.callback, el.value)
			end
			function keybindObj:GetState()
				if not el.value or el.value == "None" then return false end
				local vk = getVKFromName(el.value)
				if not vk then return false end
				return iskeypressed(vk)
			end
			return keybindObj
		end
		
		-- COLORPICKER CONSTRUCTOR
		function tabObj:CreateColorPicker(cfg)
			cfg = cfg or {}
			local Flag = cfg.Flag
			local defaultVal = cfg.Color or Color3.fromRGB(255, 255, 255)
			if Flag and Library.Flags[Flag] ~= nil then
				defaultVal = Library.Flags[Flag]
			elseif Flag then
				Library.Flags[Flag] = defaultVal
			end
			
			local el = {
				type = "ColorPicker",
				name = cfg.Name or "Color Picker",
				value = defaultVal,
				callback = cfg.Callback or function() end,
				flag = Flag,
			}
			table.insert(tabObj.elements, el)
			
			local colorpickerObj = {}
			function colorpickerObj:Set(newVal)
				if typeof(newVal) == "Color3" then
					el.value = newVal
					if Flag then Library.Flags[Flag] = el.value; saveConfig() end
					task.spawn(el.callback, el.value)
				end
			end
			function colorpickerObj:Get()
				return el.value
			end
			return colorpickerObj
		end
		
		return tabObj
	end
	
	return Window
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

-- Set Visibility (compat for Rayfield API)
function Library:SetVisibility(visible)
	State.Minimized = not visible
end

-- Is Visible (compat for Rayfield API)
function Library:IsVisible()
	return not State.Minimized
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
