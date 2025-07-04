local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Fentanyl", "DarkTheme")

local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Main")

Section:NewButton("Get Free Wins","",function()
local args = {
    [1] = "Medium Wins Pack";
    [2] = 1;
}

game:GetService("ReplicatedStorage"):WaitForChild("RemotesMain", 9e9):WaitForChild("GiveDailyReward", 9e9):FireServer(unpack(args))
end)

Section:NewButton("Get Free Power","",function()
local args = {
    [1] = "Power 4";
    [2] = 250;
    [3] = 0;
}

game:GetService("ReplicatedStorage"):WaitForChild("RemotesMain", 9e9):WaitForChild("ClaimFreeGift", 9e9):FireServer(unpack(args))
end)

Section:NewButton("Get x85 Pet","",function()
local args = {
    [1] = "Poison_Butterfly";
    [2] = 1;
    [3] = 0;
}

game:GetService("ReplicatedStorage"):WaitForChild("RemotesMain", 9e9):WaitForChild("ClaimFreeGift", 9e9):FireServer(unpack(args))
end)

Section:NewButton("Get Best Title (1/2M)","",function()
-- Generated with Sigma Spy Github: https://github.com/depthso/Sigma-Spy
-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Remote
local ObtainedTitle = ReplicatedStorage.RemotesMain.ObtainedTitle -- RemoteEvent 

ObtainedTitle:FireServer(
    "TheWinner"
)

end)
