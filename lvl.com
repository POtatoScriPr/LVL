

--DONT STEAL



---// ANTI-KICK
local mt = getrawmetatable(game)
local ncallsa = mt.__namecall
	setreadonly(mt, false)
	mt.__namecall = newcclosure(function(...)
		local args = {...}
		if not checkcaller() and getnamecallmethod() == "Kick" then
			return nil
		end
		return ncallsa(...)
	end)
	setreadonly(mt, true)
--//
	
--// ANTI-BAN
	local mmt = getrawmetatable(game)

local oldnamecall = mmt.__namecall

setreadonly(mmt, false)

mmt.__namecall = newcclosure(function(self, ...)
   local method = tostring(getnamecallmethod())
   local Args = {...}
   if not checkcaller() and method == "FireServer" and tostring(self) == "Banned" then
       return nil
   end
   
   return oldnamecall(self, ...)
end)

setreadonly(mmt, true)
	
	local gmt = getrawmetatable(game);
setreadonly(gmt, false);
local old_index = gmt.__index;
gmt.__index = function(a, b)
    if tostring(a) == "BannedA" or tostring(a) == "BannedB" or tostring(a) == "BannedC" or tostring(a) == "BannedD" then
        if tostring(b) == "Value" then
            return false;
        end
    end
    return old_index(a, b);
end

local bgmt = getrawmetatable(game);
setreadonly(bgmt, false);
local bold_index = bgmt.__index;
bgmt.__index = function(a, b)
    if tostring(a) == "BCount" then
        if tostring(b) == "Value" then
            return 0;
        end
    end
    return bold_index(a, b);
end

for i,BN in pairs(game:GetService("Workspace").FE.Settings:GetChildren()) do
    if BN.Name == "BName" then
    BN:Destroy()
end
end
--//

--// ANTI-WALKSPEED AND ANTI-JUMPPOWER
for i,b in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if b.Name == " " then
    b:Destroy()
end
end

for i,lc2 in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if lc2:IsA("LocalScript") and string.match(lc2.Name, "1") or string.match(lc2.Name, "2") or string.match(lc2.Name, "3") or string.match(lc2.Name, "4") or string.match(lc2.Name, "5") or string.match(lc2.Name, "6") or string.match(lc2.Name, "7") or string.match(lc2.Name, "8") or string.match(lc2.Name, "9") then
       lc2:Destroy()
    end
end

for i,lc in pairs(game.Players.LocalPlayer.PlayerGui.Start:GetChildren()) do
    if lc:IsA("LocalScript") and string.match(lc.Name, "1") or string.match(lc.Name, "2") or string.match(lc.Name, "3") or string.match(lc.Name, "4") or string.match(lc.Name, "5") or string.match(lc.Name, "6") or string.match(lc.Name, "7") or string.match(lc.Name, "8") or string.match(lc.Name, "9") then
       lc:Destroy()
    end
end

for i,c in pairs(game.Players.LocalPlayer.PlayerGui.Start:GetChildren()) do
    if c.Name == "CheckPlayerW" then
    c:Destroy()
end
end

for i,z in pairs(game.StarterGui.Start:GetChildren()) do
    if z.Name == "CheckPlayerW" then
    z:Destroy()
end
end

for _, v in pairs(game.StarterPlayer.StarterCharacterScripts:GetDescendants()) do
if v.Name == " " then
v:Destroy()
end
end

game.Players.LocalPlayer.CharacterAdded:Connect(function()
wait(0.5)
for i,char in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if char.Name == " " then
       char:Destroy()
    end
    end
end)
--//

--// ANTI-LAG (REMOVES LAG FROM GUI)
for i,nolag in pairs(game.StarterGui.Start:GetChildren()) do
if nolag.Name == "Gradient" then
nolag:Destroy()
end
end
for i,nolaglp in pairs(game.Players.LocalPlayer.PlayerGui.Start:GetChildren()) do
if nolaglp.Name == "Gradient" then
nolaglp:Destroy()
end
end
--//

--// FUNCTIONS, VARIABLES AND SCRIPTS //--
function GetPlayer(String)
	local Foundplr = {}
	local strl = String:lower()
	if strl == "all" then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			table.insert(Foundplr,v)
		end
	elseif strl == "others" then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Name ~= game.Players.LocalPlayer.Name then
				table.insert(Foundplr,v)
			end
		end
	elseif strl == "me" then
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Name == game.Players.LocalPlayer.Name then
				table.insert(Foundplr,v)
			end
		end
	else
		for i,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.DisplayName:lower():sub(1, #String) == String:lower() or v.Name:lower():sub(1, #String) == String:lower() then
				table.insert(Foundplr,v)
			end
		end
	end
	return Foundplr
end

local RS
local LeftLeg
local RightLeg
local LeftFoot
local RightFoot
local Distance = 0
local DistanceTackle = 0
local DistanceReach = 0
local DistancePass = 0
local DistanceWalk = 0
local DistanceSide = 0
local DistanceJump = 0
local SaveDelay = 0
local Heartbeat
local HumanoidDied
local TouchedBallLoop
local RunStepped2
local RunStepBall
local AddBallA
local TouchedGKBallBox

local Player = game.Players.LocalPlayer
local RootPart = Player.Character.HumanoidRootPart

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/cypherdh/VanisUILIB/main/.gitignore'))()

local Window = library:CreateWindow("TPS: Street Soccer", "Version: 1.48", 10044538000)

local Tab = Window:CreateTab("LEVEL SCRIPT")

local LPPage = Tab:CreateFrame("LEVEL")

LPPage:CreateLabel("Level Spoofer")

LPPage:CreateBox("Level", 10044538000, function(arg)
local Targets
	Targets = tonumber(arg)
	wait(0.1)
	local mt = getrawmetatable(game);
setreadonly(mt, false);
local old_index = mt.__index;
mt.__index = function(a, b)
    if tostring(a) == "PPLevel" or tostring(a) == "Level" then
        if tostring(b) == "Value" then
            return Targets;
        end
    end
    return old_index(a, b);
end
end)

LPPage:CreateBox("XP", 10044538000, function(arg)
local Targetz
	Targetz = tonumber(arg)
	wait(0.1)
	local mt = getrawmetatable(game);
setreadonly(mt, false);
local old_index = mt.__index;
mt.__index = function(a, b)
    if tostring(a) == "XP" then
        if tostring(b) == "Value" then
            return Targetz;
        end
    end
    return old_index(a, b);
end
end)
