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

hitbox.Parent = character
hitbox.CanCollide = false
hitbox.Size = Vector3.new(40,40,40)
hitbox.Transparency=0.8
rs.RenderStepped:Connect(function()
	hitbox.CFrame = hrp.CFrame
end)
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


hitbox.Touched:Connect(function(part)
	if auraEnabled and hasGloveEquipped and part.Parent:FindFirstChild("Humanoid") then
		game.ReplicatedStorage.Events.Slap:FireServer(part.Parent.HumanoidRootPart)
	end
	task.wait(0.05)
end)



local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "ExtiHub"

local names = {"Slap Aura (OFF)", "Item Vacuum", "Item Vacuum (OP Only)"}
local funcs = {}
local ts = game:GetService("TweenService")



-- Button actions
funcs[1] = function(btn)
	auraEnabled = not auraEnabled
	btn.Text = auraEnabled and "Slap Aura (ON)" or "Slap Aura (OFF)"
	print("Slap Aura is now", auraEnabled and "ON" or "OFF")
end

funcs[2] = function()
	print("Running Item Vacuum")
	CollectAllItemsSR()
end

funcs[3] = function()
	print("Running Item Vacuum (OP Only)")
	CollectAllOneShottyItemsSR()
end

for i, text in ipairs(names) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.25, 0, 0.07, 0)
	btn.Position = UDim2.new(0.025 + (i-1)*0.32, 0, 0.02, 0)
	btn.BackgroundColor3 = Color3.fromRGB(39, 36, 54)
	btn.TextColor3 = Color3.fromRGB(238, 238, 238)
	btn.Font = Enum.Font.Inconsolata
	btn.TextSize = 18
	btn.Text = text
	btn.Parent = gui
	btn.Name = "Button"..i
	local uic = Instance.new("UICorner", btn)
	uic.CornerRadius = UDim.new(0, 10)
	local tweenIn = ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(69, 66, 84)})
	local tweenOut = ts:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(39, 36, 54)})
	btn.MouseEnter:Connect(function() tweenIn:Play() end)
	btn.MouseLeave:Connect(function() tweenOut:Play() end)
	btn.MouseButton1Click:Connect(function()
		funcs[i](btn)
	end)
end

