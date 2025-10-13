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
local ok = true
task.spawn(function()
	if player.PlayerGui:FindFirstChild("Countdown") then
		local ctxt = player.PlayerGui.Countdown.Countdown.TimeLeft.Text
		if tonumber(ctxt) < 4 then
			ok = false
			task.wait(5)
			ok = true
		end
	end
end)
if map then
    local originOffice = map:FindFirstChild("OriginOffice")
    if originOffice then
        originOffice:Destroy()
    end
end


local moveDelay = 0.2
local pauseTime = 0.5

local function moveTo(part)
    character:PivotTo(part.CFrame)
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
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
	task.wait(0.05)
	VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
end

local function CollectAllItemsSR()
    for i=1,3 do
        for _, tool in ipairs(itemsFolder:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Handle") and ok then
                local handle = tool.Handle
                moveTo(handle)
                task.wait(pauseTime)
                faceTarget(handle)
                rotateCameraTo(handle)
                task.wait(pauseTime)
                sendFKey()
			else if not ok then
				task.wait(5)
            end
			task.wait(moveDelay)
        end
    end
end

local function CollectAllPermaBuffsSR()
    for i=1,3 do
        for _, tool in ipairs(itemsFolder:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Handle") and (tool.Name=="Bull's essence" or tool.Name=="Potion of Strength" or tool.Name=="Frog Potion" or tool.Name=="Speed Potion" or tool.Name=="Boba") then
                local handle = tool.Handle
                moveTo(handle)
                task.wait(pauseTime)
                faceTarget(handle)
                rotateCameraTo(handle)
                task.wait(pauseTime)
                sendFKey()
            end
        end
    end
end

local function CollectAllStrengthItemsSR()
    for i=1,3 do
        for _, tool in ipairs(itemsFolder:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Handle") and (tool.Name=="Bull's essence" or tool.Name=="Potion of Strength" or tool.Name=="Boba" or tool.Name=="True Power" or tool.Name=="Sphere of fury") then
                local handle = tool.Handle
                moveTo(handle)
                task.wait(pauseTime)
                faceTarget(handle)
                rotateCameraTo(handle)
                task.wait(pauseTime)
                sendFKey()
            end
        end
    end
end

local function CollectAllSpeedAndJumpItemsSR()
    for i=1,3 do
        for _, tool in ipairs(itemsFolder:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Handle") and (tool.Name=="Speed Potion" or tool.Name=="Frog Potion" or tool.Name=="Boba" or tool.Name=="Lightning Potion") then
                local handle = tool.Handle
                moveTo(handle)
                task.wait(pauseTime)
                faceTarget(handle)
                rotateCameraTo(handle)
                task.wait(pauseTime)
                sendFKey()
            end
        end
    end
end

local function CollectAllOneShottyItemsSR()
    CollectAllStrengthItemsSR()
    for i=1,3 do
        for _, tool in ipairs(itemsFolder:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Handle") and (tool.Name=="Cube of Ice") then
                local handle = tool.Handle
                moveTo(handle)
                task.wait(pauseTime)
                faceTarget(handle)
                rotateCameraTo(handle)
                task.wait(pauseTime)
                sendFKey()
            end
        end
    end
end

local function CollectAllHealingItemsSR()
    for i=1,3 do
        for _, tool in ipairs(itemsFolder:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Handle") and (tool.Name=="Apple" or tool.Name=="Bandage" or tool.Name:lower()=="first aid kit" or tool.Name=="Healing Potion" or tool.Name=="Potion of Healing" or tool.Name=="Boba") then
                local handle = tool.Handle
                moveTo(handle)
                task.wait(pauseTime)
                faceTarget(handle)
                rotateCameraTo(handle)
                task.wait(pauseTime)
                sendFKey()
            end
        end
    end
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
		local thrp = tchar.HumanoidRootPart
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

exti:SetTitle("exti hub")
local main = exti:CreateTab("Main", 1)
local items = exti:CreateTab("Items", 2)
exti:CreateButton(main,"toggle","Slap Aura","Automatically slaps for you with extended hitbox",1,auraOn,auraOff)
exti:CreateLabel(items,"Collect Items", 1)
exti:CreateButton(items,"trigger","Item Vaccum","Automatically collects all items",2,CollectAllItemsSR)
exti:CreateButton(items,"trigger","Oneshot Item Vaccum","Automatically collects all items that help you oneshot people.",3,CollectAllOneShottyItemsSR)
exti:CreateLabel(items,"Auto-Use Items", 4)
exti:CreateButton(items,"trigger","Use All Items","Automatically equips and uses all the items in your inventory.",5,UseAllItemsSR)
exti:CreateButton(items,"trigger","Use All Permanent Boosts","Automatically equips and uses all items that give a permanent boost to stats.",6,UseAllPermanentItemsSR)
exti:CreateButton(items,"trigger","Use All Oneshot Items","Automatically equips all items that help you oneshot people.",7,UseAllOneshotItemsSR)
exti:FinishLoading()
