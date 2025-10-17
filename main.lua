
local exti = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pyth0n1zed/GUI-Framework-Roblox/refs/heads/main/script.lua"))()()
local Players = game:GetService("Players")
local hitbox = Instance.new("Part")
local VirtualInputManager = game:GetService("VirtualInputManager") or getvirtualinputmanager()
local player = Players.LocalPlayer
local uis = game:GetService("UserInputService")
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera
local itemsFolder = workspace:FindFirstChild("Items")
local map = workspace:FindFirstChild("Map")
local ts = game:GetService("TweenService")
local rs = game:GetService("RunService")
local events = game.ReplicatedStorage:FindFirstChild("Events")
if map then
    local originOffice = map:FindFirstChild("OriginOffice")
    if originOffice then
        originOffice:Destroy()
    end
end
local ok = true
task.spawn(function()
	while true do
		local asd = player.PlayerGui:FindFirstChild("Countdown")
		if asd then
			if tonumber(asd.Countdown.TimeLeft.Text) < 3 then
				ok = false
				task.wait(9)
				ok = true
				asd:Destroy()
			end
		end
	task.wait(0.5)
	end
end)


local moveDelay = 0.51
local pauseTime = 0.09

local function moveTo(part)
    local direction = (part.Position - hrp.Position).Unit
    local targetPos = part.Position - direction * 3
    local targetCF = CFrame.new(targetPos)
    hrp.CFrame = targetCF
end

local function moveTo2(part)
    local direction = (part.Position - hrp.Position).Unit
    local targetPos = part.Position + direction * 3
    local targetCF = CFrame.new(targetPos)
    hrp.CFrame = targetCF
end

local function faceTarget(part)
    local lookC = CFrame.lookAt(hrp.Position,part.Position)
	local _,y,_ = lookC:ToEulerAnglesYXZ()
	local finalC = CFrame.Angles(0,y,0)
	hrp.CFrame=hrp.CFrame*finalC
	-- no more weird maths

end

local function rotateCameraTo(part)
    local camPos = camera.CFrame.Position
    local lookAt = part.Position
    camera.CFrame = CFrame.new(camPos, lookAt)
end

local function sendFKey()
    for _ = 1, 3 do
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
        task.wait(0.05)
    end
end

local function sendSpaceKey()
	VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
	task.wait(0.05)
	VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
end

local function CollectItemsSR(itemNames, repeatCount)
    repeatCount = repeatCount or 3
	local ii = 1
    for i = 1, repeatCount do
        for _, tool in ipairs(itemsFolder:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Handle") and table.find(itemNames, tool.Name) and ok then
				local currentItems = 0
				for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					currentItems = currentItems + 1
				end
				local currentcurrentItems = 0
                local handle = tool.Handle
                moveTo(handle)
                task.wait(pauseTime)
                faceTarget(handle)
                rotateCameraTo(handle)
                task.wait(pauseTime)
				if ii == 1 then task.wait(5) end
                sendFKey()
                task.wait(pauseTime)
                sendSpaceKey()
                task.wait(moveDelay)
				for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
					currentcurrentItems = currentcurrentItems + 1
				end
				if currentcurrentItems == currentItems then
					moveTo2(handle)
                	task.wait(pauseTime)
                	faceTarget(handle)
                	rotateCameraTo(handle)
                	task.wait(pauseTime)
                	sendFKey()
                	task.wait(pauseTime)
                	sendSpaceKey()
               		task.wait(moveDelay)
				end
				ii = ii + 1
            elseif not ok then
                task.wait(12)
				sendSpaceKey()
				task.wait(10)
				for i = 1, 2 do
   					VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.I, false, game)
    				task.wait(0.1) -- hold
    				VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.I, false, game)
    				task.wait(0.2) -- wait between presses
				end
            end
        end
    end
    hrp.CFrame = hrp.CFrame + Vector3.new(0,200,0)
end


local function CollectAllPermanentItemsSR()
    CollectItemsSR({"Potion of Strength", "Frog Potion", "Speed Potion", "Boba", "Bull's essence"},5)
end

local function CollectAllStrengthItemsSR()
    CollectItemsSR({"Bull's essence","Potion of Strength","Boba","True Power","Sphere of fury"},5)
end

local function CollectAllOneShottyItemsSR()
    CollectItemsSR({"Cube of Ice","Bull's essence","Potion of Strength","Boba","True Power","Sphere of fury"},5)
end

local function CollectAllHealingItemsSR()
    CollectItemsSR({"Apple","Bandage","First Aid Kit","Healing Potion","Potion of Healing","Boba"},5)
end

local function CollectAllItemsSR()
	CollectItemsSR({"Potion of Strength","Frog Potion","Speed Potion","Boba","Bull's essence","True Power","Sphere of fury","Cube of Ice","Apple","Bandage","First Aid Kit","Healing Potion","Potion of Healing"},5)
end

local auraDist = 30

local auraEnabled = false
local hasGloveEquipped = false

local function updateGloveStatus()
	hasGloveEquipped = false
	for _, v in ipairs(character:GetChildren()) do
		if v:IsA("Tool") and v:FindFirstChild("Glove") then
			hasGloveEquipped = true
			break
		end
	end
end

character.ChildAdded:Connect(updateGloveStatus)
character.ChildRemoved:Connect(updateGloveStatus)

local auraRange = Instance.new("Part")
auraRange.Shape = Enum.PartType.Ball
auraRange.Parent = character
auraRange.Transparency = 0.9
auraRange.Size = Vector3.new(auraDist*2,auraDist*2,auraDist*2)
auraRange.CanCollide = false



rs.RenderStepped:Connect(function()
	
	if not hasGloveEquipped then return end
	if auraEnabled then
		auraRange.Transparency = 0.9
	else
		auraRange.Transparency=1
		return
	end
	for _,v in pairs(game.Players:GetPlayers()) do
		if v==player then continue end
		local tchar = v.Character
		local thrp = tchar:FindFirstChild("HumanoidRootPart")
		local dist = (hrp.Position - thrp.Position).Magnitude
		if dist < auraDist + 1 then events:FindFirstChild("Slap"):FireServer(thrp) end
	end
end)

function auraOn()
	auraEnabled = true
end

function auraOff()
	auraEnabled = false
end


function UseAllPermanentItemsSR()
	for _,v in pairs(player:GetDescendants()) do
		if v.Name == "Bull's essence" or v.Name == "Speed Potion" or v.Name == "Frog Potion" or v.Name == "Boba" or v.Name == "Potion of Strength" then
			v.Parent = character
			v:Activate()
			task.wait(0.05)
		end
	end
end
function UseAllOneshotItemsSR()
	for _,v in pairs(player:GetDescendants()) do
		if v.Name == "Bull's essence" or v.Name == "Cube of Ice" or v.Name == "Sphere of fury" or v.Name == "Boba" or v.Name == "Potion of Strength" then
			v.Parent = character
			v:Activate()
			task.wait(0.05)
		end
	end
end
function UseAllItemsSR()
	for _,v in pairs(player:GetDescendants()) do
		if v:IsA("Tool") then
			v.Parent = character
			v:Activate()
			task.wait(0.05)
		end
	end
end
function Teleporttomatchmaking()
	game:GetService("TeleportService"):Teleport(9426795465,game.Players.LocalPlayer)
end

function espCreate()
	for _,v in pairs(game.Players:GetPlayers()) do
		local c = v.Character
		local highlight = Instance.new("Highlight")
		local billboard = Instance.new("BillboardGui")
		local textLabel = Instance.new("TextLabel")

		highlight.Adornee = c
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Enabled = true
		highlight.OutlineColor = Color3.fromRGB(255,0,255)
		highlight.FillTransparency = 1
		highlight.Parent = c

		billboard.Parent = c.Head
		billboard.Size = UDim2.new(0,200,0,50)
		billboard.AlwaysOnTop = true
		billboard.StudsOffset = Vector3.new(0,3,0)

		textLabel.Parent = billboard
		textLabel.Size = UDim2.new(1, 0, 1, 0)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = v.Name
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.TextStrokeTransparency = 0
		textLabel.TextScaled = true
		task.spawn(function()
			while true do
				local distance = (camera.CFrame.Position - character.Head.Position).Magnitude
				billboard.Size = UDim2.new(0, math.clamp(500 / distance, 50, 200), 0, math.clamp(500 / distance, 25, 200))
				wait(0.5)
				if c.Humanoid.Health == 0 then
					highlight:Destroy()
					billboard:Destroy()
				end
			end
		end)

	end
 end

local function destroyESP()
	for _,v in pairs(game.Players:GetPlayers()) do
		v.Character:FindFirstChild("Highlight"):Destroy()
		v.Character.Head:FindFirstChild("BillboardGui"):Destroy()
	end
end
local loopgoto = false
local name = ""
function loopgotoname(t)
	for i,v in pairs(game.Players:GetPlayers()) do
		if string.find(v.Name:lower(),t:lower()) then
			name = v.Name
			break
		end
	end
end

function loopgotoenable(t)
	loopgoto = not loopgoto
	print(loopgoto)
end

task.spawn(function()
while true do
	for _,v in pairs(game.Players:GetPlayers())do	
		if v.Name == name and loopgoto and v.Character.Humanoid.Health > 0 then
			hrp:PivotTo(v.Character.HumanoidRootPart.CFrame)
		end
	end
	wait(0.01)
end
end)

function AutoKill()
	auraOn()
	for i = 1, 1000 do
		for i,v in pairs(game.Players:GetPlayers()) do
			if not v.Character then continue end
			if not v.Character:FindFirstChild("Humanoid") then continue end
			if character.Humanoid.Health == 0 then continue end
			if v.Character.Humanoid.Health > 0 then
				name = v.Name
			end
			wait(3.5)
			continue
		end
	end
end

function AutoWin()
	auraOn()
	CollectAllOneShottyItemsSR()
	while true do
		if not player.PlayerGui:FindFirstChild("Countdown") then break end task.wait(0.1)
	end
	UseAllOneshotItemsSR()
	for i = 1, 10 do
		sendSpaceKey()
		task.wait(0.8)
	end
	for _,v in pairs(player:GetDescendants()) do
		if v:FindFirstChild("Glove") and v:IsA("Tool") then
		    v.Parent = character
			v:Activate()
		end
	end
	loopgoto = true
	local zone = game.Workspace:WaitForChild("Zone1")
	task.wait(3)
	local centerpos = zone.Position
	local targetpos = centerpos - Vector3.new(0,90,0)
	local part = Instance.new("Part")
	part.Parent = game.Workspace
	
	part.Anchored = true
	part.CanCollide = true
	part.Size = Vector3.new(50,2,50)
	part.Position = targetpos

	hrp.CFrame = CFrame.new(targetpos + Vector3.new(0,5,0))
	
	wait(1)
	hrp:PivotTo(part.CFrame + Vector3.new(0,1,0))
	local alive = 20
	while wait(0.1) do
		
		local aliveLabel = player.PlayerGui.HUD.HUD.AliveCounter.CounterLabel

		local function getAliveCount()
    		local text = tostring(aliveLabel.Text)
    		local num = text:match("%d+") 
    		return tonumber(num) or 0
		end

		if getAliveCount() < 7 then
    		break
		end

		hrp:PivotTo(part.CFrame + Vector3.new(0,1,0))
	end
	AutoKill()
end

local sIndex = 0
local spectate = false

function searchPlayers(index)
	for i,v in pairs(game.Players:GetPlayers()) do
		if not spectate then break end
		if i == index and v.Character and v.Character:FindFirstChild("Humanoid") then
			return v
		elseif not v.Character or not v.Character:FindFirstChild("Humanoid") then
			continue
		end
	end
	return "skibidi"
end

local function cyclespec()
	local validPlayer
	repeat
		sIndex = sIndex + 1
		if sIndex > #game.Players:GetPlayers() then sIndex = 1 end

		validPlayer = searchPlayers(sIndex)
		if validPlayer == "skibidi" then return end
		task.wait(0.1)
	until validPlayer ~= false or validPlayer ~= "skibidi"
	camera.CameraSubject = validPlayer.Character.Humanoid
end

function spectoggle()
	spectate = not spectate
	if not spectate then
		camera.CameraSubject = character.Humanoid
	end
end
local hi = false
local mapRemove = false
local part1
function killRandomWithVoid()
	mapRemove = true
	task.wait(0.5)
	character:PivotTo(CFrame.new(-77.1818771, 5.79619646, -702.108704))
	task.wait(2)
	VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
	task.wait(5.8)
	VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
	for i,v in pairs(game.Players:GetPlayers()) do
		if v.Character then
			if v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 and v ~= game.Players.LocalPlayer then
				local dir = (v.Character.HumanoidRootPart.Position - hrp.Position).Unit
				local tpos1 = v.Character.HumanoidRootPart.Position + dir*3
				local tpos2 = v.Character.HumanoidRootPart.Position - dir*3
				tcf1 = CFrame.new(tpos1)
				tcf2 = CFrame.new(tpos2)
				hrp:PivotTo(tcf1)
				wait(0.3)
				auraOn()
				wait(0.2)
				auraOff()
				break
			end
		end
	end
	if game.Workspace:FindFirstChild("Zone1") then
		if part1 then
			character:PivotTo(part1.CFrame + Vector3.new(0,5,0))
		else
			character:PivotTo(game.Workspace.Zone1.CFrame + Vector3.new(0,50,0))
		end
		mapRemove = false
	else
		character:PivotTo(CFrame.new(4.3729744, -44.6337852, -713.86615))	
	end
end
local mapClone = game.Workspace.Map:Clone()
task.spawn(function()
	while true do
		if mapRemove and game.Workspace:FindFirstChild("Map") then
			game.Workspace.Map:Destroy()
		elseif not game.Workspace:FindFirstChild("Map") and not mapRemove then
			mapClone.Parent = game.Workspace
			mapClone = nil
			mapClone = game.Workspace.Map:Clone()
		end
		
		task.wait()
	end
end)

task.spawn(function()
			while true do
				if hi and part1 then
					killRandomWithVoid()
					hrp.CFrame = part1.CFrame + Vector3.new(0,5,0)
					wait(70)
				end
				task.wait(2)
			end
		end)
function AutoWinVoid()
	CollectAllOneShottyItemsSR()
	while true do
		if not player.PlayerGui:FindFirstChild("Countdown") then break end task.wait(0.1)
	end
	for i = 1, 10 do
		sendSpaceKey()
		task.wait(0.8)
	end
	for _,v in pairs(player:GetDescendants()) do
		if v:FindFirstChild("Glove") and v:IsA("Tool") then
		    v.Parent = character
			v:Activate()
		end
	end
	loopgoto = true
	local zone = game.Workspace:WaitForChild("Zone1")
	task.wait(3)
	local centerpos = zone.Position
	local targetpos = centerpos - Vector3.new(0,90,0)
	local part = Instance.new("Part")
	part.Parent = game.Workspace
	
	part.Anchored = true
	part.CanCollide = true
	part.Size = Vector3.new(50,2,50)
	part.Position = targetpos
	part1 = part

	local size = part.Size
	local cf = part.CFrame

	local wallThickness = 5
	local wallHeight = 25
	local color = Color3.fromRGB(130, 130, 130)

	local function makePart(offset, partSize)
		local p = Instance.new("Part")
		p.Anchored = true
		p.Color = color
		p.Size = partSize
		p.CFrame = cf * CFrame.new(offset)
		p.Parent = workspace
		return p
	end

	makePart(Vector3.new(0, wallHeight/2 + size.Y/2, -size.Z/2 + wallThickness/2), Vector3.new(size.X + wallThickness*2, wallHeight, wallThickness)) -- front
	makePart(Vector3.new(0, wallHeight/2 + size.Y/2, size.Z/2 - wallThickness/2), Vector3.new(size.X + wallThickness*2, wallHeight, wallThickness))  -- back
	makePart(Vector3.new(-size.X/2 + wallThickness/2, wallHeight/2 + size.Y/2, 0), Vector3.new(wallThickness, wallHeight, size.Z))                 -- left
	makePart(Vector3.new(size.X/2 - wallThickness/2, wallHeight/2 + size.Y/2, 0), Vector3.new(wallThickness, wallHeight, size.Z))                  -- right

	makePart(Vector3.new(0, wallHeight + size.Y/2, 0), Vector3.new(size.X + wallThickness*2, wallThickness, size.Z + wallThickness*2))             -- roof

	
	hrp.CFrame = CFrame.new(targetpos + Vector3.new(0,5,0))

	while true do
		local aliveLabel = player.PlayerGui.HUD.HUD.AliveCounter.CounterLabel
		hi = true
		local function getAliveCount()
    		local text = tostring(aliveLabel.Text)
    		local num = text:match("%d+") 
    		return tonumber(num) or 0
		end

		if getAliveCount() < 7 then
			hi = false
    		break
		end
		task.wait(2)
	end
	UseAllOneshotItemsSR()
	AutoKill()
	part1 = nil
end


exti:SetTitle("exti hub")
local main = exti:CreateTab("Main", 1)
local items = exti:CreateTab("Items", 2)
local auto = exti:CreateTab("Auto",3)
local misc = exti:CreateTab("Misc", 4)

exti:CreateButton(main,"toggle","Slap Aura","Automatically slaps for you with extended hitbox",1,auraOn,auraOff)
exti:CreateLabel(items,"Collect Items (best used before match starting", 1)
exti:CreateButton(items,"trigger","Item Vaccum","Automatically collects all items",2,CollectAllItemsSR)
exti:CreateButton(items,"trigger","Oneshot Item Vaccum","Automatically collects all items that help you oneshot people.",3,CollectAllOneShottyItemsSR)
exti:CreateButton(items,"trigger","Strength Item Vaccum","Automatically collects all items that increase your strength.",4,CollectAllStrengthItemsSR)
exti:CreateButton(items,"trigger","Permanent Buff Item Vaccum","Automatically collects all items that increase your stats permanently.",5,CollectAllPermanentItemsSR)
exti:CreateButton(items,"trigger","Heal Item Vaccum","Automatically collects all items that heal you.",6,CollectAllHealingItemsSR)
exti:CreateLabel(items,"Auto-Use Items", 7)
exti:CreateButton(items,"trigger","Use All Items","Automatically equips and uses all the items in your inventory.",8,UseAllItemsSR)
exti:CreateButton(items,"trigger","Use All Permanent Boosts","Automatically equips and uses all items that give a permanent boost to stats.",9,UseAllPermanentItemsSR)
exti:CreateButton(items,"trigger","Use All Oneshot Items","Automatically equips all items that help you oneshot people.",10,UseAllOneshotItemsSR)
exti:CreateButton(misc,"trigger","Teleport to Slap Royale matchmaking","Automatically teleports you to the slap royale matchmaking place to start a new game",1,Teleporttomatchmaking)
exti:CreateButton(misc,"toggle","ESP","See where players are at and their usernames.",2,espCreate,destroyESP)
exti:CreateTextInput(misc,"Loop Goto","Basically stick to a player by constantly teleporting towards them (Supports name shorthands)",3,loopgotoname)
exti:CreateButton(misc,"toggle","Loop Goto Enable","Enable Loop Goto",4,loopgotoenable,loopgotoenable)
exti:CreateButton(auto,"trigger","Auto win","Automatically wins the game for you (EXPERIMENTAL)",1,AutoWin)
exti:CreateButton(auto,"trigger","Auto Kill","Automatically teleports to everybody in the server and kills them",2,AutoKill)
exti:CreateLabel(misc, "Spectate players", 5)
exti:CreateButton(misc, "trigger", "Spectate Cycle", "Cycle between spectating players", 6, cyclespec)
exti:CreateButton(misc, "toggle", "Enable spectate", "Enables spectating", 7, spectoggle, spectoggle)
exti:CreateButton(auto,"trigger","Kill random person with void","Requires void, teleports them into acid (RNG)", 3, killRandomWithVoid)
exti:CreateButton(auto,"trigger","Auto win with void method","Requires void, automatically wins for you(RNG AF)", 4, AutoWinVoid)
exti:FinishLoading()
if map then
    local originOffice = map:FindFirstChild("OriginOffice")
    if originOffice then
        originOffice:Destroy()
    end
end
