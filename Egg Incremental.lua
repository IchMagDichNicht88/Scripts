local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "Fentanyl",
    Footer = "Egg Incremental",
	Icon = 135320221397534,
    ToggleKeybind = Enum.KeyCode.LeftControl,
    Center = true,
    AutoShow = true,
    ShowCustomCursor = false
})

local MainTab = Window:AddTab("Main", "globe") -- Second parameter is the icon name (optional)
local LeftGroupbox = MainTab:AddLeftGroupbox("Eggs")
local RightGroupbox = MainTab:AddRightGroupbox("Upgrades")

local Button = LeftGroupbox:AddButton({
    Text = "Collect All Eggs",
    Func = function()
    local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local eggsFolder = game:GetService("Workspace"):WaitForChild("Eggs")

-- Alle BaseParts in Eggs sammeln (unabhängig vom Namen)
local targets = {}
for _, child in pairs(eggsFolder:GetChildren()) do
	if child:IsA("BasePart") then
		table.insert(targets, child)
	end
end

task.spawn(function()
	for _, part in ipairs(targets) do
		hrp.CFrame = part.CFrame -- genau auf den Part teleportieren
		task.wait(0.01) -- sofort zum nächsten Part
	end
end)
    end,
    DoubleClick = false -- Requires double-click for risky actions
})


local HitBoxInv = false

local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "HitBox Invisible ?",
    Default = false,
    Tooltip = "Turn On/Off Hitbox Invisible",
    Callback = function(Value)
    if Value then
    HitBoxInv = true
    else
    HitBoxInv = false
    end
    end
})

local HitBoxSize = 3

local Slider = LeftGroupbox:AddSlider("MySlider", {
    Text = "Egg Collect HitBox Extender",
    Default = 3,
    Min = 3,
    Max = 250,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
    HitBoxSize = Value
    end
})

local Button = RightGroupbox:AddButton({
    Text = "Upgrade All",
    Func = function()
    for i = 1, 100 do
    task.spawn(function()
        local upgradeName = "Egg Upgrade " .. i
        game:GetService("ReplicatedStorage").Events.Upgrade:FireServer(upgradeName)
    end)
    end
    end,
    DoubleClick = False -- Requires double-click for risky actions
})

local autoupgrade = false

local MyToggle = RightGroupbox:AddToggle("MyToggle", {
    Text = "Auto Upgrade All",
    Default = false,
    Tooltip = "Turn On/Off Auto Upgrade All",
    Callback = function(Value)
    if Value then
    autoupgrade = true
    else
    autoupgrade = false
    end
    end
})

local MainTab = Window:AddTab("Egg", "egg") -- Second parameter is the icon name (optional)
local LeftGroupbox = MainTab:AddLeftGroupbox("Hatch")


local Dropdown = LeftGroupbox:AddDropdown("MyDropdown", {
    Values = {"Standard Egg", "Tech Egg", "Muscle Egg"},
    Default = 0, -- Index of the default option
    Multi = false, -- Whether to allow multiple selections
    Text = "What Egg To Hatch ?",
    Tooltip = "Select What Egg To Hatch",
    Callback = function(Value)
    selectedegg = Value
    local ohString1 = Value
    local ohTable2 = {}
    game:GetService("ReplicatedStorage").Events.BuyEgg:InvokeServer(ohString1, ohTable2)
    end
})



local MainTab = Window:AddTab("Player", "person-standing") -- Second parameter is the icon name (optional)
local LeftGroupbox = MainTab:AddLeftGroupbox("Walk Speed")

local Button = LeftGroupbox:AddButton({
    Text = "Reset Walk Speed",
    Func = function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end,
    DoubleClick = false -- Requires double-click for risky actions
})

local Input = LeftGroupbox:AddInput("MyInput", {
    Text = "Walk Speed",
    Default = "16",
    Numeric = true,
    Finished = true, -- Only calls callback when you press enter
    Placeholder = "Enter text here...",
    Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

local MainTab = Window:AddTab("Info", "info") -- Second parameter is the icon name (optional)
local LeftGroupbox = MainTab:AddLeftGroupbox("Info")
local RightGroupbox = MainTab:AddRightGroupbox("Info")
local Label = RightGroupbox:AddLabel("Discord: Xhynii")
local Label = RightGroupbox:AddLabel("Its Not The Best Bc I am")
local Label = RightGroupbox:AddLabel("New To Creating Scripts")
local Label = LeftGroupbox:AddLabel("Open/Close With Left Control")

local MainTab = Window:AddTab("Setting", "settings") -- Second parameter is the icon name (optional)
local LeftGroupbox = MainTab:AddLeftGroupbox("Setting")

local Dropdown = LeftGroupbox:AddDropdown("MyDropdown", {
    Values = {"50", "75", "100", "125", "150"},
    Default = 3, -- Index of the default option
    Multi = false, -- Whether to allow multiple selections
    Text = "Change Dpi",
    Tooltip = "What Dpi ?",
    Callback = function(scale)
    Library:SetDPIScale(scale)
    end
})

local Button = LeftGroupbox:AddButton({
    Text = "Unload Menu",
    Func = function()
    Library:Notify("Unloading", 0.5, soundId)
    wait(0.7)
    Library:Unload()
    end,
    DoubleClick = false -- Requires double-click for risky actions
})

while wait(0.15) do
if autoupgrade == true then
    for i = 1, 100 do
    task.spawn(function()
        local upgradeName = "Egg Upgrade " .. i
        game:GetService("ReplicatedStorage").Events.Upgrade:FireServer(upgradeName)
    end)
    end
    else
    end
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hitbox = character:WaitForChild("Default")
    hitbox.Size = Vector3.new(HitBoxSize, HitBoxSize, HitBoxSize)
    if HitBoxInv == false then
    hitbox.Transparency = 0.5
    else
    hitbox.Transparency = 1
    end
    hitbox.CanCollide = false
end
