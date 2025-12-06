-- BaraLeaks FIX WINDOW HALF VERSION
-- UI lebih kecil, tidak fullscreen

local OWNER_AVATAR_URL = "https://i.imgur.com/oaWMMf7.png"
local MAIN_PIC_URL = "https://i.imgur.com/oaWMMf7.png"
local USE_MAIN_PIC = false

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local function new(class, props)
    local o = Instance.new(class)
    if props then for k,v in pairs(props) do o[k] = v end end
    return o
end

local screenGui = new("ScreenGui", {
    Parent = PlayerGui,
    Name = "BaraLeaksUI",
    ResetOnSpawn = false
})

-- WINDOW — sekarang ukurannya lebih kecil
local window = new("Frame", {
    Parent = screenGui,
    Name = "Window",
    Size = UDim2.new(0, 520, 0, 320), -- DULU 820x380 → SEKARANG 520x320
    Position = UDim2.new(0.5, -260, 0.45, -160),
    BackgroundColor3 = Color3.fromRGB(45,45,45),
})
new("UICorner", {Parent=window, CornerRadius=UDim.new(0,16)})

-- TOP BAR
local topBar = new("Frame", {
    Parent = window,
    Size = UDim2.new(1,0,0,60),
    BackgroundColor3 = Color3.fromRGB(36,36,36)
})
new("UICorner", {Parent=topBar, CornerRadius=UDim.new(0,16)})

local avatar = new("ImageLabel", {
    Parent = topBar,
    Size = UDim2.new(0,52,0,52),
    Position = UDim2.new(0,8,0,4),
    Image = OWNER_AVATAR_URL,
    BackgroundTransparency = 1,
})
new("UICorner", {Parent=avatar, CornerRadius=UDim.new(0,12)})

local title = new("TextLabel", {
    Parent = topBar,
    Text = "BaraLeaks | Owner Tampan",
    BackgroundTransparency = 1,
    Position = UDim2.new(0,70,0,10),
    Size = UDim2.new(1,-150,1,-10),
    TextColor3 = Color3.fromRGB(240,240,240),
    Font = Enum.Font.GothamBlack,
    TextSize = 26,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- TOMBOL CLOSE & MINIMIZE DIBESARIN
local closeBtn = new("TextButton", {
    Parent = topBar,
    Text = "X",
    Size = UDim2.new(0,55,0,45),
    Position = UDim2.new(1,-60,0,7),
    BackgroundTransparency = 1,
    TextColor3 = Color3.new(1,1,1),
    Font = Enum.Font.GothamBold,
    TextSize = 32
})

local minBtn = new("TextButton", {
    Parent = topBar,
    Text = "–",
    Size = UDim2.new(0,55,0,45),
    Position = UDim2.new(1,-120,0,7),
    BackgroundTransparency = 1,
    TextColor3 = Color3.new(1,1,1),
    Font = Enum.Font.GothamBold,
    TextSize = 32
})

-- BODY
local body = new("Frame", {
    Parent = window,
    Position = UDim2.new(0,0,0,60),
    Size = UDim2.new(1,0,1,-60),
    BackgroundTransparency = 1
})

local ROWS = {
    "Feature", "Info Owner",
    "Coming Soon", "Coming Soon",
    "Coming Soon", "Coming Soon"
}

local leftWidth = 0.33
local contentCells = {}

for i=1,6 do
    local y = (i-1)/6

    local left = new("Frame", {
        Parent = body,
        Position = UDim2.new(0,0,y,0),
        Size = UDim2.new(leftWidth,0,1/6,0),
        BackgroundColor3 = Color3.fromRGB(50,50,50)
    })
    new("UICorner", {Parent=left, CornerRadius=UDim.new(0,4)})

    new("TextLabel", {
        Parent = left,
        Text = ROWS[i],
        BackgroundTransparency = 1,
        Position = UDim2.new(0,10,0,0),
        Size = UDim2.new(1,-12,1,0),
        TextColor3 = Color3.fromRGB(240,240,240),
        Font = Enum.Font.Gotham,
        TextSize = 22,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local right = new("Frame", {
        Parent = body,
        Position = UDim2.new(leftWidth,0,y,0),
        Size = UDim2.new(1-leftWidth,0,1/6,0),
        BackgroundColor3 = Color3.fromRGB(70,70,70)
    })
    new("UICorner", {Parent=right, CornerRadius=UDim.new(0,4)})

    new("TextLabel", {
        Parent = right,
        Text = (i==2) and "Owner" or "Segera Hadir",
        BackgroundTransparency = 1,
        Size = UDim2.new(0.85,0,1,0),
        Position = UDim2.new(0.05,0,0,0),
        TextColor3 = Color3.fromRGB(255,255,255),
        Font = Enum.Font.GothamSemibold,
        TextSize = 20
    })

    contentCells[i] = {frame = right}
end

-- POPUP OWNER
local popup = new("Frame", {
    Parent = window,
    Size = UDim2.new(0,0,0,0),
    Visible = false,
    BackgroundColor3 = Color3.fromRGB(90,90,90)
})
new("UICorner",{Parent=popup,CornerRadius=UDim.new(0,10)})

local popupImg = new("ImageLabel", {
    Parent = popup,
    Size = UDim2.new(0,80,0,80),
    Position = UDim2.new(0.05,0,0.15,0),
    BackgroundTransparency = 1,
    Image = OWNER_AVATAR_URL,
})
new("UICorner",{Parent=popupImg,CornerRadius=UDim.new(0,10)})

new("TextLabel", {
    Parent = popup,
    Text = "Logo BaraLeaks Script\nFist It",
    BackgroundTransparency = 1,
    Position = UDim2.new(0.32,0,0.18,0),
    Size = UDim2.new(0.6,0,0.2,0),
    Font = Enum.Font.GothamBold,
    TextSize = 22,
    TextColor3 = Color3.new(1,1,1)
})

-- CLICK OWNER INFO
local opened = false
contentCells[2].frame.InputBegan:Connect(function(i)
    if i.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

    opened = not opened
    popup.Visible = opened

    if opened then
        popup.Size = UDim2.new(0,380,0,200)
        popup.Position = UDim2.new(0.5,-190,0.5,-100)
    end
end)

-- MINIMIZE
local isMin = false
local originalSize = window.Size

minBtn.MouseButton1Click:Connect(function()
    if not isMin then
        TweenService:Create(window,TweenInfo.new(.25),{Size = UDim2.new(0,260,0,60)}):Play()
    else
        TweenService:Create(window,TweenInfo.new(.25),{Size = originalSize}):Play()
    end
    isMin = not isMin
end)

-- CLOSE
closeBtn.MouseButton1Click:Connect(function()
    window:Destroy()
    screenGui:Destroy()
end)
