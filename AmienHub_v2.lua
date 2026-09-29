--// Amien.Hub V2
--// UI ONLY - Black & Gold responsive design
--// Player information is dynamic for the user running the UI.
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
local ROW = Color3.fromRGB(18, 18, 18)
local WHITE = Color3.fromRGB(242, 242, 242)
local GREY = Color3.fromRGB(155, 155, 155)
local GREEN = Color3.fromRGB(65, 220, 90)

--==================================================
-- HELPERS
--==================================================
local function New(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function Corner(obj, radius)
    return New("UICorner", {CornerRadius = UDim.new(0, radius or 10)}, obj)
end

local function Stroke(obj, color, thickness, transparency)
    return New("UIStroke", {
        Color = color or GOLD,
        Thickness = thickness or 1,
        Transparency = transparency or 0
    }, obj)
end

local function Label(parent, text, size, position, textSize, color, font)
    return New("TextLabel", {
        Size = size,
        Position = position or UDim2.new(),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = color or WHITE,
        TextSize = textSize or 14,
        Font = font or Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center
    }, parent)
end

--==================================================
-- GUI ROOT
--==================================================
local Gui = New("ScreenGui", {
    Name = "Amien.Hub",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 999
}, PlayerGui)

--==================================================
-- MAIN WINDOW
--==================================================
local Main = New("Frame", {
    Name = "Main",
    Size = UDim2.fromScale(0.88, 0.72),
    Position = UDim2.fromScale(0.5, 0.5),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = DARK,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, Gui)
Corner(Main, 16)
Stroke(Main, GOLD, 2, 0.08)
New("UIAspectRatioConstraint", {AspectRatio = 1.55}, Main)

local Header = New("Frame", {
    Size = UDim2.new(1, 0, 0, 74),
    BackgroundColor3 = Color3.fromRGB(3, 3, 3),
    BorderSizePixel = 0
}, Main)
New("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(10,10,10)),
        ColorSequenceKeypoint.new(0.55, Color3.fromRGB(2,2,2)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(13,10,3))
    })
}, Header)

local HeaderCrown = Label(Header, "A", UDim2.fromOffset(48, 50), UDim2.fromOffset(12, 8), 34, GOLD2, Enum.Font.GothamBlack)
HeaderCrown.TextXAlignment = Enum.TextXAlignment.Center
local HeaderA = Label(Header, "A", UDim2.fromOffset(36, 42), UDim2.fromOffset(51, 15), 28, GOLD2, Enum.Font.GothamBlack)
HeaderA.TextXAlignment = Enum.TextXAlignment.Center
local HeaderName = Label(Header, "AMIEN.HUB V2", UDim2.fromOffset(220, 32), UDim2.fromOffset(91, 11), 20, GOLD2, Enum.Font.GothamBlack)
local HeaderSub = Label(Header, "P R E M I U M   S C R I P T   H U B", UDim2.fromOffset(300, 18), UDim2.fromOffset(92, 40), 9, GREY, Enum.Font.GothamMedium)

local Minimize = New("TextButton", {
    Size = UDim2.fromOffset(38, 32),
    Position = UDim2.new(1, -86, 0, 21),
    BackgroundColor3 = PANEL2,
    Text = "-",
    TextColor3 = GOLD2,
    TextSize = 21,
    Font = Enum.Font.GothamBold,
    BorderSizePixel = 0,
    AutoButtonColor = false
}, Header)
Corner(Minimize, 8)
Stroke(Minimize, Color3.fromRGB(60,60,60), 1, 0.2)

local Close = New("TextButton", {
    Size = UDim2.fromOffset(38, 32),
    Position = UDim2.new(1, -43, 0, 21),
    BackgroundColor3 = PANEL2,
    Text = "X",
    TextColor3 = GOLD2,
    TextSize = 24,
    Font = Enum.Font.GothamBold,
    BorderSizePixel = 0,
    AutoButtonColor = false
}, Header)
Corner(Close, 8)
Stroke(Close, Color3.fromRGB(60,60,60), 1, 0.2)

local Body = New("Frame", {
    Size = UDim2.new(1, 0, 1, -74),
    Position = UDim2.fromOffset(0, 74),
    BackgroundTransparency = 1
}, Main)

--==================================================
-- SIDEBAR
--==================================================
local Sidebar = New("Frame", {
    Size = UDim2.new(0, 180, 1, -18),
    Position = UDim2.fromOffset(10, 9),
    BackgroundColor3 = Color3.fromRGB(7,7,7),
    BorderSizePixel = 0
}, Body)
Corner(Sidebar, 12)
Stroke(Sidebar, Color3.fromRGB(35,35,35), 1, 0)
New("UIPadding", {
    PaddingTop = UDim.new(0, 10),
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8)
}, Sidebar)

local SideList = New("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
}, Sidebar)

local ContentArea = New("Frame", {
    Size = UDim2.new(1, -204, 1, -18),
    Position = UDim2.fromOffset(194, 9),
    BackgroundTransparency = 1
}, Body)

local pages = {}
local tabs = {}
local activePage = nil

local tabDefinitions = {
    {"Home", "H"},
    {"Main", "M"},
    {"Player", "P"},
    {"Visual", "V"},
    {"World", "W"},
    {"Teleport", "T"},
    {"Settings", "S"}
}

local function CreateTab(name, icon, order)
    local button = New("TextButton", {
        Name = name,
        Size = UDim2.new(1, 0, 0, 42),
        BackgroundColor3 = Color3.fromRGB(12,12,12),
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = order,
        BorderSizePixel = 0
    }, Sidebar)
    Corner(button, 9)
    local st = Stroke(button, Color3.fromRGB(35,35,35), 1, 0.35)
    local ic = Label(button, icon, UDim2.fromOffset(38, 42), UDim2.fromOffset(3,0), 21, WHITE, Enum.Font.Gotham)
    ic.TextXAlignment = Enum.TextXAlignment.Center
    local tx = Label(button, name, UDim2.new(1, -47, 1, 0), UDim2.fromOffset(44,0), 14, WHITE, Enum.Font.GothamMedium)
    tabs[name] = {Button = button, Icon = ic, Text = tx, Stroke = st}
    return button
end

for i, def in ipairs(tabDefinitions) do
    CreateTab(def[1], def[2], i)
end

--==================================================
-- PAGE HELPERS
--==================================================
local function CreatePage(name)
    local page = New("ScrollingFrame", {
        Name = name .. "Page",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 5,
        ScrollBarImageColor3 = GOLD,
        CanvasSize = UDim2.new(0,0,0,0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Visible = false
    }, ContentArea)
    New("UIPadding", {
        PaddingTop = UDim.new(0, 2),
        PaddingLeft = UDim.new(0, 2),
        PaddingRight = UDim.new(0, 7),
        PaddingBottom = UDim.new(0, 12)
    }, page)
    pages[name] = page
    return page
end

local function PageTitle(page, title, subtitle)
    local titleLabel = Label(page, title, UDim2.new(1, -4, 0, 42), nil, 25, WHITE, Enum.Font.GothamBold)
    local sub = Label(page, subtitle or "", UDim2.new(1, -4, 0, 22), UDim2.fromOffset(0, 38), 11, GREY, Enum.Font.GothamMedium)
    return titleLabel, sub
end

local function SetActive(name)
    for tabName, data in pairs(tabs) do
        local active = tabName == name
        data.Button.BackgroundColor3 = active and Color3.fromRGB(52, 39, 9) or Color3.fromRGB(12,12,12)
        data.Icon.TextColor3 = active and GOLD2 or WHITE
        data.Text.TextColor3 = active and GOLD2 or WHITE
        data.Stroke.Color = active and GOLD or Color3.fromRGB(35,35,35)
        data.Stroke.Transparency = active and 0 or 0.35
    end
    for pageName, page in pairs(pages) do
        page.Visible = pageName == name
    end
    activePage = name
end

--==================================================
-- GENERIC UI CARDS / TOGGLES
--==================================================
local function Card(parent, title, height)
    local card = New("Frame", {
        Size = UDim2.new(1, -4, 0, height or 100),
        BackgroundColor3 = PANEL,
        BorderSizePixel = 0
    }, parent)
    Corner(card, 12)
    Stroke(card, Color3.fromRGB(42,42,42), 1, 0.1)
    Label(card, title, UDim2.new(1,-28,0,28), UDim2.fromOffset(14,8), 16, WHITE, Enum.Font.GothamBold)
    return card
end

local function ToggleRow(parent, text, icon, order)
    local row = New("TextButton", {
        Size = UDim2.new(1, -24, 0, 46),
        BackgroundColor3 = ROW,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = order or 1
    }, parent)
    Corner(row, 9)
    Stroke(row, Color3.fromRGB(42,42,42), 1, 0.15)
    local ico = Label(row, icon or "-", UDim2.fromOffset(36,46), UDim2.fromOffset(5,0), 19, GOLD2, Enum.Font.GothamBold)
    ico.TextXAlignment = Enum.TextXAlignment.Center
    Label(row, text, UDim2.new(1,-105,1,0), UDim2.fromOffset(47,0), 13, WHITE, Enum.Font.GothamMedium)
    local track = New("Frame", {
        Size = UDim2.fromOffset(43, 24),
        Position = UDim2.new(1,-56,0.5,-12),
        BackgroundColor3 = Color3.fromRGB(38,38,38),
        BorderSizePixel = 0
    }, row)
    Corner(track, 12)
    local knob = New("Frame", {
        Size = UDim2.fromOffset(18,18),
        Position = UDim2.fromOffset(3,3),
        BackgroundColor3 = WHITE,
        BorderSizePixel = 0
    }, track)
    Corner(knob, 10)
    local state = false
    row.MouseButton1Click:Connect(function()
        state = not state
        track.BackgroundColor3 = state and GOLD or Color3.fromRGB(38,38,38)
        knob.Position = state and UDim2.fromOffset(22,3) or UDim2.fromOffset(3,3)
        knob.BackgroundColor3 = state and Color3.fromRGB(25,25,25) or WHITE
    end)
    return row
end

local function Stack(parent, gap)
    return New("UIListLayout", {
        Padding = UDim.new(0, gap or 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, parent)
end

--==================================================
-- HOME PAGE
--==================================================
local Home = CreatePage("Home")
PageTitle(Home, "Home", "Simple - Clean - Powerful")
local Hero = New("Frame", {
    Size = UDim2.new(1,-4,0,280),
    BackgroundColor3 = Color3.fromRGB(7,7,7),
    BorderSizePixel = 0
}, Home)
Corner(Hero, 15)
Stroke(Hero, GOLD, 1, 0.15)
Label(Hero, "A", UDim2.new(1,0,0,65), UDim2.fromOffset(0,25), 54, GOLD2, Enum.Font.GothamBlack).TextXAlignment = Enum.TextXAlignment.Center
local heroA = Label(Hero, "A M I E N", UDim2.new(1,0,0,65), UDim2.fromOffset(0,78), 43, GOLD2, Enum.Font.GothamBlack)
heroA.TextXAlignment = Enum.TextXAlignment.Center
local welcome = New("Frame", {
    Size = UDim2.new(0.7,0,0,58),
    Position = UDim2.new(0.15,0,1,-72),
    BackgroundColor3 = Color3.fromRGB(8,8,8),
    BorderSizePixel = 0
}, Hero)
Corner(welcome, 28)
Stroke(welcome, GOLD, 1, 0.05)
local wl = Label(welcome, "Welcome to Amien.Hub V2", UDim2.new(1,0,0,26), UDim2.fromOffset(0,4), 15, WHITE, Enum.Font.GothamBold)
wl.TextXAlignment = Enum.TextXAlignment.Center
local ws = Label(welcome, "Simple - Clean - Powerful", UDim2.new(1,0,0,20), UDim2.fromOffset(0,30), 11, GREY, Enum.Font.GothamMedium)
ws.TextXAlignment = Enum.TextXAlignment.Center

local HomeInfo = Card(Home, "Information", 105)
Label(HomeInfo, "Amien.Hub V2", UDim2.new(1,-28,0,24), UDim2.fromOffset(14,40), 14, GOLD2, Enum.Font.GothamBold)
Label(HomeInfo, "Responsive black & gold interface with scrollable pages.", UDim2.new(1,-28,0,24), UDim2.fromOffset(14,66), 12, WHITE, Enum.Font.GothamMedium)

local HomeStatus = Card(Home, "Status", 105)
Label(HomeStatus, "READY", UDim2.new(1,-28,0,24), UDim2.fromOffset(14,40), 14, GREEN, Enum.Font.GothamBold)
Label(HomeStatus, "UI loaded for " .. Player.DisplayName, UDim2.new(1,-28,0,24), UDim2.fromOffset(14,66), 12, WHITE, Enum.Font.GothamMedium)

--==================================================
-- MAIN PAGE
--==================================================
local MainPage = CreatePage("Main")
PageTitle(MainPage, "Main", "Main Features")
local MainCard = Card(MainPage, "Main Features", 300)
local MainStack = Stack(MainCard, 7)
MainStack.Parent = MainCard
local mainItems = {
    {"Auto Farm", "AF"},
    {"Auto Collect", "AC"},
    {"Auto Quest", "AQ"},
    {"Auto Upgrade", "AU"},
    {"Auto Rebirth", "AR"}
}
for i, item in ipairs(mainItems) do ToggleRow(MainCard, item[1], item[2], i) end

--==================================================
-- PLAYER PAGE - DYNAMIC USER DATA
--==================================================
local PlayerPage = CreatePage("Player")
PageTitle(PlayerPage, "Player", "Your Roblox profile & live player information")

local ProfileCard = New("Frame", {
    Size = UDim2.new(1,-4,0,235),
    BackgroundColor3 = PANEL,
    BorderSizePixel = 0
}, PlayerPage)
Corner(ProfileCard, 14)
Stroke(ProfileCard, Color3.fromRGB(55,55,55), 1, 0)

local AvatarBox = New("Frame", {
    Size = UDim2.new(0,205,1,-24),
    Position = UDim2.fromOffset(12,12),
    BackgroundColor3 = Color3.fromRGB(24,24,24),
    BorderSizePixel = 0
}, ProfileCard)
Corner(AvatarBox, 12)
Stroke(AvatarBox, GOLD, 1, 0.25)

local Avatar = New("ImageLabel", {
    Name = "Avatar",
    Size = UDim2.new(1,-18,1,-18),
    Position = UDim2.fromOffset(9,9),
    BackgroundTransparency = 1,
    Image = "",
    ScaleType = Enum.ScaleType.Fit
}, AvatarBox)

local AvatarName = Label(ProfileCard, "Your Information", UDim2.new(1,-235,0,30), UDim2.fromOffset(230,12), 17, WHITE, Enum.Font.GothamBold)

local InfoList = New("Frame", {
    Size = UDim2.new(1,-235,1,-54),
    Position = UDim2.fromOffset(230,47),
    BackgroundTransparency = 1
}, ProfileCard)
local infoLayout = Stack(InfoList, 6)

local function InfoRow(labelText, icon)
    local row = New("Frame", {
        Size = UDim2.new(1,0,0,38),
        BackgroundColor3 = ROW,
        BorderSizePixel = 0
    }, InfoList)
    Corner(row, 9)
    Stroke(row, Color3.fromRGB(42,42,42), 1, 0.18)

    local i = Label(row, icon or "-", UDim2.fromOffset(34,38), UDim2.fromOffset(5,0), 15, GOLD2, Enum.Font.GothamBold)
    i.TextXAlignment = Enum.TextXAlignment.Center

    local l = Label(row, labelText, UDim2.fromOffset(105,38), UDim2.fromOffset(45,0), 12, GREY, Enum.Font.GothamMedium)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextTruncate = Enum.TextTruncate.AtEnd

    local v = Label(row, "--", UDim2.new(1,-162,1,0), UDim2.fromOffset(155,0), 12, WHITE, Enum.Font.GothamBold)
    v.TextXAlignment = Enum.TextXAlignment.Left
    v.TextTruncate = Enum.TextTruncate.AtEnd
    return v
end

local usernameValue = InfoRow("Username", "U")
local displayValue = InfoRow("Display Name", "D")
local userIdValue = InfoRow("User ID", "ID")
local speedValue = InfoRow("Speed", "SP")
local moneyValue = InfoRow("Money / Cash", "$")

local function GetHumanoid()
    local character = Player.Character
    if not character then return nil end
    return character:FindFirstChildOfClass("Humanoid")
end

local function FindMoneyValue()
    local roots = {Player, Player:FindFirstChild("leaderstats")}
    local wanted = {
        cash=true, money=true, coins=true, coin=true, currency=true,
        gold=true, gems=true, gem=true, balance=true, credits=true
    }
    for _, root in ipairs(roots) do
        if root then
            for _, obj in ipairs(root:GetDescendants()) do
                if (obj:IsA("IntValue") or obj:IsA("NumberValue") or obj:IsA("StringValue")) then
                    local n = string.lower(obj.Name)
                    if wanted[n] then return obj end
                end
            end
        end
    end
    return nil
end

local function UpdatePlayerInfo()
    usernameValue.Text = Player.Name
    displayValue.Text = Player.DisplayName
    userIdValue.Text = tostring(Player.UserId)
    local humanoid = GetHumanoid()
    speedValue.Text = humanoid and string.format("%.0f", humanoid.WalkSpeed) or "--"
    local money = FindMoneyValue()
    moneyValue.Text = money and tostring(money.Value) or "--"
end

task.spawn(function()
    local ok, image = pcall(function()
        local content, _ = Players:GetUserThumbnailAsync(
            Player.UserId,
            Enum.ThumbnailType.AvatarThumbnail,
            Enum.ThumbnailSize.Size420x420
        )
        return content
    end)
    if ok and image then Avatar.Image = image end
end)

UpdatePlayerInfo()
Player.CharacterAdded:Connect(function()
    task.wait(0.5)
    UpdatePlayerInfo()
end)

local playerInfoConnection = true
task.spawn(function()
    while Gui.Parent do
        if activePage == "Player" then
            UpdatePlayerInfo()
        end
        task.wait(0.5)
    end
end)

--==================================================
-- VISUAL PAGE
--==================================================
local VisualPage = CreatePage("Visual")
PageTitle(VisualPage, "Visual", "Visual Features")
local VisualCard = Card(VisualPage, "Visual Features", 300)
Stack(VisualCard, 7)
local visualItems = {
    {"ESP Player", "EP"},
    {"ESP Item", "EI"},
    {"ESP Chest", "EC"},
    {"Fullbright", "FB"},
    {"No Fog", "NF"}
}
for i, item in ipairs(visualItems) do ToggleRow(VisualCard, item[1], item[2], i) end

--==================================================
-- WORLD PAGE
--==================================================
local WorldPage = CreatePage("World")
PageTitle(WorldPage, "World", "World Features")
local WorldCard = Card(WorldPage, "World Features", 300)
Stack(WorldCard, 7)
local worldItems = {
    {"Remove Grass", "RG"},
    {"Remove Tree", "RT"},
    {"Remove Rock", "RR"},
    {"Low Texture", "LT"},
    {"No Water", "NW"}
}
for i, item in ipairs(worldItems) do ToggleRow(WorldCard, item[1], item[2], i) end

--==================================================
-- TELEPORT PAGE - UI ONLY
--==================================================
local TeleportPage = CreatePage("Teleport")
PageTitle(TeleportPage, "Teleport", "Teleport Locations")
local Search = New("TextBox", {
    Size = UDim2.new(1,-4,0,42),
    BackgroundColor3 = ROW,
    BorderSizePixel = 0,
    PlaceholderText = "Search location...",
    PlaceholderColor3 = GREY,
    Text = "",
    TextColor3 = WHITE,
    TextSize = 13,
    Font = Enum.Font.GothamMedium,
    ClearTextOnFocus = false
}, TeleportPage)
Corner(Search, 10)
Stroke(Search, Color3.fromRGB(50,50,50), 1, 0)
New("UIPadding", {PaddingLeft = UDim.new(0,12), PaddingRight = UDim.new(0,12)}, Search)

local TeleportCard = New("Frame", {
    Size = UDim2.new(1,-4,0,260),
    BackgroundColor3 = PANEL,
    BorderSizePixel = 0
}, TeleportPage)
Corner(TeleportCard, 12)
Stroke(TeleportCard, Color3.fromRGB(42,42,42), 1, 0.1)
New("UIGridLayout", {
    CellSize = UDim2.new(0.32, -8, 0, 52),
    CellPadding = UDim2.new(0.02, 0, 0, 8),
    FillDirection = Enum.FillDirection.Horizontal,
    SortOrder = Enum.SortOrder.LayoutOrder
}, TeleportCard)
New("UIPadding", {
    PaddingTop = UDim.new(0, 12),
    PaddingLeft = UDim.new(0, 12),
    PaddingRight = UDim.new(0, 12),
    PaddingBottom = UDim.new(0, 12)
}, TeleportCard)

local locations = {
    {"Spawn", "SP"}, {"Shop", "SH"}, {"Island 1", "I1"},
    {"Island 2", "I2"}, {"Boss", "BO"}, {"Event", "EV"},
    {"Desert", "DE"}, {"Snow", "SN"}, {"Ocean", "OC"}
}
local locationButtons = {}
for i, item in ipairs(locations) do
    local b = New("TextButton", {
        BackgroundColor3 = ROW,
        BorderSizePixel = 0,
        Text = "  " .. item[2] .. "    " .. item[1],
        TextColor3 = WHITE,
        TextSize = 12,
        Font = Enum.Font.GothamMedium,
        AutoButtonColor = false,
        LayoutOrder = i
    }, TeleportCard)
    Corner(b, 9)
    Stroke(b, GOLD, 1, 0.45)
    b.MouseButton1Click:Connect(function()
        -- UI-only: location selection is visual only.
        for _, other in ipairs(locationButtons) do
            other.BackgroundColor3 = ROW
        end
        b.BackgroundColor3 = Color3.fromRGB(52,39,9)
    end)
    table.insert(locationButtons, b)
end

Search:GetPropertyChangedSignal("Text"):Connect(function()
    local q = string.lower(Search.Text)
    for i, b in ipairs(locationButtons) do
        local loc = locations[i][1]
        b.Visible = q == "" or string.find(string.lower(loc), q, 1, true) ~= nil
    end
end)

--==================================================
-- SETTINGS PAGE
--==================================================
local SettingsPage = CreatePage("Settings")
PageTitle(SettingsPage, "Settings", "Save & Config")
local SettingsCard = Card(SettingsPage, "Save & Config", 250)
local settingsLayout = Stack(SettingsCard, 8)
settingsLayout.Parent = SettingsCard

local function ActionRow(parent, title, icon, actionText, order)
    local row = New("Frame", {
        Size = UDim2.new(1,-24,0,45),
        BackgroundColor3 = ROW,
        BorderSizePixel = 0,
        LayoutOrder = order
    }, parent)
    Corner(row, 9)
    Stroke(row, Color3.fromRGB(42,42,42), 1, 0.15)
    local ic = Label(row, icon, UDim2.fromOffset(34,45), UDim2.fromOffset(5,0), 18, GOLD2, Enum.Font.GothamBold)
    ic.TextXAlignment = Enum.TextXAlignment.Center
    Label(row, title, UDim2.new(1,-135,1,0), UDim2.fromOffset(44,0), 13, WHITE, Enum.Font.GothamMedium)
    local button = New("TextButton", {
        Size = UDim2.fromOffset(105,33),
        Position = UDim2.new(1,-113,0.5,-16),
        BackgroundColor3 = GOLD2,
        Text = actionText,
        TextColor3 = Color3.fromRGB(20,20,20),
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        AutoButtonColor = false
    }, row)
    Corner(button, 8)
    return button
end

ActionRow(SettingsCard, "Save Config", "SV", "Save", 1)
ActionRow(SettingsCard, "Load Config", "LD", "Load", 2)
ActionRow(SettingsCard, "Reset Config", "RS", "Reset", 3)

local KeyRow = New("Frame", {
    Size = UDim2.new(1,-24,0,45),
    BackgroundColor3 = ROW,
    BorderSizePixel = 0,
    LayoutOrder = 4
}, SettingsCard)
Corner(KeyRow, 9)
Stroke(KeyRow, Color3.fromRGB(42,42,42), 1, 0.15)
Label(KeyRow, "KEY", UDim2.fromOffset(34,45), UDim2.fromOffset(5,0), 18, GOLD2, Enum.Font.GothamBold).TextXAlignment = Enum.TextXAlignment.Center
Label(KeyRow, "UI Toggle Key", UDim2.new(1,-150,1,0), UDim2.fromOffset(44,0), 13, WHITE, Enum.Font.GothamMedium)
local KeyValue = New("TextLabel", {
    Size = UDim2.fromOffset(105,33),
    Position = UDim2.new(1,-113,0.5,-16),
    BackgroundColor3 = Color3.fromRGB(25,25,25),
    Text = "RightShift",
    TextColor3 = WHITE,
    TextSize = 12,
    Font = Enum.Font.GothamBold,
    BorderSizePixel = 0
}, KeyRow)
Corner(KeyValue, 8)
Stroke(KeyValue, Color3.fromRGB(70,70,70), 1, 0.2)

--==================================================
-- TAB CONNECTIONS
--==================================================
for name, data in pairs(tabs) do
    data.Button.MouseButton1Click:Connect(function()
        SetActive(name)
    end)
end

--==================================================
-- MAIN WINDOW DRAG
--==================================================
local dragging = false
local dragStart
local startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

--==================================================
-- FLOATING A + CROWN MINIMIZE BUTTON
--==================================================
local Floating = New("TextButton", {
    Name = "FloatingLogo",
    Size = UDim2.fromOffset(58,58),
    Position = UDim2.new(0.5,-29,0.5,-29),
    AnchorPoint = Vector2.new(0.5,0.5),
    BackgroundColor3 = Color3.fromRGB(7,7,7),
    BorderSizePixel = 0,
    Text = "",
    AutoButtonColor = false,
    Visible = false,
    ZIndex = 100
}, Gui)
Corner(Floating, 29)
Stroke(Floating, GOLD, 2, 0.05)

local FloatCrown = Label(Floating, "^", UDim2.new(1,0,0,22), UDim2.fromOffset(0,1), 15, GOLD2, Enum.Font.GothamBlack)
FloatCrown.TextXAlignment = Enum.TextXAlignment.Center
FloatCrown.ZIndex = 101
local FloatA = Label(Floating, "A", UDim2.new(1,0,0,42), UDim2.fromOffset(0,20), 28, GOLD2, Enum.Font.GothamBlack)
FloatA.TextXAlignment = Enum.TextXAlignment.Center
FloatA.ZIndex = 101

local floatingDragging = false
local floatMoved = false
local floatDragStart
local floatStartPos
Floating.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        floatingDragging = true
        floatMoved = false
        floatDragStart = input.Position
        floatStartPos = Floating.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then floatingDragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if floatingDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - floatDragStart
        if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
            floatMoved = true
        end
        Floating.Position = UDim2.new(floatStartPos.X.Scale, floatStartPos.X.Offset + delta.X, floatStartPos.Y.Scale, floatStartPos.Y.Offset + delta.Y)
    end
end)

local minimized = false
local savedSize = Main.Size
local savedPosition = Main.Position

local function MinimizeUI()
    if minimized then return end
    minimized = true
    savedSize = Main.Size
    savedPosition = Main.Position
    Main.Visible = false
    -- Keep the floating logo exactly where the user last dragged it.
    Floating.Visible = true
end

local function RestoreUI()
    if not minimized then return end
    minimized = false
    Floating.Visible = false
    Main.Size = savedSize
    Main.Position = savedPosition
    Main.Visible = true
end

Minimize.MouseButton1Click:Connect(MinimizeUI)
Floating.MouseButton1Click:Connect(function()
    if not floatMoved then RestoreUI() end
    floatMoved = false
end)

Close.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

-- RightShift toggles the full UI.
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        if minimized then RestoreUI() else MinimizeUI() end
    end
end)

--==================================================
-- INITIAL STATE
--==================================================
SetActive("Home")
