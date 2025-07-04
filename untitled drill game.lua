local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title = "Fentanyl",
    Footer = "Game",
	Icon = 71270239105109,
    ToggleKeybind = Enum.KeyCode.LeftControl,
    Center = true,
    AutoShow = true,
    ShowCustomCursor = false
})

local MainTab = Window:AddTab("Main", "globe")
local LeftGroupbox = MainTab:AddLeftGroupbox("Main")
local RightGroupbox = MainTab:AddRightGroupbox("Hand Drill")

local Button = RightGroupbox:AddButton({
    Text = "Get Random Ore (Equip Hand Drill)",
    Func = function()
    game:GetService("ReplicatedStorage"):WaitForChild("Packages", 9e9):WaitForChild("Knit", 9e9):WaitForChild("Services", 9e9):WaitForChild("OreService", 9e9):WaitForChild("RE", 9e9):WaitForChild("RequestRandomOre", 9e9):FireServer()
    end,
    DoubleClick = false
})
local Button = LeftGroupbox:AddButton({
    Text = "Sell All",
    Func = function()
    local player = game.Players.LocalPlayer
local character = player.Character
local humanoid = character.Humanoid

-- Save the original position
local originalPos = character.HumanoidRootPart.CFrame

-- Set the teleportation location
local tpLoc = Vector3.new(-380, 94, 282.5)  -- change this to the desired location

-- Teleport to the location
character.HumanoidRootPart.CFrame = CFrame.new(tpLoc)
wait(0.5)

-- Teleport back to the original location
character.HumanoidRootPart.CFrame = originalPos
game:GetService("ReplicatedStorage"):WaitForChild("Packages", 9e9):WaitForChild("Knit", 9e9):WaitForChild("Services", 9e9):WaitForChild("OreService", 9e9):WaitForChild("RE", 9e9):WaitForChild("SellAll", 9e9):FireServer()
    end,
    DoubleClick = false -- Requires double-click for risky actions
})
local Button = LeftGroupbox:AddButton({
    Text = "Collect Storage",
    Func = function()
    local player = game.Players.LocalPlayer
    local plot = nil

    -- Dein Plot automatisch finden über Owner
    for _, p in ipairs(workspace.Plots:GetChildren()) do
        if p:FindFirstChild("Owner") and p.Owner.Value == player then
            plot = p
            break
        end
    end

    if not plot then
        warn("Dein Plot wurde nicht gefunden.")
        return
    end

    -- Referenz zu CollectDrill
    local collectDrillRemote = game:GetService("ReplicatedStorage"):WaitForChild("Packages", 9e9)
        :WaitForChild("Knit", 9e9)
        :WaitForChild("Services", 9e9)
        :WaitForChild("PlotService", 9e9)
        :WaitForChild("RE", 9e9)
        :WaitForChild("CollectDrill", 9e9)

    -- Alle gültigen Storages finden und CollectDrill feuern
    local storages = plot:WaitForChild("Storage", 9e9):GetChildren()

    for _, storage in ipairs(storages) do
        collectDrillRemote:FireServer(storage)
    end
    end,
    DoubleClick = false -- Requires double-click for risky actions
})

local MainTab = Window:AddTab("Visual", "eye") -- Second parameter is the icon name (optional)
local LeftGroupbox = MainTab:AddLeftGroupbox("Shops")
local RightGroupbox = MainTab:AddRightGroupbox("Storage")


local Button = LeftGroupbox:AddButton({
    Text = "Open/Close Buy Shop",
    Func = function()
    local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local canvasGroup = playerGui:WaitForChild("Menu"):WaitForChild("CanvasGroup")

local drill = canvasGroup:WaitForChild("HandDrills")
local crafting = canvasGroup:WaitForChild("Crafting")
local buy = canvasGroup:WaitForChild("Buy")

buy.Visible = not buy.Visible
if buy.Visible then
	drill.Visible = false
	crafting.Visible = false
end
    end,
    DoubleClick = false -- Requires double-click for risky actions
})
local Button = LeftGroupbox:AddButton({
    Text = "Open/Close Crafting",
    Func = function()
    local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local canvasGroup = playerGui:WaitForChild("Menu"):WaitForChild("CanvasGroup")

local drill = canvasGroup:WaitForChild("HandDrills")
local crafting = canvasGroup:WaitForChild("Crafting")
local buy = canvasGroup:WaitForChild("Buy")

crafting.Visible = not crafting.Visible
if crafting.Visible then
	drill.Visible = false
	buy.Visible = false
end
    end,
    DoubleClick = false -- Requires double-click for risky actions
})
local Button = LeftGroupbox:AddButton({
    Text = "Open/Close Drill Shop",
    Func = function()
    local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local canvasGroup = playerGui:WaitForChild("Menu"):WaitForChild("CanvasGroup")

local drill = canvasGroup:WaitForChild("HandDrills")
local crafting = canvasGroup:WaitForChild("Crafting")
local buy = canvasGroup:WaitForChild("Buy")

drill.Visible = not drill.Visible
if drill.Visible then
	crafting.Visible = false
	buy.Visible = false
end
    end,
    DoubleClick = false -- Requires double-click for risky actions
})
local Button = RightGroupbox:AddButton({
    Text = "Show Total Storage",
    Func = function()
    local player = game.Players.LocalPlayer
local plots = workspace.Plots:GetChildren()
local myPlot = nil

-- Finde das Plot, das dem Spieler gehört
for _, plot in ipairs(plots) do
	if plot:FindFirstChild("Owner") and plot.Owner.Value == player then
		myPlot = plot
		break
	end
end

if not myPlot then
	warn("Kein Plot gefunden, das dir gehört.")
	return
end

-- Sammle alle Ores.TotalQuantity aus allen Storage-Teilen
local ores = {}

for _, storage in ipairs(myPlot:FindFirstChild("Storage"):GetChildren()) do
	if storage:FindFirstChild("Ores") and storage.Ores:FindFirstChild("TotalQuantity") then
		table.insert(ores, storage.Ores.TotalQuantity)
	end
end

-- GUI erstellen
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "StorageDisplay"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 50)
frame.Position = UDim2.new(0.5, -125, 0.5, -25)  -- zentriert
frame.BackgroundColor3 = Color3.fromRGB(135, 206, 235)  -- Himmelblau
frame.Active = true
frame.Draggable = true

local text = Instance.new("TextLabel", frame)
text.Size = UDim2.new(0, 200, 1, 0)
text.Position = UDim2.new(0, 10, 0, 0)
text.BackgroundTransparency = 1
text.TextColor3 = Color3.new(1, 1, 1)
text.TextScaled = true
text.Font = Enum.Font.SourceSansBold

local closeButton = Instance.new("TextButton", frame)
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(1, -25, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextScaled = true

closeButton.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Funktion zum Aktualisieren des Texts
local function update()
	local total = 0
	for _, ore in ipairs(ores) do
		total += ore.Value
	end
	text.Text = "Total Storage: " .. total
end

-- Wenn sich ein Wert ändert, aktualisieren
for _, ore in ipairs(ores) do
	ore:GetPropertyChangedSignal("Value"):Connect(update)
end

update()
    end,
    DoubleClick = false -- Requires double-click for risky actions
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
    wait(0.5)
    Library:Unload()
    end,
    DoubleClick = false -- Requires double-click for risky actions
})
