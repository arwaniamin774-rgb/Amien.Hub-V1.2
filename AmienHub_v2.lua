--------------------------------------------------------------------------------
-- AMIEN.HUB - REVISI ULTIMATE (MANUAL TP & DESYNC ANTI-HIT)
--------------------------------------------------------------------------------
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

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
local FULL_HEIGHT = 330
local CLOSED_HEIGHT = 45

local isAntiHitGuardsActive = false
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
    Btn.Size = UDim2.new(1, 0, 0, 50)
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
    Title.Size = UDim2.new(1, -20, 0, 20)
    Title.Position = UDim2.new(0, 10, 0, 5)
    Title.BackgroundTransparency = 1
    Title.Text = titleText
    Title.TextColor3 = Theme.TextBright
    Title.TextSize = 13
    Title.Font = Enum.Font.SourceSansBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Btn

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 8, 0, 8)
    Dot.Position = UDim2.new(0, 10, 0, 30)
    Dot.BackgroundColor3 = Theme.GoldMuted
    Dot.BorderSizePixel = 0
    Dot.Parent = Btn

    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = Dot

    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(1, -30, 0, 18)
    Status.Position = UDim2.new(0, 24, 0, 25)
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

-- Tombol Manual Teleport
local TpZoneBtn = Instance.new("TextButton")
TpZoneBtn.Name = "TpZoneBtn"
TpZoneBtn.Size = UDim2.new(1, 0, 0, 50)
TpZoneBtn.BackgroundColor3 = Theme.On
TpZoneBtn.Text = "TELEPORT ZONA AMAN"
TpZoneBtn.TextColor3 = Theme.GoldPrimary
TpZoneBtn.Font = Enum.Font.SourceSansBold
TpZoneBtn.TextSize = 13
TpZoneBtn.LayoutOrder = 3
TpZoneBtn.Parent = ExtraFeatures

local TpCorner = Instance.new("UICorner")
TpCorner.CornerRadius = UDim.new(0, 6)
TpCorner.Parent = TpZoneBtn

local TpStroke = Instance.new("UIStroke")
TpStroke.Color = Theme.GoldPrimary
TpStroke.Thickness = 1
TpStroke.Parent = TpZoneBtn

--------------------------------------------------------------------------------
-- TELEPORT ZONA AMAN LOGIC
--------------------------------------------------------------------------------
local function TeleportToZonaAman()
    local char = LocalPlayer.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    if not hrp then return end

    -- Mencari titik Zona Aman berdasarkan nama di workspace
    local targetCFrame = nil
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            if obj.Name:lower():find("zona aman") or obj.Name:lower():find("zonaaman") then
                if obj:IsA("BasePart") then
                    targetCFrame = obj.CFrame + Vector3.new(0, 5, 0)
                    break
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    targetCFrame = obj.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
                    break
                end
            end
        end
    end

    -- Fallback ke SpawnLocation jika tidak ketemu
    if not targetCFrame then
        local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
        if spawn then targetCFrame = spawn.CFrame + Vector3.new(0, 5, 0) end
    end

    if targetCFrame then
        char:PivotTo(targetCFrame)
    end
end

TpZoneBtn.MouseButton1Click:Connect(TeleportToZonaAman)

-- Teleport Otomatis saat menekan ProximityPrompt (Selesai ambil telur)
workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("ProximityPrompt") then
        descendant.Triggered:Connect(function(playerWhoTriggered)
            if playerWhoTriggered == LocalPlayer then
                task.wait(0.1) -- Jeda sebentar agar server memproses telur
                TeleportToZonaAman()
            end
        end)
    end
end)

--------------------------------------------------------------------------------
-- ANTI HIT GUARDS (DESYNC / GHOST POSITION)
--------------------------------------------------------------------------------
RunService.Stepped:Connect(function()
    if isAntiHitGuardsActive then
        local char = LocalPlayer.Character
        if char then
            -- 1. Matikan CanTouch & CanCollide pada karakter
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanTouch = false
                    part.CanCollide = false
                end
            end

            -- 2. Spoofing Velocity agar Guard gagal menghitung pergerakan kita
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Velocity = Vector3.new(0, -100, 0)
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
-- UI TOGGLES
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
