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


local moveDelay = 1.5
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
            if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
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

local auraDist = 50

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


rs.RenderStepped:Connect(function()
	if not auraEnabled or not hasGloveEquipped then return end
	for _,v in pairs(game.Players:GetPlayers()) do
		if v==player then continue end
		local tchar = v.Character
		local thrp = tchar.HumanoidRootPart
		local dist = (hrp.Position - thrp.Position).Magnitude
		if dist < auraDist + 1 then events:FindFirstChild("Slap"):FireServer(thrp) end
	end
end



local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "ExtiHub"

local names = {"Slap Aura (OFF)", "Item Vacuum", "Item Vacuum (OP Only)"}
local funcs = {
	function(btn)
		auraEnabled = not auraEnabled
		btn.Text = auraEnabled and "Slap Aura (ON)" or "Slap Aura (OFF)"
	end,
	function()
		CollectAllItemsSR()
	end,
	function()
		CollectAllOneShottyItemsSR()
	end
}

for i, text in ipairs(names) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.09, 0, 0.04, 0)
	btn.Position = UDim2.new(0.015, 0, 1 - (i * 0.06), 0)
	btn.BackgroundColor3 = Color3.fromRGB(39, 36, 54)
	btn.TextColor3 = Color3.fromRGB(238, 238, 238)
	btn.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json")
	btn.TextSize = 11
	btn.Text = text
	btn.Parent = gui

	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	local tweenIn = ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(69, 66, 84)})
	local tweenOut = ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(39, 36, 54)})

	btn.MouseEnter:Connect(function() tweenIn:Play() end)
	btn.MouseLeave:Connect(function() tweenOut:Play() end)
	btn.MouseButton1Click:Connect(function() funcs[i](btn) end)
end







