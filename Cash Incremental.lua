local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Fentanyl", "DarkTheme")

local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Main")

Section:NewButton("Collect All Money","",function()
local spawnedFolder = game:GetService("Workspace"):WaitForChild("Spawned")
local remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("CollectPart", 9e9)

-- Funktion zum Überprüfen, ob ein String nur aus Zahlen besteht
local function isNumeric(str)
	return tonumber(str) ~= nil
end

-- Einmal alles abarbeiten
for _, part in ipairs(spawnedFolder:GetChildren()) do
	if isNumeric(part.Name) then
		local args = {
			[1] = part.Name
		}
		remote:FireServer(unpack(args))
	end
end
end)

Section:NewButton("Buy Rebirth (Level 20)","",function()
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Rebirth", 9e9):FireServer()
end)

Section:NewButton("Buy Automation Centre","",function()
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Automation", 9e9):FireServer()
end)

Section:NewButton("Buy Prestige","",function()
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Prestige", 9e9):FireServer()
end)

Section:NewButton("Buy Ascension","",function()
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Ascension", 9e9):FireServer()
end)



local Tab = Window:NewTab("Auto")
local Section = Tab:NewSection("Auto")

Section:NewToggle("Auto Collect All","",function(state)
if state then
autocollect = true
else
autocollect = false
end
end)


local Tab = Window:NewTab("Upgrade")
local Section = Tab:NewSection("Main Upgrade")

local max = false

Section:NewToggle("Max Upgrade","",function(state)
if state then
max = true
else
max = false
end
end)

--/ Cash Upgrades

Section:NewButton("More Cash","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreCash",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreCash",true,"Single")
end
end)

Section:NewButton("More Xp","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreXP",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreXP",true,"Single")
end
end)

Section:NewButton("More Bag Multi","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreBagMultiplier",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreBagMultiplier",true,"Single")
end
end)

Section:NewButton("More WalkSpeed","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreWalkspeed",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreWalkspeed",true,"Single")
end
end)

Section:NewButton("More Range","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreCollectionRange",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreCollectionRange",true,"Single")
end
end)

Section:NewButton("More Spawn Limit","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreCap",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreCap",true,"Single")
end
end)

Section:NewButton("Increase Spawn Rate","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","LessSpawnCooldown",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","LessSpawnCooldown",true,"Single")
end
end)

Section:NewButton("More Spawn Bulk","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreSpawnBulk",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreSpawnBulk",true,"Single")
end
end)

Section:NewButton("More Rebirth Points","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreRebirthPoints",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreRebirthPoints",true,"Single")
end
end)

Section:NewButton("More Shards","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreShards",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreShards",true,"Single")
end
end)

Section:NewButton("More Ascension Points","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreAscensionPoints",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("MainBoard","MoreAscensionPoints",true,"Single")
end
end)


--/ Xp Upgrades

local Section = Tab:NewSection("Xp Upgrade")

Section:NewButton("More Cash","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("XPUpgrades","XPMoreCash",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("XPUpgrades","XPMoreCash",true,"Single")
end
end)

Section:NewButton("More Xp","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("XPUpgrades","XPMoreXP",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("XPUpgrades","XPMoreXP",true,"Single")
end
end)

Section:NewButton("More Range","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("XPUpgrades","XPMoreRange",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("XPUpgrades","XPMoreRange",true,"Single")
end
end)

Section:NewButton("More Spawn Limit","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("XPUpgrades","XPMoreCap",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("XPUpgrades","XPMoreCap",true,"Single")
end
end)

Section:NewButton("Increase Spawn Rate","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("XPUpgrades","XPLessSpawnCooldown",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("XPUpgrades","XPLessSpawnCooldown",true,"Single")
end
end)

Section:NewButton("More Spawn Bulk","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("XPUpgrades","XPMoreBulk",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("XPUpgrades","XPMoreBulk",true,"Single")
end
end)

Section:NewButton("More Rebirth Points","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("XPUpgrades", "XPMoreRebirthPoints", true ,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("XPUpgrades", "XPMoreRebirthPoints", true ,"Single")
end
end)


--/Rebirth Upgrades
local Section = Tab:NewSection("Rebirth Upgrade")

Section:NewButton("More Cash","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("RebirthBoard","RebirthMoreCash",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("RebirthBoard","RebirthMoreCash",true,"Single")
end
end)

Section:NewButton("More Xp","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("RebirthBoard","RebirthMoreXP",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("RebirthBoard","RebirthMoreXP",true,"Single")
end
end)

Section:NewButton("Less Cooldown","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("RebirthBoard","RebirthLessCooldown",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("RebirthBoard","RebirthLessCooldown",true,"Single")
end
end)

Section:NewButton("More Shards","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("RebirthBoard","RebirthMoreShards",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("RebirthBoard","RebirthMoreShards",true,"Single")
end
end)

Section:NewButton("More Ascension Points","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("RebirthBoard","RebirthMoreAscensionPoints",true,"Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("Upgrade", 9e9):FireServer("RebirthBoard","RebirthMoreAscensionPoints",true,"Single")
end
end)


--/Ascension Upgrades
local Section = Tab:NewSection("Ascension Upgrade")

Section:NewButton("More Cash","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("AscensionUpgrade", 9e9):FireServer("AscensionMoreCash", "Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("AscensionUpgrade", 9e9):FireServer("AscensionMoreCash", "Single")
end
end)

Section:NewButton("More XP","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("AscensionUpgrade", 9e9):FireServer("AscensionMoreXP", "Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("AscensionUpgrade", 9e9):FireServer("AscensionMoreXP", "Single")
end
end)

Section:NewButton("More Rebirth Points","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("AscensionUpgrade", 9e9):FireServer("AscensionMoreRebirthPoints", "Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("AscensionUpgrade", 9e9):FireServer("AscensionMoreRebirthPoints", "Single")
end
end)

Section:NewButton("More Shards","",function()
if max == true then
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("AscensionUpgrade", 9e9):FireServer("AscensionMoreShards", "Max")
else
game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("AscensionUpgrade", 9e9):FireServer("AscensionMoreShards", "Single")
end
end)

--/ Auto Collect
while wait(0.25) do
if autocollect == true then
local spawnedFolder = game:GetService("Workspace"):WaitForChild("Spawned")
local remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 9e9):WaitForChild("CollectPart", 9e9)

-- Funktion zum Überprüfen, ob ein String nur aus Zahlen besteht
local function isNumeric(str)
	return tonumber(str) ~= nil
end

-- Einmal alles abarbeiten
for _, part in ipairs(spawnedFolder:GetChildren()) do
	if isNumeric(part.Name) then
		local args = {
			[1] = part.Name
		}
		remote:FireServer(unpack(args))
	end
end
else
end
end
