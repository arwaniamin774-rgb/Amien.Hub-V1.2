--------------------------------------------------------------------------------
-- AMIEN.HUB - REVISI CURI TELUR & ANTI HIT
--------------------------------------------------------------------------------
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlaceId = game.PlaceId

--------------------------------------------------------------------------------
-- CONFIG & THEME
--------------------------------------------------------------------------------
local Theme = {
    Background    = Color3.fromRGB(15, 15, 18),
    GoldPrimary   = Color3.fromRGB(255, 215, 0),
    GoldMuted     = Color3.fromRGB(122, 106, 67),
    TextBright    = Color3.fromRGB(255, 245, 220),
    On            = Color3.fromRGB(35, 30, 15),
    Off           = Color3.fromRGB(18, 18, 22),
    OnStroke      = Color3.fromRGB(255, 215, 0),
    OffStroke     = Color3.fromRGB(50, 45, 35)
}

local MAIN_WIDTH = 250
local FULL_HEIGHT = 280
local CLOSED_HEIGHT = 45

local isAntiHitGuardsActive = false
local isInstantTpActive = false
local isAutoHopping = false

--------------------------------------------------------------------------------
-- GUI CREATION
--------------------------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AmienHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.fromOffset(MAIN_WIDTH, FULL_HEIGHT)
MainFrame.Position = UDim2.new(0.5, -125, 0.3, 0)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.GoldPrimary
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

local HubTitleLabel = Instance.new("TextLabel")
HubTitleLabel.Size = UDim2.new(1, -40, 0, CLOSED_HEIGHT)
HubTitleLabel.Position = UDim2.new(0, 12, 0, 0)
HubTitleLabel.BackgroundTransparency = 1
HubTitleLabel.Text = "Amien.Hub"
HubTitleLabel.TextColor3 = Theme.GoldPrimary
HubTitleLabel.TextSize = 16
HubTitleLabel.Font = Enum.Font.SourceSansBold
HubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
HubTitleLabel.Parent = MainFrame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 30, 0, 30)
ToggleBtn.Position = UDim2.new(1, -35, 0, 7)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = "<"
ToggleBtn.TextColor3 = Theme.GoldPrimary
ToggleBtn.TextSize = 18
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Parent = MainFrame

local ExtraFeatures = Instance.new("CanvasGroup")
ExtraFeatures.Size = UDim2.new(1, -20, 1, -CLOSED_HEIGHT - 10)
ExtraFeatures.Position = UDim2.new(0, 10, 0, CLOSED_HEIGHT)
ExtraFeatures.BackgroundTransparency = 1
ExtraFeatures.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ExtraFeatures

local function CreateFeatureButton(name, titleText, layoutOrder)
    local Btn = Instance.new("TextButton")
    Btn.Name = name
    Btn.Size = UDim2.new(1, 0, 0, 55)
    Btn.BackgroundColor3 = Theme.Off
    Btn.Text = ""
    Btn.AutoButtonColor = false
    Btn.LayoutOrder = layoutOrder
    Btn.Parent = ExtraFeatures

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Btn

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Theme.OffStroke
    Stroke.Thickness = 1
    Stroke.Parent = Btn

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 22)
    Title.Position = UDim2.new(0, 10, 0, 6)
    Title.BackgroundTransparency = 1
    Title.Text = titleText
    Title.TextColor3 = Theme.TextBright
    Title.TextSize = 13
    Title.Font = Enum.Font.SourceSansBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Btn

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 8, 0, 8)
    Dot.Position = UDim2.new(0, 10, 0, 34)
    Dot.BackgroundColor3 = Theme.GoldMuted
    Dot.BorderSizePixel = 0
    Dot.Parent = Btn

    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = Dot

    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(1, -30, 0, 18)
    Status.Position = UDim2.new(0, 24, 0, 29)
    Status.BackgroundTransparency = 1
    Status.Text = "Status: OFF"
    Status.TextColor3 = Theme.GoldMuted
    Status.TextSize = 11
    Status.Font = Enum.Font.SourceSans
    Status.TextXAlignment = Enum.TextXAlignment.Left
    Status.Parent = Btn

    return Btn, Title, Status, Dot, Stroke
end

local AutoHopBtn, BtnTitle, StatusLabel, StatusDot, BtnStroke = CreateFeatureButton("AutoHopBtn", "AUTO HOP SERVER", 1)
local AntiHitGuardsBtn, _, AntiHitStatusLabel, AntiHitDot, AntiHitStroke = CreateFeatureButton("AntiHitGuardsBtn", "ANTI HIT GUARDS", 2)
local InstantTpBtn, _, InstantTpStatusLabel, InstantTpDot, InstantTpStroke = CreateFeatureButton("InstantTpBtn", "INSTANT TELEPORT", 3)

--------------------------------------------------------------------------------
-- DETEKSI TELUR YANG SEDANG DICURI (CARRIED EGG)
--------------------------------------------------------------------------------

local function getSafeZoneCFrame()
    local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
    if spawn then return spawn.CFrame + Vector3.new(0, 5, 0) end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local n = obj.Name:lower()
            if n:find("safe") or n:find("aman") or n:find("base") or n:find("spawn") then
                return obj.CFrame + Vector3.new(0, 5, 0)
            end
        end
    end
    return nil
end

local function isCarryingEgg()
    local char = LocalPlayer.Character
    if not char then return false end

    for _, obj in ipairs(char:GetChildren()) do
        local n = obj.Name:lower()
        if obj:IsA("Model") or obj:IsA("BasePart") or obj:IsA("Tool") or obj:IsA("Accoutrement") then
            if n:find("egg") or n:find("telur") or n:find("stolen") or n:find("carry") then
                return true
            end
        end
        if obj:IsA("Weld") or obj:IsA("Motor6D") or obj:IsA("WeldConstraint") then
            if obj.Part1 and obj.Part1.Name:lower():find("egg") then
                return true
            end
        end
    end

    for attrName, attrVal in pairs(char:GetAttributes()) do
        local name = attrName:lower()
        if (name:find("egg") or name:find("holding") or name:find("carrying") or name:find("steal")) and attrVal == true then
            return true
        end
    end

    return false
end

--------------------------------------------------------------------------------
-- LOGIKA ANTI HIT GUARDS
--------------------------------------------------------------------------------
RunService.Stepped:Connect(function()
    if isAntiHitGuardsActive then
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanTouch = false
                end
            end
        end

        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("TouchTransmitter") then
                if char and not obj:IsDescendantOf(char) then
                    obj:Destroy()
                end
            elseif obj:IsA("BasePart") and (obj.Name:lower():find("hitbox") or obj.Name:lower():find("damage")) then
                obj.CanTouch = false
            end
        end
    end
end)

--------------------------------------------------------------------------------
-- LOGIKA INSTANT TELEPORT (HANYA AKTIF SAAT MEMEGAN/MECURI TELUR)
--------------------------------------------------------------------------------
task.spawn(function()
    local hasTeleportedForEgg = false

    while task.wait(0.05) do
        if isInstantTpActive then
            local char = LocalPlayer.Character

            if isCarryingEgg() then
                if not hasTeleportedForEgg and char and char:FindFirstChild("HumanoidRootPart") then
                    local targetCFrame = getSafeZoneCFrame()
                    if targetCFrame then
                        char:PivotTo(targetCFrame)
                        hasTeleportedForEgg = true
                    end
                end
            else
                hasTeleportedForEgg = false
            end
        end
    end
end)

--------------------------------------------------------------------------------
-- AUTO HOP LOGIC
--------------------------------------------------------------------------------
local function StartAutoHop()
    if isAutoHopping then return end
    isAutoHopping = true

    task.spawn(function()
        BtnTitle.Text = "SEARCHING SERVER..."
        BtnTitle.TextColor3 = Theme.GoldPrimary
        StatusDot.BackgroundColor3 = Theme.GoldPrimary
        BtnStroke.Color = Theme.OnStroke

        local attempt = 1
        local foundJobId = nil

        while isAutoHopping and not foundJobId do
            StatusLabel.Text = string.format("Fetching... (#%d)", attempt)

            local success, result = pcall(function()
                return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/0?sortOrder=Asc&limit=100"))
            end)

            if success and result and result.data then
                for _, server in ipairs(result.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        foundJobId = server.id
                        break
                    end
                end
            end

            if foundJobId then
                StatusLabel.Text = "Teleporting..."
                TeleportService:TeleportToPlaceInstance(PlaceId, foundJobId, LocalPlayer)
                task.wait(5)
            else
                attempt = attempt + 1
                task.wait(0.3)
            end
        end

        BtnTitle.Text = "AUTO HOP SERVER"
        BtnTitle.TextColor3 = Theme.TextBright
        StatusDot.BackgroundColor3 = Theme.GoldMuted
        BtnStroke.Color = Theme.OffStroke
        isAutoHopping = false
    end)
end

--------------------------------------------------------------------------------
-- UI TOGGLES & EVENT HANDLERS
--------------------------------------------------------------------------------
local isCollapsed = false
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

ToggleBtn.MouseButton1Click:Connect(function()
    isCollapsed = not isCollapsed
    if isCollapsed then
        ToggleBtn.Text = ">"
        TweenService:Create(ExtraFeatures, tweenInfo, {GroupTransparency = 1}):Play()
        TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.fromOffset(MAIN_WIDTH, CLOSED_HEIGHT)}):Play()
        task.delay(0.3, function() if isCollapsed then ExtraFeatures.Visible = false end end)
    else
        ToggleBtn.Text = "<"
        ExtraFeatures.Visible = true
        TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.fromOffset(MAIN_WIDTH, FULL_HEIGHT)}):Play()
        TweenService:Create(ExtraFeatures, tweenInfo, {GroupTransparency = 0}):Play()
    end
end)

AutoHopBtn.MouseButton1Click:Connect(StartAutoHop)

AntiHitGuardsBtn.MouseButton1Click:Connect(function()
    isAntiHitGuardsActive = not isAntiHitGuardsActive
    if isAntiHitGuardsActive then
        AntiHitStatusLabel.Text = "Status: ON"
        AntiHitStatusLabel.TextColor3 = Theme.GoldPrimary
        AntiHitDot.BackgroundColor3 = Theme.GoldPrimary
        AntiHitGuardsBtn.BackgroundColor3 = Theme.On
        AntiHitStroke.Color = Theme.OnStroke
    else
        AntiHitStatusLabel.Text = "Status: OFF"
        AntiHitStatusLabel.TextColor3 = Theme.GoldMuted
        AntiHitDot.BackgroundColor3 = Theme.GoldMuted
        AntiHitGuardsBtn.BackgroundColor3 = Theme.Off
        AntiHitStroke.Color = Theme.OffStroke
    end
end)

InstantTpBtn.MouseButton1Click:Connect(function()
    isInstantTpActive = not isInstantTpActive
    if isInstantTpActive then
        InstantTpStatusLabel.Text = "Status: ON"
        InstantTpStatusLabel.TextColor3 = Theme.GoldPrimary
        InstantTpDot.BackgroundColor3 = Theme.GoldPrimary
        InstantTpBtn.BackgroundColor3 = Theme.On
        InstantTpStroke.Color = Theme.OnStroke
    else
        InstantTpStatusLabel.Text = "Status: OFF"
        InstantTpStatusLabel.TextColor3 = Theme.GoldMuted
        InstantTpDot.BackgroundColor3 = Theme.GoldMuted
        InstantTpBtn.BackgroundColor3 = Theme.Off
        InstantTpStroke.Color = Theme.OffStroke
    end
end)
