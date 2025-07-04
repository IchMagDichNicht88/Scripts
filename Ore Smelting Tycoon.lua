local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

setclipboard("https://discord.gg/FentanylHub")
Library:Notify("discord invite copied", 1.5, soundId)

if Library.IsMobile then
Library:SetDPIScale(65)
end

local Window = Library:CreateWindow({
    Title = "FentaWare",
    Footer = "Ore Smelting Tycoon",
	Icon = 121061267334054,
    ToggleKeybind = Enum.KeyCode.RightControl,
    Size = UDim2.fromOffset(725, 450),
    Center = true,
    AutoShow = true,
    ShowCustomCursor = false,
    MobileButtonsSide = "Left"
})

local MainTab = Window:AddTab("Main", "globe")

local LeftGroupbox = MainTab:AddLeftGroupbox("Ore", "circle-small")

local Label = LeftGroupbox:AddLabel("Equip Pick Ores")

local Button = LeftGroupbox:AddButton({
    Text = "Get Ore",
    Func = function()
local player = game.Players.LocalPlayer
local tycoons = workspace:WaitForChild("Tycoons")

-- Tycoon des Spielers finden
local myTycoon = nil
for _, tycoon in ipairs(tycoons:GetChildren()) do
    local owner = tycoon:FindFirstChild("Owner")
    if owner and owner.Value == player then
        myTycoon = tycoon
        break
    end
end

if not myTycoon then
    warn("Kein Tycoon für Spieler " .. player.Name .. " gefunden.")
    return
end

local dropsFolder = myTycoon:WaitForChild("Drops")
local drops = dropsFolder:GetChildren()

local remoteFolder = workspace:FindFirstChild(player.Name)
if not remoteFolder then
    warn("Kein Remote-Ordner für Spieler " .. player.Name .. " gefunden.")
    return
end

local pickOres = remoteFolder:FindFirstChild("Pick Ores")
if not pickOres then
    warn("Kein 'Pick Ores' Ordner gefunden.")
    return
end

local collectRemote = pickOres:FindFirstChild("Collect")
if not collectRemote then
    warn("Kein 'Collect' RemoteEvent gefunden.")
    return
end

local repetitions = 3 -- Anzahl wie oft jeder Drop eingesammelt werden soll

for i = 1, math.min(10, #drops) do
    local args = {[1] = drops[i]}
    for _ = 1, repetitions do
        collectRemote:FireServer(unpack(args))
    end
end

    end,
    DoubleClick = false
})

local Button = LeftGroupbox:AddButton({
    Text = "Put Ores In Smelter",
    Func = function()
    local player = game.Players.LocalPlayer
local tycoons = workspace:WaitForChild("Tycoons")

for _, tycoon in ipairs(tycoons:GetChildren()) do
    local owner = tycoon:FindFirstChild("Owner")
    if owner and owner.Value == player then
        print("✅ Tycoon gefunden:", tycoon.Name)

        local smelter = tycoon:FindFirstChild("Smelter")
        if smelter then
            local smelt = smelter:FindFirstChild("Smelt")
            if smelt then
                local clickDetector = smelt:FindFirstChildOfClass("ClickDetector")
                if clickDetector then
                    fireclickdetector(clickDetector)
                    print("🟢 Smelt ClickDetector wurde gedrückt!")
                else
                    warn("❌ Kein ClickDetector im Smelt gefunden.")
                end
            else
                warn("❌ Kein Smelt-Teil im Smelter gefunden.")
            end
        else
            warn("❌ Kein Smelter im Tycoon gefunden.")
        end

        break -- Tycoon gefunden, Schleife beenden
    end
end

    end,
    DoubleClick = false
})

local MainTab = Window:AddTab("Obby", "copy")

local LeftGroupbox = MainTab:AddLeftGroupbox("Win", "flag")

local Button = LeftGroupbox:AddButton({
    Text = "Win Easy Obby",
    Func = function()
    local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local rewardPart = workspace:WaitForChild("EasyObby"):WaitForChild("Reward")

-- Teleportiere den Spieler zum Reward-Part
hrp.CFrame = rewardPart.CFrame + Vector3.new(0, 3, 0) -- leicht über dem Reward, damit du nicht steckst

    end,
    DoubleClick = false -- Requires double-click for risky actions
})

local Button = LeftGroupbox:AddButton({
    Text = "Win Hard Obby",
    Func = function()
    local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local rewardPart = workspace:WaitForChild("HardObby"):WaitForChild("Reward")

-- Teleportiere den Spieler zum Reward-Part
hrp.CFrame = rewardPart.CFrame + Vector3.new(0, 3, 0) -- leicht darüber, um nicht festzustecken

    end,
    DoubleClick = false -- Requires double-click for risky actions
})

local RightGroupbox = MainTab:AddRightGroupbox("Random", "badge-question-mark")

local Button = RightGroupbox:AddButton({
    Text = "Remove Easy Obby Kill Parts",
    Func = function()
    local easyObby = workspace:WaitForChild("EasyObby")

for _, part in ipairs(easyObby:GetDescendants()) do
    if part:IsA("BasePart") and part.Name == "Kill" then
        part:Destroy()
    end
end

    end,
    DoubleClick = false
})

local Button = RightGroupbox:AddButton({
    Text = "Remove Hard Obby Kill Parts",
    Func = function()
    local hardObby = workspace:WaitForChild("HardObby")

for _, part in ipairs(hardObby:GetDescendants()) do
    if part:IsA("BasePart") and part.Name == "Kill" then
        part:Destroy()
    end
end

    end,
    DoubleClick = false
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
local Label = LeftGroupbox:AddLabel("Open/Close With Right Control")

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
