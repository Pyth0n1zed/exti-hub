local ts = game:GetService("TweenService")
local vim = game:GetService("VirtualInputManager")
local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local plr = game.Players.LocalPlayer
local char = plr.Character
local items = game.Workspace.Items
local camera = game.Workspace.CurrentCamera
local thevoid = Instance.new("Folder",game.ReplicatedStorage)
local originOffice = game.Workspace.Map:FindFirstChild("OriginOffice")
if originOffice then
    originOffice:Destroy()
end
local inMatch = false

task.spawn(function()
	while task.wait(0.1) do
		if game.Workspace:FindFirstChild("Lobby") then
			inMatch = false
		else
			inMatch = true
		end
	end
end)

function presskey(key,hold)
	vim:SendKeyEvent(true, key, false, game)
    task.wait(hold)
	vim:SendKeyEvent(false, key, false, game)
end

function freezePlayer()
	for _,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Anchored = true
			v.CanCollide = false
		end
	end
end
function unfreezePlayer()
	for _,v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Anchored = false
			v.CanCollide = true
		end
	end
end
local vaccumRan = false
function GrabItems(typ,count)
	game.Workspace.Map.Parent = thevoid
	local jumped = false
	local itemsGrabbed = 0
	if count == 0 then count = 67 end
	--[[for i = 1, 10 do
		presskey(Enum.KeyCode.I, 0.05)
	end]]
	freezePlayer()
	local prevPos
	for idx,item in pairs(items:GetChildren()) do
		prevPos = hrp.Position
		if (not inMatch) and item.Name == typ and item:IsA("Tool") and item.Handle then
			local direction = (item.Handle.Position - hrp.Position).Unit
    		local targetPos = item.Handle.Position - direction * 3
    		local targetCF = CFrame.new(targetPos)
			unfreezePlayer()
			task.wait()
    		hrp.CFrame = targetCF
			freezePlayer()
			local camPos = camera.CFrame.Position
    		local lookAt = item.Handle.Position
    		camera.CFrame = CFrame.new(camPos, lookAt)
			task.wait(0.5)
			task.wait(math.clamp((hrp.Position - item.Handle.Position).Magnitude/3.5,0.05,0.75)-1)
			print((hrp.Position - item.Handle.Position).Magnitude/3.5)
			unfreezePlayer()
			task.wait(0.5)
			hrp.CFrame = targetCF
			task.wait()
			presskey(Enum.KeyCode.F,0.1)
			freezePlayer()
		end
	end
	unfreezePlayer()
	thevoid.Map.Parent = game.Workspace
end
GrabItems("Potion of Strength",0)
GrabItems("Boba",0)
GrabItems("Speed Potion", 0)
GrabItems("Bull's essence",0)
