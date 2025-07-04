local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local lp = Players.LocalPlayer
local promptTracker = {}
local descendantConnection = nil

-- Utility Functions
local function parseMoney(moneyStr)
    if not moneyStr then return 0 end
    moneyStr = tostring(moneyStr):gsub("Г‚Вў", ""):gsub(",", ""):gsub(" ", ""):gsub("%$", "")
    local multiplier = 1
    if moneyStr:lower():find("k") then
        multiplier = 1000
        moneyStr = moneyStr:lower():gsub("k", "")
    elseif moneyStr:lower():find("m") then
        multiplier = 1000000
        moneyStr = moneyStr:lower():gsub("m", "")
    end
    return (tonumber(moneyStr) or 0) * multiplier
end

-- Get player money (replace with actual stat name)
local function getPlayerMoney()
    return parseMoney(lp:WaitForChild("leaderstats").Money.Value) -- ADJUST THIS
end

local function isInventoryFull()
    return #lp.Backpack:GetChildren() >= 200
end 

-- Auto-collect functions
local function modifyPrompt(prompt, enable)
    if enable then
        prompt.Enabled = true
        prompt.RequiresLineOfSight = false
        prompt.HoldDuration = 0
    else
        prompt.Enabled = false
    end
end

local function handleNewPrompt(desc)
    if desc:IsA("ProximityPrompt") and not promptTracker[desc] then
        promptTracker[desc] = true
        modifyPrompt(desc, true)
        
        -- Auto-trigger prompt
        fireproximityprompt(desc)
    end
end

local function startAutoCollect()
    descendantConnection = workspace.DescendantAdded:Connect(handleNewPrompt)
    for _, desc in ipairs(workspace:GetDescendants()) do
        handleNewPrompt(desc)
    end
end

local function stopAutoCollect()
    if descendantConnection then
        descendantConnection:Disconnect()
        descendantConnection = nil
    end
    for prompt in pairs(promptTracker) do
        modifyPrompt(prompt, false)
    end
    promptTracker = {}
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

setclipboard("https://discord.gg/FentanylHub")
Library:Notify("discord invite copied", 1.5, soundId)

if Library.IsMobile then
Library:SetDPIScale(65)
end

local Window = Library:CreateWindow({
    Title = "Fentanyl",
    Footer = "Grow A Garden",
	Icon = 121061267334054,
    ToggleKeybind = Enum.KeyCode.LeftControl,
    Center = true,
    AutoShow = true,
    ShowCustomCursor = false
})



local MainTab = Window:AddTab("Main", "globe")
local LeftGroupbox = MainTab:AddLeftGroupbox("Main")

local Button = LeftGroupbox:AddButton({
    Text = "Sell All",
    Func = function()
    local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- Zielposition, zu der teleportiert werden soll (Beispiel)
local targetPosition = Vector3.new(85, 10, 0)

-- Ursprüngliche Position merken
local originalPosition = hrp.Position

-- Teleportieren
hrp.CFrame = CFrame.new(targetPosition)
wait(0.2)
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents", 9e9):WaitForChild("Sell_Inventory", 9e9):FireServer()

-- Nach 1.5 Sekunden zurückteleportieren
wait(0.4)
hrp.CFrame = CFrame.new(originalPosition)

    end,
    DoubleClick = false -- Requires double-click for risky actions
})

local HarvestEnabled = false
local HarvestConnection = nil

local function FindGarden()
    local farm = workspace:FindFirstChild("Farm")
    if not farm then return nil end
    
    for _, plot in ipairs(farm:GetChildren()) do
        local data = plot:FindFirstChild("Important") and plot.Important:FindFirstChild("Data")
        local owner = data and data:FindFirstChild("Owner")
        if owner and owner.Value == lp.Name then
            return plot
        end
    end
    return nil
end

local function CanHarvest(part)
    local prompt = part:FindFirstChild("ProximityPrompt")
    return prompt and prompt.Enabled
end

local function Harvest()
    if not HarvestEnabled then return end
    if isInventoryFull() then return end
    
    local garden = FindGarden()
    if not garden then return end
    
    local plants = garden:FindFirstChild("Important") and garden.Important:FindFirstChild("Plants_Physical")
    if not plants then return end
    
    for _, plant in ipairs(plants:GetChildren()) do
        if not HarvestEnabled then break end
        local fruits = plant:FindFirstChild("Fruits")
        if fruits then
            for _, fruit in ipairs(fruits:GetChildren()) do
                if not HarvestEnabled then break end
                for _, part in ipairs(fruit:GetChildren()) do
                    if not HarvestEnabled then break end
                    if part:IsA("BasePart") and CanHarvest(part) then
                        local prompt = part.ProximityPrompt
                        local pos = part.Position + Vector3.new(0, 3, 0)
                        if lp.Character and lp.Character.PrimaryPart then
                            lp.Character:SetPrimaryPartCFrame(CFrame.new(pos))
                            task.wait(0.1)
                            if not HarvestEnabled then break end
                            prompt:InputHoldBegin()
                            task.wait(0.1)
                            if not HarvestEnabled then break end
                            prompt:InputHoldEnd()
                            task.wait(0.1)
                        end
                    end
                end
            end
        end
    end
end

local function ToggleHarvest(state)
    if HarvestConnection then
        HarvestConnection:Disconnect()
        HarvestConnection = nil
    end
    HarvestEnabled = state
    if state then
        HarvestConnection = RunService.Heartbeat:Connect(function()
            if HarvestEnabled then
                Harvest()
            else
                HarvestConnection:Disconnect()
                HarvestConnection = nil
            end
        end)
    end
end
local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Harverest All",
    Default = false,
    Tooltip = "This is a toggle",
    Callback = function(state)
        ToggleHarvest(state)
    end
})


local MainTab = Window:AddTab("Plant", "carrot")
local LeftGroupbox = MainTab:AddLeftGroupbox("Plant Seeds")


--Auto plant 
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

-- Anti-AFK
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Farm location
local farm = nil
for _, v in next, Workspace:FindFirstChild("Farm"):GetDescendants() do
    if v.Name == "Owner" and v.Value == LocalPlayer.Name then
        farm = v.Parent.Parent
        break
    end
end

-- State variables
local autoPlant = false
local plantDelay = 0.1
local plantPosition = nil
local autoPlantMethod = "Player Position"

-- Auto Plant Functionality
local function startAutoPlant()
    if not autoPlant then return end
    
    task.spawn(function()
        while autoPlant do
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool") 
            and LocalPlayer.Character:FindFirstChildOfClass("Tool"):GetAttribute("ItemType") == "Seed" then
                
                if autoPlantMethod == "Player Position" then
                    ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Plant_RE"):FireServer(LocalPlayer.Character:GetPivot().Position, LocalPlayer.Character:FindFirstChildOfClass("Tool"):GetAttribute("ItemName"))
                end
                
                task.wait(plantDelay)
            end
            task.wait()
        end
    end)
end

local Label = LeftGroupbox:AddLabel("Plants The Seed Under Your Player")

local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Auto Plant",
    Default = false,
    Tooltip = "Auto Plant",
    Callback = function(state)
     autoPlant = state
        if state then
            startAutoPlant()
        end
    end
})


local MainTab = Window:AddTab("Buy", "shopping-bag")
local LeftGroupbox = MainTab:AddLeftGroupbox("Seeds")

local seeds = {
    "Carrot","Strawberry","Blueberry","Orange Tulip","Tomato",
    "Corn","Daffodil","Watermelon","Pumpkin","Apple","Bamboo",
    "Coconut","Cactus","Dragon Fruit","Mango","Grape","Mushroom",
    "Pepper","Cacao","Beanstalk"
}

local Dropdown = LeftGroupbox:AddDropdown("SeedDropdown", {
    Values = seeds,
    Default = 1,
    Multi = false,
    Text = "Select Seed to Buy",
    Tooltip = "Choose a seed to buy",
    Callback = function(selectedSeed)
        print("Buying seed:", selectedSeed)
        local args = {[1] = selectedSeed}
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local BuySeedStock = ReplicatedStorage:WaitForChild("GameEvents", 9e9):WaitForChild("BuySeedStock", 9e9)
        BuySeedStock:FireServer(unpack(args))
    end
})



    local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Buy All Seeds",
    Default = false,
    Tooltip = "This is a toggle",
    Callback = function(v)
        autoBuySeeds = v
        task.spawn(function()
            while autoBuySeeds do
                for _, name in ipairs({
                    "Carrot","Strawberry","Blueberry","Orange Tulip","Tomato",
                    "Corn","Daffodil","Watermelon","Pumpkin","Apple","Bamboo",
                    "Coconut","Cactus","Dragon Fruit","Mango","Grape","Mushroom",
                    "Pepper","Cacao","Beanstalk"
                }) do
                    ReplicatedStorage.GameEvents.BuySeedStock:FireServer(name)
                end
                task.wait(2)
            end
        end)
    end
})

local MainTab = Window:AddTab("Gui", "app-window")
local LeftGroupbox = MainTab:AddLeftGroupbox("Gui")

local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Open Seed Shop",
    Default = false,
    Tooltip = "This is a toggle",
    Callback = function(mkl)
    local shop = lp.PlayerGui:FindFirstChild("Seed_Shop")
    if shop then
        shop.Enabled = mkl
    end
    end
})

local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Open Gear Shop",
    Default = false,
    Tooltip = "This is a toggle",
    Callback = function(koko)
    local gear = lp.PlayerGui:FindFirstChild("Gear_Shop")
    if gear then
        gear.Enabled = koko
    end
    end
})

local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Open Quest Shop",
    Default = false,
    Tooltip = "This is a toggle",
    Callback = function(ml)
    quest = lp.PlayerGui:FindFirstChild("DailyQuests_UI")
    if quest then
        quest.Enabled = ml
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
