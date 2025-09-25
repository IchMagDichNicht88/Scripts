local Library = loadstring(
    game:HttpGet(
        'https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua'
    )
)()

local Window = Library:CreateWindow({
    Title = 'Cryptic.cc',
    Icon = 15635627476,
    ShowCustomCursor = false,
    DisableSearch = true,
    Size = UDim2.fromOffset(650, 300),
    Footer = ' ',
    NotifySide = "Right",
    Resizable = false,
})

-- === Main Tab ===
local Tab = Window:AddTab('Main', 'globe')
local LeftGroupbox = Tab:AddLeftGroupbox("Aimbot","")

local Options = Library.Options
local Toggles = Library.Toggles

-- Toggle for Aimbot
local AimbotToggle = LeftGroupbox:AddToggle("AimbotToggle", {
    Text = "Enable Cube Aimbot",
    Default = false,
})



LeftGroupbox:AddSlider("Smoothing", {
    Text = "Less = More Smooth",
    Default = 100,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
})

-- === Variables ===
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

local cubes = {}
local currentTarget = nil
local aimbotEnabled = false
local smoothingFactor = 1.0

-- === Functions ===

-- Get oldest cube
local function getOldestCube()
    local oldest = nil
    local earliestTime = math.huge

    for cube, timestamp in pairs(cubes) do
        if cube and cube.Parent then
            if timestamp < earliestTime then
                oldest = cube
                earliestTime = timestamp
            end
        else
            cubes[cube] = nil
        end
    end

    return oldest
end

-- Move mouse with smoothing and precision
local function lockMouseToCube(cube)
    if not cube or not cube.Parent then return end

    local pos, onScreen = camera:WorldToScreenPoint(cube.Position)
    if onScreen then
        local deltaX = (pos.X - mouse.X) * smoothingFactor
        local deltaY = (pos.Y - mouse.Y) * smoothingFactor
        mousemoverel(deltaX, deltaY) -- bewegt die Maus relativ
    end
end

-- Monitor cubes
local function startMonitoringCubes()
    local folder = workspace:FindFirstChild("Client")
    folder = folder and folder:FindFirstChild("Game")

    if folder then
        -- Füge sofort alle vorhandenen Cubes hinzu
        for _, obj in ipairs(folder:GetDescendants()) do
            if obj.Name == "Cube_Mesh" and obj:IsA("BasePart") then
                cubes[obj] = tick()
                if not currentTarget then
                    currentTarget = getOldestCube()
                end
            end
        end

        -- Danach neue Cubes überwachen
        folder.DescendantAdded:Connect(function(obj)
            if obj.Name == "Cube_Mesh" and obj:IsA("BasePart") then
                cubes[obj] = tick()
                if not currentTarget then
                    currentTarget = getOldestCube()
                end
            end
        end)
    else
        -- Folder noch nicht da, nach 3 Sekunden erneut prüfen
        delay(3, startMonitoringCubes)
    end
end

-- Main loop
game:GetService("RunService").RenderStepped:Connect(function()
    if aimbotEnabled then
        if not currentTarget or not currentTarget.Parent then
            currentTarget = getOldestCube()
        end

        if currentTarget then
            lockMouseToCube(currentTarget)
        end
    end
end)

-- === Callbacks ===

Toggles.AimbotToggle:OnChanged(function(state)
    aimbotEnabled = state
end)

Options.Smoothing:OnChanged(function(value)
    smoothingFactor = value / 100
end)

-- Start monitoring cubes
startMonitoringCubes()


-- === Player Tab ===
local Tab = Window:AddTab("Player", "user")
local LeftGroupbox = Tab:AddLeftGroupbox("Walk Speed","")
local RightGroupbox = Tab:AddRightGroupbox("Jump Power", "")

LeftGroupbox:AddInput("WalkSpeedInput", {
    Text = "Enter Speed",
    Default = "",
    Placeholder = "Default = 16",
    Finished = true,
    Callback = function(value)
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = tonumber(value) or 16
        Library:Notify("Speed Changed To: "..value , 1.5)
    end
})

LeftGroupbox:AddButton({
    Text = "Reset",
    Func = function()
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = 16
        Library:Notify("Speed Restored", 1.5)
    end
})

RightGroupbox:AddInput("JumpPowerInput", {
    Text = "Enter Jump Power",
    Default = "",
    Placeholder = "Default = 50",
    Finished = true,
    Callback = function(value)
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = tonumber(value) or 50
        Library:Notify("Jump Power Changed To: "..value , 1.5)
    end
})

RightGroupbox:AddButton({
    Text = "Reset",
    Func = function()
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = 50
        Library:Notify("Jump Power Restored", 1.5)
    end
})

-- === ESP Tab ===
local Tab = Window:AddTab('Esp', 'eye')
local LeftGroupbox = Tab:AddLeftGroupbox('Player', 'eye')

local HighlightToggle = LeftGroupbox:AddToggle('HighlightToggle', {
    Text = 'Enable Highlights',
    Default = false,
})

local HighlightEnabled = HighlightToggle.Value
local highlights = {}

local function updatePlayers()
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local char = player.Character
            if char then
                local existingH = highlights[player]
                if HighlightEnabled then
                    if not existingH or not existingH.Parent then
                        local h = Instance.new('Highlight')
                        h.FillColor = Color3.fromRGB(255, 255, 255)
                        h.OutlineColor = Color3.fromRGB(255, 255, 255)
                        h.FillTransparency = 0.5
                        h.Parent = char
                        highlights[player] = h
                    end
                else
                    if existingH and existingH.Parent then
                        existingH:Destroy()
                        highlights[player] = nil
                    end
                end
            end
        end
    end
end

game:GetService('RunService').Heartbeat:Connect(updatePlayers)

Toggles.HighlightToggle:OnChanged(function(state)
    HighlightEnabled = state
end)

-- === Settings Tab ===
local Tab = Window:AddTab('Settings', 'wrench')
local LeftGroupbox = Tab:AddLeftGroupbox('UI', 'app-window')
LeftGroupbox:AddButton('Unload', function()
    Library:Notify("Unloading", 1.4)
    wait(1.6)
    Library:Unload()
end)
