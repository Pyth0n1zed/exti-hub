local plr = game.Players.LocalPlayer
local theshadowrealm = game.Workspace

local exti = Instance.new("ScreenGui")
exti.Parent = plr.PlayerGui
exti.ResetOnSpawn = false

local mainframe = Instance.new("Frame")
mainframe.Parent = exti
mainframe.BackgroundColor3 = Color3.fromRGB(12,20,31)
mainframe.Position = UDim2.new(0.33,0,0.295,0)
mainframe.Size = UDim2.new(0.339,0,0.408,0)
mainframe.Active = true
mainframe.Draggable = true
local mainframeuic = Instance.new("UICorner")
mainframeuic.Parent = mainframe
mainframeuic.CornerRadius = UDim.new(0,12)

local mainframetop = Instance.new("Frame")
mainframetop.Parent = mainframe
mainframetop.Position = UDim2.new(0,0,0,0)
mainframetop.Size = UDim2.new(1,0,0.106,0)
mainframetop.BackgroundColor3 = Color3.fromRGB(12,20,31)
Instance.new("UICorner", mainframetop).CornerRadius = UDim.new(0,12)

local closebtn = Instance.new("TextButton")
closebtn.Parent = mainframe
closebtn.BackgroundTransparency = 1
closebtn.Position = UDim2.new(0.933,0,0.012,0)
closebtn.Size = UDim2.new(0.052,0,0.079,0)
closebtn.TextColor3 = Color3.fromRGB(255,255,255)
closebtn.Text = "X"
closebtn.TextScaled = true
closebtn.FontFace = Font.new("rbxasset://fonts/families/Arimo.json")

local minimizebtn = Instance.new("TextButton")
minimizebtn.Parent = mainframe
minimizebtn.Size = closebtn.Size
minimizebtn.Position = UDim2.new(0.86,0,0.012,0)
minimizebtn.Text = "━" -- unicode horizontal bar heavy
minimizebtn.TextScaled = true
minimizebtn.TextColor3 = Color3.fromRGB(255,255,255)
minimizebtn.FontFace = closebtn.FontFace
minimizebtn.BackgroundTransparency = 1


local mainframetopuic = Instance.new("UICorner")
mainframetopuic.Parent = mainframetop
mainframetopuic.CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel")
title.FontFace = Font.new("rbxasset://fonts/families/Titillium Web.json")
title.BackgroundTransparency = 1
title.Position = UDim2.new(0.025,0,0,0)
title.Parent = mainframe
title.Size = UDim2.new(0.835,0,0.106,0)
title.TextScaled = true
title.Text = "exti hub"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left

local minimdmain = Instance.new("Frame")
minimdmain.Parent = exti
minimdmain.BackgroundColor3 = Color3.fromRGB(12,20,31)
minimdmain.Position = UDim2.new(0.33,0,0.295,0)
minimdmain.Size = UDim2.new(0.339,0,0.043,0)
Instance.new("UICorner",minimdmain).CornerRadius = UDim.new(0,12)
minimdmain.Visible = false
minimdmain.Active = true
minimdmain.Draggable = true

local minimdtitle = title:Clone()
minimdtitle.Parent = minimdmain
minimdtitle.Position = UDim2.new(0.025,0,-0.041,0)
minimdtitle.Size = UDim2.new(0.644,0,1.004,0)

local minimdclose = closebtn:Clone()
minimdclose.Parent = minimdmain
minimdclose.Position = UDim2.new(0.93,0,0.086,0)
minimdclose.Size = UDim2.new(0.052,0,0.766,0)

local minimdminimize = minimizebtn:Clone()
minimdminimize.Parent = minimdmain
minimdminimize.Position = UDim2.new(0.86,0,0.086,0)
minimdminimize.Size = UDim2.new(0.052,0,0.766,0)

minimdminimize.MouseButton1Click:Connect(function()
	minimdmain.Visible = false
	mainframe.Position = minimdmain.Position
	mainframe.Visible = true
end)
minimizebtn.MouseButton1Click:Connect(function()
	mainframe.Visible = false
	minimdmain.Position = mainframe.Position
	minimdmain.Visible = true
end)

