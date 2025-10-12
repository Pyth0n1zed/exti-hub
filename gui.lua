local plr = game.Players.LocalPlayer

local exti = Instance.new("ScreenGui")
exti.Parent = plr.PlayerGui
exti.ResetOnSpawn = false

local mainframe = Instance.new("Frame")
mainframe.Parent = exti
mainframe.BackgroundColor3 = Color3.fromRGB(12,20,31)
mainframe.Position = UDim2.new(0.33,0,0.295,0)
mainframe.Size = UDim2.new(0.339,0,0.408,0)
local mainframeuic = Instance.new("UICorner")
mainframeuic.Parent = mainframe
mainframeuic.CornerRadius = UDim.new(0,12)

local closebtn = Instance.new("TextButton")
closebtn.Parent = mainframe
closebtn.BackgroundTransparency = 1
closebtn.Position = UDim2.new(0.933,0,0.012,0)
closebtn.Size = UDim2.new(0.052,0,0.079,0)
closebtn.TextColor3 = Color3.fromRGB(255,255,255)
closebtn.Text = "X"
closebtn.TextScaled = true
closebtn.FontFace = Font.fromFamily("rbxasset://fonts/families/Inconsolata.json")

local minimizebtn = closebtn:Clone()
minimizebtn.Parent = mainframe
minimizebtn.Text = "_"
minimizebtn.Position = UDim2.new(0.86,0,-0.024,0)

local mainframetop = mainframe:Clone()
mainframetop.Parent = mainframe
mainframetop.Position = UDim2.new(0,0,0,0)
mainframetop.Size = UDim2.new(0,342,0,27)
for _,v in pairs(mainframetop:GetDescendants()) do
	v:Destroy()
end
local mainframetopuic = Instance.new("UICorner")
mainframetopuic.Parent = mainframetop
mainframetopuic.CornerRadius = UDim.new(0,12)
mainframetop.Active = true
mainframetop.Draggable = true

local mainframetopbottom = mainframetop:Clone()
mainframetopbottom.Parent = mainframetop
mainframetopbottom.Position = UDim2.new(0,0,0.519,0)
mainframetopbottom.Size = UDim2.new(0,342,0,13)

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.new(0.025,0,0.016,0)
title.Parent = mainframe
title.Size = UDim2.new(0.835,0,0.075,0)
title.TextScaled = true
title.Text = "exti hub"
