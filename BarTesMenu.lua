--[[=========================================================
 UI BaraLeaks — Update Expand, Collapse, Drag, Minimize
===========================================================]]

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 300)
Main.Position = UDim2.new(0.2, 0, 0.25, 0)
Main.BackgroundColor3 = Color3.fromRGB(35,35,35)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

-- HEADER ---------------------------------------------------
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(25,25,25)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(230,230,230)
Title.Text = "BaraLeaks | Owner Tampan"

-- CLOSE BUTTON (X)
local X = Instance.new("TextButton", Header)
X.Size = UDim2.new(0, 30, 1, 0)
X.Position = UDim2.new(1, -35, 0, 0)
X.Text = "X"
X.TextColor3 = Color3.fromRGB(255,255,255)
X.BackgroundTransparency = 1
X.Font = Enum.Font.GothamBold
X.TextSize = 20
X.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

-- MINIMIZE (-)
local Min = Instance.new("TextButton", Header)
Min.Size = UDim2.new(0, 30, 1, 0)
Min.Position = UDim2.new(1, -70, 0, 0)
Min.Text = "-"
Min.TextColor3 = Color3.fromRGB(255,255,255)
Min.BackgroundTransparency = 1
Min.Font = Enum.Font.GothamBold
Min.TextSize = 24

local Minimized = false
Min.MouseButton1Click:Connect(function()
	Minimized = not Minimized
	for _, v in ipairs(Main:GetChildren()) do
		if v ~= Header then
			v.Visible = not Minimized
		end
	end
	Main.Size = Minimized and UDim2.new(0, 500, 0, 40) or UDim2.new(0, 500, 0, 300)
end)

-- TABLE CONTENT --------------------------------------------
local TableHolder = Instance.new("Frame", Main)
TableHolder.Size = UDim2.new(1, 0, 1, -40)
TableHolder.Position = UDim2.new(0, 0, 0, 40)
TableHolder.BackgroundTransparency = 1

local UIListLayout = Instance.new("UIListLayout", TableHolder)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- FEATURE LIST DATA ----------------------------------------
local Features = {
	{
		Title = "Info Owner",
		Content = [[
Developer : Bara Tamvan
Team : BarLens Studio
]],
		Image = "rbxassetid://7229442422"
	},

	{ Title = "Coming Soon", Content = "Segera Hadir", Image = "" },
	{ Title = "Coming Soon", Content = "Segera Hadir", Image = "" },
	{ Title = "Coming Soon", Content = "Segera Hadir", Image = "" },
	{ Title = "Coming Soon", Content = "Segera Hadir", Image = "" },
}

-- MAKE ROWS -------------------------------------------------
for _, data in ipairs(Features) do
	
	local Row = Instance.new("Frame", TableHolder)
	Row.Size = UDim2.new(1, 0, 0, 40)
	Row.BackgroundColor3 = Color3.fromRGB(50,50,50)

	local Ftxt = Instance.new("TextLabel", Row)
	Ftxt.Size = UDim2.new(0.5, 0, 1, 0)
	Ftxt.BackgroundTransparency = 1
	Ftxt.Text = data.Title
	Ftxt.Font = Enum.Font.Gotham
	Ftxt.TextSize = 18
	Ftxt.TextColor3 = Color3.fromRGB(255,255,255)

	local Toggle = Instance.new("TextButton", Row)
	Toggle.Size = UDim2.new(0.5, -10, 1, 0)
	Toggle.Position = UDim2.new(0.5, 10, 0, 0)
	Toggle.BackgroundTransparency = 1
	Toggle.Font = Enum.Font.GothamBold
	Toggle.TextSize = 18
	Toggle.TextColor3 = Color3.fromRGB(255,255,255)
	Toggle.Text = "▼"

	-- CONTENT PANEL
	local Panel = Instance.new("Frame", Row)
	Panel.Size = UDim2.new(1, 0, 0, 0)
	Panel.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Panel.BorderSizePixel = 0
	Panel.Visible = false

	local Ptxt = Instance.new("TextLabel", Panel)
	Ptxt.Size = UDim2.new(1, -80, 1, 0)
	Ptxt.Position = UDim2.new(0, 80, 0, 0)
	Ptxt.BackgroundTransparency = 1
	Ptxt.Text = data.Content
	Ptxt.Font = Enum.Font.Gotham
	Ptxt.TextColor3 = Color3.fromRGB(200,200,200)
	Ptxt.TextSize = 16
	Ptxt.TextXAlignment = Enum.TextXAlignment.Left
	Ptxt.TextYAlignment = Enum.TextYAlignment.Top

	if data.Image and data.Image ~= "" then
		local Img = Instance.new("ImageLabel", Panel)
		Img.Size = UDim2.new(0, 60, 0, 60)
		Img.Position = UDim2.new(0, 10, 0, 10)
		Img.BackgroundTransparency = 1
		Img.Image = data.Image
	end

	-- TOGGLE SYSTEM (expand / collapse)
	local Expanded = false
	Toggle.MouseButton1Click:Connect(function()
		Expanded = not Expanded
		Panel.Visible = Expanded
		Toggle.Text = Expanded and "▲" or "▼"
		Row.Size = Expanded and UDim2.new(1, 0, 0, 140) or UDim2.new(1, 0, 0, 40)
	end)
end
