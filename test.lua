-- MyLibrary.lua
local Library = {}

-- Funktion zum Erstellen eines Buttons
function Library:AddButton(config)
    -- ScreenGui erstellen, falls nicht vorhanden
    local gui = game.CoreGui:FindFirstChild("MyCustomGui")
    if not gui then
        gui = Instance.new("ScreenGui")
        gui.Name = "MyCustomGui"
        gui.Parent = game.CoreGui
    end

    -- Frame für den Button
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 100)
    frame.Position = UDim2.new(0.5, -100, 0.5, -50)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.Parent = gui

    -- Button erstellen
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 180, 0, 50)
    button.Position = UDim2.new(0, 10, 0, 25)
    button.Text = config.Text or "Click Me"
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = frame

    -- Klick-Logik
    local lastClick = 0
    button.MouseButton1Click:Connect(function()
        if config.DoubleClick then
            local now = tick()
            if now - lastClick <= 0.5 then -- 0.5 Sek. für Doppelklick
                pcall(config.Func)
            else
                print("Double-click needed!")
            end
            lastClick = now
        else
            pcall(config.Func)
        end
    end)

    return button
end

return Library
