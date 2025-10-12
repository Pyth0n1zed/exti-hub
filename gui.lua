return function()
local gui = {}
local plr = game.Players.LocalPlayer
local theshadowrealm = game.Workspace

local exti = Instance.new("ScreenGui")
exti.Parent = plr.PlayerGui
exti.ResetOnSpawn = false

local loading = Instance.new("Frame", exti)
loading.BackgroundColor3 = Color3.fromRGB(12,20,21)
loading.Position = UDim2.new("0.362,0,0.392,0")
loading.Size = UDim2.new(0.275,0,0.216,0)
Instance.new("UICorner", loading).CornerRadius = UDim.new(0,8)
local loadingtext = Instance.new("TextLabel", loading)
loadingtext.BackgroundTransparency = 1
loadingtext.Position = UDim2.new(0,0,0.319,0)
loadingtext.Size = UDim2.new(1,0,0.362,0)
loading.Visible = false

local mainframe = Instance.new("Frame")
mainframe.Parent = exti
mainframe.BackgroundColor3 = Color3.fromRGB(12,20,31)
mainframe.Position = UDim2.new(0.33,0,0.295,0)
mainframe.Size = UDim2.new(0.339,0,0.408,0)
mainframe.Active = true
mainframe.Draggable = true
mainframe.Visible = true
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

local closedialogue = Instance.new("Frame")
closedialogue.BackgroundColor3 = Color3.fromRGB(26,43,66)
closedialogue.Parent = exti
closedialogue.Position = UDim2.new(0.411,0,0.387,0)
closedialogue.Size = UDim2.new(0.177,0,0.222,0)
Instance.new("UICorner",closedialogue).CornerRadius = UDim.new(0,12)
closedialogue.Visible = false

local yesbtn = Instance.new("TextButton")
yesbtn.BackgroundColor3 = Color3.fromRGB(53,53,53)

yesbtn.Position = UDim2.new(0.08,0,0.704,0)
yesbtn.Size = UDim2.new(0.385,0,0.211,0)
Instance.new("UICorner", yesbtn).CornerRadius = UDim.new(0,6)
yesbtn.Text = "Yes"
yesbtn.Parent = closedialogue
yesbtn.TextScaled = true
yesbtn.TextColor3 = Color3.fromRGB(255,255,255)
yesbtn.FontFace = Font.new("rbxasset://fonts/families/Nunito.json")

local nobtn = yesbtn:Clone()
nobtn.Parent = closedialogue
nobtn.Text = "No"
nobtn.Position = UDim2.new(0.522,0,0.704,0)

local closetext = Instance.new("TextLabel", closedialogue)
closetext.BackgroundTransparency = 1
closetext.Position = UDim2.new(0.08,0,0.099,0)
closetext.Size = UDim2.new(0.823,0,0.607,0)
closetext.TextColor3 = Color3.fromRGB(255,255,255)
closetext.Text = "Are you sure you want to unload the interface?"
closetext.TextScaled = true

closebtn.MouseButton1Click:Connect(function()
	closedialogue.Visible = true
end)
yesbtn.MouseButton1Click:Connect(function()
	exti:Destroy()
end)
nobtn.MouseButton1Click:Connect(function()
	closedialogue.Visible = false
end)

local tabselector = Instance.new("Frame")
tabselector.Parent = mainframe
tabselector.BackgroundColor3 = Color3.fromRGB(27,45,47)
tabselector.BackgroundTransparency = 0.5
tabselector.Position = UDim2.new(0.025,0,0.106,0)
tabselector.Size = UDim2.new(0.214,0,0.859,0)
Instance.new("UICorner",tabselector).CornerRadius = UDim.new(0,8)
local tabselectorull = Instance.new("UIListLayout", tabselector)
tabselectorull.Padding = UDim.new(0,4)
tabselectorull.FillDirection = Enum.FillDirection.Vertical
tabselectorull.VerticalAlignment = Enum.VerticalAlignment.Top

local tabs = Instance.new("Frame")
tabs.BackgroundTransparency = 1
tabs.Position = UDim2.new(0.283,0,0.106,0)
tabs.Size = UDim2.new(0.679,0,0.858,0)
Instance.new("UICorner",tabs).CornerRadius = UDim.new(0,8)


gui.Title = title
gui.MainFrame = mainframe
gui.Gui = exti
gui.LoadingScreen = loading
gui.Tabs = tabs

function gui:SetTitle(str)
	self.Title.Text = str
	minimdtitle.Text = str
end

function gui:FinishLoading()
	self.LoadingScreen:Destroy()
	self.MainFrame.Visible = true
end

function gui:CreateTab(name)
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Text = name
	btn.Parent = tabselector
	btn.BackgroundTransparency = 0.9
	btn.Size = UDim2.new(1,0,0.2,0)
	btn.FontFace = Font.new("rbxasset://fonts/families/Roboto.json")
	btn.TextScaled = true
	btn.Weight = Enum.TextWeight.Light

	local tab = Instance.new("Frame", self.Tabs)
	tab.Name = name
	tab.BackgroundTransparency = 0.9
	tab.Position = UDim2.new(0,0,0,0)
	tab.Size = UDim2.new(1,0,1,0)
	Instance.new("UICorner", tab).CornerRadius = UDim.new(0,8)
	tab.Visible = false

	btn.MouseButton1Click:Connect(function()
		for _,v in pairs(self.Tabs:GetChildren()) do
			if v:IsA("Frame") then v.Visible = false end
		end
		tab.Visible = true
	end)
end
return gui
end
