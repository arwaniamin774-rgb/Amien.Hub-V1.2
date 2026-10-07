--------------------------------------------------------------------------------
-- AMIEN.HUB - CLEAN GUI / DEBUG VERSION
-- Original GUI preserved. Unsafe game-exploit functions are not included.
--------------------------------------------------------------------------------

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    return
end

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

--------------------------------------------------------------------------------
-- REMOVE OLD GUI INSTANCE
--------------------------------------------------------------------------------
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local OldGui = PlayerGui:FindFirstChild("AmienHubGui")

if OldGui then
    OldGui:Destroy()
end

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local isAntiHitGuardsActive = false
local isInstantTpActive = false
local isAutoHopping = false
local isCollapsed = false

--------------------------------------------------------------------------------
-- GUI CREATION
--------------------------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AmienHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

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
HubTitleLabel.Name = "HubTitle"
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
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.fromOffset(30, 30)
ToggleBtn.Position = UDim2.new(1, -35, 0, 7)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = "<"
ToggleBtn.TextColor3 = Theme.GoldPrimary
ToggleBtn.TextSize = 18
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.AutoButtonColor = false
ToggleBtn.Parent = MainFrame

local ExtraFeatures = Instance.new("CanvasGroup")
ExtraFeatures.Name = "ExtraFeatures"
ExtraFeatures.Size = UDim2.new(1, -20, 1, -CLOSED_HEIGHT - 10)
ExtraFeatures.Position = UDim2.new(0, 10, 0, CLOSED_HEIGHT)
ExtraFeatures.BackgroundTransparency = 1
ExtraFeatures.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ExtraFeatures

--------------------------------------------------------------------------------
-- FEATURE BUTTON
--------------------------------------------------------------------------------
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
    Title.Name = "Title"
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
    Dot.Name = "StatusDot"
    Dot.Size = UDim2.fromOffset(8, 8)
    Dot.Position = UDim2.new(0, 10, 0, 34)
    Dot.BackgroundColor3 = Theme.GoldMuted
    Dot.BorderSizePixel = 0
    Dot.Parent = Btn

    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = Dot

    local Status = Instance.new("TextLabel")
    Status.Name = "Status"
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

local AutoHopBtn, AutoHopTitle, AutoHopStatus, AutoHopDot, AutoHopStroke =
    CreateFeatureButton("AutoHopBtn", "AUTO HOP SERVER", 1)

local AntiHitGuardsBtn, AntiHitTitle, AntiHitStatusLabel, AntiHitDot, AntiHitStroke =
    CreateFeatureButton("AntiHitGuardsBtn", "ANTI HIT GUARDS", 2)

local InstantTpBtn, InstantTpTitle, InstantTpStatusLabel, InstantTpDot, InstantTpStroke =
    CreateFeatureButton("InstantTpBtn", "INSTANT TELEPORT", 3)

--------------------------------------------------------------------------------
-- SAFE UI STATUS HANDLER
--------------------------------------------------------------------------------
local function SetButtonState(button, statusLabel, dot, stroke, enabled)
    if enabled then
        statusLabel.Text = "Status: ON"
        statusLabel.TextColor3 = Theme.GoldPrimary
        dot.BackgroundColor3 = Theme.GoldPrimary
        button.BackgroundColor3 = Theme.On
        stroke.Color = Theme.OnStroke
    else
        statusLabel.Text = "Status: OFF"
        statusLabel.TextColor3 = Theme.GoldMuted
        dot.BackgroundColor3 = Theme.GoldMuted
        button.BackgroundColor3 = Theme.Off
        stroke.Color = Theme.OffStroke
    end
end

--------------------------------------------------------------------------------
-- BUTTON HANDLERS
-- These keep the original GUI behavior but do not perform game bypass/exploit
-- actions against another game's mechanics.
--------------------------------------------------------------------------------
AutoHopBtn.MouseButton1Click:Connect(function()
    if isAutoHopping then
        return
    end

    isAutoHopping = true
    AutoHopTitle.Text = "AUTO HOP SERVER"
    AutoHopTitle.TextColor3 = Theme.GoldPrimary
    AutoHopStatus.Text = "Status: UNAVAILABLE"
    AutoHopStatus.TextColor3 = Theme.GoldMuted
    AutoHopDot.BackgroundColor3 = Theme.GoldMuted
    AutoHopStroke.Color = Theme.OffStroke

    warn("[Amien.Hub] Auto Hop is not implemented in this safe version.")

    task.delay(1.5, function()
        if ScreenGui.Parent then
            AutoHopStatus.Text = "Status: OFF"
            AutoHopTitle.Text = "AUTO HOP SERVER"
            AutoHopTitle.TextColor3 = Theme.TextBright
            isAutoHopping = false
        end
    end)
end)

AntiHitGuardsBtn.MouseButton1Click:Connect(function()
    isAntiHitGuardsActive = not isAntiHitGuardsActive

    SetButtonState(
        AntiHitGuardsBtn,
        AntiHitStatusLabel,
        AntiHitDot,
        AntiHitStroke,
        isAntiHitGuardsActive
    )

    if isAntiHitGuardsActive then
        warn("[Amien.Hub] Anti Hit is UI/debug only in this version.")
    end
end)

InstantTpBtn.MouseButton1Click:Connect(function()
    isInstantTpActive = not isInstantTpActive

    SetButtonState(
        InstantTpBtn,
        InstantTpStatusLabel,
        InstantTpDot,
        InstantTpStroke,
        isInstantTpActive
    )

    if isInstantTpActive then
        warn("[Amien.Hub] Instant Teleport is UI/debug only in this version.")
    end
end)

--------------------------------------------------------------------------------
-- COLLAPSE / EXPAND
--------------------------------------------------------------------------------
local tweenInfo = TweenInfo.new(
    0.3,
    Enum.EasingStyle.Quad,
    Enum.EasingDirection.Out
)

ToggleBtn.MouseButton1Click:Connect(function()
    isCollapsed = not isCollapsed

    if isCollapsed then
        ToggleBtn.Text = ">"

        local fadeTween = TweenService:Create(
            ExtraFeatures,
            tweenInfo,
            {GroupTransparency = 1}
        )

        local sizeTween = TweenService:Create(
            MainFrame,
            tweenInfo,
            {Size = UDim2.fromOffset(MAIN_WIDTH, CLOSED_HEIGHT)}
        )

        fadeTween:Play()
        sizeTween:Play()

        task.delay(0.3, function()
            if isCollapsed and ExtraFeatures.Parent then
                ExtraFeatures.Visible = false
            end
        end)
    else
        ToggleBtn.Text = "<"
        ExtraFeatures.Visible = true

        local sizeTween = TweenService:Create(
            MainFrame,
            tweenInfo,
            {Size = UDim2.fromOffset(MAIN_WIDTH, FULL_HEIGHT)}
        )

        local fadeTween = TweenService:Create(
            ExtraFeatures,
            tweenInfo,
            {GroupTransparency = 0}
        )

        sizeTween:Play()
        fadeTween:Play()
    end
end)

--------------------------------------------------------------------------------
-- CLEANUP
--------------------------------------------------------------------------------
ScreenGui.AncestryChanged:Connect(function(_, parent)
    if not parent then
        isAntiHitGuardsActive = false
        isInstantTpActive = false
        isAutoHopping = false
    end
end)

print("[Amien.Hub] GUI loaded successfully.")
