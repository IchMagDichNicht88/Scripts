local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "Fentanyl",
    Footer = "Egg Factory RNG",
	Icon = 135320221397534,
    ToggleKeybind = Enum.KeyCode.LeftControl,
    Center = true,
    AutoShow = true,
    ShowCustomCursor = false
})



local MainTab = Window:AddTab("Main", "globe")
local LeftGroupbox = MainTab:AddLeftGroupbox("Main")

local Button = LeftGroupbox:AddButton({
    Text = "Collect 1 Egg",
    Func = function()
local player = game.Players.LocalPlayer
local tycoonsFolder = game:GetService("Workspace").Tycoons

-- Suche deinen Tycoon
local myTycoon = nil
for _, tycoon in ipairs(tycoonsFolder:GetChildren()) do
    local owner = tycoon:FindFirstChild("Owner")
    if owner and owner.Value == player then
        myTycoon = tycoon
        break
    end
end

-- Wenn dein Tycoon gefunden wurde, Drop sammeln
if myTycoon then
    local drop = myTycoon:WaitForChild("Drops"):GetChildren()[1] -- nimm z.B. den ersten Drop
    local args = {
        [1] = "CollectDrop",
        [2] = { drop },
    }

    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
else
    warn("Kein eigener Tycoon gefunden!")
end

    end,
    DoubleClick = false -- Requires double-click for risky actions
})

local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Auto Collect Eggs",
    Default = false,
    Tooltip = "Turn On/Off Auto Collect",
    Callback = function(Value)
    if Value then
    autocollect = true
    else
    autocollect = false
    end
    end
})

local MainTab = Window:AddTab("Info", "info") -- Second parameter is the icon name (optional)
local LeftGroupbox = MainTab:AddLeftGroupbox("Info")
local RightGroupbox = MainTab:AddRightGroupbox("Info")
local Label = RightGroupbox:AddLabel("Discord: Xhynii")
local Button = RightGroupbox:AddButton({
    Text = "Copy Discord Server Link",
    Func = function()
    setclipboard("https://discord.gg/FentanylHub")
    end,
    DoubleClick = false -- Requires double-click for risky actions
})

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

while wait(0.1) do
if autocollect == true then
local player = game.Players.LocalPlayer
local tycoonsFolder = game:GetService("Workspace").Tycoons

-- Suche deinen Tycoon
local myTycoon = nil
for _, tycoon in ipairs(tycoonsFolder:GetChildren()) do
    local owner = tycoon:FindFirstChild("Owner")
    if owner and owner.Value == player then
        myTycoon = tycoon
        break
    end
end

-- Wenn dein Tycoon gefunden wurde, Drop sammeln
if myTycoon then
    local drop = myTycoon:WaitForChild("Drops"):GetChildren()[1] -- nimm z.B. den ersten Drop
    local args = {
        [1] = "CollectDrop",
        [2] = { drop },
    }

    game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
else
    warn("Kein eigener Tycoon gefunden!")
end

else
end
end
