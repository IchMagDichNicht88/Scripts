-- UILibrary.lua

local Library = {}

-- altes UI schließen, falls schon offen
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
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- macht das Fenster verschiebbar
MainFrame.Parent = ScreenGui

-- Titel-Leiste
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

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
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 18
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Parent = TitleBar

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Container für Buttons / Inhalte
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -40)
ContentFrame.Position = UDim2.new(0, 10, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Button-Funktion
function Library:AddButton(config)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 200, 0, 40)
    Button.Position = UDim2.new(0, 10, 0, (#ContentFrame:GetChildren() - 0) * 45)
    Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 16
    Button.Text = config.Text or "Click Me"
    Button.Parent = ContentFrame

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
