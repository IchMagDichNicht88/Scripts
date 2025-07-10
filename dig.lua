local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/Library.lua"))()

setclipboard("https://discord.gg/FentanylHub")
Library:Notify("discord invite copied", 1.5, soundId)

if Library.IsMobile then
Library:SetDPIScale(65)
end

local Window = Library:CreateWindow({
    Title = "FentaWare",
    Footer = "Dig",
	Icon = 121061267334054,
    ToggleKeybind = Enum.KeyCode.RightControl,
    Size = UDim2.fromOffset(725, 300),
    Center = true,
    AutoShow = true,
    ShowCustomCursor = false,
    MobileButtonsSide = "Left"
})

local MainTab = Window:AddTab("Main", "globe")

local RightGroupbox = MainTab:AddRightGroupbox("Dig", "shovel")

local LeftGroupbox = MainTab:AddLeftGroupbox("Sell", "circle-dollar-sign")

local Button = LeftGroupbox:AddButton({
    Text = "Sell All",
    Func = function()
    local args = {
    [1] = workspace:WaitForChild("World", 9e9):WaitForChild("NPCs", 9e9):WaitForChild("Rocky", 9e9);
}

game:GetService("ReplicatedStorage"):WaitForChild("DialogueRemotes", 9e9):WaitForChild("SellAllItems", 9e9):FireServer(unpack(args))
    end,
    DoubleClick = false
})


local local_player = game:GetService("Players").LocalPlayer
local workspace = game:GetService("Workspace")

local holes = workspace:WaitForChild("World"):WaitForChild("Zones"):WaitForChild("_NoDig")

local MyToggle = RightGroupbox:AddToggle("MyToggle", {
    Text = "Toggle Auto Dig",
    Default = false,
    Callback = function(Value)
    if Value then
    getgenv().enabled = true
    else
    getgenv().enabled = false
    end
    end
})

-- Funktion zum An-/Ausschalten
function setEnabled(state)
    getgenv().enabled = state
    print("Digging script enabled:", state)
end

function get_tool()
    return local_player.Character and local_player.Character:FindFirstChildOfClass("Tool")
end

local_player.Character.ChildAdded:Connect(function(v)
    if getgenv().enabled and v:IsA("Tool") and v.Name:find("Shovel") then
        task.wait(1)
        if holes:FindFirstChild(local_player.Name.."_Crater_Hitbox") then
            holes[local_player.Name.."_Crater_Hitbox"]:Destroy()
        end
        v:Activate()
    end
end)

local_player.PlayerGui.ChildAdded:Connect(function(v)
    if getgenv().enabled and v.Name == "Dig" then
        local strong_bar = v:WaitForChild("Safezone"):WaitForChild("Holder"):WaitForChild("Area_Strong")
        local player_bar = v:WaitForChild("Safezone"):WaitForChild("Holder"):WaitForChild("PlayerBar")

        player_bar:GetPropertyChangedSignal("Position"):Connect(function()
            if not getgenv().enabled then return end
            if math.abs(player_bar.Position.X.Scale - strong_bar.Position.X.Scale) <= 0.04 then
                local tool = get_tool()
                if tool then
                    tool:Activate()
                    task.wait()
                end
            end
        end)
    end
end)

local_player:GetAttributeChangedSignal("IsDigging"):Connect(function()
    if not getgenv().enabled then return end
    if not local_player:GetAttribute("IsDigging") then
        if holes:FindFirstChild(local_player.Name.."_Crater_Hitbox") then
            holes[local_player.Name.."_Crater_Hitbox"]:Destroy()
        end
        local tool = get_tool()
        if tool then
            tool:Activate()
        end
    end
end)



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
