local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Überprüfe, ob die Instanz existiert
local coinPackRemote = ReplicatedStorage:FindFirstChild("ClientToServer")
if coinPackRemote and coinPackRemote:FindFirstChild("GetCoinPacks") then
    coinPackRemote.GetCoinPacks:Destroy()
    print("GetCoinPacks wurde gelöscht.")
else
    warn("GetCoinPacks konnte nicht gefunden werden.")
end


local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

setclipboard("https://discord.gg/FentanylHub")
Library:Notify("discord invite copied", 1.5, soundId)

if Library.IsMobile then
Library:SetDPIScale(65)
end

local Window = Library:CreateWindow({
    Title = "Fentanyl",
    Footer = "Factory RNG",
	Icon = 121061267334054,
    ToggleKeybind = Enum.KeyCode.RightControl,
    Center = true,
    AutoShow = true,
    ShowCustomCursor = false,
    MobileButtonsSide = "Left"
})


local MainTab = Window:AddTab("Main", "globe")

local Tabbox = MainTab:AddLeftTabbox("Settings")
local Sell = Tabbox:AddTab("Sell")
local Auto = Tabbox:AddTab("Auto")

--/ Sell
local Button = Sell:AddButton({
    Text = "Sell Storage",
    Func = function()
    game:GetService("ReplicatedStorage").ClientToServer.SellStorage:FireServer()
    end,
    DoubleClick = false -- Requires double-click for risky actions
})

--/ Auto

local MyToggle = Auto:AddToggle("MyToggle", {
    Text = "Auto Sell",
    Default = false,
    Tooltip = "Automatic Sells Storage",
    Callback = function(Value)
    if Value then
        autosell = true
        else
        autosell = false
    end
    end
})


spawn(function()
while wait(0.2) do
if autosell == true then
game:GetService("ReplicatedStorage").ClientToServer.SellStorage:FireServer()
else
end
end
end)

local MyToggle = Auto:AddToggle("MyToggle", {
    Text = "Auto Buy Next Floor",
    Default = false,
    Tooltip = "This is a toggle",
    Callback = function(Value)
    if Value then
        autofloor = true
    else
        autofloor = false
    end
    end
})

spawn(function()
while wait(0.2) do
    if autofloor == true then
        game:GetService("ReplicatedStorage").ClientToServer.BuyFloor:InvokeServer()
    else
    end
end
end)

local MyToggle = Auto:AddToggle("MyToggle", {
    Text = "Auto Buy 10 Floors",
    Default = false,
    Tooltip = "This is a toggle",
    Callback = function(Value)
    if Value then
        auto10floors = true
    else
        auto10floors = false
    end
    end
})

spawn(function()
while wait(0.2) do
    if auto10floors == true then
        game:GetService("ReplicatedStorage").ClientToServer.BuyFloor:InvokeServer(true)
    else
    end
end
end)

local MyToggle = Auto:AddToggle("MyToggle", {
    Text = "Auto Rebirth",
    Default = false,
    Tooltip = "Toggle Auto Rebirth",
    Callback = function(Value)
    if Value then
        autorebirth = true
    else
        autorebirth = false
    end
end
})

spawn(function()
while wait() do
    if autorebirth == true then
    game:GetService("ReplicatedStorage"):WaitForChild("ClientToServer", 9e9):WaitForChild("BuyRebirth", 9e9):FireServer()
    else
    end
end
end)



local Button = Auto:AddButton({
Text = "Remove Notification",
Func = function()
local player = game:GetService("Players").LocalPlayer
local guiElement = player:WaitForChild("PlayerGui"):WaitForChild("MainUI"):FindFirstChild("NotificationWindow")

if guiElement then
    guiElement:Destroy()
end
end,
DoubleClick = false
})

local Tabbox = MainTab:AddRightTabbox("Settings")
local Upgrades = Tabbox:AddTab("Upgrades")
local Tp = Tabbox:AddTab("Tp")
local Truck = Tabbox:AddTab("Truck")

--/ Upgrades

local Button = Upgrades:AddButton({
    Text = "Upgrade Factory Tier",
    Func = function()
    game:GetService("ReplicatedStorage"):WaitForChild("ClientToServer", 9e9):WaitForChild("UpgradeFactoryTier", 9e9):InvokeServer()
    end,
    DoubleClick = false -- Requires double-click for risky actions
})

local Button = Upgrades:AddButton({
    Text = "Buy Next Floor",
    Func = function()
    game:GetService("ReplicatedStorage").ClientToServer.BuyFloor:InvokeServer()
    end,
    DoubleClick = false -- Requires double-click for risky actions
})

local Button = Upgrades:AddButton({
    Text = "Buy 10 Floors",
    Func = function()
    game:GetService("ReplicatedStorage").ClientToServer.BuyFloor:InvokeServer(true)
    end,
    DoubleClick = false -- Requires double-click for risky actions
})

local Button = Upgrades:AddButton({
    Text = "Upgrade Storage",
    Func = function()
    game:GetService("ReplicatedStorage").ClientToServer.UpgradeStorage:FireServer()
    end,
    DoubleClick = false
})

local Button = Upgrades:AddButton({
    Text = "Rebirth",
    Func = function()
    game:GetService("ReplicatedStorage"):WaitForChild("ClientToServer", 9e9):WaitForChild("BuyRebirth", 9e9):FireServer()
    end,
    DoubleClick = false
})

--/ Tp

local Button = Tp:AddButton({
    Text = "Tp To Factory",
    Func = function()
    game:GetService("ReplicatedStorage"):WaitForChild("ClientToServer", 9e9):WaitForChild("GoToFloor", 9e9):FireServer(1)
    end,
    DoubleClick = false
})

local Button = Tp:AddButton({
    Text = "To To Sacrifices",
    Func = function()
    local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")


local target = game:GetService("Workspace").VoidArea.QuickTPArea.Position


humanoidRootPart.CFrame = CFrame.new(target)

    end,
    DoubleClick = false
})

--/ Truck

local Button = Truck:AddButton({
    Text = "Buy & Claim Machine From Truck",
    Func = function()
        local carsFolder = workspace:FindFirstChild("Cars")
        if not carsFolder then return end

        local replicatedStorage = game:GetService("ReplicatedStorage")
        local clientToServer = replicatedStorage:WaitForChild("ClientToServer", 9e9)
        local buyEvent = clientToServer:WaitForChild("BuyTruckMachine", 9e9)
        local claimEvent = clientToServer:WaitForChild("ClaimTruckMachine", 9e9)

        for _, v in ipairs(carsFolder:GetChildren()) do
            if v:IsA("Model") then
                local n = v.Name:lower()
                if n:find("car") or n:find("item") or n:find("truck") then
                    v:Destroy()
                else
                    buyEvent:InvokeServer(v.Name)
                    claimEvent:FireServer(v.Name)
                    v:Destroy()
                    break
                end
            end
        end
    end,
    DoubleClick = false -- Doppelklick zum Ausführen
})

local MainTab = Window:AddTab("Potions", "glass-water")
local LeftGroupbox = MainTab:AddLeftGroupbox("")
local Label = LeftGroupbox:AddLabel("Collect Potions")

local Potion = ""

local Button = LeftGroupbox:AddButton({
    Text = "Collect All Poitons",
    Func = function()
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local potionFolder = Workspace:WaitForChild("PotionDrops")

local foundAny = false

for _, potionModel in ipairs(potionFolder:GetChildren()) do
    if potionModel:IsA("Model") then
        local primary = potionModel.PrimaryPart or potionModel:FindFirstChildWhichIsA("BasePart")
        if primary then
            foundAny = true
            hrp.CFrame = primary.CFrame + Vector3.new(0, 5, 0)
            task.wait(0.2)

            local prompt = potionModel:FindFirstChildOfClass("ProximityPrompt")
            if prompt then
                prompt:InputHoldBegin()
                task.wait(0.3)
                prompt:InputHoldEnd()
            end

            task.wait(0)
        end
    end
end

if not foundAny then
Potion = "No potion drops found!"
Label:SetText(Potion)
wait(1)
Potion = "Collect All Poitons"
Label:SetText(Potion)
end
    end,
    DoubleClick = false -- Requires double-click for risky actions
})

local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Auto Collect Potions",
    Default = false,
    Tooltip = "Automatic Collects All Potions",
    Callback = function(Value)
    if Value then
        autopotion = true
        else
        autopotion = false
    end
    end
})

spawn(function()
while wait(0.5) do
if autopotion == true then
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local potionFolder = Workspace:WaitForChild("PotionDrops")

local foundAny = false

for _, potionModel in ipairs(potionFolder:GetChildren()) do
    if potionModel:IsA("Model") then
        local primary = potionModel.PrimaryPart or potionModel:FindFirstChildWhichIsA("BasePart")
        if primary then
            foundAny = true
            hrp.CFrame = primary.CFrame + Vector3.new(0, 5, 0)
            task.wait(0.2)

            local prompt = potionModel:FindFirstChildOfClass("ProximityPrompt")
            if prompt then
                prompt:InputHoldBegin()
                task.wait(0.3)
                prompt:InputHoldEnd()
            end

            task.wait(0)
        end
    end
end

if not foundAny then
Potion = "No potion drops found!"
Label:SetText(Potion)
wait(1)
Potion = "Collect All Poitons"
Label:SetText(Potion)
else
end
end
end
end)

local MainTab = Window:AddTab("Roll/Fuse", "zap")
local LeftGroupbox = MainTab:AddLeftGroupbox("Best Dropper / Roll")
local RightGroupbox = MainTab:AddRightGroupbox("Fuse")
local bestdropper = LeftGroupbox:AddLabel("")

spawn(function()
while wait(1) do
local player = game:GetService("Players").LocalPlayer
local factory = workspace:WaitForChild("Factories"):WaitForChild(player.Name)
local rawText = factory
    :WaitForChild("Billboard")
    :WaitForChild("Screen")
    :WaitForChild("SurfaceGui")
    :WaitForChild("RarestMachine").Text
local BestDropper = string.gsub(rawText, "%s*%b()", "")
bestdropper:SetText(BestDropper)
end
end)

local Label = LeftGroupbox:AddLabel("")

local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Auto Roll",
    Default = false,
    Tooltip = "Automatic Rolls Machine",
    Callback = function(Value)
    if Value then
        autoroll = true
        else
        autoroll = false
    end
    end
})

local Dropdown = RightGroupbox:AddDropdown("MyDropdown", {
    Values = {"Dirt Machine", "Stone Machine", "Moss Machine", "Wood Machine", "Sand Machine", "Bottle Machine", "Clay Machine", "Coal Machine", "YoYo Machine", "Chocolate Machine", "Ice Cream Machine", "Slime Machine", "Cheese Machine", "Coffee Machine", "Cactus Machine", "Iron Machine", "Paint Machine", "Obsidian Machine", "Bone Machine", "Emerald Machine", "Diamond Machine", "Amethyst Machine", "Meteorite Machine", "Ghost Machine", "Marble Machine", "Crystal Core Machine", "Void Machine", "FrostFire  Machine", "Phoenix  Feather Machine", "Ancient Bone Machine","Ancient Earth Machine", "Eternal  Fire Machine", "StarMachine", "Plasma Machine", "Soul Stone Machine ", "Magic Soul Machine", "Dimension Core Machine", "Verdant Geode Machine", "Celestial Silk Machine", "Everlasting Cog Machine", "Void Heart Machine", "Boilerheart Tinkerer Machine", "Iron Aristocrat Machine", "Fission Prism Machine", "Toxicwood Heart Machine", "Chrono Winder Machine", "Anti Matter", "Uranium Core Machine", "Toxic Void Machine", "Nuclear Reactor", "Boomspark Machine", "Cogmaster Sentinel Machine", "Ancient Titan", "Obsidian Obelisk Machine", "Jade Serpent Machine"},
    Default = 0, -- Index of the default option
    Multi = false, -- Whether to allow multiple selections
    Text = "Select",
    Tooltip = "What Machine ?",
    Callback = function(Value)
    fusedropper = Value
    end})

    local Button = RightGroupbox:AddButton({
    Text = "Fuse Machine",
    Func = function()
    game:GetService("ReplicatedStorage"):WaitForChild("ClientToServer", 9e9):WaitForChild("FuseMachines", 9e9):FireServer(fusedropper)
    end,
    DoubleClick = false -- Requires double-click for risky actions
    })


local MainTab = Window:AddTab("Machine", "pickaxe") -- Second parameter is the icon name (optional)
local LeftGroupbox = MainTab:AddLeftGroupbox("Machine")
local RightGroupbox = MainTab:AddRightGroupbox("Info")


local free = RightGroupbox:AddLabel("")
local equiped = RightGroupbox:AddLabel("")

spawn(function()
while wait(0.1) do
local player = game:GetService("Players").LocalPlayer
local myFolderName = player.Name

local factories = game:GetService("Workspace").Factories
local floorsFolder = factories:FindFirstChild(myFolderName) and factories[myFolderName]:FindFirstChild("Floors")

local equippedSlots = 0
local totalSlots = 0

if floorsFolder then
    for _, floor in pairs(floorsFolder:GetChildren()) do
        if floor:FindFirstChild("MachineSlots") then
            local machineSlots = floor.MachineSlots

            for _, slot in pairs(machineSlots:GetChildren()) do
                totalSlots = totalSlots + 1
                local isOccupied = false

                for _, child in pairs(slot:GetChildren()) do
                    if child:IsA("Model") then
                        isOccupied = true
                        break
                    end
                end

                if isOccupied then
                    equippedSlots = equippedSlots + 1
                end
            end
        end
    end
end

local freeSlots = totalSlots - equippedSlots
equiped:SetText("Equipped Slots: " ..equippedSlots)
free:SetText("Total Slots: " ..totalSlots)

slotnumber = totalSlots
end
end)

local nigger = RightGroupbox:AddLabel("")


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MachinesFolder = ReplicatedStorage:WaitForChild("Machines")


local SelectedMachine = nil

local selectedmachinetext = LeftGroupbox:AddLabel("Selected: None")

local Input = LeftGroupbox:AddInput("MyInput", {
    Text = "Type Machine name",
    Default = "",
    Numeric = false,
    Finished = true,
    Placeholder = "Enter machine name (without 'Machine')...",
    Callback = function(Value)
        local input = (Value or ""):lower():gsub("%s+", "") -- alles klein, ohne Leerzeichen
        SelectedMachine = nil

        -- Hilfsfunktion zum Suchen in einem Ordner
        local function findMachine(folder)
            for _, machine in pairs(folder:GetChildren()) do
                local machineName = machine.Name:lower()
                local baseName = machineName:gsub(" machine", ""):gsub("%s+", "")
                if baseName == input then
                    return machine.Name
                end
            end
            return nil
        end

        -- Erst in Machines suchen
        SelectedMachine = findMachine(MachinesFolder)

        -- Falls nicht gefunden, in MutantMachines suchen
        if not SelectedMachine then
            SelectedMachine = findMachine(MutantMachinesFolder)
        end

        if SelectedMachine then
            print("Selected machine:", SelectedMachine)
            selectedmachinetext:SetText("Selected: "..SelectedMachine)
        else
            warn("Keine passende Maschine gefunden für:", Value)
            selectedmachinetext:SetText("Selected: None")
        end
    end
})

local WarnLabel = LeftGroupbox:AddLabel({
    Text = "Do not turn toggles/switches if your machine is normal and not Fused, Shiny or Cursed",
    DoesWrap = true
})
local tutorial1 = RightGroupbox:AddLabel("To dupe input the machine name")
local tutorial3 = RightGroupbox:AddLabel("you want to dupe without machine")
local tutorial2 = RightGroupbox:AddLabel("For example:")
local tutorial4 = RightGroupbox:AddLabel("To dupe dirt machine input dirt")
local tutorial5 = RightGroupbox:AddLabel("Press enter after input")
local tutorial6 = RightGroupbox:AddLabel("press on equip/dupe selected")
local tutorial7 = RightGroupbox:AddLabel("Join discord and make a ticket")
local tutorial8 = RightGroupbox:AddLabel("for support if issues occur")

local daddy = RightGroupbox:AddButton({
    Text = "Hide Tutorial",
    Func = function()
        tutorial1:SetVisible(false)
        tutorial2:SetVisible(false)
        tutorial3:SetVisible(false)
        tutorial4:SetVisible(false)
        tutorial5:SetVisible(false)
        tutorial6:SetVisible(false)
        tutorial7:SetVisible(false)
        tutorial8:SetVisible(false)
        WarnLabel:SetVisible(false)
    end,
    DoubleClick = false
})

local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Fused",
    Default = false,
    Tooltip = "This is a toggle",
    Callback = function(Value)
    if Value then
        fused = true
    else
        fused = false
    end
    end
})

local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Shiny",
    Default = false,
    Tooltip = "This is a toggle",
    Callback = function(Value)
    if Value then
        shiny = true
    else
        shiny = false
    end
    end
})

local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Cursed",
    Default = false,
    Tooltip = "This is a toggle",
    Callback = function(Value)
    if Value then
        blood = true
    else
        blood = false
    end
    end
})

local Button = LeftGroupbox:AddButton({
    Text = "Dupe Selected",
    Func = function()
    local args = {
    [1] = {}
}

if fused == true then
for i = 1, slotnumber do
    table.insert(args[1], {
        ["machineName"] = SelectedMachine.."_FUSED",
        ["isDuplicated"] = false
    })
end
elseif shiny == true then
for i = 1, slotnumber do
    table.insert(args[1], {
        ["machineName"] = SelectedMachine.."_SHINY",
        ["isDuplicated"] = false
    })
end
elseif blood == true then
    for i = 1, slotnumber do
    table.insert(args[1], {
        ["machineName"] = SelectedMachine.."_BLOOD",
        ["isDuplicated"] = false
    })
end
else
for i = 1, slotnumber do
    table.insert(args[1], {
        ["machineName"] = SelectedMachine,
        ["isDuplicated"] = false
    })
end
end
game:GetService("ReplicatedStorage")
    :WaitForChild("ClientToServer", 9e9)
    :WaitForChild("EquipMachinesAnyAvailableSlot", 9e9)
    :InvokeServer(unpack(args))

    end,
    DoubleClick = false -- Requires double-click for risky actions
})

local testmachine

spawn(function()
    while wait(0.2) do
local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Versuche, den Text vom RarestMachine-Label zu holen
local rareText = ""
pcall(function()
    rareText = workspace.Factories[player.Name].Billboard.Screen.SurfaceGui.RarestMachine.Text
end)

-- Funktion zur simplen Ähnlichkeitsprüfung
local function getSimilarity(a, b)
    a, b = a:lower(), b:lower()
    local score = math.abs(#a - #b)
    for i = 1, math.min(#a, #b) do
        if a:sub(i, i) ~= b:sub(i, i) then
            score += 1
        end
    end
    return score
end

-- Suche im Machines-Ordner nach dem ähnlichsten Namen
local machines = replicatedStorage:FindFirstChild("Machines")
if machines then
    local bestName = nil
    local bestScore = math.huge

    for _, machine in pairs(machines:GetChildren()) do
        local score = getSimilarity(machine.Name, rareText)
        if score < bestScore then
            bestScore = score
            bestName = machine.Name
        end
    end

    if bestName then
        testmachine = bestName
    else
        warn("Keine passende Maschine gefunden.")
    end
else
    warn("Ordner 'Machines' nicht gefunden.")
end
end
end)

local Button = LeftGroupbox:AddButton({
    Text = "Dupe BillBoard",
    Func = function()
    local args = {
    [1] = {}
}

for i = 1, slotnumber do
    table.insert(args[1], {
        ["machineName"] = testmachine,
        ["isDuplicated"] = false
    })
end
game:GetService("ReplicatedStorage")
    :WaitForChild("ClientToServer", 9e9)
    :WaitForChild("EquipMachinesAnyAvailableSlot", 9e9)
    :InvokeServer(unpack(args))

    end,
    DoubleClick = false -- Requires double-click for risky actions
})

local Button = LeftGroupbox:AddButton({
    Text = "Uneqip All Machine",
    Func = function()
    game:GetService("ReplicatedStorage"):WaitForChild("ClientToServer", 9e9):WaitForChild("UnequipAllMachines", 9e9):InvokeServer()
    end,
    DoubleClick = false -- Requires double-click for risky actions
})


local MainTab = Window:AddTab("Player/Anti Lag", "person-standing") -- Second parameter is the icon name (optional)
local LeftGroupbox = MainTab:AddLeftGroupbox("Walk Speed")
local RightGroupbox = MainTab:AddRightGroupbox("Remove Lags")

local Button = RightGroupbox:AddButton({
    Text = "Remove Machine/Dropper Drops",
    Func = function()
    local player = game:GetService("Players").LocalPlayer
local factories = game:GetService("Workspace").Factories
local myFolderName = player.Name

local targetFolder = factories:FindFirstChild(myFolderName)
if targetFolder then
    local itemDrops = targetFolder:FindFirstChild("ItemDrops")
    if itemDrops then
        itemDrops:Destroy()
        print("ItemDrops folder has been deleted.")
    else
        print("ItemDrops folder not found.")
    end
else
    print("Your factory folder was not found.")
end

    end,
    DoubleClick = false -- Requires double-click for risky actions
})

local Label = RightGroupbox:AddLabel("Game Will Freeze For A Sec")
local Button = RightGroupbox:AddButton({
    Text = "Remove Other Factorys",
    Func = function()
    local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local localPlayer = Players.LocalPlayer
if not localPlayer then
    return warn("LocalPlayer Not Found.")
end

local factories = Workspace:FindFirstChild("Factories")
if not factories then
    return warn("Factory Not Found.")
end

for _, model in ipairs(factories:GetChildren()) do
    if model:IsA("Model") and model.Name ~= localPlayer.Name then
        model:Destroy()
    end
end

    end,
    DoubleClick = false -- Requires double-click for risky actions
})

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

spawn(function()
while wait(0.1) do
if autoroll == true then
game:GetService("ReplicatedStorage"):WaitForChild("ClientToServer", 9e9):WaitForChild("RollMachine", 9e9):InvokeServer()
else
end
end
end)

wait(10)
local player = game:GetService("Players").LocalPlayer
local crh = player:WaitForChild("PlayerScripts"):FindFirstChild("ClientRenderingHandler")
if crh then
    crh:Destroy()
    print("ClientRenderingHandler script disabled.")
end
