local Library = {}

-- Dienste abrufen
local TweenService = game:GetService("TweenService")

-- Altes UI schließen, falls schon offen
if game.CoreGui:FindFirstChild("MyCustomUI") then
    game.CoreGui.MyCustomUI:Destroy()
end

-- ScreenGui erstellen
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyCustomUI"
ScreenGui.Parent = game:GetService("CoreGui")

-- Hauptfenster
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dunklerer Hintergrund
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Macht das Fenster verschiebbar
MainFrame.Parent = ScreenGui

-- UICorner für MainFrame (abgerundete Ecken)
local MainFrameCorner = Instance.new("UICorner")
MainFrameCorner.CornerRadius = UDim.new(0, 8)
MainFrameCorner.Parent = MainFrame

-- Titel-Leiste
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45) -- Etwas heller
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- UICorner für TitleBar (wird die oberen Ecken des MainFrame abrunden)
local TitleBarCorner = Instance.new("UICorner")
TitleBarCorner.CornerRadius = UDim.new(0, 8)
TitleBarCorner.Parent = TitleBar

-- Titel-Text
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Meine Library UI"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 1, 0)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40) -- Dunkleres Rot
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 18
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Parent = TitleBar

-- UICorner für CloseBtn
local CloseBtnCorner = Instance.new("UICorner")
CloseBtnCorner.CornerRadius = UDim.new(0, 6)
CloseBtnCorner.Parent = CloseBtn

-- TweenInfo für Hover-Effekte
local hoverTweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Close Button Hover-Effekt
CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(220, 60, 60)}):Play()
end)

CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(180, 40, 40)}):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Container für Buttons / Inhalte
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -40)
ContentFrame.Position = UDim2.new(0, 10, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- UIPadding für ContentFrame (Innenabstand)
local ContentFramePadding = Instance.new("UIPadding")
ContentFramePadding.PaddingTop = UDim.new(0, 10)
ContentFramePadding.PaddingBottom = UDim.new(0, 10)
ContentFramePadding.PaddingLeft = UDim.new(0, 10)
ContentFramePadding.PaddingRight = UDim.new(0, 10)
ContentFramePadding.Parent = ContentFrame

-- UIListLayout für ContentFrame, um Buttons automatisch anzuordnen
local ContentListLayout = Instance.new("UIListLayout")
ContentListLayout.Padding = UDim.new(0, 5) -- Abstand zwischen Buttons
ContentListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center -- Buttons horizontal zentrieren
ContentListLayout.VerticalAlignment = Enum.VerticalAlignment.Top -- Buttons oben ausrichten
ContentListLayout.Parent = ContentFrame

-- Button-Funktion
function Library:AddButton(config)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 200, 0, 40)
    -- Button.Position wird jetzt vom UIListLayout gehandhabt
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60) -- Standard-Buttonfarbe
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 16
    Button.Text = config.Text or "Click Me"
    Button.Parent = ContentFrame

    -- UICorner für Button
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = Button

    -- Button Hover-Effekt
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
    end)

    local lastClick = 0
    Button.MouseButton1Click:Connect(function()
        if config.DoubleClick then
            local now = tick()
            if now - lastClick <= 0.5 then
                pcall(config.Func)
            else
                print("Double-click needed!")
            end
            lastClick = now
        else
            pcall(config.Func)
        end
    end)

    return Button
end

return Library
