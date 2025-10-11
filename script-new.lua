local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager") or getvirtualinputmanager()
local player = Players.LocalPlayer
local uis = game:GetService("UserInputService")
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera
local itemsFolder = workspace:WaitForChild("Items")
local map = workspace:FindFirstChild("Map")
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

