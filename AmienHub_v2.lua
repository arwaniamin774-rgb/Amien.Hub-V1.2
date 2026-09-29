--// Amien.Hub V2
--// UI ONLY - Black & Gold
--// No game/exploit features included.

local ok, err = pcall(function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local Player = Players.LocalPlayer
    if not Player then return end
    local PlayerGui = Player:WaitForChild("PlayerGui", 10)
    if not PlayerGui then return end

    local old = PlayerGui:FindFirstChild("Amien.Hub")
    if old then old:Destroy() end

    local GOLD = Color3.fromRGB(235,180,55)
    local GOLD2 = Color3.fromRGB(255,210,90)
    local DARK = Color3.fromRGB(5,5,5)
    local PANEL = Color3.fromRGB(13,13,13)
    local PANEL2 = Color3.fromRGB(20,20,20)
    local WHITE = Color3.fromRGB(242,242,242)
    local GREY = Color3.fromRGB(150,150,150)
    local GREEN = Color3.fromRGB(70,220,95)

    local Gui = Instance.new("ScreenGui")
    Gui.Name = "Amien.Hub"
    Gui.ResetOnSpawn = false
    Gui.IgnoreGuiInset = true
    Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Gui.DisplayOrder = 999999
    Gui.Parent = PlayerGui

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.fromScale(0.86,0.70)
    Main.Position = UDim2.fromScale(0.5,0.5)
    Main.AnchorPoint = Vector2.new(0.5,0.5)
    Main.BackgroundColor3 = DARK
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Parent = Gui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0,16)
    MainCorner.Parent = Main

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = GOLD
    MainStroke.Thickness = 2
    MainStroke.Transparency = 0.12
    MainStroke.Parent = Main

    -- Background FX: Roblox UI primitives only, so no external asset is needed.
    local BG = Instance.new("Frame")
    BG.Size = UDim2.fromScale(1,1)
    BG.BackgroundColor3 = Color3.fromRGB(4,4,4)
    BG.BorderSizePixel = 0
    BG.ZIndex = 0
    BG.Parent = Main

    local BGGrad = Instance.new("UIGradient")
    BGGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0,Color3.fromRGB(3,3,3)),
        ColorSequenceKeypoint.new(0.55,Color3.fromRGB(8,7,4)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(2,2,2))
    }
    BGGrad.Rotation = 25
    BGGrad.Parent = BG

    local Glow1 = Instance.new("Frame")
    Glow1.Size = UDim2.fromOffset(300,300)
    Glow1.Position = UDim2.new(1,-230,0,-120)
    Glow1.BackgroundColor3 = Color3.fromRGB(70,48,8)
    Glow1.BackgroundTransparency = 0.72
    Glow1.BorderSizePixel = 0
    Glow1.ZIndex = 0
    Glow1.Parent = BG
    local Glow1Corner = Instance.new("UICorner")
    Glow1Corner.CornerRadius = UDim.new(1,0)
    Glow1Corner.Parent = Glow1

    local Glow2 = Instance.new("Frame")
    Glow2.Size = UDim2.fromOffset(220,220)
    Glow2.Position = UDim2.new(-0.08,0,0.72,0)
    Glow2.BackgroundColor3 = Color3.fromRGB(50,36,8)
    Glow2.BackgroundTransparency = 0.82
    Glow2.BorderSizePixel = 0
    Glow2.ZIndex = 0
    Glow2.Parent = BG
    local Glow2Corner = Instance.new("UICorner")
    Glow2Corner.CornerRadius = UDim.new(1,0)
    Glow2Corner.Parent = Glow2

    local function AddLine(parent,x,y,w,rot,transparency)
        local line = Instance.new("Frame")
        line.Size = UDim2.fromOffset(w,1)
        line.Position = UDim2.new(x,0,y,0)
        line.Rotation = rot
        line.BackgroundColor3 = GOLD
        line.BackgroundTransparency = transparency
        line.BorderSizePixel = 0
        line.ZIndex = 0
        line.Parent = parent
        return line
    end
    AddLine(BG,-0.08,0.18,520,-25,0.84)
    AddLine(BG,0.48,0.90,520,-25,0.88)
    AddLine(BG,0.42,0.22,360,25,0.92)

    -- Header
    local Header = Instance.new("Frame")
    Header.Size = UDim2.new(1,0,0,78)
    Header.BackgroundColor3 = Color3.fromRGB(3,3,3)
    Header.BorderSizePixel = 0
    Header.ZIndex = 5
    Header.Parent = Main

    local HeaderGrad = Instance.new("UIGradient")
    HeaderGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0,Color3.fromRGB(8,8,8)),
        ColorSequenceKeypoint.new(0.65,Color3.fromRGB(2,2,2)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(22,15,3))
    }
    HeaderGrad.Parent = Header

    -- Shape-based crown: avoids unsupported Unicode glyphs.
    local CrownHolder = Instance.new("Frame")
    CrownHolder.Size = UDim2.fromOffset(52,52)
    CrownHolder.Position = UDim2.fromOffset(12,13)
    CrownHolder.BackgroundTransparency = 1
    CrownHolder.ZIndex = 7
    CrownHolder.Parent = Header
    local CrownBase = Instance.new("Frame")
    CrownBase.Size = UDim2.fromOffset(32,5)
    CrownBase.Position = UDim2.fromOffset(10,35)
    CrownBase.BackgroundColor3 = GOLD2
    CrownBase.BorderSizePixel = 0
    CrownBase.ZIndex = 7
    CrownBase.Parent = CrownHolder
    local CrownBaseCorner = Instance.new("UICorner")
    CrownBaseCorner.CornerRadius = UDim.new(0,2)
    CrownBaseCorner.Parent = CrownBase
    for i=0,2 do
        local d = Instance.new("Frame")
        d.Size = UDim2.fromOffset(9,9)
        d.Position = UDim2.fromOffset(10+i*11,27-i*7)
        d.Rotation = 45
        d.BackgroundColor3 = GOLD2
        d.BorderSizePixel = 0
        d.ZIndex = 7
        d.Parent = CrownHolder
        local dc = Instance.new("UICorner")
        dc.CornerRadius = UDim.new(0,2)
        dc.Parent = d
    end

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0,240,0,38)
    Title.Position = UDim2.fromOffset(72,9)
    Title.BackgroundTransparency = 1
    Title.Text = "AMIEN.HUB"
    Title.TextColor3 = GOLD2
    Title.TextSize = 30
    Title.Font = Enum.Font.GothamBlack
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 7
    Title.Parent = Header

    local Subtitle = Instance.new("TextLabel")
    Subtitle.Size = UDim2.new(0,300,0,18)
    Subtitle.Position = UDim2.fromOffset(73,47)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "PREMIUM UI  -  SIMPLE  -  CLEAN"
    Subtitle.TextColor3 = GREY
    Subtitle.TextSize = 9
    Subtitle.Font = Enum.Font.GothamMedium
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    Subtitle.ZIndex = 7
    Subtitle.Parent = Header

    local Minimize = Instance.new("TextButton")
    Minimize.Size = UDim2.fromOffset(36,30)
    Minimize.Position = UDim2.new(1,-82,0,24)
    Minimize.BackgroundColor3 = PANEL2
    Minimize.Text = "-"
    Minimize.TextColor3 = GOLD2
    Minimize.TextSize = 20
    Minimize.Font = Enum.Font.GothamBold
    Minimize.BorderSizePixel = 0
    Minimize.AutoButtonColor = false
    Minimize.ZIndex = 8
    Minimize.Parent = Header
    local mc = Instance.new("UICorner")
    mc.CornerRadius = UDim.new(0,8)
    mc.Parent = Minimize

    local Close = Instance.new("TextButton")
    Close.Size = UDim2.fromOffset(36,30)
    Close.Position = UDim2.new(1,-41,0,24)
    Close.BackgroundColor3 = PANEL2
    Close.Text = "X"
    Close.TextColor3 = GOLD2
    Close.TextSize = 16
    Close.Font = Enum.Font.GothamBold
    Close.BorderSizePixel = 0
    Close.AutoButtonColor = false
    Close.ZIndex = 8
    Close.Parent = Header
    local cc = Instance.new("UICorner")
    cc.CornerRadius = UDim.new(0,8)
    cc.Parent = Close

    local Body = Instance.new("Frame")
    Body.Size = UDim2.new(1,0,1,-78)
    Body.Position = UDim2.fromOffset(0,78)
    Body.BackgroundTransparency = 1
    Body.ZIndex = 2
    Body.Parent = Main

    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0,176,1,-18)
    Sidebar.Position = UDim2.fromOffset(10,9)
    Sidebar.BackgroundColor3 = Color3.fromRGB(7,7,7)
    Sidebar.BackgroundTransparency = 0.08
    Sidebar.BorderSizePixel = 0
    Sidebar.ZIndex = 4
    Sidebar.Parent = Body
    local sc = Instance.new("UICorner")
    sc.CornerRadius = UDim.new(0,12)
    sc.Parent = Sidebar
    local ss = Instance.new("UIStroke")
    ss.Color = Color3.fromRGB(40,32,18)
    ss.Thickness = 1
    ss.Parent = Sidebar

    local sidePad = Instance.new("UIPadding")
    sidePad.PaddingTop = UDim.new(0,10)
    sidePad.PaddingLeft = UDim.new(0,8)
    sidePad.PaddingRight = UDim.new(0,8)
    sidePad.Parent = Sidebar
    local sideList = Instance.new("UIListLayout")
    sideList.Padding = UDim.new(0,7)
    sideList.SortOrder = Enum.SortOrder.LayoutOrder
    sideList.Parent = Sidebar

    local tabs = {}
    local function CreateTab(name,icon,order)
        local b = Instance.new("TextButton")
        b.Name = name
        b.LayoutOrder = order
        b.Size = UDim2.new(1,0,0,44)
        b.BackgroundColor3 = Color3.fromRGB(12,12,12)
        b.BorderSizePixel = 0
        b.Text = ""
        b.AutoButtonColor = false
        b.ZIndex = 6
        b.Parent = Sidebar
        local bc = Instance.new("UICorner")
        bc.CornerRadius = UDim.new(0,9)
        bc.Parent = b
        local bs = Instance.new("UIStroke")
        bs.Color = Color3.fromRGB(35,35,35)
        bs.Thickness = 1
        bs.Parent = b
        local il = Instance.new("TextLabel")
        il.Size = UDim2.fromOffset(38,44)
        il.BackgroundTransparency = 1
        il.Text = icon
        il.TextColor3 = WHITE
        il.TextSize = 13
        il.Font = Enum.Font.GothamBold
        il.ZIndex = 7
        il.Parent = b
        local tl = Instance.new("TextLabel")
        tl.Size = UDim2.new(1,-48,1,0)
        tl.Position = UDim2.fromOffset(44,0)
        tl.BackgroundTransparency = 1
        tl.Text = name
        tl.TextColor3 = WHITE
        tl.TextSize = 14
        tl.Font = Enum.Font.GothamMedium
        tl.TextXAlignment = Enum.TextXAlignment.Left
        tl.ZIndex = 7
        tl.Parent = b
        tabs[name] = {Button=b,Icon=il,Text=tl,Stroke=bs}
        return b
    end

    CreateTab("Home","H",1)
    CreateTab("Main","M",2)
    CreateTab("Player","P",3)
    CreateTab("Visual","V",4)
    CreateTab("World","W",5)
    CreateTab("Teleport","T",6)
    CreateTab("Settings","S",7)

    local Content = Instance.new("ScrollingFrame")
    Content.Name = "Content"
    Content.Size = UDim2.new(1,-198,1,-18)
    Content.Position = UDim2.fromOffset(190,9)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 4
    Content.ScrollBarImageColor3 = GOLD
    Content.CanvasSize = UDim2.new(0,0,0,700)
    Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Content.ScrollingDirection = Enum.ScrollingDirection.Y
    Content.ZIndex = 3
    Content.Parent = Body

    local PageHolder = Instance.new("Frame")
    PageHolder.Size = UDim2.new(1,-10,0,680)
    PageHolder.BackgroundTransparency = 1
    PageHolder.ZIndex = 4
    PageHolder.Parent = Content

    local function ClearPage()
        for _,v in ipairs(PageHolder:GetChildren()) do v:Destroy() end
    end

    local function AddLabel(text,y,size,color)
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(1,-18,0,size or 30)
        l.Position = UDim2.fromOffset(0,y)
        l.BackgroundTransparency = 1
        l.Text = text
        l.TextColor3 = color or WHITE
        l.TextSize = 15
        l.Font = Enum.Font.GothamMedium
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.ZIndex = 5
        l.Parent = PageHolder
        return l
    end

    local function Card(y,h,title,desc)
        local c = Instance.new("Frame")
        c.Size = UDim2.new(1,-18,0,h)
        c.Position = UDim2.fromOffset(0,y)
        c.BackgroundColor3 = PANEL
        c.BorderSizePixel = 0
        c.ZIndex = 5
        c.Parent = PageHolder
        local cr = Instance.new("UICorner")
        cr.CornerRadius = UDim.new(0,12)
        cr.Parent = c
        local st = Instance.new("UIStroke")
        st.Color = Color3.fromRGB(58,46,22)
        st.Thickness = 1
        st.Parent = c
        local t = Instance.new("TextLabel")
        t.Size = UDim2.new(1,-28,0,28)
        t.Position = UDim2.fromOffset(14,10)
        t.BackgroundTransparency = 1
        t.Text = title
        t.TextColor3 = GOLD2
        t.TextSize = 18
        t.Font = Enum.Font.GothamBold
        t.TextXAlignment = Enum.TextXAlignment.Left
        t.ZIndex = 6
        t.Parent = c
        if desc then
            local d = Instance.new("TextLabel")
            d.Size = UDim2.new(1,-28,1,-46)
            d.Position = UDim2.fromOffset(14,42)
            d.BackgroundTransparency = 1
            d.Text = desc
            d.TextColor3 = GREY
            d.TextSize = 13
            d.Font = Enum.Font.GothamMedium
            d.TextWrapped = true
            d.TextXAlignment = Enum.TextXAlignment.Left
            d.TextYAlignment = Enum.TextYAlignment.Top
            d.ZIndex = 6
            d.Parent = c
        end
        return c
    end

    local function GetCash()
        local keys = {"cash","money","coins","coin","currency","gold","gems","gem","balance","credits"}
        local function matches(n)
            n = string.lower(n)
            for _,k in ipairs(keys) do
                if n == k or string.find(n,k,1,true) then return true end
            end
            return false
        end
        local containers = {Player,Player:FindFirstChild("leaderstats")}
        for _,container in ipairs(containers) do
            if container then
                for _,obj in ipairs(container:GetDescendants()) do
                    if (obj:IsA("IntValue") or obj:IsA("NumberValue") or obj:IsA("StringValue")) and matches(obj.Name) then
                        return tostring(obj.Value)
                    end
                end
            end
        end
        return "--"
    end

    local function MakeRow(parent,y,label,value)
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1,-28,0,34)
        row.Position = UDim2.fromOffset(14,y)
        row.BackgroundColor3 = Color3.fromRGB(18,18,18)
        row.BorderSizePixel = 0
        row.ZIndex = 7
        row.Parent = parent
        local rc = Instance.new("UICorner")
        rc.CornerRadius = UDim.new(0,7)
        rc.Parent = row
        local l = Instance.new("TextLabel")
        l.Size = UDim2.new(0.38,0,1,0)
        l.Position = UDim2.fromOffset(10,0)
        l.BackgroundTransparency = 1
        l.Text = label
        l.TextColor3 = GREY
        l.TextSize = 12
        l.Font = Enum.Font.GothamMedium
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.ZIndex = 8
        l.Parent = row
        local v = Instance.new("TextLabel")
        v.Size = UDim2.new(0.58,-10,1,0)
        v.Position = UDim2.new(0.40,0,0,0)
        v.BackgroundTransparency = 1
        v.Text = value
        v.TextColor3 = WHITE
        v.TextSize = 12
        v.Font = Enum.Font.GothamBold
        v.TextXAlignment = Enum.TextXAlignment.Right
        v.TextTruncate = Enum.TextTruncate.AtEnd
        v.ZIndex = 8
        v.Parent = row
        return v
    end

    local currentPage = "Home"
    local playerValues = {}

    local function RenderHome()
        ClearPage()
        AddLabel("Welcome to",0,32,WHITE).Font = Enum.Font.GothamBold
        local h = AddLabel("Amien.Hub",34,48,GOLD2)
        h.TextSize = 36
        h.Font = Enum.Font.GothamBlack
        AddLabel("BLACK / GOLD UI  -  READY",82,22,GREY)
        local line = Instance.new("Frame")
        line.Size = UDim2.fromOffset(65,3)
        line.Position = UDim2.fromOffset(0,111)
        line.BackgroundColor3 = GOLD
        line.BorderSizePixel = 0
        line.ZIndex = 5
        line.Parent = PageHolder
        Card(132,125,"Information","Clean interface\nSmooth performance\nEasy to use")
        Card(270,125,"Status","UI Status: READY\nGame: Roblox\nMode: UI ONLY")
    end

    local function RenderPlayer()
        ClearPage()
        AddLabel("PLAYER",0,32,GOLD2).Font = Enum.Font.GothamBlack
        AddLabel("Live information from the current Roblox client",34,22,GREY)
        local avatarCard = Card(70,120,"PLAYER PROFILE",nil)
        local avatar = Instance.new("ImageLabel")
        avatar.Size = UDim2.fromOffset(82,82)
        avatar.Position = UDim2.fromOffset(16,28)
        avatar.BackgroundColor3 = PANEL2
        avatar.BorderSizePixel = 0
        avatar.ZIndex = 7
        avatar.Parent = avatarCard
        local ac = Instance.new("UICorner")
        ac.CornerRadius = UDim.new(1,0)
        ac.Parent = avatar
        local okThumb,url = pcall(function()
            return Players:GetUserThumbnailAsync(Player.UserId,Enum.ThumbnailType.AvatarBust,Enum.ThumbnailSize.Size150x150)
        end)
        if okThumb then avatar.Image = url end
        local name = Instance.new("TextLabel")
        name.Size = UDim2.new(1,-120,0,28)
        name.Position = UDim2.fromOffset(112,38)
        name.BackgroundTransparency = 1
        name.Text = Player.Name
        name.TextColor3 = WHITE
        name.TextSize = 18
        name.Font = Enum.Font.GothamBold
        name.TextXAlignment = Enum.TextXAlignment.Left
        name.ZIndex = 8
        name.Parent = avatarCard
        local dn = Instance.new("TextLabel")
        dn.Size = UDim2.new(1,-120,0,22)
        dn.Position = UDim2.fromOffset(112,68)
        dn.BackgroundTransparency = 1
        dn.Text = Player.DisplayName
        dn.TextColor3 = GOLD2
        dn.TextSize = 13
        dn.Font = Enum.Font.GothamMedium
        dn.TextXAlignment = Enum.TextXAlignment.Left
        dn.ZIndex = 8
        dn.Parent = avatarCard

        local info = Card(205,230,"PLAYER INFO",nil)
        playerValues.username = MakeRow(info,48,"Username",Player.Name)
        playerValues.display = MakeRow(info,86,"Display Name",Player.DisplayName)
        playerValues.userid = MakeRow(info,124,"User ID",tostring(Player.UserId))
        local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        playerValues.speed = MakeRow(info,162,"Speed",hum and tostring(hum.WalkSpeed) or "--")
        playerValues.money = MakeRow(info,200,"Money / Cash",GetCash())
    end

    local function RenderGeneric(title,desc,items)
        ClearPage()
        AddLabel(title,0,32,GOLD2).Font = Enum.Font.GothamBlack
        AddLabel(desc,34,24,GREY)
        local y = 72
        for _,item in ipairs(items) do
            Card(y,72,item[1],item[2])
            y += 82
        end
    end

    local function RenderPage(name)
        currentPage = name
        if name == "Home" then
            RenderHome()
        elseif name == "Player" then
            RenderPlayer()
        elseif name == "Main" then
            RenderGeneric("MAIN","UI controls - feature placeholders only",{{"Auto Farm","Placeholder"},{"Auto Collect","Placeholder"},{"Auto Quest","Placeholder"},{"Auto Upgrade","Placeholder"},{"Auto Rebirth","Placeholder"}})
        elseif name == "Visual" then
            RenderGeneric("VISUAL","Visual options - presentation only",{{"ESP Player","Placeholder"},{"ESP Item","Placeholder"},{"ESP Chest","Placeholder"},{"Fullbright","Placeholder"},{"No Fog","Placeholder"}})
        elseif name == "World" then
            RenderGeneric("WORLD","World options - presentation only",{{"Remove Grass","Placeholder"},{"Remove Tree","Placeholder"},{"Remove Rock","Placeholder"},{"Low Texture","Placeholder"},{"No Water","Placeholder"}})
        elseif name == "Teleport" then
            RenderGeneric("TELEPORT","Location buttons - placeholders only",{{"Spawn","Placeholder"},{"Shop","Placeholder"},{"Island 1","Placeholder"},{"Island 2","Placeholder"},{"Boss","Placeholder"},{"Event","Placeholder"},{"Desert","Placeholder"},{"Snow","Placeholder"},{"Ocean","Placeholder"}})
        else
            RenderGeneric("SETTINGS","UI settings",{{"Save Config","UI placeholder"},{"Load Config","UI placeholder"},{"Reset Config","UI placeholder"},{"Toggle Key","RightShift"}})
        end
    end

    local function SetActive(name)
        for tabName,data in pairs(tabs) do
            local active = tabName == name
            data.Button.BackgroundColor3 = active and Color3.fromRGB(48,35,8) or Color3.fromRGB(12,12,12)
            data.Icon.TextColor3 = active and GOLD2 or WHITE
            data.Text.TextColor3 = active and GOLD2 or WHITE
            data.Stroke.Color = active and GOLD or Color3.fromRGB(35,35,35)
            data.Stroke.Transparency = active and 0 or 0.35
        end
        RenderPage(name)
        Content.CanvasPosition = Vector2.new(0,0)
    end

    for name,data in pairs(tabs) do
        data.Button.MouseButton1Click:Connect(function() SetActive(name) end)
    end

    -- Main panel dragging.
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
            Main.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
        end
    end)

    -- Small floating A/crown button. Position is preserved while dragging.
    local Floating = Instance.new("TextButton")
    Floating.Name = "FloatingLogo"
    Floating.Size = UDim2.fromOffset(50,50)
    Floating.Position = UDim2.new(0.5,-25,0.5,-25)
    Floating.BackgroundColor3 = Color3.fromRGB(8,8,8)
    Floating.BorderSizePixel = 0
    Floating.Text = "A"
    Floating.TextColor3 = GOLD2
    Floating.TextSize = 22
    Floating.Font = Enum.Font.GothamBlack
    Floating.AutoButtonColor = false
    Floating.Visible = false
    Floating.ZIndex = 50
    Floating.Parent = Gui
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(1,0)
    fc.Parent = Floating
    local fs = Instance.new("UIStroke")
    fs.Color = GOLD
    fs.Thickness = 2
    fs.Parent = Floating

    local miniCrown = Instance.new("Frame")
    miniCrown.Size = UDim2.fromOffset(24,12)
    miniCrown.Position = UDim2.fromOffset(13,3)
    miniCrown.BackgroundTransparency = 1
    miniCrown.ZIndex = 52
    miniCrown.Parent = Floating
    for i=0,2 do
        local d = Instance.new("Frame")
        d.Size = UDim2.fromOffset(6,6)
        d.Position = UDim2.fromOffset(i*8,5-i*3)
        d.Rotation = 45
        d.BackgroundColor3 = GOLD2
        d.BorderSizePixel = 0
        d.ZIndex = 53
        d.Parent = miniCrown
    end

    local floatingDragging = false
    local fStart
    local fPos
    Floating.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            floatingDragging = true
            fStart = input.Position
            fPos = Floating.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then floatingDragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if floatingDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - fStart
            Floating.Position = UDim2.new(fPos.X.Scale,fPos.X.Offset+delta.X,fPos.Y.Scale,fPos.Y.Offset+delta.Y)
        end
    end)

    local minimized = false
    Minimize.MouseButton1Click:Connect(function()
        minimized = true
        Main.Visible = false
        Floating.Visible = true
    end)
    Floating.MouseButton1Click:Connect(function()
        minimized = false
        Floating.Visible = false
        Main.Visible = true
    end)
    Close.MouseButton1Click:Connect(function() Gui:Destroy() end)

    -- Refresh player values when character/values change.
    task.spawn(function()
        while Gui.Parent do
            if currentPage == "Player" then
                local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                if playerValues.speed then playerValues.speed.Text = hum and tostring(hum.WalkSpeed) or "--" end
                if playerValues.money then playerValues.money.Text = GetCash() end
            end
            task.wait(1)
        end
    end)

    SetActive("Home")
end)

if not ok then
    warn("[Amien.Hub] UI error: " .. tostring(err))
end
