-- [[ REDAXHACK v3.0 - MIDNIGHT ELITE ]] --
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

if CoreGui:FindFirstChild("RedaxUltimate") then CoreGui.RedaxUltimate:Destroy() end

-- ==================== AYARLAR ====================
_G.AimbotEnabled  = false
_G.AimbotFOV      = 120
_G.AimbotSmooth   = 1
_G.TeamCheck      = false
_G.EspEnabled     = false
_G.TeamEsp        = true
_G.WallCheck      = true
_G.WalkSpeed      = 16


-- ==================== EKSİK DEĞİŞKENLER (DÜZELTME) ====================
local SkinCategories = {"T Silahları", "CT Silahları", "Ortak", "Bıçaklar"}
local activeSkinCat  = "T Silahları"
local appliedSkins   = {}       -- {[sfKey] = skinName}
local activeSkinWeapon = nil    -- şu an seçili silah

-- ==================== RENKLER (ExHack Tema) ====================
local C = {
    BG          = Color3.fromRGB(10, 10, 12),
    BGDeep      = Color3.fromRGB(6, 6, 8),
    Sidebar     = Color3.fromRGB(13, 13, 16),
    Card        = Color3.fromRGB(18, 18, 22),
    CardHover   = Color3.fromRGB(25, 25, 30),
    CardActive  = Color3.fromRGB(28, 14, 14),
    Accent      = Color3.fromRGB(220, 40, 40),
    AccentDim   = Color3.fromRGB(140, 20, 20),
    AccentGlow  = Color3.fromRGB(255, 60, 60),
    TabActive   = Color3.fromRGB(28, 14, 14),
    Text        = Color3.fromRGB(230, 225, 225),
    SubText     = Color3.fromRGB(130, 120, 120),
    Border      = Color3.fromRGB(40, 30, 30),
    BorderBright= Color3.fromRGB(180, 30, 30),
    SliderTrack = Color3.fromRGB(28, 20, 20),
    Off         = Color3.fromRGB(45, 35, 35),
    Header      = Color3.fromRGB(8, 7, 9),
    EspGreen    = Color3.fromRGB(0, 220, 90),
    EspRed      = Color3.fromRGB(230, 50, 50),
    EspYellow   = Color3.fromRGB(240, 200, 0),
}

-- ==================== FOV DAİRESİ ====================
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.Color = Color3.fromRGB(220, 40, 40)
FOVCircle.Visible = false
FOVCircle.Filled = false
FOVCircle.NumSides = 64

-- ==================== SCREEN GUI ====================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "RedaxUltimate"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999

-- ==================== INTRO (Yeni Tasarım) ====================
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(6, 6, 8)
IntroFrame.ZIndex = 200
IntroFrame.BorderSizePixel = 0

-- Arka plan noise efekti için ince grid
for i = 1, 12 do
    local line = Instance.new("Frame", IntroFrame)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, i / 12, 0)
    line.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
    line.BackgroundTransparency = 0.96
    line.BorderSizePixel = 0
    line.ZIndex = 200
end

-- Merkez container
local IntroCenterFrame = Instance.new("Frame", IntroFrame)
IntroCenterFrame.Size = UDim2.new(0, 480, 0, 90)
IntroCenterFrame.Position = UDim2.new(0.5, -240, 0.5, -45)
IntroCenterFrame.BackgroundTransparency = 1
IntroCenterFrame.ZIndex = 205

-- Logo kutusu (sol taraf - kırmızı kare/X ikonu)
local LogoBox = Instance.new("Frame", IntroCenterFrame)
LogoBox.Size = UDim2.new(0, 80, 0, 80)
LogoBox.Position = UDim2.new(0, 0, 0.5, -40)
LogoBox.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
LogoBox.BorderSizePixel = 0
LogoBox.ZIndex = 206
LogoBox.BackgroundTransparency = 1  -- animasyonla gelecek
Instance.new("UICorner", LogoBox).CornerRadius = UDim.new(0, 6)

-- Logo iç kenarlık efekti
local LogoBoxInner = Instance.new("Frame", LogoBox)
LogoBoxInner.Size = UDim2.new(1, -4, 1, -4)
LogoBoxInner.Position = UDim2.new(0, 2, 0, 2)
LogoBoxInner.BackgroundColor3 = Color3.fromRGB(12, 10, 14)
LogoBoxInner.BorderSizePixel = 0
LogoBoxInner.ZIndex = 207
Instance.new("UICorner", LogoBoxInner).CornerRadius = UDim.new(0, 4)

-- Logo X harfi
local LogoX = Instance.new("TextLabel", LogoBox)
LogoX.Text = "✕"
LogoX.Size = UDim2.new(1, 0, 1, 0)
LogoX.Font = Enum.Font.GothamBlack
LogoX.TextSize = 42
LogoX.TextColor3 = Color3.fromRGB(220, 40, 40)
LogoX.BackgroundTransparency = 1
LogoX.ZIndex = 208
LogoX.TextTransparency = 1  -- animasyonla gelecek

-- Dikey ayırıcı çizgi (logo ile yazı arasında)
local IntroDivider = Instance.new("Frame", IntroCenterFrame)
IntroDivider.Size = UDim2.new(0, 2, 0, 0)  -- önce 0 yükseklik, animasyonla büyüyecek
IntroDivider.Position = UDim2.new(0, 96, 0.5, 0)
IntroDivider.AnchorPoint = Vector2.new(0, 0.5)
IntroDivider.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
IntroDivider.BorderSizePixel = 0
IntroDivider.ZIndex = 206

-- Sağ taraf: yazı grubu
local IntroTextGroup = Instance.new("Frame", IntroCenterFrame)
IntroTextGroup.Size = UDim2.new(0, 370, 1, 0)
IntroTextGroup.Position = UDim2.new(0, 108, 0, 0)
IntroTextGroup.BackgroundTransparency = 1
IntroTextGroup.ZIndex = 206

-- Ana başlık: RedaxHack
local IntroTitle = Instance.new("TextLabel", IntroTextGroup)
IntroTitle.Text = "RedaxHack"
IntroTitle.Size = UDim2.new(1, 0, 0, 52)
IntroTitle.Position = UDim2.new(0, 0, 0, 6)
IntroTitle.Font = Enum.Font.GothamBlack
IntroTitle.TextSize = 44
IntroTitle.TextColor3 = Color3.fromRGB(230, 225, 225)
IntroTitle.BackgroundTransparency = 1
IntroTitle.TextXAlignment = Enum.TextXAlignment.Left
IntroTitle.ZIndex = 207
IntroTitle.TextTransparency = 1  -- animasyonla gelecek

-- "Redax" kırmızı vurgu overlay
local IntroTitleRed = Instance.new("TextLabel", IntroTextGroup)
IntroTitleRed.Text = "Redax"
IntroTitleRed.Size = UDim2.new(1, 0, 0, 52)
IntroTitleRed.Position = UDim2.new(0, 0, 0, 6)
IntroTitleRed.Font = Enum.Font.GothamBlack
IntroTitleRed.TextSize = 44
IntroTitleRed.TextColor3 = Color3.fromRGB(220, 40, 40)
IntroTitleRed.BackgroundTransparency = 1
IntroTitleRed.TextXAlignment = Enum.TextXAlignment.Left
IntroTitleRed.ZIndex = 208
IntroTitleRed.TextTransparency = 1

-- by HzFewarr
local IntroBy = Instance.new("TextLabel", IntroTextGroup)
IntroBy.Text = "by HzFewarr"
IntroBy.Size = UDim2.new(1, 0, 0, 20)
IntroBy.Position = UDim2.new(0, 2, 0, 58)
IntroBy.Font = Enum.Font.GothamMedium
IntroBy.TextSize = 13
IntroBy.TextColor3 = Color3.fromRGB(130, 120, 120)
IntroBy.BackgroundTransparency = 1
IntroBy.TextXAlignment = Enum.TextXAlignment.Left
IntroBy.ZIndex = 207
IntroBy.TextTransparency = 1

-- Alt ince kırmızı çizgi (yazının altında)
local IntroUnderline = Instance.new("Frame", IntroTextGroup)
IntroUnderline.Size = UDim2.new(0, 0, 0, 2)
IntroUnderline.Position = UDim2.new(0, 0, 0, 54)
IntroUnderline.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
IntroUnderline.BorderSizePixel = 0
IntroUnderline.ZIndex = 207

-- BarFill dummy (intro animasyonu LoadPercent referansı gerektiriyor)
local BarFill = Instance.new("Frame", IntroFrame)
BarFill.Size = UDim2.new(0, 0, 0, 0)
BarFill.BackgroundTransparency = 1

-- ==================== ANA MENÜ ====================
local Main = Instance.new("Frame", ScreenGui)
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 760, 0, 500)
Main.Position = UDim2.new(0.5, -380, 1.5, 0)
Main.BackgroundColor3 = C.BG
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(40, 30, 30)
MainStroke.Thickness = 1

local TL = Instance.new("Frame", Main)
TL.Size = UDim2.new(0, 40, 0, 2)
TL.Position = UDim2.new(0, 0, 0, 0)
TL.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
TL.BorderSizePixel = 0

local TL2 = Instance.new("Frame", Main)
TL2.Size = UDim2.new(0, 2, 0, 40)
TL2.Position = UDim2.new(0, 0, 0, 0)
TL2.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
TL2.BorderSizePixel = 0

local BR = Instance.new("Frame", Main)
BR.Size = UDim2.new(0, 40, 0, 2)
BR.Position = UDim2.new(1, -40, 1, -2)
BR.BackgroundColor3 = Color3.fromRGB(140, 20, 20)
BR.BorderSizePixel = 0

local BR2 = Instance.new("Frame", Main)
BR2.Size = UDim2.new(0, 2, 0, 40)
BR2.Position = UDim2.new(1, -2, 1, -40)
BR2.BackgroundColor3 = Color3.fromRGB(140, 20, 20)
BR2.BorderSizePixel = 0

-- ========== HEADER (ExHack Stili) ==========
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 44)
Header.BackgroundColor3 = Color3.fromRGB(8, 7, 9)
Header.BorderSizePixel = 0

-- Alt kırmızı çizgi
local HeaderBottomLine = Instance.new("Frame", Header)
HeaderBottomLine.Size = UDim2.new(1, 0, 0, 2)
HeaderBottomLine.Position = UDim2.new(0, 0, 1, -2)
HeaderBottomLine.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
HeaderBottomLine.BorderSizePixel = 0

-- Sol: ✕ ikonu
local HLogo = Instance.new("TextLabel", Header)
HLogo.Text = "✕"
HLogo.Size = UDim2.new(0, 36, 1, 0)
HLogo.Position = UDim2.new(0, 10, 0, 0)
HLogo.Font = Enum.Font.GothamBlack
HLogo.TextSize = 20
HLogo.TextColor3 = Color3.fromRGB(220, 40, 40)
HLogo.BackgroundTransparency = 1

-- Başlık: kırmızı R + beyaz EDAXHACK
local HeaderTitle = Instance.new("TextLabel", Header)
HeaderTitle.Text = "REDAXHACK"
HeaderTitle.Font = Enum.Font.GothamBlack
HeaderTitle.TextSize = 15
HeaderTitle.TextColor3 = Color3.fromRGB(225, 220, 220)
HeaderTitle.Size = UDim2.new(0, 180, 1, 0)
HeaderTitle.Position = UDim2.new(0, 46, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Orta: versiyon etiketi
local HeaderMid = Instance.new("TextLabel", Header)
HeaderMid.Text = "Counter Blox"
HeaderMid.Font = Enum.Font.GothamMedium
HeaderMid.TextSize = 10
HeaderMid.TextColor3 = Color3.fromRGB(100, 90, 90)
HeaderMid.Size = UDim2.new(0, 160, 1, 0)
HeaderMid.Position = UDim2.new(0.5, -80, 0, 0)
HeaderMid.BackgroundTransparency = 1

-- Sağ: INSERT tuşu göstergesi
local HeaderRight = Instance.new("TextLabel", Header)
HeaderRight.Text = "[INSERT] Gizle"
HeaderRight.Font = Enum.Font.GothamMedium
HeaderRight.TextSize = 10
HeaderRight.TextColor3 = Color3.fromRGB(100, 90, 90)
HeaderRight.Size = UDim2.new(0, 160, 1, 0)
HeaderRight.Position = UDim2.new(1, -172, 0, 0)
HeaderRight.BackgroundTransparency = 1
HeaderRight.TextXAlignment = Enum.TextXAlignment.Right

local dragging, dragStart, startPos = false, nil, nil
Header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = i.Position
        startPos = Main.Position
    end
end)
Header.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UserInputService.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

-- ========== SIDEBAR (ExHack Stili) ==========
local SideBar = Instance.new("Frame", Main)
SideBar.Size = UDim2.new(0, 160, 1, -44)
SideBar.Position = UDim2.new(0, 0, 0, 44)
SideBar.BackgroundColor3 = Color3.fromRGB(11, 10, 13)
SideBar.BorderSizePixel = 0

-- Sağ kenar çizgisi
local SBLine = Instance.new("Frame", SideBar)
SBLine.Size = UDim2.new(0, 1, 1, 0)
SBLine.Position = UDim2.new(1, -1, 0, 0)
SBLine.BackgroundColor3 = Color3.fromRGB(40, 30, 30)
SBLine.BorderSizePixel = 0

-- Üst kırmızı çizgi
local SBDeco = Instance.new("Frame", SideBar)
SBDeco.Size = UDim2.new(1, 0, 0, 2)
SBDeco.Position = UDim2.new(0, 0, 0, 0)
SBDeco.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
SBDeco.BorderSizePixel = 0

-- Oyuncu adı kutusu
local PlayerBox = Instance.new("Frame", SideBar)
PlayerBox.Size = UDim2.new(1, -16, 0, 42)
PlayerBox.Position = UDim2.new(0, 8, 0, 10)
PlayerBox.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
PlayerBox.BorderSizePixel = 0
Instance.new("UICorner", PlayerBox).CornerRadius = UDim.new(0, 4)
local PBStroke = Instance.new("UIStroke", PlayerBox)
PBStroke.Color = Color3.fromRGB(40, 30, 30)
PBStroke.Thickness = 1

-- Sol kırmızı çizgi
local PlayerAccent = Instance.new("Frame", PlayerBox)
PlayerAccent.Size = UDim2.new(0, 2, 0.7, 0)
PlayerAccent.Position = UDim2.new(0, 0, 0.15, 0)
PlayerAccent.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
PlayerAccent.BorderSizePixel = 0
Instance.new("UICorner", PlayerAccent).CornerRadius = UDim.new(1, 0)

local PlayerNameLbl = Instance.new("TextLabel", PlayerBox)
PlayerNameLbl.Text = LocalPlayer.DisplayName
PlayerNameLbl.Size = UDim2.new(1, -14, 0, 18)
PlayerNameLbl.Position = UDim2.new(0, 10, 0, 5)
PlayerNameLbl.Font = Enum.Font.GothamBold
PlayerNameLbl.TextSize = 12
PlayerNameLbl.TextColor3 = Color3.fromRGB(230, 225, 225)
PlayerNameLbl.BackgroundTransparency = 1
PlayerNameLbl.TextXAlignment = Enum.TextXAlignment.Left

local PlayerTagLbl = Instance.new("TextLabel", PlayerBox)
PlayerTagLbl.Text = "@" .. LocalPlayer.Name
PlayerTagLbl.Size = UDim2.new(1, -14, 0, 14)
PlayerTagLbl.Position = UDim2.new(0, 10, 0, 23)
PlayerTagLbl.Font = Enum.Font.Gotham
PlayerTagLbl.TextSize = 10
PlayerTagLbl.TextColor3 = Color3.fromRGB(130, 120, 120)
PlayerTagLbl.BackgroundTransparency = 1
PlayerTagLbl.TextXAlignment = Enum.TextXAlignment.Left

local SBSep = Instance.new("Frame", SideBar)
SBSep.Size = UDim2.new(1, -16, 0, 1)
SBSep.Position = UDim2.new(0, 8, 0, 58)
SBSep.BackgroundColor3 = Color3.fromRGB(40, 30, 30)
SBSep.BorderSizePixel = 0

-- ========== İÇERİK ALANI ==========
local ContentArea = Instance.new("Frame", Main)
ContentArea.Position = UDim2.new(0, 160, 0, 44)
ContentArea.Size = UDim2.new(1, -160, 1, -44)
ContentArea.BackgroundTransparency = 1
ContentArea.ClipsDescendants = true

-- ==================== SAYFA SİSTEMİ ====================
local Pages = {}
local TabButtons = {}

local function CreatePage(name)
    local Scroll = Instance.new("ScrollingFrame", ContentArea)
    Scroll.Size = UDim2.new(1, 0, 1, 0)
    Scroll.BackgroundTransparency = 1
    Scroll.Visible = false
    Scroll.ScrollBarThickness = 3
    Scroll.ScrollBarImageColor3 = Color3.fromRGB(140, 20, 20)
    Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

    local Pad = Instance.new("UIPadding", Scroll)
    Pad.PaddingLeft   = UDim.new(0, 18)
    Pad.PaddingRight  = UDim.new(0, 18)
    Pad.PaddingTop    = UDim.new(0, 16)
    Pad.PaddingBottom = UDim.new(0, 16)

    local List = Instance.new("UIListLayout", Scroll)
    List.Padding = UDim.new(0, 8)
    List.SortOrder = Enum.SortOrder.LayoutOrder

    Pages[name] = Scroll
    return Scroll
end

-- ==================== BİLEŞENLER ====================
local layoutOrder = 0
local function NextOrder() layoutOrder += 1 return layoutOrder end

local function SectionLabel(parent, text)
    layoutOrder += 1
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 24)
    row.BackgroundTransparency = 1
    row.LayoutOrder = layoutOrder
    row.BorderSizePixel = 0

    local bar = Instance.new("Frame", row)
    bar.Size = UDim2.new(0, 3, 1, -8)
    bar.Position = UDim2.new(0, 0, 0, 4)
    bar.BackgroundColor3 = C.Accent
    bar.BorderSizePixel = 0
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local lbl = Instance.new("TextLabel", row)
    lbl.Text = text:upper()
    lbl.Size = UDim2.new(1, -12, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 10
    lbl.TextColor3 = C.Accent
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

local function AddToggle(parent, text, desc, callback)
    layoutOrder += 1
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, 0, 0, desc and 54 or 44)
    Frame.BackgroundColor3 = C.Card
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = layoutOrder
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 5)

    local Stroke = Instance.new("UIStroke", Frame)
    Stroke.Color = C.Border
    Stroke.Thickness = 1

    local Label = Instance.new("TextLabel", Frame)
    Label.Text = text
    Label.Size = UDim2.new(1, -68, 0, 22)
    Label.Position = UDim2.new(0, 14, 0, desc and 8 or 0)
    Label.TextColor3 = C.Text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    if desc then
        local Sub = Instance.new("TextLabel", Frame)
        Sub.Text = desc
        Sub.Size = UDim2.new(1, -68, 0, 16)
        Sub.Position = UDim2.new(0, 14, 0, 28)
        Sub.TextColor3 = C.SubText
        Sub.Font = Enum.Font.Gotham
        Sub.TextSize = 10
        Sub.TextXAlignment = Enum.TextXAlignment.Left
        Sub.BackgroundTransparency = 1
    end

    local Switch = Instance.new("Frame", Frame)
    Switch.Size = UDim2.new(0, 40, 0, 20)
    Switch.Position = UDim2.new(1, -54, 0.5, -10)
    Switch.BackgroundColor3 = C.Off
    Switch.BorderSizePixel = 0
    Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

    local Ball = Instance.new("Frame", Switch)
    Ball.Size = UDim2.new(0, 14, 0, 14)
    Ball.Position = UDim2.new(0, 3, 0.5, -7)
    Ball.BackgroundColor3 = Color3.fromRGB(160, 190, 160)
    Ball.BorderSizePixel = 0
    Instance.new("UICorner", Ball).CornerRadius = UDim.new(1, 0)

    local Btn = Instance.new("TextButton", Frame)
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""

    local state = false
    Btn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(Ball, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7),
            BackgroundColor3 = state and Color3.fromRGB(255,255,255) or Color3.fromRGB(160,190,160)
        }):Play()
        TweenService:Create(Switch, TweenInfo.new(0.15), {
            BackgroundColor3 = state and C.Accent or C.Off
        }):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.15), {
            Color = state and C.AccentDim or C.Border
        }):Play()
        callback(state)
    end)
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Frame, TweenInfo.new(0.1), {BackgroundColor3 = C.CardHover}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Frame, TweenInfo.new(0.1), {BackgroundColor3 = C.Card}):Play()
    end)
end

local function AddSlider(parent, text, min, max, default, suffix, callback)
    layoutOrder += 1
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, 0, 0, 66)
    Frame.BackgroundColor3 = C.Card
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = layoutOrder
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 5)
    Instance.new("UIStroke", Frame).Color = C.Border

    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(0.6, 0, 0, 26)
    Label.Position = UDim2.new(0, 14, 0, 10)
    Label.Text = text
    Label.TextColor3 = C.Text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local ValBox = Instance.new("Frame", Frame)
    ValBox.Size = UDim2.new(0, 60, 0, 22)
    ValBox.Position = UDim2.new(1, -74, 0, 10)
    ValBox.BackgroundColor3 = C.SliderTrack
    ValBox.BorderSizePixel = 0
    Instance.new("UICorner", ValBox).CornerRadius = UDim.new(0, 4)

    local ValLabel = Instance.new("TextLabel", ValBox)
    ValLabel.Size = UDim2.new(1, 0, 1, 0)
    ValLabel.Text = default .. (suffix or "")
    ValLabel.TextColor3 = C.Accent
    ValLabel.Font = Enum.Font.Code
    ValLabel.TextSize = 12
    ValLabel.BackgroundTransparency = 1

    local BarBG = Instance.new("Frame", Frame)
    BarBG.Size = UDim2.new(1, -28, 0, 4)
    BarBG.Position = UDim2.new(0, 14, 0, 50)
    BarBG.BackgroundColor3 = C.SliderTrack
    BarBG.BorderSizePixel = 0
    Instance.new("UICorner", BarBG).CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame", BarBG)
    Fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    Fill.BackgroundColor3 = C.Accent
    Fill.BorderSizePixel = 0
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

    local Knob = Instance.new("Frame", BarBG)
    Knob.Size = UDim2.new(0, 12, 0, 12)
    Knob.AnchorPoint = Vector2.new(0.5, 0.5)
    Knob.Position = UDim2.new((default-min)/(max-min), 0, 0.5, 0)
    Knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Knob.BorderSizePixel = 0
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

    local KnobGlow = Instance.new("UIStroke", Knob)
    KnobGlow.Color = C.Accent
    KnobGlow.Thickness = 1.5
    KnobGlow.Transparency = 0.5

    local draggingSlider = false
    local SliderBtn = Instance.new("TextButton", BarBG)
    SliderBtn.Size = UDim2.new(1, 0, 4, 0)
    SliderBtn.Position = UDim2.new(0, 0, -1.5, 0)
    SliderBtn.BackgroundTransparency = 1
    SliderBtn.Text = ""

    SliderBtn.MouseButton1Down:Connect(function() draggingSlider = true end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = false end
    end)
    RunService.RenderStepped:Connect(function()
        if draggingSlider then
            local rel = math.clamp((UserInputService:GetMouseLocation().X - BarBG.AbsolutePosition.X) / BarBG.AbsoluteSize.X, 0, 1)
            local val = math.floor(min + (max-min) * rel)
            Fill.Size = UDim2.new(rel, 0, 1, 0)
            Knob.Position = UDim2.new(rel, 0, 0.5, 0)
            ValLabel.Text = val .. (suffix or "")
            callback(val)
        end
    end)
end

local function AddButton(parent, text, desc, callback)
    layoutOrder += 1
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, 0, 0, desc and 54 or 44)
    Frame.BackgroundColor3 = C.Card
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = layoutOrder
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 5)
    Instance.new("UIStroke", Frame).Color = C.Border

    local Label = Instance.new("TextLabel", Frame)
    Label.Text = text
    Label.Size = UDim2.new(1, -50, 0, 22)
    Label.Position = UDim2.new(0, 14, 0, desc and 8 or 0)
    Label.TextColor3 = C.Text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    if desc then
        local Sub = Instance.new("TextLabel", Frame)
        Sub.Text = desc
        Sub.Size = UDim2.new(1, -50, 0, 16)
        Sub.Position = UDim2.new(0, 14, 0, 28)
        Sub.TextColor3 = C.SubText
        Sub.Font = Enum.Font.Gotham
        Sub.TextSize = 10
        Sub.TextXAlignment = Enum.TextXAlignment.Left
        Sub.BackgroundTransparency = 1
    end

    local ArrowBox = Instance.new("Frame", Frame)
    ArrowBox.Size = UDim2.new(0, 28, 0, 22)
    ArrowBox.Position = UDim2.new(1, -42, 0.5, -11)
    ArrowBox.BackgroundColor3 = C.SliderTrack
    ArrowBox.BorderSizePixel = 0
    Instance.new("UICorner", ArrowBox).CornerRadius = UDim.new(0, 4)

    local Arrow = Instance.new("TextLabel", ArrowBox)
    Arrow.Text = "›"
    Arrow.Size = UDim2.new(1, 0, 1, 0)
    Arrow.TextColor3 = C.Accent
    Arrow.Font = Enum.Font.GothamBold
    Arrow.TextSize = 18
    Arrow.BackgroundTransparency = 1

    local Btn = Instance.new("TextButton", Frame)
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""

    Btn.MouseButton1Click:Connect(function()
        TweenService:Create(Frame, TweenInfo.new(0.07), {BackgroundColor3 = C.AccentDim}):Play()
        task.delay(0.14, function()
            TweenService:Create(Frame, TweenInfo.new(0.12), {BackgroundColor3 = C.Card}):Play()
        end)
        callback()
    end)
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Frame, TweenInfo.new(0.1), {BackgroundColor3 = C.CardHover}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Frame, TweenInfo.new(0.1), {BackgroundColor3 = C.Card}):Play()
    end)
end

-- ==================== SAYFA İÇERİKLERİ ====================
local CombatPage  = CreatePage("Combat")
local VisualsPage = CreatePage("Visuals")
local MiscPage    = CreatePage("Misc")

local SkinsPage = Instance.new("Frame", ContentArea)
SkinsPage.Size = UDim2.new(1, 0, 1, 0)
SkinsPage.BackgroundTransparency = 1
SkinsPage.Visible = false
Pages["Skins"] = SkinsPage

-- COMBAT
layoutOrder = 0
SectionLabel(CombatPage, "Aimbot")
AddToggle(CombatPage, "Aimbot", "Sağ tık basılıyken otomatik nişan", function(v) _G.AimbotEnabled = v end)
AddSlider(CombatPage, "FOV Radius", 10, 800, 120, " px", function(v) _G.AimbotFOV = v end)
AddSlider(CombatPage, "Smoothness", 1, 20, 1, "x", function(v) _G.AimbotSmooth = v end)
SectionLabel(CombatPage, "Filters")
AddToggle(CombatPage, "Team Check", "Takım arkadaşlarını atla", function(v) _G.TeamCheck = v end)
AddToggle(CombatPage, "Wall Check", "Duvar arkasındakileri atla", function(v) _G.WallCheck = v end)


-- VISUALS
layoutOrder = 0
SectionLabel(VisualsPage, "ESP")
AddToggle(VisualsPage, "ESP Highlight", "Oyuncuları renkle vurgula", function(v) _G.EspEnabled = v end)
AddToggle(VisualsPage, "Team ESP", "Takım arkadaşlarını da göster", function(v) _G.TeamEsp = v end)
SectionLabel(VisualsPage, "Renk Kılavuzu")

layoutOrder += 1
local ColorGuide = Instance.new("Frame", VisualsPage)
ColorGuide.Size = UDim2.new(1, 0, 0, 80)
ColorGuide.BackgroundColor3 = C.Card
ColorGuide.BorderSizePixel = 0
ColorGuide.LayoutOrder = layoutOrder
Instance.new("UICorner", ColorGuide).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", ColorGuide).Color = C.Border

local guideData = {
    {Color3.fromRGB(0,220,90),   "Takım arkadaşı (görünür)"},
    {Color3.fromRGB(230,50,50),  "Düşman (görünür)"},
    {Color3.fromRGB(240,200,0),  "Düşman (duvar arkası)"},
}
for i, g in ipairs(guideData) do
    local dot = Instance.new("Frame", ColorGuide)
    dot.Size = UDim2.new(0, 10, 0, 10)
    dot.Position = UDim2.new(0, 14, 0, 10 + (i-1)*22)
    dot.BackgroundColor3 = g[1]
    dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)

    local lbl = Instance.new("TextLabel", ColorGuide)
    lbl.Text = g[2]
    lbl.Size = UDim2.new(1, -36, 0, 16)
    lbl.Position = UDim2.new(0, 32, 0, 7 + (i-1)*22)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 11
    lbl.TextColor3 = C.SubText
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

-- MISC
layoutOrder = 0
SectionLabel(MiscPage, "Hareket")
AddSlider(MiscPage, "Walk Speed", 16, 250, 16, " st/s", function(v)
    _G.WalkSpeed = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
end)
AddButton(MiscPage, "Hızı Sıfırla", "Normal hıza geri dön (16)", function()
    _G.WalkSpeed = 16
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

-- ==================== SKİN CHANGER SİSTEMİ ====================
local CB_Skins = {
    {cat="T Silahları", name="AK-47",         sfKey="AK47",         team="T", skins={
        "Ace","Bloodboom","Clown","Code Orange","Eve","Gifted","Glo","Godess",
        "Hallows","Halo","Hypersonic","Inversion","Jester","Maker","Mean Green",
        "Outlaws","Outrunner","Patch","Plated","Precision","Quantum","Quicktime",
        "Scapter","Shooting Star","Stock","Survivor","VAV","Variant Camo","Yltude",
    }},
    {cat="T Silahları", name="Galil AR",       sfKey="Galil",        team="T", skins={
        "Stock","Frosted","Hardware","Hardware 2","Toxicity","Worn","Burnt",
    }},
    {cat="T Silahları", name="SG 553",         sfKey="SG",           team="T", skins={
        "Stock","Variant Camo","Knighthood","Yltude",
    }},
    {cat="T Silahları", name="Glock-18",       sfKey="Glock",        team="T", skins={
        "Stock","Angler","Anubis","Biotrip","Day Dreamer","Desert Camo","Gravestomper",
        "Midnight Tiger","Money Maker","RSL","Rush","Scapter","Spacedust",
        "Tarnish","Underwater","Wetland","White Sauce",
    }},
    {cat="T Silahları", name="Tec-9",          sfKey="Tec9",         team="T", skins={
        "Stock","Charger","Ironline","Skintech","Stocking Stuffer",
    }},
    {cat="T Silahları", name="MAC-10",         sfKey="MAC10",        team="T", skins={
        "Stock","Pimpin","Wetland","Skeleboney","Turbo","Golden Rings",
    }},
    {cat="CT Silahları", name="M4A4",          sfKey="M4A4",         team="CT", skins={
        "Stock","Candyskull","Desert Camo","Pinkvision","Precision","Racer","Stardust",
        "Pinkie","Toy Soldier","Endline","Devil","Ice Cap","Pondside","Scapter",
    }},
    {cat="CT Silahları", name="M4A1-S",        sfKey="M4A1",         team="CT", skins={
        "Stock","Desert Camo","Toucan","Impulse","Technician","Wastelander",
        "Animatic","Heavens Gate",
    }},
    {cat="CT Silahları", name="FAMAS",         sfKey="Famas",        team="CT", skins={
        "Stock","Abstract","Centipede","Cogged","Goliath","Haunted Forest",
        "KugaX","MK11","Medic","Redux","Shocker","Toxic Rain",
    }},
    {cat="CT Silahları", name="AUG",           sfKey="AUG",          team="CT", skins={
        "Stock","Chilly Night","Dream Hound","Enlisted","Graffiti","Homestead",
        "Maker","NightHawk","Phoenix","Sunsthetic",
    }},
    {cat="CT Silahları", name="USP-S",         sfKey="USP",          team="CT", skins={
        "Stock","Skull","Jade Dream","Crimson","Paradise","Dizzy","Racing",
        "Frostbite","Nighttown","YellowBelly",
    }},
    {cat="CT Silahları", name="Five-SeveN",    sfKey="FiveSeven",    team="CT", skins={
        "Stock","Autumn Fade","Danjo","Fluid","Gifted","Midnight Ride",
        "Mr. Anatomy","Stigma","Sub Zero","Summer",
    }},
    {cat="CT Silahları", name="MP9",           sfKey="MP9",          team="CT", skins={
        "Stock","Velvita","Blueroyal","Wilderness","Decked Halls","Cookie Man",
    }},
    {cat="CT Silahları", name="P2000",         sfKey="P2000",        team="CT", skins={
        "Stock","Golden Age","Apathy","Comet","Ruby","Lunar","Candycorn",
    }},
    {cat="Ortak", name="AWP",                  sfKey="AWP",          team="Both", skins={
        "Stock","Abaddon","Autumness","Blastech","Bloodborne","Coffin Biter",
        "Desert Camo","Difference","Dragon","Forever","Grepkin","Hika",
        "Illusion","Instinct","JTF2","Lunar","Nerf","Northern Lights","Pear Tree",
        "Pink Vision","Pinkie","Quicktime","Racer","Regina","Retroactive",
        "Scapter","Silence","Venomus","Weeb",
    }},
    {cat="Ortak", name="Desert Eagle",         sfKey="DesertEagle",  team="Both", skins={
        "Stock","Cold Truth","Cool Blue","DropX","Glittery","Grim","Heat",
        "Honor-bound","Independence","Krystallos","Pumpkin Buster","ROLVe",
        "Racer","Scapter","Survivor","Weeb","Xmas",
    }},
    {cat="Ortak", name="Dual Berettas",        sfKey="DualBerettas", team="Both", skins={
        "Stock","Carbonized","Dusty Manor","Floral","Hexline","Neon web",
        "Old Fashioned","Xmas",
    }},
    {cat="Ortak", name="CZ75-Auto",            sfKey="CZ",           team="Both", skins={
        "Stock","Designed","Festive","Holidays","Lightning","Orange Web","Spectre",
    }},
    {cat="Ortak", name="UMP-45",               sfKey="UMP",          team="Both", skins={
        "Stock","Militia Camo","Magma","Death Grip","Redline",
    }},
    {cat="Ortak", name="Bizon",                sfKey="Bizon",        team="Both", skins={
        "Stock","Autumic","Festive","Oblivion","Saint Nick","Sergeant","Shattered",
    }},
    {cat="Ortak", name="P90",                  sfKey="P90",          team="Both", skins={
        "Stock","Demon Within","Redcopy","Elegant","Krampus","P-Chan","Pine","Skulls",
    }},
    {cat="Ortak", name="Scout",                sfKey="Scout",        team="Both", skins={
        "Stock","Flowing Mists","Pulse","Railgun","Theory","Hellborn","Hot Cocoa","Xmas",
    }},
    {cat="Ortak", name="G3SG1",                sfKey="G3SG1",        team="Both", skins={
        "Stock","Amethyst","Autumn","Foliage","Hex","Holly Bound","Mahogany",
    }},
    {cat="Bıçaklar", name="Bayonet (T)",       sfKey="Bayonet",      team="T", skins={
        "Stock","Aequalis","Banner","Candy Cane","Consumed","Cosmos","Crimson Tiger",
        "Crow","Delinquent","Digital","Egg Shell","Festive","Frozen Dream","Geo Blade",
        "Ghastly","Goo","Hallows","Marbleized","Naval","Neonic","RSL","Racer",
        "Sapphire","Splattered","Topaz","Tropical","Wetland","Worn","Wrapped",
    }},
    {cat="Bıçaklar", name="Karambit (T)",      sfKey="Karambit",     team="T", skins={
        "Stock","Aurora","Bloodwidow","Consumed","Cosmos","Crimson Tiger","Crippled Fade",
        "Digital","Egg Shell","Festive","Freedom","Frozen Dream","Goo","Hallows",
        "Marbleized","Naval","Neonic","Racer","Ruby","Sapphire","Scapter",
        "Splattered","Topaz","Tropical","Wetland","Worn","Wrapped",
    }},
    {cat="Bıçaklar", name="Butterfly (T)",     sfKey="ButterflyKnife", team="T", skins={
        "Stock","Aurora","Bloodwidow","Consumed","Cosmos","Crimson Tiger","Crippled Fade",
        "Digital","Egg Shell","Freedom","Frozen Dream","Goo","Hallows","Icicle",
        "Inversion","Jade Dream","Marbleized","Naval","Neonic","Reaper","Ruby",
        "Scapter","Splattered","Topaz","Tropical","Wetland","White Boss","Worn","Wrapped",
    }},
    {cat="Bıçaklar", name="Huntsman (T)",      sfKey="HuntsmanKnife", team="T", skins={
        "Stock","Aurora","Bloodwidow","Consumed","Cosmos","Cozy","Crimson Tiger",
        "Digital","Egg Shell","Freedom","Frozen Dream","Goo","Hallows","Marbleized",
        "Naval","Neonic","Ruby","Scapter","Splattered","Topaz","Tropical","Wetland","Worn","Wrapped",
    }},
    {cat="Bıçaklar", name="Falchion (T)",      sfKey="FalchionKnife", team="T", skins={
        "Stock","Bloodwidow","Chosen","Coal","Consumed","Cosmos","Crimson Tiger",
        "Digital","Egg Shell","Festive","Freedom","Frozen Dream","Goo","Hallows",
        "Marbleized","Naval","Neonic","Racer","Ruby","Splattered","Topaz","Tropical",
        "Wetland","Worn","Wrapped","Zombie",
    }},
    {cat="Bıçaklar", name="Gut Knife (T)",     sfKey="GutKnife",     team="T", skins={
        "Stock","Banner","Bloodwidow","Consumed","Cosmos","Crimson Tiger","Digital",
        "Egg Shell","Frozen Dream","Geo Blade","Goo","Hallows","Lurker","Marbleized",
        "Naval","Neonic","Ruby","Rusty","Splattered","Topaz","Tropical","Wetland","Worn","Wrapped",
    }},
    {cat="Bıçaklar", name="Bayonet (CT)",      sfKey="Bayonet",      team="CT", skins={
        "Stock","Aequalis","Banner","Candy Cane","Consumed","Cosmos","Crimson Tiger",
        "Crow","Digital","Egg Shell","Festive","Frozen Dream","Geo Blade","Ghastly",
        "Goo","Hallows","Marbleized","Naval","Neonic","RSL","Racer","Sapphire",
        "Splattered","Topaz","Tropical","Wetland","Worn","Wrapped",
    }},
    {cat="Bıçaklar", name="Karambit (CT)",     sfKey="Karambit",     team="CT", skins={
        "Stock","Aurora","Bloodwidow","Consumed","Cosmos","Crimson Tiger","Crippled Fade",
        "Digital","Egg Shell","Festive","Freedom","Frozen Dream","Goo","Hallows",
        "Marbleized","Naval","Neonic","Ruby","Sapphire","Scapter",
        "Splattered","Topaz","Tropical","Wetland","Worn","Wrapped",
    }},
    {cat="Bıçaklar", name="Butterfly (CT)",    sfKey="ButterflyKnife", team="CT", skins={
        "Stock","Aurora","Bloodwidow","Consumed","Cosmos","Crimson Tiger","Crippled Fade",
        "Digital","Egg Shell","Freedom","Frozen Dream","Goo","Hallows","Icicle",
        "Inversion","Marbleized","Naval","Neonic","Reaper","Ruby","Scapter",
        "Splattered","Topaz","Tropical","Wetland","Worn","Wrapped",
    }},
    {cat="Bıçaklar", name="Huntsman (CT)",     sfKey="HuntsmanKnife", team="CT", skins={
        "Stock","Aurora","Bloodwidow","Consumed","Cosmos","Crimson Tiger","Digital",
        "Egg Shell","Freedom","Frozen Dream","Goo","Hallows","Marbleized","Naval",
        "Neonic","Ruby","Scapter","Splattered","Topaz","Tropical","Wetland","Worn","Wrapped",
    }},
}

local allSkins = {}
local _addedSkins = {}
for _, w in ipairs(CB_Skins) do
    for _, s in ipairs(w.skins) do
        local fullId = w.sfKey .. "_" .. s
        if not _addedSkins[fullId] then
            table.insert(allSkins, {fullId})
            _addedSkins[fullId] = true
        end
    end
end

local _hookDone = false
local _clientEnv = nil

local function _SetupHook()
    if _hookDone then return end
    _hookDone = true
    pcall(function()
        local Client = getsenv(LocalPlayer.PlayerGui:WaitForChild("Client", 3))
        if not Client then return end
        _clientEnv = Client
        Client.CurrentInventory = allSkins

        local sf = LocalPlayer:WaitForChild("SkinFolder", 5)
        if sf then
            local TC = sf.TFolder:Clone()
            local CC = sf.CTFolder:Clone()
            sf.TFolder:Destroy()
            sf.CTFolder:Destroy()
            TC.Parent = sf
            CC.Parent = sf
        end

        local mt = getrawmetatable(game)
        local _old = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local args = {...}
            local m = getnamecallmethod()
            if m == "InvokeServer" and #tostring(self) == 38 then
                for i, v in pairs(allSkins) do
                    local doSkip = false
                    for i2, v2 in pairs(args[1]) do
                        if v[1] == v2[1] then doSkip = true end
                    end
                    if not doSkip then
                        table.insert(args[1], v)
                    end
                end
                return
            end
            if tostring(self) == "DataEvent" and args[1] and args[1][4] then
                local currentSkin = string.split(args[1][4][1], "_")[2]
                local wKey = args[1][3]
                local team = args[1][2]
                if currentSkin and wKey then
                    pcall(function()
                        if team == "Both" then
                            LocalPlayer["SkinFolder"]["CTFolder"][wKey].Value = currentSkin
                            LocalPlayer["SkinFolder"]["TFolder"][wKey].Value  = currentSkin
                        else
                            LocalPlayer["SkinFolder"][team .. "Folder"][wKey].Value = currentSkin
                        end
                    end)
                end
            end
            return _old(self, ...)
        end)
        setreadonly(mt, true)
    end)
end

local function ApplyCBSkin(sfKey, skinValue, team)
    if not _hookDone then _SetupHook() end
    if _clientEnv then _clientEnv.CurrentInventory = allSkins end

    local sf = LocalPlayer:FindFirstChild("SkinFolder")
    if not sf then return false end

    local wrote = false
    local folders = team == "Both" and {"TFolder","CTFolder"}
                    or team == "T"  and {"TFolder"}
                    or team == "CT" and {"CTFolder"}
                    or {"TFolder","CTFolder"}

    for _, fname in ipairs(folders) do
        local folder = sf:FindFirstChild(fname)
        if folder then
            local val = folder:FindFirstChild(sfKey)
            if val then
                val.Value = skinValue
                wrote = true
            end
        end
    end
    return wrote
end

task.spawn(function()
    task.wait(3)
    _SetupHook()
end)

-- ========== SKINS SAYFASI LAYOUT ==========
local SkinCatBar = Instance.new("Frame", SkinsPage)
SkinCatBar.Size = UDim2.new(1, 0, 0, 36)
SkinCatBar.BackgroundColor3 = Color3.fromRGB(8, 7, 9)
SkinCatBar.BorderSizePixel = 0
Instance.new("UIStroke", SkinCatBar).Color = Color3.fromRGB(40, 30, 30)

local SkinCatList = Instance.new("UIListLayout", SkinCatBar)
SkinCatList.FillDirection = Enum.FillDirection.Horizontal
SkinCatList.Padding = UDim.new(0, 0)
SkinCatList.SortOrder = Enum.SortOrder.LayoutOrder

local SkinLeft = Instance.new("Frame", SkinsPage)
SkinLeft.Size = UDim2.new(0, 185, 1, -36)
SkinLeft.Position = UDim2.new(0, 0, 0, 36)
SkinLeft.BackgroundColor3 = Color3.fromRGB(11, 10, 13)
SkinLeft.BorderSizePixel = 0
Instance.new("UIStroke", SkinLeft).Color = Color3.fromRGB(40, 30, 30)

local SkinLeftScroll = Instance.new("ScrollingFrame", SkinLeft)
SkinLeftScroll.Size = UDim2.new(1, 0, 1, 0)
SkinLeftScroll.BackgroundTransparency = 1
SkinLeftScroll.ScrollBarThickness = 2
SkinLeftScroll.ScrollBarImageColor3 = C.AccentDim
SkinLeftScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SkinLeftScroll.CanvasSize = UDim2.new(0,0,0,0)
local SkinLeftList = Instance.new("UIListLayout", SkinLeftScroll)
SkinLeftList.Padding = UDim.new(0, 3)
SkinLeftList.SortOrder = Enum.SortOrder.LayoutOrder
local SkinLeftPad = Instance.new("UIPadding", SkinLeftScroll)
SkinLeftPad.PaddingLeft = UDim.new(0, 6)
SkinLeftPad.PaddingRight = UDim.new(0, 6)
SkinLeftPad.PaddingTop = UDim.new(0, 6)

local SkinRight = Instance.new("Frame", SkinsPage)
SkinRight.Size = UDim2.new(1, -185, 1, -36)
SkinRight.Position = UDim2.new(0, 185, 0, 36)
SkinRight.BackgroundTransparency = 1
SkinRight.BorderSizePixel = 0

local SkinRightHdr = Instance.new("Frame", SkinRight)
SkinRightHdr.Size = UDim2.new(1, 0, 0, 34)
SkinRightHdr.BackgroundColor3 = Color3.fromRGB(8, 7, 9)
SkinRightHdr.BorderSizePixel = 0
Instance.new("UIStroke", SkinRightHdr).Color = Color3.fromRGB(40, 30, 30)

local SkinRightTitle = Instance.new("TextLabel", SkinRightHdr)
SkinRightTitle.Text = "← Silah seç"
SkinRightTitle.Font = Enum.Font.Code
SkinRightTitle.TextSize = 11
SkinRightTitle.TextColor3 = C.SubText
SkinRightTitle.Size = UDim2.new(0.6, 0, 1, 0)
SkinRightTitle.Position = UDim2.new(0, 12, 0, 0)
SkinRightTitle.BackgroundTransparency = 1
SkinRightTitle.TextXAlignment = Enum.TextXAlignment.Left

local SkinStatusLbl = Instance.new("TextLabel", SkinRightHdr)
SkinStatusLbl.Text = ""
SkinStatusLbl.Font = Enum.Font.Code
SkinStatusLbl.TextSize = 10
SkinStatusLbl.TextColor3 = C.Accent
SkinStatusLbl.Size = UDim2.new(0.4, -8, 1, 0)
SkinStatusLbl.Position = UDim2.new(0.6, 0, 0, 0)
SkinStatusLbl.BackgroundTransparency = 1
SkinStatusLbl.TextXAlignment = Enum.TextXAlignment.Right

local SkinRightScroll = Instance.new("ScrollingFrame", SkinRight)
SkinRightScroll.Size = UDim2.new(1, 0, 1, -34)
SkinRightScroll.Position = UDim2.new(0, 0, 0, 34)
SkinRightScroll.BackgroundTransparency = 1
SkinRightScroll.ScrollBarThickness = 2
SkinRightScroll.ScrollBarImageColor3 = C.AccentDim
SkinRightScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SkinRightScroll.CanvasSize = UDim2.new(0,0,0,0)
local SkinRightList = Instance.new("UIListLayout", SkinRightScroll)
SkinRightList.Padding = UDim.new(0, 4)
SkinRightList.SortOrder = Enum.SortOrder.LayoutOrder
local SkinRightPad = Instance.new("UIPadding", SkinRightScroll)
SkinRightPad.PaddingLeft = UDim.new(0, 10)
SkinRightPad.PaddingRight = UDim.new(0, 10)
SkinRightPad.PaddingTop = UDim.new(0, 8)
SkinRightPad.PaddingBottom = UDim.new(0, 8)

-- ========== SKIN KARTLARI YÜKLEYİCİ ==========
local skinCardRefs = {}

local function LoadSkinCards(weapon)
    for _, v in pairs(SkinRightScroll:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    skinCardRefs = {}
    activeSkinWeapon = weapon
    SkinRightTitle.Text = weapon.name .. " — Skin Seç"

    for i, skinId in ipairs(weapon.skins) do
        local skinName = skinId
        local isActive = appliedSkins[weapon.sfKey] == skinId

        local Card = Instance.new("Frame", SkinRightScroll)
        Card.Size = UDim2.new(1, 0, 0, 44)
        Card.BackgroundColor3 = isActive and C.CardActive or C.Card
        Card.BorderSizePixel = 0
        Card.LayoutOrder = i
        Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 5)
        local Stroke = Instance.new("UIStroke", Card)
        Stroke.Color = isActive and C.Accent or C.Border
        Stroke.Thickness = 1

        local ActiveBar = Instance.new("Frame", Card)
        ActiveBar.Size = UDim2.new(0, 3, 0.6, 0)
        ActiveBar.Position = UDim2.new(0, 0, 0.2, 0)
        ActiveBar.BackgroundColor3 = C.Accent
        ActiveBar.BackgroundTransparency = isActive and 0 or 1
        ActiveBar.BorderSizePixel = 0
        Instance.new("UICorner", ActiveBar).CornerRadius = UDim.new(1, 0)

        local SkinNameLbl = Instance.new("TextLabel", Card)
        SkinNameLbl.Text = skinName
        SkinNameLbl.Font = Enum.Font.GothamMedium
        SkinNameLbl.TextSize = 12
        SkinNameLbl.TextColor3 = isActive and C.Accent or C.Text
        SkinNameLbl.Size = UDim2.new(1, -80, 1, 0)
        SkinNameLbl.Position = UDim2.new(0, 14, 0, 0)
        SkinNameLbl.BackgroundTransparency = 1
        SkinNameLbl.TextXAlignment = Enum.TextXAlignment.Left

        local ApplyBtn = Instance.new("TextButton", Card)
        ApplyBtn.Size = UDim2.new(0, 64, 0, 26)
        ApplyBtn.Position = UDim2.new(1, -74, 0.5, -13)
        ApplyBtn.BackgroundColor3 = isActive and C.Accent or C.Off
        ApplyBtn.BorderSizePixel = 0
        ApplyBtn.Text = isActive and "✓ Aktif" or "Uygula"
        ApplyBtn.Font = Enum.Font.GothamMedium
        ApplyBtn.TextSize = 11
        ApplyBtn.TextColor3 = isActive and Color3.fromRGB(0,0,0) or C.Text
        Instance.new("UICorner", ApplyBtn).CornerRadius = UDim.new(0, 4)

        skinCardRefs[skinId] = {card=Card, stroke=Stroke, bar=ActiveBar, lbl=SkinNameLbl, btn=ApplyBtn}

        ApplyBtn.MouseButton1Click:Connect(function()
            appliedSkins[weapon.sfKey] = skinId
            local ok = ApplyCBSkin(weapon.sfKey, skinId, weapon.team)

            for sid, refs in pairs(skinCardRefs) do
                local on = sid == skinId
                TweenService:Create(refs.card, TweenInfo.new(0.15), {BackgroundColor3 = on and C.CardActive or C.Card}):Play()
                TweenService:Create(refs.stroke, TweenInfo.new(0.15), {Color = on and C.Accent or C.Border}):Play()
                TweenService:Create(refs.bar, TweenInfo.new(0.15), {BackgroundTransparency = on and 0 or 1}):Play()
                TweenService:Create(refs.lbl, TweenInfo.new(0.15), {TextColor3 = on and C.Accent or C.Text}):Play()
                TweenService:Create(refs.btn, TweenInfo.new(0.15), {BackgroundColor3 = on and C.Accent or C.Off}):Play()
                refs.btn.Text = on and "✓ Aktif" or "Uygula"
                refs.btn.TextColor3 = on and Color3.fromRGB(0,0,0) or C.Text
            end

            if weaponBtnRefs[weapon.name] then
                weaponBtnRefs[weapon.name].dot.BackgroundTransparency = 0
            end

            if ok then
                SkinStatusLbl.Text = "✓ " .. skinName .. " uygulandı"
                SkinStatusLbl.TextColor3 = C.Accent
            else
                SkinStatusLbl.Text = "⚠ Bir sonraki raunda geçince aktif olur"
                SkinStatusLbl.TextColor3 = Color3.fromRGB(240, 200, 0)
            end
            task.delay(3, function() SkinStatusLbl.Text = "" end)
        end)

        Card.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseMovement then
                if appliedSkins[weapon.sfKey] ~= skinId then
                    TweenService:Create(Card, TweenInfo.new(0.1), {BackgroundColor3 = C.CardHover}):Play()
                end
            end
        end)
        Card.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseMovement then
                if appliedSkins[weapon.sfKey] ~= skinId then
                    TweenService:Create(Card, TweenInfo.new(0.1), {BackgroundColor3 = C.Card}):Play()
                end
            end
        end)
    end
end

-- ========== SİLAH BUTONLARI ==========
weaponBtnRefs = {}  -- global olarak yukarıda tanımlandı

local function BuildWeaponList(cat)
    for _, v in pairs(SkinLeftScroll:GetChildren()) do
        if v:IsA("TextButton") or v:IsA("Frame") then v:Destroy() end
    end
    weaponBtnRefs = {}
    for _, v in pairs(SkinRightScroll:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    skinCardRefs = {}
    SkinRightTitle.Text = "← Silah seç"
    activeSkinWeapon = nil

    local order = 0
    for _, w in ipairs(CB_Skins) do
        if w.cat == cat then
            order += 1
            local Btn = Instance.new("TextButton", SkinLeftScroll)
            Btn.Size = UDim2.new(1, 0, 0, 38)
            Btn.BackgroundColor3 = C.Card
            Btn.BorderSizePixel = 0
            Btn.Text = ""
            Btn.LayoutOrder = order
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)
            local BStroke = Instance.new("UIStroke", Btn)
            BStroke.Color = C.Border
            BStroke.Thickness = 1

            local BLabel = Instance.new("TextLabel", Btn)
            BLabel.Text = w.name
            BLabel.Font = Enum.Font.GothamMedium
            BLabel.TextSize = 12
            BLabel.TextColor3 = C.Text
            BLabel.Size = UDim2.new(1, -22, 1, 0)
            BLabel.Position = UDim2.new(0, 10, 0, 0)
            BLabel.BackgroundTransparency = 1
            BLabel.TextXAlignment = Enum.TextXAlignment.Left

            local Dot = Instance.new("Frame", Btn)
            Dot.Size = UDim2.new(0, 6, 0, 6)
            Dot.Position = UDim2.new(1, -11, 0.5, -3)
            Dot.BackgroundColor3 = C.Accent
            Dot.BackgroundTransparency = appliedSkins[w.sfKey] and 0 or 1
            Dot.BorderSizePixel = 0
            Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

            weaponBtnRefs[w.name] = {btn=Btn, stroke=BStroke, lbl=BLabel, dot=Dot}
            local wRef = w

            Btn.MouseButton1Click:Connect(function()
                for wn, refs in pairs(weaponBtnRefs) do
                    local on = wn == w.name
                    TweenService:Create(refs.btn, TweenInfo.new(0.12), {BackgroundColor3 = on and C.CardActive or C.Card}):Play()
                    TweenService:Create(refs.stroke, TweenInfo.new(0.12), {Color = on and C.Accent or C.Border}):Play()
                    refs.lbl.TextColor3 = on and C.Accent or C.Text
                end
                LoadSkinCards(wRef)
            end)
            Btn.MouseEnter:Connect(function()
                if not activeSkinWeapon or activeSkinWeapon.name ~= w.name then
                    TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = C.CardHover}):Play()
                end
            end)
            Btn.MouseLeave:Connect(function()
                if not activeSkinWeapon or activeSkinWeapon.name ~= w.name then
                    TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = C.Card}):Play()
                end
            end)
        end
    end
end

-- ========== KATEGORİ BUTONLARI ==========
local skinCatBtnRefs = {}
for i, cat in ipairs(SkinCategories) do
    local Btn = Instance.new("TextButton", SkinCatBar)
    Btn.Size = UDim2.new(0, 103, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.BorderSizePixel = 0
    Btn.Text = cat
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextSize = 12
    Btn.TextColor3 = cat == activeSkinCat and C.Accent or C.SubText
    Btn.LayoutOrder = i

    local Line = Instance.new("Frame", Btn)
    Line.Size = UDim2.new(0.7, 0, 0, 2)
    Line.Position = UDim2.new(0.15, 0, 1, -2)
    Line.BackgroundColor3 = C.Accent
    Line.BackgroundTransparency = cat == activeSkinCat and 0 or 1
    Line.BorderSizePixel = 0
    Instance.new("UICorner", Line).CornerRadius = UDim.new(1, 0)

    skinCatBtnRefs[cat] = {btn=Btn, line=Line}

    Btn.MouseButton1Click:Connect(function()
        activeSkinCat = cat
        for c, refs in pairs(skinCatBtnRefs) do
            local on = c == cat
            TweenService:Create(refs.btn, TweenInfo.new(0.15), {TextColor3 = on and C.Accent or C.SubText}):Play()
            TweenService:Create(refs.line, TweenInfo.new(0.15), {BackgroundTransparency = on and 0 or 1}):Play()
        end
        BuildWeaponList(cat)
    end)
end

BuildWeaponList(activeSkinCat)

-- ==================== TAB BUTONLARI ====================
-- ==================== TAB BUTONLARI (ExHack Stili) ====================
local tabDefs = {
    {name="Combat",  icon="◈", desc="Aimbot & ESP"},
    {name="Visuals", icon="◉", desc="Görsel"},
    {name="Misc",    icon="◧", desc="Ekstra"},
    {name="Skins",   icon="◇", desc="Skin Changer"},
}

local function SetActiveTab(activeName)
    for name, d in pairs(TabButtons) do
        local on = name == activeName
        TweenService:Create(d.BG, TweenInfo.new(0.12), {
            BackgroundTransparency = on and 0 or 1,
        }):Play()
        TweenService:Create(d.Indicator, TweenInfo.new(0.12), {
            BackgroundTransparency = on and 0 or 1,
        }):Play()
        TweenService:Create(d.Label, TweenInfo.new(0.12), {
            TextColor3 = on and Color3.fromRGB(230,225,225) or Color3.fromRGB(100,90,90),
        }):Play()
        TweenService:Create(d.Icon, TweenInfo.new(0.12), {
            TextColor3 = on and Color3.fromRGB(220,40,40) or Color3.fromRGB(70,60,60),
        }):Play()
        Pages[name].Visible = on
    end
end

for i, tab in ipairs(tabDefs) do
    local Btn = Instance.new("TextButton", SideBar)
    Btn.Size = UDim2.new(1, -16, 0, 44)
    Btn.Position = UDim2.new(0, 8, 0, 64 + (i-1)*48)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.BorderSizePixel = 0

    -- Arka plan (aktifken görünür)
    local BG = Instance.new("Frame", Btn)
    BG.Size = UDim2.new(1, 0, 1, 0)
    BG.BackgroundColor3 = Color3.fromRGB(28, 14, 14)
    BG.BackgroundTransparency = 1
    BG.BorderSizePixel = 0
    Instance.new("UICorner", BG).CornerRadius = UDim.new(0, 4)

    -- Sol kırmızı aktif çizgi
    local Indicator = Instance.new("Frame", Btn)
    Indicator.Size = UDim2.new(0, 3, 0.55, 0)
    Indicator.Position = UDim2.new(0, 0, 0.225, 0)
    Indicator.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
    Indicator.BackgroundTransparency = 1
    Indicator.BorderSizePixel = 0
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

    -- İkon
    local Icon = Instance.new("TextLabel", Btn)
    Icon.Text = tab.icon
    Icon.Size = UDim2.new(0, 28, 1, 0)
    Icon.Position = UDim2.new(0, 10, 0, 0)
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 16
    Icon.TextColor3 = Color3.fromRGB(70, 60, 60)
    Icon.BackgroundTransparency = 1

    -- Tab adı
    local Label = Instance.new("TextLabel", Btn)
    Label.Text = tab.name
    Label.Size = UDim2.new(1, -42, 0, 20)
    Label.Position = UDim2.new(0, 38, 0, 6)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 12
    Label.TextColor3 = Color3.fromRGB(100, 90, 90)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left

    -- Alt açıklama
    local Desc = Instance.new("TextLabel", Btn)
    Desc.Text = tab.desc
    Desc.Size = UDim2.new(1, -42, 0, 14)
    Desc.Position = UDim2.new(0, 38, 0, 25)
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 9
    Desc.TextColor3 = Color3.fromRGB(65, 55, 55)
    Desc.BackgroundTransparency = 1
    Desc.TextXAlignment = Enum.TextXAlignment.Left

    TabButtons[tab.name] = {BG=BG, Indicator=Indicator, Label=Label, Icon=Icon, Desc=Desc}

    Btn.MouseButton1Click:Connect(function() SetActiveTab(tab.name) end)
    Btn.MouseEnter:Connect(function()
        if not Pages[tab.name].Visible then
            TweenService:Create(Label, TweenInfo.new(0.1), {TextColor3 = Color3.fromRGB(160,150,150)}):Play()
        end
    end)
    Btn.MouseLeave:Connect(function()
        if not Pages[tab.name].Visible then
            TweenService:Create(Label, TweenInfo.new(0.1), {TextColor3 = Color3.fromRGB(100,90,90)}):Play()
        end
    end)
end

-- Alt footer
local Footer = Instance.new("TextLabel", SideBar)
Footer.Text = "✕  REDAXHACK  v3.0"
Footer.Size = UDim2.new(1, 0, 0, 28)
Footer.Position = UDim2.new(0, 0, 1, -32)
Footer.Font = Enum.Font.GothamMedium
Footer.TextSize = 9
Footer.TextColor3 = Color3.fromRGB(50, 40, 40)
Footer.BackgroundTransparency = 1

SetActiveTab("Combat")

-- ==================== INTRO ANİMASYONU (Yeni) ====================
task.spawn(function()
    -- 1. AŞAMA: Logo kutusu soldan kayarak gelir
    task.wait(0.1)
    LogoBox.Position = UDim2.new(0, -100, 0.5, -40)
    LogoBox.BackgroundTransparency = 0
    TweenService:Create(LogoBox, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0.5, -40)
    }):Play()
    task.wait(0.3)

    -- 2. AŞAMA: X ikonu belirir (fade in)
    TweenService:Create(LogoX, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
        TextTransparency = 0
    }):Play()
    task.wait(0.2)

    -- 3. AŞAMA: Dikey çizgi yukarıdan aşağıya uzar
    TweenService:Create(IntroDivider, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 2, 0, 70)
    }):Play()
    task.wait(0.25)

    -- 4. AŞAMA: "RedaxHack" yazısı sağdan kayarak gelir + fade in
    IntroTitle.Position = UDim2.new(0, 30, 0, 6)
    IntroTitleRed.Position = UDim2.new(0, 30, 0, 6)
    TweenService:Create(IntroTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        TextTransparency = 0,
        Position = UDim2.new(0, 0, 0, 6)
    }):Play()
    TweenService:Create(IntroTitleRed, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        TextTransparency = 0,
        Position = UDim2.new(0, 0, 0, 6)
    }):Play()
    task.wait(0.3)

    -- 5. AŞAMA: Alt çizgi soldan sağa uzar
    TweenService:Create(IntroUnderline, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 200, 0, 2)
    }):Play()
    task.wait(0.2)

    -- 6. AŞAMA: "by HzFewarr" aşağıdan fade in
    IntroBy.Position = UDim2.new(0, 2, 0, 66)
    TweenService:Create(IntroBy, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
        TextTransparency = 0,
        Position = UDim2.new(0, 2, 0, 58)
    }):Play()

    -- 7. AŞAMA: 1.2 saniye bekle
    task.wait(1.2)

    -- 8. AŞAMA: Her şey sola kayarak çıkar
    TweenService:Create(IntroCenterFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Position = UDim2.new(-0.6, 0, 0.5, -45)
    }):Play()
    TweenService:Create(IntroFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.15), {
        BackgroundTransparency = 1
    }):Play()

    task.wait(0.55)
    IntroFrame.Visible = false

    -- Menü aşağıdan yukarıya gelir
    Main.Position = UDim2.new(0.5, -380, 1.5, 0)
    Main.BackgroundTransparency = 0
    TweenService:Create(Main, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -380, 0.5, -250)
    }):Play()
end)

-- ==================== DUVAR KONTROLÜ ====================
local function IsVisible(targetPart)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local exclude = {targetPart.Parent}
    if LocalPlayer.Character then
        table.insert(exclude, LocalPlayer.Character)
    end
    params.FilterDescendantsInstances = exclude

    local origin    = Camera.CFrame.Position
    local direction = (targetPart.Position - origin)
    local result = workspace:Raycast(origin, direction, params)
    return result == nil
end

-- ==================== HİLE MOTORU ====================
local function GetClosest(fovOverride)
    local fov = fovOverride or _G.AimbotFOV
    local target, dist = nil, math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v == LocalPlayer then continue end
        if not v.Character then continue end
        local head = v.Character:FindFirstChild("Head")
        local hum  = v.Character:FindFirstChild("Humanoid")
        if not head or not hum or hum.Health <= 0 then continue end
        if _G.TeamCheck and v.Team == LocalPlayer.Team then continue end
        if _G.WallCheck and not IsVisible(head) then continue end
        local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
        if not onScreen then continue end
        local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
        if mag < fov and mag < dist then
            target = v
            dist = mag
        end
    end
    return target
end



RunService.RenderStepped:Connect(function()
    FOVCircle.Radius = _G.AimbotFOV
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    FOVCircle.Visible = _G.AimbotEnabled

    if _G.AimbotEnabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local t = GetClosest()
        if t and t.Character and t.Character:FindFirstChild("Head") then
            local targetCF = CFrame.new(Camera.CFrame.Position, t.Character.Head.Position)
            Camera.CFrame = Camera.CFrame:Lerp(targetCF, 1 / math.max(1, _G.AimbotSmooth))
        end
    end



    if _G.EspEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            if not p.Character then continue end

            local isTeammate = p.Team == LocalPlayer.Team
            if isTeammate and not _G.TeamEsp then
                if p.Character:FindFirstChild("RedaxESP") then p.Character.RedaxESP:Destroy() end
                continue
            end

            local visible = p.Character:FindFirstChild("Head") and IsVisible(p.Character.Head)

            local fillColor, outlineColor
            if isTeammate then
                fillColor   = C.EspGreen
                outlineColor = C.EspGreen
            elseif visible then
                fillColor   = C.EspRed
                outlineColor = C.EspRed
            else
                fillColor   = C.EspYellow
                outlineColor = C.EspYellow
            end

            local esp = p.Character:FindFirstChild("RedaxESP")
            if not esp then
                esp = Instance.new("Highlight", p.Character)
                esp.Name = "RedaxESP"
            end
            esp.FillColor = fillColor
            esp.FillTransparency = 0.65
            esp.OutlineColor = outlineColor
            esp.OutlineTransparency = 0
            if isTeammate then
                esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            elseif visible then
                esp.DepthMode = Enum.HighlightDepthMode.Occluded
            else
                esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end
        end
    else
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("RedaxESP") then
                p.Character.RedaxESP:Destroy()
            end
        end
    end

    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if LocalPlayer.Character.Humanoid.WalkSpeed ~= _G.WalkSpeed then
            LocalPlayer.Character.Humanoid.WalkSpeed = _G.WalkSpeed
        end
    end
end)

-- ==================== INSERT TOGGLE ====================
local isOpen = true
UserInputService.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.Insert then
        isOpen = not isOpen
        if isOpen then
            TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, -380, 0.5, -250)
            }):Play()
        else
            TweenService:Create(Main, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, -380, 1.6, 0)
            }):Play()
        end
        FOVCircle.Visible = isOpen and _G.AimbotEnabled
    end
end)
