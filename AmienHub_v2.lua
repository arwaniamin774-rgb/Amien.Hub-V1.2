--// Amien.Hub
--// UI ONLY - Black & Gold responsive design
--// No game/exploit features included.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local old = PlayerGui:FindFirstChild("Amien.Hub")
if old then old:Destroy() end

--==================================================
-- COLORS
--==================================================

local GOLD = Color3.fromRGB(235, 180, 55)
local GOLD2 = Color3.fromRGB(255, 210, 90)
local DARK = Color3.fromRGB(5, 5, 5)
local PANEL = Color3.fromRGB(13, 13, 13)
local PANEL2 = Color3.fromRGB(20, 20, 20)
local WHITE = Color3.fromRGB(242, 242, 242)
local GREY = Color3.fromRGB(155, 155, 155)
local GREEN = Color3.fromRGB(65, 220, 90)

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "Amien.Hub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromScale(0.88, 0.72)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = DARK
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = GOLD
MainStroke.Thickness = 2
MainStroke.Transparency = 0.1
MainStroke.Parent = Main

local Aspect = Instance.new("UIAspectRatioConstraint")
Aspect.AspectRatio = 1.55
Aspect.Parent = Main

-- subtle gold border glow
local Glow = Instance.new("Frame")
Glow.Size = UDim2.fromScale(1, 1)
Glow.BackgroundTransparency = 1
Glow.BorderSizePixel = 0
Glow.Parent = Main

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 92)
Header.BackgroundColor3 = Color3.fromRGB(3, 3, 3)
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(8,8,8)),
    ColorSequenceKeypoint.new(0.55, Color3.fromRGB(2,2,2)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12,9,3))
}
HeaderGradient.Rotation = 0
HeaderGradient.Parent = Header

local Crown = Instance.new("TextLabel")
Crown.Size = UDim2.fromOffset(62, 70)
Crown.Position = UDim2.fromOffset(15, 9)
Crown.BackgroundTransparency = 1
Crown.Text = "♛"
Crown.TextColor3 = GOLD2
Crown.TextSize = 48
Crown.Font = Enum.Font.GothamBlack
Crown.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 320, 0, 45)
Title.Position = UDim2.fromOffset(73, 8)
Title.BackgroundTransparency = 1
Title.Text = "AMIEN"
Title.TextColor3 = GOLD2
Title.TextSize = 34
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local HubWhite = Instance.new("TextLabel")
HubWhite.Size = UDim2.new(0, 180, 0, 38)
HubWhite.Position = UDim2.fromOffset(220, 14)
HubWhite.BackgroundTransparency = 1
HubWhite.Text = "Hub"
HubWhite.TextColor3 = WHITE
HubWhite.TextSize = 31
HubWhite.Font = Enum.Font.GothamBlack
HubWhite.TextXAlignment = Enum.TextXAlignment.Left
HubWhite.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 300, 0, 20)
Subtitle.Position = UDim2.fromOffset(160, 57)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "P R E M I U M   S C R I P T   H U B"
Subtitle.TextColor3 = GREY
Subtitle.TextSize = 10
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.TextXAlignment = Enum.TextXAlignment.Center
Subtitle.Parent = Header

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(42, 34)
Minimize.Position = UDim2.new(1, -94, 0, 25)
Minimize.BackgroundColor3 = PANEL2
Minimize.Text = "—"
Minimize.TextColor3 = GOLD2
Minimize.TextSize = 22
Minimize.Font = Enum.Font.GothamBold
Minimize.BorderSizePixel = 0
Minimize.AutoButtonColor = false
Minimize.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = Minimize

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(42, 34)
Close.Position = UDim2.new(1, -47, 0, 25)
Close.BackgroundColor3 = PANEL2
Close.Text = "×"
Close.TextColor3 = GOLD2
Close.TextSize = 25
Close.Font = Enum.Font.GothamBold
Close.BorderSizePixel = 0
Close.AutoButtonColor = false
Close.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = Close

--==================================================
-- CONTENT ROOT
--==================================================

local Body = Instance.new("Frame")
Body.Size = UDim2.new(1, 0, 1, -92)
Body.Position = UDim2.fromOffset(0, 92)
Body.BackgroundTransparency = 1
Body.Parent = Main

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 180, 1, -18)
Sidebar.Position = UDim2.fromOffset(10, 9)
Sidebar.BackgroundColor3 = Color3.fromRGB(7,7,7)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Body

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 12)
SideCorner.Parent = Sidebar

local SideStroke = Instance.new("UIStroke")
SideStroke.Color = Color3.fromRGB(35, 35, 35)
SideStroke.Thickness = 1
SideStroke.Parent = Sidebar

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 12)
SidePadding.PaddingLeft = UDim.new(0, 9)
SidePadding.PaddingRight = UDim.new(0, 9)
SidePadding.Parent = Sidebar

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 8)
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Parent = Sidebar

local tabs = {}

local function CreateTab(name, icon)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(1, 0, 0, 48)
    Button.BackgroundColor3 = Color3.fromRGB(12,12,12)
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = Sidebar

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Button

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(35,35,35)
    Stroke.Thickness = 1
    Stroke.Parent = Button

    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.fromOffset(40, 48)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.TextColor3 = WHITE
    Icon.TextSize = 22
    Icon.Font = Enum.Font.Gotham
    Icon.Parent = Button

    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(1, -48, 1, 0)
    Text.Position = UDim2.fromOffset(45, 0)
    Text.BackgroundTransparency = 1
    Text.Text = name
    Text.TextColor3 = WHITE
    Text.TextSize = 15
    Text.Font = Enum.Font.GothamMedium
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.Parent = Button

    tabs[name] = {Button = Button, Icon = Icon, Text = Text, Stroke = Stroke}
    return Button
end

CreateTab("Home", "⌂")
CreateTab("Main", "⚙")
CreateTab("Player", "♙")
CreateTab("Visual", "◉")
CreateTab("World", "◎")
CreateTab("Teleport", "⌖")
CreateTab("Settings", "⚙")

local function SetActive(name)
    for tabName, data in pairs(tabs) do
        local active = tabName == name
        data.Button.BackgroundColor3 = active and Color3.fromRGB(48, 35, 8) or Color3.fromRGB(12,12,12)
        data.Icon.TextColor3 = active and GOLD2 or WHITE
        data.Text.TextColor3 = active and GOLD2 or WHITE
        data.Stroke.Color = active and GOLD or Color3.fromRGB(35,35,35)
        data.Stroke.Transparency = active and 0 or 0.35
    end
end

SetActive("Home")

--==================================================
-- HOME CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -204, 1, -18)
Content.Position = UDim2.fromOffset(194, 9)
Content.BackgroundTransparency = 1
Content.Parent = Body

local Welcome = Instance.new("TextLabel")
Welcome.Size = UDim2.new(1, 0, 0, 38)
Welcome.BackgroundTransparency = 1
Welcome.Text = "Welcome to"
Welcome.TextColor3 = WHITE
Welcome.TextSize = 25
Welcome.Font = Enum.Font.GothamBold
Welcome.TextXAlignment = Enum.TextXAlignment.Left
Welcome.Parent = Content

local HubName = Instance.new("TextLabel")
HubName.Size = UDim2.new(1, 0, 0, 52)
HubName.Position = UDim2.fromOffset(0, 34)
HubName.BackgroundTransparency = 1
HubName.Text = "Amien.Hub"
HubName.TextColor3 = GOLD2
HubName.TextSize = 39
HubName.Font = Enum.Font.GothamBlack
HubName.TextXAlignment = Enum.TextXAlignment.Left
HubName.Parent = Content

local SmallDesc = Instance.new("TextLabel")
SmallDesc.Size = UDim2.new(1, 0, 0, 24)
SmallDesc.Position = UDim2.fromOffset(0, 82)
SmallDesc.BackgroundTransparency = 1
SmallDesc.Text = "B e s t   S c r i p t   H u b   F o r   R o b l o x"
SmallDesc.TextColor3 = GREY
SmallDesc.TextSize = 12
SmallDesc.Font = Enum.Font.GothamMedium
SmallDesc.TextXAlignment = Enum.TextXAlignment.Left
SmallDesc.Parent = Content

local Line = Instance.new("Frame")
Line.Size = UDim2.fromOffset(55, 4)
Line.Position = UDim2.fromOffset(0, 112)
Line.BackgroundColor3 = GOLD
Line.BorderSizePixel = 0
Line.Parent = Content

-- Decorative crown watermark
local Watermark = Instance.new("TextLabel")
Watermark.Size = UDim2.fromOffset(260, 180)
Watermark.Position = UDim2.new(1, -260, 0, 10)
Watermark.BackgroundTransparency = 1
Watermark.Text = "♛"
Watermark.TextColor3 = Color3.fromRGB(45, 33, 8)
Watermark.TextTransparency = 0.35
Watermark.TextSize = 170
Watermark.Font = Enum.Font.GothamBlack
Watermark.Parent = Content

--==================================================
-- CARD HELPERS
--==================================================

local function CreateCard(y, height, title, icon)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, 0, 0, height)
    Card.Position = UDim2.fromOffset(0, y)
    Card.BackgroundColor3 = PANEL
    Card.BorderSizePixel = 0
    Card.Parent = Content

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Card

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(60, 48, 25)
    Stroke.Thickness = 1
    Stroke.Parent = Card

    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.fromOffset(42, 40)
    Icon.Position = UDim2.fromOffset(14, 10)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.TextColor3 = GOLD2
    Icon.TextSize = 25
    Icon.Font = Enum.Font.GothamBold
    Icon.Parent = Card

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -65, 0, 38)
    TitleLabel.Position = UDim2.fromOffset(58, 9)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = GOLD2
    TitleLabel.TextSize = 19
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Card

    return Card
end

local Info = CreateCard(130, 128, "Information", "●")

local InfoLine = Instance.new("Frame")
InfoLine.Size = UDim2.new(1, -28, 0, 1)
InfoLine.Position = UDim2.fromOffset(14, 50)
InfoLine.BackgroundColor3 = Color3.fromRGB(45,45,45)
InfoLine.BorderSizePixel = 0
InfoLine.Parent = Info

local InfoAccent = Instance.new("Frame")
InfoAccent.Size = UDim2.fromOffset(4, 72)
InfoAccent.Position = UDim2.fromOffset(18, 61)
InfoAccent.BackgroundColor3 = GOLD
InfoAccent.BorderSizePixel = 0
InfoAccent.Parent = Info

local InfoName = Instance.new("TextLabel")
InfoName.Size = UDim2.new(1, -55, 0, 25)
InfoName.Position = UDim2.fromOffset(35, 58)
InfoName.BackgroundTransparency = 1
InfoName.Text = "Amien.Hub"
InfoName.TextColor3 = GOLD2
InfoName.TextSize = 16
InfoName.Font = Enum.Font.GothamBold
InfoName.TextXAlignment = Enum.TextXAlignment.Left
InfoName.Parent = Info

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -55, 0, 60)
InfoText.Position = UDim2.fromOffset(35, 83)
InfoText.BackgroundTransparency = 1
InfoText.Text = "Clean Interface\nSmooth Performance\nEasy To Use"
InfoText.TextColor3 = WHITE
InfoText.TextSize = 13
InfoText.Font = Enum.Font.GothamMedium
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.Parent = Info

local Status = CreateCard(268, 128, "Status", "▮▮▮")

local StatusLine = Instance.new("Frame")
StatusLine.Size = UDim2.new(1, -28, 0, 1)
StatusLine.Position = UDim2.fromOffset(14, 50)
StatusLine.BackgroundColor3 = Color3.fromRGB(45,45,45)
StatusLine.BorderSizePixel = 0
StatusLine.Parent = Status

local function StatusRow(parent, y, label, value, valueColor)
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(0, 150, 0, 25)
    L.Position = UDim2.fromOffset(25, y)
    L.BackgroundTransparency = 1
    L.Text = label
    L.TextColor3 = WHITE
    L.TextSize = 14
    L.Font = Enum.Font.GothamMedium
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.Parent = parent

    local V = Instance.new("TextLabel")
    V.Size = UDim2.new(0, 180, 0, 25)
    V.Position = UDim2.fromOffset(175, y)
    V.BackgroundTransparency = 1
    V.Text = value
    V.TextColor3 = valueColor
    V.TextSize = 14
    V.Font = Enum.Font.GothamBold
    V.TextXAlignment = Enum.TextXAlignment.Left
    V.Parent = parent
end

StatusRow(Status, 61, "Executor :", "Delta", GOLD2)
StatusRow(Status, 86, "Game     :", "Roblox", GOLD2)
StatusRow(Status, 111, "Status   :", "● Ready", GREEN)

--==================================================
-- BUTTON BEHAVIOR
--==================================================

for name, data in pairs(tabs) do
    data.Button.MouseButton1Click:Connect(function()
        SetActive(name)
        -- UI-only navigation placeholder.
        -- Add your own harmless page content here if needed.
    end)
end

--==================================================
-- DRAG
--==================================================

local dragging = false
local dragStart
local startPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPos = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

--==================================================
-- MINIMIZE / CLOSE
--==================================================

local minimized = false
local fullSize = Main.Size

Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    Body.Visible = not minimized
    Main.Size = minimized and UDim2.fromScale(0.42, 0.12) or fullSize
end)

Close.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)
