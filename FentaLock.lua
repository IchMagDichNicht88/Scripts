local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

-- Default Values
_G.AimBotEnabled = false
_G.AimPart = "Head"
_G.CircleVisible = false
_G.CircleRadius = 75
_G.RageCheck = false
_G.TeamCheck = false
_G.VisCheck = false
_G.ESPEnabled = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- Drawing: FOV Circle vorbereiten
local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(0, 0) -- Dummy initial value
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = false
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Transparency = 0.6
FOVCircle.NumSides = 75
FOVCircle.Thickness = 1

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        local pos = UIS:GetMouseLocation()
        FOVCircle.Position = Vector2.new(pos.X, pos.Y)
    end
end)

local Window = Library:CreateWindow({
    Title = "FentaLock",
    Footer = "Universal",
    Icon = 135320221397534,
    ToggleKeybind = Enum.KeyCode.LeftControl,
    Center = true,
    AutoShow = true,
    ShowCustomCursor = false
})

local MainTab = Window:AddTab("Main", "globe")
local LeftGroupbox = MainTab:AddLeftGroupbox("Main")

-- AimBot Toggle
LeftGroupbox:AddToggle("AimBotToggle", {
    Text = "AimBot",
    Default = _G.AimBotEnabled,
    Tooltip = "Toggle AimBot",
    Callback = function(Value)
        _G.AimBotEnabled = Value
        _G.CircleVisible = Value
        FOVCircle.Visible = Value
    end
})

-- Hitbox Dropdown
LeftGroupbox:AddDropdown("HitboxDropdown", {
    Values = {"Head", "HumanoidRootPart"},
    Default = 1,
    Multi = false,
    Text = "Hit Box",
    Tooltip = "Target part to aim at",
    Callback = function(Value)
        _G.AimPart = Value
    end
})

-- Show FOV Toggle
LeftGroupbox:AddToggle("ShowFOVToggle", {
    Text = "Show FOV",
    Default = _G.CircleVisible,
    Tooltip = "Shows FOV circle",
    Callback = function(Value)
        _G.CircleVisible = Value
        FOVCircle.Visible = Value
    end
})

-- FOV Size Slider
LeftGroupbox:AddSlider("FOVSizeSlider", {
    Text = "FOV Size",
    Default = _G.CircleRadius,
    Min = 0,
    Max = 500,
    Rounding = 0,
    Compact = false,
    Callback = function(Value)
        _G.CircleRadius = Value
        FOVCircle.Radius = Value
    end
})

-- Rage Check Toggle
LeftGroupbox:AddToggle("RageCheckToggle", {
    Text = "Range Check",
    Default = _G.RageCheck,
    Tooltip = "Checks max range",
    Callback = function(Value)
        _G.RageCheck = Value
    end
})

-- Team Check Toggle
LeftGroupbox:AddToggle("TeamCheckToggle", {
    Text = "Team Check",
    Default = _G.TeamCheck,
    Tooltip = "Don't aim at teammates",
    Callback = function(Value)
        _G.TeamCheck = Value
    end
})

-- Vis Check Toggle (Sichtprüfung)
LeftGroupbox:AddToggle("VisCheckToggle", {
    Text = "Visibility Check",
    Default = _G.VisCheck,
    Tooltip = "Aim only if visible",
    Callback = function(Value)
        _G.VisCheck = Value
    end
})

local MainTab = Window:AddTab("Esp", "user")
local LeftGroupbox = MainTab:AddLeftGroupbox("Main")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer and LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local LocalHumanoidRootPart = LocalCharacter:WaitForChild("HumanoidRootPart")

local ESP = {}
ESP.__index = ESP

function ESP.new()
    local self = setmetatable({}, ESP)
    self.espCache = {}
    return self
end

function ESP:createDrawing(type, properties)
    local drawing = Drawing.new(type)
    for prop, val in pairs(properties) do
        drawing[prop] = val
    end
    return drawing
end

function ESP:createComponents()
    return {
        Box = self:createDrawing("Square", {
            Thickness = 1,
            Transparency = 1,
            Color = Color3.fromRGB(255, 255, 255),
            Filled = false
        }),
        Tracer = self:createDrawing("Line", {
            Thickness = 1,
            Transparency = 1,
            Color = Color3.fromRGB(255, 255, 255)
        }),
        -- Entfernungsetikett entfernt
        NameLabel = self:createDrawing("Text", {
            Size = 18,
            Center = true,
            Outline = true,
            Color = Color3.fromRGB(255, 255, 255),
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }),
        HealthBar = {
            Outline = self:createDrawing("Square", {
                Thickness = 1,
                Transparency = 1,
                Color = Color3.fromRGB(0, 0, 0),
                Filled = false
            }),
            Health = self:createDrawing("Square", {
                Thickness = 1,
                Transparency = 1,
                Color = Color3.fromRGB(0, 255, 0),
                Filled = true
            })
        },
        ItemLabel = self:createDrawing("Text", {
            Size = 18,
            Center = true,
            Outline = true,
            Color = Color3.fromRGB(255, 255, 255),
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }),
        SkeletonLines = {}
    }
end

local bodyConnections = {
    R15 = {
        {"Head", "UpperTorso"},
        {"UpperTorso", "LowerTorso"},
        {"LowerTorso", "LeftUpperLeg"},
        {"LowerTorso", "RightUpperLeg"},
        {"LeftUpperLeg", "LeftLowerLeg"},
        {"LeftLowerLeg", "LeftFoot"},
        {"RightUpperLeg", "RightLowerLeg"},
        {"RightLowerLeg", "RightFoot"},
        {"UpperTorso", "LeftUpperArm"},
        {"UpperTorso", "RightUpperArm"},
        {"LeftUpperArm", "LeftLowerArm"},
        {"LeftLowerArm", "LeftHand"},
        {"RightUpperArm", "RightLowerArm"},
        {"RightLowerArm", "RightHand"}
    },
    R6 = {
        {"Head", "Torso"},
        {"Torso", "Left Arm"},
        {"Torso", "Right Arm"},
        {"Torso", "Left Leg"},
        {"Torso", "Right Leg"}
    }
}

function ESP:updateComponents(components, character, player, showBox, showTracer, showName, showSkeleton, showTool)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")

    if hrp and humanoid then
        local hrpPosition, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        local mousePosition = Camera:WorldToViewportPoint(LocalPlayer:GetMouse().Hit.p)

        if onScreen then
            local screenWidth, screenHeight = Camera.ViewportSize.X, Camera.ViewportSize.Y
            local factor = 1 / (hrpPosition.Z * math.tan(math.rad(Camera.FieldOfView * 0.5)) * 2) * 100
            local width, height = math.floor(screenHeight / 25 * factor), math.floor(screenWidth / 27 * factor)

            -- Box anzeigen, wenn showBox true
            components.Box.Visible = showBox
            if showBox then
                components.Box.Size = Vector2.new(width, height)
                components.Box.Position = Vector2.new(hrpPosition.X - width / 2, hrpPosition.Y - height / 2)
            end

            -- Tracer anzeigen, wenn showTracer true
            components.Tracer.Visible = showTracer
            if showTracer then
                components.Tracer.From = Vector2.new(mousePosition.X, mousePosition.Y)
                components.Tracer.To = Vector2.new(hrpPosition.X, hrpPosition.Y + height / 2)
            end

            -- Name anzeigen, wenn showName true
            components.NameLabel.Visible = showName
            if showName then
                components.NameLabel.Text = string.format("[%s]", player.Name)
                components.NameLabel.Position = Vector2.new(hrpPosition.X, hrpPosition.Y - height / 2 - 15)
            end

            -- Health Bar (nur sichtbar wenn Box sichtbar)
            components.HealthBar.Outline.Visible = showBox
            components.HealthBar.Health.Visible = showBox
            if showBox then
                local healthBarHeight = height
                local healthBarWidth = 5
                local healthFraction = humanoid.Health / humanoid.MaxHealth

                components.HealthBar.Outline.Size = Vector2.new(healthBarWidth, healthBarHeight)
                components.HealthBar.Outline.Position = Vector2.new(components.Box.Position.X - healthBarWidth - 2, components.Box.Position.Y)

                components.HealthBar.Health.Size = Vector2.new(healthBarWidth - 2, healthBarHeight * healthFraction)
                components.HealthBar.Health.Position = Vector2.new(components.HealthBar.Outline.Position.X + 1, components.HealthBar.Outline.Position.Y + healthBarHeight * (1 - healthFraction))
            end

            -- Tool in Hand anzeigen, wenn showTool true
            components.ItemLabel.Visible = showTool
            if showTool then
                local backpack = player.Backpack
                local tool = backpack:FindFirstChildOfClass("Tool") or character:FindFirstChildOfClass("Tool")
                if tool then
                    components.ItemLabel.Text = string.format("[Holding: %s]", tool.Name)
                else
                    components.ItemLabel.Text = "[Holding: No tool]"
                end
                components.ItemLabel.Position = Vector2.new(hrpPosition.X, hrpPosition.Y + height / 2 + 35)
            end

            -- Skeleton anzeigen, wenn showSkeleton true
            local connections = bodyConnections[humanoid.RigType.Name] or {}
            for _, connection in ipairs(connections) do
                local partA = character:FindFirstChild(connection[1])
                local partB = character:FindFirstChild(connection[2])
                if partA and partB then
                    local line = components.SkeletonLines[connection[1] .. "-" .. connection[2]] or self:createDrawing("Line", {Thickness = 1, Color = Color3.fromRGB(255, 255, 255)})
                    local posA, onScreenA = Camera:WorldToViewportPoint(partA.Position)
                    local posB, onScreenB = Camera:WorldToViewportPoint(partB.Position)
                    if onScreenA and onScreenB and showSkeleton then
                        line.From = Vector2.new(posA.X, posA.Y)
                        line.To = Vector2.new(posB.X, posB.Y)
                        line.Visible = true
                        components.SkeletonLines[connection[1] .. "-" .. connection[2]] = line
                    else
                        line.Visible = false
                    end
                end
            end
        else
            self:hideComponents(components)
        end
    else
        self:hideComponents(components)
    end
end

function ESP:hideComponents(components)
    components.Box.Visible = false
    components.Tracer.Visible = false
    components.NameLabel.Visible = false
    components.HealthBar.Outline.Visible = false
    components.HealthBar.Health.Visible = false
    components.ItemLabel.Visible = false

    for _, line in pairs(components.SkeletonLines) do
        line.Visible = false
    end
end

function ESP:removeEsp(player)
    local components = self.espCache[player]
    if components then
        components.Box:Remove()
        components.Tracer:Remove()
        components.NameLabel:Remove()
        components.HealthBar.Outline:Remove()
        components.HealthBar.Health:Remove()
        components.ItemLabel:Remove()
        for _, line in pairs(components.SkeletonLines) do
            line:Remove()
        end
        self.espCache[player] = nil
    end
end

local espInstance = ESP.new()
local espEnabled = false
local showTracer = true
local showBox = true
local showName = true
local showSkeleton = true
local showTool = true
local renderConnection

local MyToggle = LeftGroupbox:AddToggle("MyToggle", {
    Text = "Toggle Esp",
    Default = false,
    Tooltip = "This is a toggle",
    Callback = function(Value)
        espEnabled = Value
        if espEnabled then
            renderConnection = RunService.RenderStepped:Connect(function()
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        local character = player.Character
                        if character then
                            if not espInstance.espCache[player] then
                                espInstance.espCache[player] = espInstance:createComponents()
                            end
                            espInstance:updateComponents(
                                espInstance.espCache[player],
                                character,
                                player,
                                showBox,
                                showTracer,
                                showName,
                                showSkeleton,
                                showTool
                            )
                        else
                            if espInstance.espCache[player] then
                                espInstance:hideComponents(espInstance.espCache[player])
                            end
                        end
                    end
                end
            end)
        else
            if renderConnection then
                renderConnection:Disconnect()
                renderConnection = nil
            end
            for player, components in pairs(espInstance.espCache) do
                espInstance:removeEsp(player)
            end
            espInstance.espCache = {}
        end
    end
})

local TracerToggle = LeftGroupbox:AddToggle("TracerToggle", {
    Text = "Toggle Tracer",
    Default = true,
    Tooltip = "Toggle Tracer lines",
    Callback = function(Value)
        showTracer = Value
    end
})

local BoxToggle = LeftGroupbox:AddToggle("BoxToggle", {
    Text = "Toggle Box",
    Default = true,
    Tooltip = "Toggle ESP Box",
    Callback = function(Value)
        showBox = Value
    end
})

local NameToggle = LeftGroupbox:AddToggle("NameToggle", {
    Text = "Toggle Name",
    Default = true,
    Tooltip = "Toggle Name ESP",
    Callback = function(Value)
        showName = Value
    end
})

local SkeletonToggle = LeftGroupbox:AddToggle("SkeletonToggle", {
    Text = "Toggle Skeleton",
    Default = true,
    Tooltip = "Toggle Skeleton ESP",
    Callback = function(Value)
        showSkeleton = Value
    end
})

local ToolToggle = LeftGroupbox:AddToggle("ToolToggle", {
    Text = "Toggle Tool In Hand",
    Default = true,
    Tooltip = "Toggle Tool In Hand ESP",
    Callback = function(Value)
        showTool = Value
    end
})


local MainTab = Window:AddTab("Player", "person-standing") -- Second parameter is the icon name (optional)
local LeftGroupbox = MainTab:AddLeftGroupbox("Walk Speed")


local Button = LeftGroupbox:AddButton({
    Text = "Reset Walk Speed",
    Func = function()
    -- Warte, bis LocalPlayer geladen ist
local player = game:GetService("Players").LocalPlayer
if not player then
    error("LocalPlayer nicht gefunden!")
end

-- Warte, bis der Charakter geladen ist
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Neue WalkSpeed setzen
local newSpeed = 16
humanoid.WalkSpeed = newSpeed

-- WalkSpeed nach Respawn erneut setzen
player.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = newSpeed
end)

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
    -- Warte, bis LocalPlayer geladen ist
local player = game:GetService("Players").LocalPlayer
if not player then
    error("LocalPlayer nicht gefunden!")
end

-- Warte, bis der Charakter geladen ist
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Neue WalkSpeed setzen
local newSpeed = Value
humanoid.WalkSpeed = newSpeed

-- WalkSpeed nach Respawn erneut setzen
player.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = newSpeed
end)

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

-- Hilfsfunktionen zum Ziel finden
local function IsValidTarget(player)
    if player == LocalPlayer then return false end
    local character = player.Character
    if not character then return false end
    local part = character:FindFirstChild(_G.AimPart)
    if not part then return false end
    if _G.TeamCheck and player.Team == LocalPlayer.Team then return false end
    if _G.RageCheck then
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return false end
        local distance = (hrp.Position - part.Position).Magnitude
        if distance > 200 then return false end
    end
    if _G.VisCheck then
        local rayParams = RaycastParams.new()
        rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        local origin = Camera.CFrame.Position
        local direction = (part.Position - origin).Unit * 500
        local raycastResult = workspace:Raycast(origin, direction, rayParams)
        if raycastResult then
            if raycastResult.Instance:IsDescendantOf(player.Character) == false then
                return false
            end
        end
    end
    return true
end

local function GetClosestTarget()
    local mousePos = UIS:GetMouseLocation()
    local closestPlayer, closestDist = nil, _G.CircleRadius

    for _, player in pairs(Players:GetPlayers()) do
        if IsValidTarget(player) then
            local part = player.Character[_G.AimPart]
            local pos, onScreen = Camera:WorldToScreenPoint(part.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestPlayer = player
                end
            end
        end
    end

    return closestPlayer
end

-- Aimbot Loop: Nur wenn Rechtsklick gedrückt & AimBot aktiv
RunService.RenderStepped:Connect(function()
    if _G.AimBotEnabled and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = GetClosestTarget()
        if target and target.Character then
            local targetPart = target.Character:FindFirstChild(_G.AimPart)
            if targetPart then
                -- Aim setzen
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
            end
        end
    end
end)
