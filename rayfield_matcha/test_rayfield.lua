-- [[ Test script for Rayfield Matcha UI Library ]] --

-- Load the library from your workspace:
loadstring(readfile("rayfield_matcha/rayfield_matcha.lua"))()
local Rayfield = _G.Rayfield

local Window = Rayfield:CreateWindow({
	Name = "Rayfield Matcha Sandbox",
	LoadingTitle = "Matcha Sandbox",
	LoadingSubtitle = "Testing Interactive Elements",
	Theme = "Default", -- Default, Ocean, AmberGlow, Light, Amethyst, Green, Bloom, DarkBlue, Serenity
	ToggleUIKeybind = "End",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "Rayfield",
		FileName = "SandboxConfig"
	}
})

-- Create Tab elements
local ControlsTab = Window:CreateTab("Controls", "sliders-horizontal")
local InfoTab = Window:CreateTab("Information", "info")
local SettingsTab = Window:CreateTab("Settings", "settings")

-- Spawn a test notification toast
task.spawn(function()
	task.wait(2.0) -- wait for loader to complete
	Rayfield:Notify({
		Title = "Sandbox Initialized",
		Content = "All elements are ready for testing.\nPress [End] to hide/show the menu.",
		Duration = 5,
	})
end)

-- 1. Tab 1: Controls (All interactive elements)
ControlsTab:CreateSection("Primary Controls")

local testButton = ControlsTab:CreateButton({
	Name = "Print Message",
	Callback = function()
		print("[Sandbox] Button pressed! Logging message to console.")
		Rayfield:Notify({
			Title = "Action Triggered",
			Content = "Printed sandbox message to console.",
			Duration = 3,
		})
	end,
})

local testToggle = ControlsTab:CreateToggle({
	Name = "Enabled State",
	CurrentValue = false,
	Flag = "ToggleState",
	Callback = function(val)
		print("[Sandbox] Toggle value changed to: " .. tostring(val))
	end,
})

local testSlider = ControlsTab:CreateSlider({
	Name = "WalkSpeed Modifier",
	Range = {16, 150},
	Increment = 1,
	Suffix = " studs/s",
	CurrentValue = 16,
	Flag = "WalkSpeed",
	Callback = function(val)
		print("[Sandbox] Slider value changed to: " .. tostring(val))
	end,
})

ControlsTab:CreateDivider()
ControlsTab:CreateSection("Advanced Controls")

local testInput = ControlsTab:CreateInput({
	Name = "Custom Name tag",
	PlaceholderText = "Type character tag...",
	Flag = "NameTag",
	Callback = function(text)
		print("[Sandbox] Input text updated: " .. text)
	end,
})

local testDropdown = ControlsTab:CreateDropdown({
	Name = "Select Game Mode",
	Options = {"Standard Aim", "Rage Mode", "Legit Bypass", "Spectator Only"},
	CurrentOption = "Standard Aim",
	Flag = "GameMode",
	Callback = function(opt)
		print("[Sandbox] Dropdown option selected: " .. opt)
	end,
})

local testKeybind = ControlsTab:CreateKeybind({
	Name = "Panic Keybind",
	CurrentKeybind = "Q",
	Flag = "PanicKey",
	Callback = function(key)
		print("[Sandbox] Panic keybind pressed! Bound to: " .. tostring(key))
	end,
})

local testColor = ControlsTab:CreateColorPicker({
	Name = "ESP Highlight Color",
	Color = Color3.fromRGB(0, 146, 214),
	Flag = "ESPColor",
	Callback = function(col)
		print(string.format("[Sandbox] Colorpicker updated: RGB(%d, %d, %d)", col.R*255, col.G*255, col.B*255))
	end,
})


-- 2. Tab 2: Information (Static text elements)
InfoTab:CreateSection("System Info")
InfoTab:CreateLabel("Matcha Executor Version: 1.0.0")
InfoTab:CreateLabel("Compatibility Mode: Pure Drawing API")

InfoTab:CreateDivider()
InfoTab:CreateSection("Library Summary")
InfoTab:CreateParagraph({
	Title = "Why Pure Drawing API?",
	Content = "Because Matcha is an undetected external VM, it operates completely out-of-process. Traditional UI rendering like ScreenGui is not visible to external overlays. Using Drawing objects ensures universal compatibility."
})


-- 3. Tab 3: Settings
SettingsTab:CreateSection("Configuration Controls")
SettingsTab:CreateButton({
	Name = "Save Settings Manually",
	Callback = function()
		Rayfield:SaveConfig("SandboxConfig")
		print("[Sandbox] Saved config manually.")
		Rayfield:Notify({
			Title = "Config Saved",
			Content = "Saved current flag states to config.",
			Duration = 3,
		})
	end,
})

SettingsTab:CreateButton({
	Name = "Load Settings Manually",
	Callback = function()
		Rayfield:LoadConfig("SandboxConfig")
		print("[Sandbox] Loaded config manually.")
		Rayfield:Notify({
			Title = "Config Loaded",
			Content = "Reloaded flag states from config.",
			Duration = 3,
		})
	end,
})
