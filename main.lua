-- [[ REDAXHACK v4.0 — PHANTOM EDITION ]] --
local CoreGui        = game:GetService("CoreGui")
local TweenService   = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService     = game:GetService("RunService")
local Players        = game:GetService("Players")
local LocalPlayer    = Players.LocalPlayer
local Camera         = workspace.CurrentCamera

if CoreGui:FindFirstChild("RedaxUltimate") then CoreGui.RedaxUltimate:Destroy() end

-- ==================== DİL SİSTEMİ ====================
_G.ActiveLang = "TR"

local Lang = {
    TR = {
        hide_key        = "[INSERT] Gizle",
        game_name       = "Arsenal",
        footer          = "REDAXHACK  v4.0  ·  PHANTOM",
        tab_combat      = "Combat",
        tab_combat_desc = "Aimbot & Filtreler",
        tab_visuals     = "Visuals",
        tab_visuals_desc= "Görsel & ESP",
        tab_misc        = "Misc",
        tab_misc_desc   = "Ekstra",
        tab_settings    = "Settings",
        tab_settings_desc = "Ayarlar",
        sec_aimbot      = "Aimbot",
        aimbot_toggle   = "Aimbot",
        aimbot_desc     = "Sağ tık basılıyken otomatik nişan",
        fov_slider      = "FOV Radius",
        smooth_slider   = "Smoothness",
        sec_target      = "Hedef Noktası",
        target_part     = "Kilitlenme Noktası",
        target_part_desc= "Aimbotun neye kilitleniceğini seç",
        target_head     = "Kafa",
        target_torso    = "Gövde",
        target_foot     = "Ayak",
        sec_filters     = "Filtreler",
        team_check      = "Takım Kontrolü",
        team_check_desc = "Takım arkadaşlarını atla",
        wall_check      = "Duvar Kontrolü",
        wall_check_desc = "Duvar arkasındakileri atla",
        sec_esp         = "ESP",
        esp_toggle      = "ESP Vurgulama",
        esp_desc        = "Oyuncuları renkle vurgula",
        team_esp        = "Takım ESP",
        team_esp_desc   = "Takım arkadaşlarını da göster",
        health_bar      = "Can Barı",
        health_bar_desc = "Oyuncuların yanında can barı göster",
        sec_camera      = "Kamera",
        cam_fov         = "Kamera FOV",
        cam_fov_desc    = "Oyun görüş açısını ayarla",
        sec_color_guide = "Renk Kılavuzu",
        color_teammate  = "Takım arkadaşı (görünür)",
        color_enemy_vis = "Düşman (görünür)",
        color_enemy_wall= "Düşman (duvar arkası)",
        sec_movement    = "Hareket",
        walk_speed      = "Yürüme Hızı",
        reset_speed     = "Hızı Sıfırla",
        reset_speed_desc= "Normal hıza geri dön (16)",
        sec_language    = "Dil / Language / Язык",
        lang_label      = "Dil Seçimi",
        lang_desc       = "Arayüz dilini değiştir",
        lang_tr         = "🇹🇷  Türkçe",
        lang_en         = "🇺🇸  English",
        lang_ru         = "🇷🇺  Русский",
    },
    EN = {
        hide_key        = "[INSERT] Hide",
        game_name       = "Arsenal",
        footer          = "REDAXHACK  v4.0  ·  PHANTOM",
        tab_combat      = "Combat",
        tab_combat_desc = "Aimbot & Filters",
        tab_visuals     = "Visuals",
        tab_visuals_desc= "Visual & ESP",
        tab_misc        = "Misc",
        tab_misc_desc   = "Extra",
        tab_settings    = "Settings",
        tab_settings_desc = "Options",
        sec_aimbot      = "Aimbot",
        aimbot_toggle   = "Aimbot",
        aimbot_desc     = "Auto-aim while right mouse held",
        fov_slider      = "FOV Radius",
        smooth_slider   = "Smoothness",
        sec_target      = "Target Point",
        target_part     = "Lock-on Point",
        target_part_desc= "Select what the aimbot locks onto",
        target_head     = "Head",
        target_torso    = "Torso",
        target_foot     = "Foot",
        sec_filters     = "Filters",
        team_check      = "Team Check",
        team_check_desc = "Skip teammates",
        wall_check      = "Wall Check",
        wall_check_desc = "Skip players behind walls",
        sec_esp         = "ESP",
        esp_toggle      = "ESP Highlight",
        esp_desc        = "Highlight players with color",
        team_esp        = "Team ESP",
        team_esp_desc   = "Show teammates too",
        health_bar      = "Health Bar",
        health_bar_desc = "Show health bar next to players",
        sec_camera      = "Camera",
        cam_fov         = "Camera FOV",
        cam_fov_desc    = "Adjust game field of view",
        sec_color_guide = "Color Guide",
        color_teammate  = "Teammate (visible)",
        color_enemy_vis = "Enemy (visible)",
        color_enemy_wall= "Enemy (behind wall)",
        sec_movement    = "Movement",
        walk_speed      = "Walk Speed",
        reset_speed     = "Reset Speed",
        reset_speed_desc= "Return to normal speed (16)",
        sec_language    = "Dil / Language / Язык",
        lang_label      = "Language",
        lang_desc       = "Change interface language",
        lang_tr         = "🇹🇷  Türkçe",
        lang_en         = "🇺🇸  English",
        lang_ru         = "🇷🇺  Русский",
    },
    RU = {
        hide_key        = "[INSERT] Скрыть",
        game_name       = "Arsenal",
        footer          = "REDAXHACK  v4.0  ·  PHANTOM",
        tab_combat      = "Бой",
        tab_combat_desc = "Аимбот & Фильтры",
        tab_visuals     = "Визуал",
        tab_visuals_desc= "Визуал & ESP",
        tab_misc        = "Разное",
        tab_misc_desc   = "Прочее",
        tab_settings    = "Настройки",
        tab_settings_desc = "Параметры",
        sec_aimbot      = "Аимбот",
        aimbot_toggle   = "Аимбот",
        aimbot_desc     = "Автоприцел при зажатой ПКМ",
        fov_slider      = "Радиус FOV",
        smooth_slider   = "Плавность",
        sec_target      = "Точка прицела",
        target_part     = "Точка прицеливания",
        target_part_desc= "Выберите куда целится аимбот",
        target_head     = "Голова",
        target_torso    = "Туловище",
        target_foot     = "Ноги",
        sec_filters     = "Фильтры",
        team_check      = "Проверка команды",
        team_check_desc = "Пропускать союзников",
        wall_check      = "Проверка стен",
        wall_check_desc = "Пропускать за стенами",
        sec_esp         = "ESP",
        esp_toggle      = "ESP Подсветка",
        esp_desc        = "Выделять игроков цветом",
        team_esp        = "ESP команды",
        team_esp_desc   = "Показывать союзников",
        health_bar      = "Полоса здоровья",
        health_bar_desc = "Показывать полосу HP рядом с игроком",
        sec_camera      = "Камера",
        cam_fov         = "FOV камеры",
        cam_fov_desc    = "Настроить угол обзора",
        sec_color_guide = "Цветовой гид",
        color_teammate  = "Союзник (виден)",
        color_enemy_vis = "Враг (виден)",
        color_enemy_wall= "Враг (за стеной)",
        sec_movement    = "Движение",
        walk_speed      = "Скорость ходьбы",
        reset_speed     = "Сбросить скорость",
        reset_speed_desc= "Вернуть нормальную скорость (16)",
        sec_language    = "Dil / Language / Язык",
        lang_label      = "Язык",
        lang_desc       = "Изменить язык интерфейса",
        lang_tr         = "🇹🇷  Türkçe",
        lang_en         = "🇺🇸  English",
        lang_ru         = "🇷🇺  Русский",
    },
}

local function T(key) return Lang[_G.ActiveLang][key] or key end

-- ==================== GLOBAL AYARLAR ====================
_G.AimbotEnabled    = false
_G.AimbotFOV        = 120
_G.AimbotSmooth     = 1
_G.AimbotTarget     = "Head"
_G.TeamCheck        = false
_G.EspEnabled       = false
_G.TeamEsp          = true
_G.WallCheck        = true
_G.HealthBarEnabled = true
_G.CameraFOV        = 70
_G.WalkSpeed        = 16

-- ==================== RENK PALETİ (Phantom - Koyu Mavi/Cyan) ====================
local C = {
    BG         = Color3.fromRGB(8,  10, 16),
    BGDeep     = Color3.fromRGB(5,  6,  10),
    Panel      = Color3.fromRGB(11, 14, 22),
    Sidebar    = Color3.fromRGB(9,  11, 18),
    Card       = Color3.fromRGB(14, 18, 28),
    CardHover  = Color3.fromRGB(18, 23, 36),
    CardActive = Color3.fromRGB(10, 22, 38),
    Accent     = Color3.fromRGB(0,  180, 255),
    AccentDim  = Color3.fromRGB(0,  100, 180),
    AccentGlow = Color3.fromRGB(80, 210, 255),
    AccentDark = Color3.fromRGB(0,  40,  80),
    Text       = Color3.fromRGB(220, 230, 245),
    SubText    = Color3.fromRGB(90,  110, 145),
    Border     = Color3.fromRGB(25,  35,  60),
    BorderBright = Color3.fromRGB(0, 120, 200),
    SliderTrack= Color3.fromRGB(18, 24, 40),
    Off        = Color3.fromRGB(30, 38, 58),
    EspGreen   = Color3.fromRGB(0,  220, 90),
    EspRed     = Color3.fromRGB(230, 50, 50),
    EspYellow  = Color3.fromRGB(240, 200, 0),
    Scan       = Color3.fromRGB(0,  180, 255),
}

-- ==================== FOV DAİRESİ ====================
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness  = 1.5
FOVCircle.Color      = C.Accent
FOVCircle.Visible    = false
FOVCircle.Filled     = false
FOVCircle.NumSides   = 80

-- ==================== SCREEN GUI ====================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name           = "RedaxUltimate"
ScreenGui.ResetOnSpawn   = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder   = 999

-- ==================== TWEEN YARDIMCI ====================
local function Tween(obj, t, props, style, dir)
    style = style or Enum.EasingStyle.Quint
    dir   = dir   or Enum.EasingDirection.Out
    return TweenService:Create(obj, TweenInfo.new(t, style, dir), props)
end
local function TPlay(obj, t, props, style, dir)
    Tween(obj, t, props, style, dir):Play()
end

-- ==================== DİL GÜNCELLEYİCİ ====================
local _langUpdaters = {}
local function OnLangUpdate(fn) table.insert(_langUpdaters, fn) end
local function RefreshLang()
    for _, fn in ipairs(_langUpdaters) do pcall(fn) end
end

-- ==================== INTRO EKRANI ====================
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size             = UDim2.new(1,0,1,0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(4,5,9)
IntroFrame.ZIndex           = 300
IntroFrame.BorderSizePixel  = 0

-- Arka plan grid çizgileri
for i = 1, 20 do
    local hl = Instance.new("Frame", IntroFrame)
    hl.Size                 = UDim2.new(1,0,0,1)
    hl.Position             = UDim2.new(0,0, i/20, 0)
    hl.BackgroundColor3     = C.Accent
    hl.BackgroundTransparency = 0.93
    hl.BorderSizePixel      = 0
    hl.ZIndex               = 300
end
for i = 1, 30 do
    local vl = Instance.new("Frame", IntroFrame)
    vl.Size                 = UDim2.new(0,1,1,0)
    vl.Position             = UDim2.new(i/30,0,0,0)
    vl.BackgroundColor3     = C.Accent
    vl.BackgroundTransparency = 0.96
    vl.BorderSizePixel      = 0
    vl.ZIndex               = 300
end

-- Merkez intro container
local IC = Instance.new("Frame", IntroFrame)
IC.Size               = UDim2.new(0,520,0,110)
IC.Position           = UDim2.new(0.5,-260,0.5,-55)
IC.BackgroundTransparency = 1
IC.ZIndex             = 305

-- Animasyon tarama çizgisi (scan line)
local ScanLine = Instance.new("Frame", IntroFrame)
ScanLine.Size               = UDim2.new(1,0,0,2)
ScanLine.Position           = UDim2.new(0,0,-0.02,0)
ScanLine.BackgroundColor3   = C.Scan
ScanLine.BackgroundTransparency = 0.4
ScanLine.BorderSizePixel    = 0
ScanLine.ZIndex             = 306

-- Sol logo kutusu
local LogoOuter = Instance.new("Frame", IC)
LogoOuter.Size             = UDim2.new(0,90,0,90)
LogoOuter.Position         = UDim2.new(0,0,0.5,-45)
LogoOuter.BackgroundColor3 = C.AccentDark
LogoOuter.BorderSizePixel  = 0
LogoOuter.ZIndex           = 306
LogoOuter.BackgroundTransparency = 1
Instance.new("UICorner", LogoOuter).CornerRadius = UDim.new(0,8)
local LogoOuterStroke = Instance.new("UIStroke", LogoOuter)
LogoOuterStroke.Color       = C.Accent
LogoOuterStroke.Thickness   = 1.5
LogoOuterStroke.Transparency = 1

local LogoInner = Instance.new("Frame", LogoOuter)
LogoInner.Size              = UDim2.new(1,-6,1,-6)
LogoInner.Position          = UDim2.new(0,3,0,3)
LogoInner.BackgroundColor3  = Color3.fromRGB(6,8,14)
LogoInner.BorderSizePixel   = 0
LogoInner.ZIndex            = 307
Instance.new("UICorner", LogoInner).CornerRadius = UDim.new(0,6)

local LogoText = Instance.new("TextLabel", LogoOuter)
LogoText.Text              = "RX"
LogoText.Size              = UDim2.new(1,0,1,0)
LogoText.Font              = Enum.Font.GothamBlack
LogoText.TextSize          = 36
LogoText.TextColor3        = C.Accent
LogoText.BackgroundTransparency = 1
LogoText.ZIndex            = 308
LogoText.TextTransparency  = 1

-- Dikey ayırıcı
local IDivider = Instance.new("Frame", IC)
IDivider.Size              = UDim2.new(0,2,0,0)
IDivider.Position          = UDim2.new(0,104,0.5,0)
IDivider.AnchorPoint       = Vector2.new(0,0.5)
IDivider.BackgroundColor3  = C.Accent
IDivider.BorderSizePixel   = 0
IDivider.ZIndex            = 306

-- Sağ text grubu
local ITG = Instance.new("Frame", IC)
ITG.Size                   = UDim2.new(0,400,1,0)
ITG.Position               = UDim2.new(0,116,0,0)
ITG.BackgroundTransparency = 1
ITG.ZIndex                 = 306

local ITitle = Instance.new("TextLabel", ITG)
ITitle.Text                = "REDAXHACK"
ITitle.Size                = UDim2.new(1,0,0,58)
ITitle.Position            = UDim2.new(0,0,0,4)
ITitle.Font                = Enum.Font.GothamBlack
ITitle.TextSize            = 48
ITitle.TextColor3          = C.Text
ITitle.BackgroundTransparency = 1
ITitle.TextXAlignment      = Enum.TextXAlignment.Left
ITitle.ZIndex              = 307
ITitle.TextTransparency    = 1

-- "REDAX" vurgu rengi overlay
local ITitleAccent = Instance.new("TextLabel", ITG)
ITitleAccent.Text          = "REDAX"
ITitleAccent.Size          = UDim2.new(1,0,0,58)
ITitleAccent.Position      = UDim2.new(0,0,0,4)
ITitleAccent.Font          = Enum.Font.GothamBlack
ITitleAccent.TextSize      = 48
ITitleAccent.TextColor3    = C.Accent
ITitleAccent.BackgroundTransparency = 1
ITitleAccent.TextXAlignment = Enum.TextXAlignment.Left
ITitleAccent.ZIndex        = 308
ITitleAccent.TextTransparency = 1

local IEdition = Instance.new("TextLabel", ITG)
IEdition.Text              = "PHANTOM EDITION  ·  v4.0"
IEdition.Size              = UDim2.new(1,0,0,18)
IEdition.Position          = UDim2.new(0,2,0,62)
IEdition.Font              = Enum.Font.Code
IEdition.TextSize          = 12
IEdition.TextColor3        = C.Accent
IEdition.BackgroundTransparency = 1
IEdition.TextXAlignment    = Enum.TextXAlignment.Left
IEdition.ZIndex            = 307
IEdition.TextTransparency  = 1

local IBy = Instance.new("TextLabel", ITG)
IBy.Text                   = "by HzFewarr"
IBy.Size                   = UDim2.new(1,0,0,16)
IBy.Position               = UDim2.new(0,2,0,82)
IBy.Font                   = Enum.Font.GothamMedium
IBy.TextSize               = 11
IBy.TextColor3             = C.SubText
IBy.BackgroundTransparency = 1
IBy.TextXAlignment         = Enum.TextXAlignment.Left
IBy.ZIndex                 = 307
IBy.TextTransparency       = 1

-- Loading bar
local IBarBG = Instance.new("Frame", IntroFrame)
IBarBG.Size                = UDim2.new(0,320,0,3)
IBarBG.Position            = UDim2.new(0.5,-160,0.5,64)
IBarBG.BackgroundColor3    = C.Border
IBarBG.BorderSizePixel     = 0
IBarBG.ZIndex              = 306
IBarBG.BackgroundTransparency = 1
Instance.new("UICorner", IBarBG).CornerRadius = UDim.new(1,0)

local IBarFill = Instance.new("Frame", IBarBG)
IBarFill.Size              = UDim2.new(0,0,1,0)
IBarFill.BackgroundColor3  = C.Accent
IBarFill.BorderSizePixel   = 0
IBarFill.ZIndex            = 307
Instance.new("UICorner", IBarFill).CornerRadius = UDim.new(1,0)

local IBarPct = Instance.new("TextLabel", IntroFrame)
IBarPct.Text               = "0%"
IBarPct.Size               = UDim2.new(0,80,0,20)
IBarPct.Position           = UDim2.new(0.5,168,0.5,56)
IBarPct.Font               = Enum.Font.Code
IBarPct.TextSize           = 11
IBarPct.TextColor3         = C.Accent
IBarPct.BackgroundTransparency = 1
IBarPct.ZIndex             = 307
IBarPct.TextTransparency   = 1

-- ==================== ANA MENÜ ====================
local Main = Instance.new("Frame", ScreenGui)
Main.Name              = "MainFrame"
Main.Size              = UDim2.new(0,800,0,520)
Main.Position          = UDim2.new(0.5,-400,2,0)
Main.BackgroundColor3  = C.BG
Main.BorderSizePixel   = 0
Main.ClipsDescendants  = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,8)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color       = C.Border
MainStroke.Thickness   = 1.5

-- Köşe aksan çizgileri (CS2 menü stili)
local function Corner(parent, x, y, w, h, color)
    local f = Instance.new("Frame", parent)
    f.Size              = UDim2.new(0,w,0,h)
    f.Position          = UDim2.new(x<0 and 1 or 0, x<0 and x or x, y<0 and 1 or 0, y<0 and y or y)
    f.BackgroundColor3  = color or C.Accent
    f.BorderSizePixel   = 0
    return f
end
Corner(Main,  0,  0, 30, 2)   -- TL yatay
Corner(Main,  0,  0,  2,30)   -- TL dikey
Corner(Main,-30,-2, 30, 2)   -- BR yatay
Corner(Main, -2,-30,  2,30)  -- BR dikey

-- Arka plan desenli katman (subtle grid)
local BGPattern = Instance.new("Frame", Main)
BGPattern.Size              = UDim2.new(1,0,1,0)
BGPattern.BackgroundTransparency = 1
BGPattern.ZIndex            = 0
for i=1,15 do
    local gl = Instance.new("Frame", BGPattern)
    gl.Size                 = UDim2.new(1,0,0,1)
    gl.Position             = UDim2.new(0,0,i/15,0)
    gl.BackgroundColor3     = C.Accent
    gl.BackgroundTransparency = 0.97
    gl.BorderSizePixel      = 0
end

-- ========== HEADER ==========
local Header = Instance.new("Frame", Main)
Header.Size             = UDim2.new(1,0,0,48)
Header.BackgroundColor3 = C.Panel
Header.BorderSizePixel  = 0
Header.ZIndex           = 2

-- Header alt çizgi (gradient efekt için iki katmanlı)
local HLine1 = Instance.new("Frame", Header)
HLine1.Size             = UDim2.new(1,0,0,1)
HLine1.Position         = UDim2.new(0,0,1,-1)
HLine1.BackgroundColor3 = C.Accent
HLine1.BorderSizePixel  = 0
HLine1.ZIndex           = 3

local HLine2 = Instance.new("Frame", Header)
HLine2.Size             = UDim2.new(1,0,0,1)
HLine2.Position         = UDim2.new(0,0,1,-2)
HLine2.BackgroundColor3 = C.AccentDim
HLine2.BackgroundTransparency = 0.6
HLine2.BorderSizePixel  = 0
HLine2.ZIndex           = 3

-- Sol logo + isim
local HLogoBox = Instance.new("Frame", Header)
HLogoBox.Size           = UDim2.new(0,32,0,32)
HLogoBox.Position       = UDim2.new(0,12,0.5,-16)
HLogoBox.BackgroundColor3 = C.AccentDark
HLogoBox.BorderSizePixel = 0
Instance.new("UICorner", HLogoBox).CornerRadius = UDim.new(0,5)
local HLogoBoxStroke = Instance.new("UIStroke", HLogoBox)
HLogoBoxStroke.Color    = C.Accent
HLogoBoxStroke.Thickness = 1

local HLogoLbl = Instance.new("TextLabel", HLogoBox)
HLogoLbl.Text           = "RX"
HLogoLbl.Size           = UDim2.new(1,0,1,0)
HLogoLbl.Font           = Enum.Font.GothamBlack
HLogoLbl.TextSize       = 13
HLogoLbl.TextColor3     = C.Accent
HLogoLbl.BackgroundTransparency = 1
HLogoLbl.ZIndex         = 3

local HTitle = Instance.new("TextLabel", Header)
HTitle.Text             = "REDAXHACK"
HTitle.Size             = UDim2.new(0,160,1,0)
HTitle.Position         = UDim2.new(0,50,0,0)
HTitle.Font             = Enum.Font.GothamBlack
HTitle.TextSize         = 14
HTitle.TextColor3       = C.Text
HTitle.BackgroundTransparency = 1
HTitle.TextXAlignment   = Enum.TextXAlignment.Left
HTitle.ZIndex           = 3

local HBadge = Instance.new("Frame", Header)
HBadge.Size             = UDim2.new(0,72,0,18)
HBadge.Position         = UDim2.new(0,162,0.5,-9)
HBadge.BackgroundColor3 = C.AccentDark
HBadge.BorderSizePixel  = 0
Instance.new("UICorner", HBadge).CornerRadius = UDim.new(1,0)
local HBadgeStroke = Instance.new("UIStroke", HBadge)
HBadgeStroke.Color      = C.AccentDim
HBadgeStroke.Thickness  = 1
local HBadgeLbl = Instance.new("TextLabel", HBadge)
HBadgeLbl.Text          = "PHANTOM"
HBadgeLbl.Size          = UDim2.new(1,0,1,0)
HBadgeLbl.Font          = Enum.Font.Code
HBadgeLbl.TextSize      = 9
HBadgeLbl.TextColor3    = C.Accent
HBadgeLbl.BackgroundTransparency = 1

local HMid = Instance.new("TextLabel", Header)
HMid.Text               = T("game_name")
HMid.Font               = Enum.Font.GothamMedium
HMid.TextSize           = 10
HMid.TextColor3         = C.SubText
HMid.Size               = UDim2.new(0,160,1,0)
HMid.Position           = UDim2.new(0.5,-80,0,0)
HMid.BackgroundTransparency = 1
HMid.ZIndex             = 3

local HRight = Instance.new("TextLabel", Header)
HRight.Text             = T("hide_key")
HRight.Font             = Enum.Font.Code
HRight.TextSize         = 10
HRight.TextColor3       = C.SubText
HRight.Size             = UDim2.new(0,180,1,0)
HRight.Position         = UDim2.new(1,-192,0,0)
HRight.BackgroundTransparency = 1
HRight.TextXAlignment   = Enum.TextXAlignment.Right
HRight.ZIndex           = 3

OnLangUpdate(function()
    HMid.Text   = T("game_name")
    HRight.Text = T("hide_key")
end)

-- Header sürükleme
local dragging, dragStart, startPos = false, nil, nil
Header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = i.Position; startPos = Main.Position
    end
end)
Header.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UserInputService.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
    end
end)

-- ========== SOL SIDEBAR ==========
local SideBar = Instance.new("Frame", Main)
SideBar.Size            = UDim2.new(0,175,1,-48)
SideBar.Position        = UDim2.new(0,0,0,48)
SideBar.BackgroundColor3 = C.Sidebar
SideBar.BorderSizePixel = 0

local SBRightLine = Instance.new("Frame", SideBar)
SBRightLine.Size        = UDim2.new(0,1,1,0)
SBRightLine.Position    = UDim2.new(1,-1,0,0)
SBRightLine.BackgroundColor3 = C.Border
SBRightLine.BorderSizePixel = 0

-- Oyuncu kutusu
local PBox = Instance.new("Frame", SideBar)
PBox.Size               = UDim2.new(1,-16,0,52)
PBox.Position           = UDim2.new(0,8,0,12)
PBox.BackgroundColor3   = C.Card
PBox.BorderSizePixel    = 0
Instance.new("UICorner", PBox).CornerRadius = UDim.new(0,6)
local PBoxStroke = Instance.new("UIStroke", PBox)
PBoxStroke.Color        = C.Border
PBoxStroke.Thickness    = 1

-- Sol cyan aksan çubuğu
local PBoxAccent = Instance.new("Frame", PBox)
PBoxAccent.Size         = UDim2.new(0,2,0.65,0)
PBoxAccent.Position     = UDim2.new(0,0,0.175,0)
PBoxAccent.BackgroundColor3 = C.Accent
PBoxAccent.BorderSizePixel = 0
Instance.new("UICorner", PBoxAccent).CornerRadius = UDim.new(1,0)

-- Online nokta
local OnlineDot = Instance.new("Frame", PBox)
OnlineDot.Size          = UDim2.new(0,6,0,6)
OnlineDot.Position      = UDim2.new(1,-14,0,10)
OnlineDot.BackgroundColor3 = Color3.fromRGB(0,220,90)
OnlineDot.BorderSizePixel = 0
Instance.new("UICorner", OnlineDot).CornerRadius = UDim.new(1,0)

local PName = Instance.new("TextLabel", PBox)
PName.Text              = LocalPlayer.DisplayName
PName.Size              = UDim2.new(1,-20,0,22)
PName.Position          = UDim2.new(0,12,0,7)
PName.Font              = Enum.Font.GothamBold
PName.TextSize          = 12
PName.TextColor3        = C.Text
PName.BackgroundTransparency = 1
PName.TextXAlignment    = Enum.TextXAlignment.Left

local PTag = Instance.new("TextLabel", PBox)
PTag.Text               = "@" .. LocalPlayer.Name
PTag.Size               = UDim2.new(1,-20,0,14)
PTag.Position           = UDim2.new(0,12,0,29)
PTag.Font               = Enum.Font.Code
PTag.TextSize           = 10
PTag.TextColor3         = C.Accent
PTag.BackgroundTransparency = 1
PTag.TextXAlignment     = Enum.TextXAlignment.Left

local SBSep = Instance.new("Frame", SideBar)
SBSep.Size              = UDim2.new(1,-16,0,1)
SBSep.Position          = UDim2.new(0,8,0,72)
SBSep.BackgroundColor3  = C.Border
SBSep.BorderSizePixel   = 0

-- ========== İÇERİK ALANI ==========
local ContentArea = Instance.new("Frame", Main)
ContentArea.Position    = UDim2.new(0,175,0,48)
ContentArea.Size        = UDim2.new(1,-175,1,-48)
ContentArea.BackgroundTransparency = 1
ContentArea.ClipsDescendants = true

-- ==================== SAYFA SİSTEMİ ====================
local Pages    = {}
local TabBtns  = {}

local function CreatePage(name)
    local S = Instance.new("ScrollingFrame", ContentArea)
    S.Size                 = UDim2.new(1,0,1,0)
    S.BackgroundTransparency = 1
    S.Visible              = false
    S.ScrollBarThickness   = 3
    S.ScrollBarImageColor3 = C.AccentDim
    S.AutomaticCanvasSize  = Enum.AutomaticSize.Y
    S.CanvasSize           = UDim2.new(0,0,0,0)
    local Pad = Instance.new("UIPadding", S)
    Pad.PaddingLeft   = UDim.new(0,18)
    Pad.PaddingRight  = UDim.new(0,18)
    Pad.PaddingTop    = UDim.new(0,16)
    Pad.PaddingBottom = UDim.new(0,16)
    local List = Instance.new("UIListLayout", S)
    List.Padding    = UDim.new(0,7)
    List.SortOrder  = Enum.SortOrder.LayoutOrder
    Pages[name] = S
    return S
end

-- ==================== BİLEŞEN YARDIMCILARI ====================
local lo = 0

-- Bölüm başlığı (section label) - glowing dot + text + line
local function SectionLabel(parent, key)
    lo += 1
    local row = Instance.new("Frame", parent)
    row.Size              = UDim2.new(1,0,0,26)
    row.BackgroundTransparency = 1
    row.LayoutOrder       = lo
    row.BorderSizePixel   = 0

    -- Sol parlayan nokta
    local dot = Instance.new("Frame", row)
    dot.Size              = UDim2.new(0,5,0,5)
    dot.Position          = UDim2.new(0,0,0.5,-2)
    dot.BackgroundColor3  = C.Accent
    dot.BorderSizePixel   = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)

    local lbl = Instance.new("TextLabel", row)
    lbl.Text              = T(key):upper()
    lbl.Size              = UDim2.new(0,140,1,0)
    lbl.Position          = UDim2.new(0,12,0,0)
    lbl.Font              = Enum.Font.Code
    lbl.TextSize          = 10
    lbl.TextColor3        = C.Accent
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment    = Enum.TextXAlignment.Left

    -- Sağa uzanan ince çizgi
    local line = Instance.new("Frame", row)
    line.Size             = UDim2.new(1,-158,0,1)
    line.Position         = UDim2.new(0,154,0.5,0)
    line.BackgroundColor3 = C.Border
    line.BorderSizePixel  = 0
    Instance.new("UICorner", line).CornerRadius = UDim.new(1,0)

    OnLangUpdate(function() lbl.Text = T(key):upper() end)
end

-- Toggle bileşeni (premium CS2 stili)
local function AddToggle(parent, tKey, dKey, cb)
    lo += 1
    local F = Instance.new("Frame", parent)
    F.Size              = UDim2.new(1,0,0, dKey and 56 or 44)
    F.BackgroundColor3  = C.Card
    F.BorderSizePixel   = 0
    F.LayoutOrder       = lo
    Instance.new("UICorner", F).CornerRadius = UDim.new(0,6)
    local Stroke = Instance.new("UIStroke", F)
    Stroke.Color        = C.Border
    Stroke.Thickness    = 1

    -- Sol aksan çizgisi (kapalıyken gizli)
    local LeftBar = Instance.new("Frame", F)
    LeftBar.Size        = UDim2.new(0,2,0.7,0)
    LeftBar.Position    = UDim2.new(0,0,0.15,0)
    LeftBar.BackgroundColor3 = C.Accent
    LeftBar.BackgroundTransparency = 1
    LeftBar.BorderSizePixel = 0
    Instance.new("UICorner", LeftBar).CornerRadius = UDim.new(1,0)

    local Lbl = Instance.new("TextLabel", F)
    Lbl.Text            = T(tKey)
    Lbl.Size            = UDim2.new(1,-68,0,22)
    Lbl.Position        = UDim2.new(0,14,0, dKey and 8 or 11)
    Lbl.TextColor3      = C.Text
    Lbl.Font            = Enum.Font.GothamBold
    Lbl.TextSize        = 12
    Lbl.TextXAlignment  = Enum.TextXAlignment.Left
    Lbl.BackgroundTransparency = 1

    local Sub
    if dKey then
        Sub = Instance.new("TextLabel", F)
        Sub.Text          = T(dKey)
        Sub.Size          = UDim2.new(1,-68,0,14)
        Sub.Position      = UDim2.new(0,14,0,29)
        Sub.TextColor3    = C.SubText
        Sub.Font          = Enum.Font.Gotham
        Sub.TextSize      = 10
        Sub.TextXAlignment = Enum.TextXAlignment.Left
        Sub.BackgroundTransparency = 1
    end

    OnLangUpdate(function()
        Lbl.Text = T(tKey)
        if Sub then Sub.Text = T(dKey) end
    end)

    -- Switch track
    local Track = Instance.new("Frame", F)
    Track.Size          = UDim2.new(0,42,0,22)
    Track.Position      = UDim2.new(1,-56,0.5,-11)
    Track.BackgroundColor3 = C.Off
    Track.BorderSizePixel = 0
    Instance.new("UICorner", Track).CornerRadius = UDim.new(1,0)

    -- Knob
    local Knob = Instance.new("Frame", Track)
    Knob.Size           = UDim2.new(0,16,0,16)
    Knob.Position       = UDim2.new(0,3,0.5,-8)
    Knob.BackgroundColor3 = Color3.fromRGB(140,155,175)
    Knob.BorderSizePixel = 0
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1,0)

    local Btn = Instance.new("TextButton", F)
    Btn.Size            = UDim2.new(1,0,1,0)
    Btn.BackgroundTransparency = 1
    Btn.Text            = ""

    local state = false
    Btn.MouseButton1Click:Connect(function()
        state = not state
        TPlay(Knob, 0.18, {
            Position = state and UDim2.new(1,-19,0.5,-8) or UDim2.new(0,3,0.5,-8),
            BackgroundColor3 = state and Color3.fromRGB(255,255,255) or Color3.fromRGB(140,155,175)
        })
        TPlay(Track, 0.18, {BackgroundColor3 = state and C.Accent or C.Off})
        TPlay(Stroke, 0.18, {Color = state and C.AccentDim or C.Border})
        TPlay(LeftBar, 0.18, {BackgroundTransparency = state and 0 or 1})
        TPlay(F, 0.18, {BackgroundColor3 = state and C.CardActive or C.Card})
        cb(state)
    end)
    Btn.MouseEnter:Connect(function()
        if not state then TPlay(F, 0.1, {BackgroundColor3 = C.CardHover}) end
    end)
    Btn.MouseLeave:Connect(function()
        if not state then TPlay(F, 0.1, {BackgroundColor3 = C.Card}) end
    end)
end

-- Slider bileşeni
local function AddSlider(parent, tKey, min, max, default, suffix, cb)
    lo += 1
    local F = Instance.new("Frame", parent)
    F.Size              = UDim2.new(1,0,0,68)
    F.BackgroundColor3  = C.Card
    F.BorderSizePixel   = 0
    F.LayoutOrder       = lo
    Instance.new("UICorner", F).CornerRadius = UDim.new(0,6)
    local Stroke = Instance.new("UIStroke", F)
    Stroke.Color        = C.Border
    Stroke.Thickness    = 1

    local Lbl = Instance.new("TextLabel", F)
    Lbl.Size            = UDim2.new(0.6,0,0,26)
    Lbl.Position        = UDim2.new(0,14,0,10)
    Lbl.Text            = T(tKey)
    Lbl.TextColor3      = C.Text
    Lbl.Font            = Enum.Font.GothamBold
    Lbl.TextSize        = 12
    Lbl.TextXAlignment  = Enum.TextXAlignment.Left
    Lbl.BackgroundTransparency = 1

    OnLangUpdate(function() Lbl.Text = T(tKey) end)

    local ValBox = Instance.new("Frame", F)
    ValBox.Size         = UDim2.new(0,62,0,24)
    ValBox.Position     = UDim2.new(1,-76,0,8)
    ValBox.BackgroundColor3 = C.SliderTrack
    ValBox.BorderSizePixel = 0
    Instance.new("UICorner", ValBox).CornerRadius = UDim.new(0,5)
    local ValStroke = Instance.new("UIStroke", ValBox)
    ValStroke.Color     = C.Border
    ValStroke.Thickness = 1

    local ValLbl = Instance.new("TextLabel", ValBox)
    ValLbl.Size         = UDim2.new(1,0,1,0)
    ValLbl.Text         = default..(suffix or "")
    ValLbl.TextColor3   = C.Accent
    ValLbl.Font         = Enum.Font.Code
    ValLbl.TextSize     = 12
    ValLbl.BackgroundTransparency = 1

    -- Track
    local BarBG = Instance.new("Frame", F)
    BarBG.Size          = UDim2.new(1,-28,0,4)
    BarBG.Position      = UDim2.new(0,14,0,52)
    BarBG.BackgroundColor3 = C.SliderTrack
    BarBG.BorderSizePixel = 0
    Instance.new("UICorner", BarBG).CornerRadius = UDim.new(1,0)

    local Fill = Instance.new("Frame", BarBG)
    Fill.Size           = UDim2.new((default-min)/(max-min),0,1,0)
    Fill.BackgroundColor3 = C.Accent
    Fill.BorderSizePixel = 0
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1,0)

    -- Parlayan knob
    local Knob = Instance.new("Frame", BarBG)
    Knob.Size           = UDim2.new(0,14,0,14)
    Knob.AnchorPoint    = Vector2.new(0.5,0.5)
    Knob.Position       = UDim2.new((default-min)/(max-min),0,0.5,0)
    Knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Knob.BorderSizePixel = 0
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1,0)
    local KStroke = Instance.new("UIStroke", Knob)
    KStroke.Color       = C.Accent
    KStroke.Thickness   = 1.5
    KStroke.Transparency = 0.3

    local draggingS = false
    local SBtn = Instance.new("TextButton", BarBG)
    SBtn.Size           = UDim2.new(1,0,5,0)
    SBtn.Position       = UDim2.new(0,0,-2,0)
    SBtn.BackgroundTransparency = 1
    SBtn.Text           = ""
    SBtn.MouseButton1Down:Connect(function() draggingS = true end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then draggingS = false end
    end)
    RunService.RenderStepped:Connect(function()
        if draggingS then
            local rel = math.clamp((UserInputService:GetMouseLocation().X - BarBG.AbsolutePosition.X)/BarBG.AbsoluteSize.X,0,1)
            local val = math.floor(min+(max-min)*rel)
            Fill.Size       = UDim2.new(rel,0,1,0)
            Knob.Position   = UDim2.new(rel,0,0.5,0)
            ValLbl.Text     = val..(suffix or "")
            cb(val)
        end
    end)
end

-- Button bileşeni
local function AddButton(parent, tKey, dKey, cb)
    lo += 1
    local F = Instance.new("Frame", parent)
    F.Size              = UDim2.new(1,0,0, dKey and 56 or 44)
    F.BackgroundColor3  = C.Card
    F.BorderSizePixel   = 0
    F.LayoutOrder       = lo
    Instance.new("UICorner", F).CornerRadius = UDim.new(0,6)
    local Stroke = Instance.new("UIStroke", F)
    Stroke.Color        = C.Border
    Stroke.Thickness    = 1

    local Lbl = Instance.new("TextLabel", F)
    Lbl.Text            = T(tKey)
    Lbl.Size            = UDim2.new(1,-50,0,22)
    Lbl.Position        = UDim2.new(0,14,0, dKey and 8 or 11)
    Lbl.TextColor3      = C.Text
    Lbl.Font            = Enum.Font.GothamBold
    Lbl.TextSize        = 12
    Lbl.TextXAlignment  = Enum.TextXAlignment.Left
    Lbl.BackgroundTransparency = 1

    local Sub
    if dKey then
        Sub = Instance.new("TextLabel", F)
        Sub.Text          = T(dKey)
        Sub.Size          = UDim2.new(1,-50,0,14)
        Sub.Position      = UDim2.new(0,14,0,29)
        Sub.TextColor3    = C.SubText
        Sub.Font          = Enum.Font.Gotham
        Sub.TextSize      = 10
        Sub.TextXAlignment = Enum.TextXAlignment.Left
        Sub.BackgroundTransparency = 1
    end

    OnLangUpdate(function()
        Lbl.Text = T(tKey)
        if Sub then Sub.Text = T(dKey) end
    end)

    local ABox = Instance.new("Frame", F)
    ABox.Size           = UDim2.new(0,28,0,22)
    ABox.Position       = UDim2.new(1,-42,0.5,-11)
    ABox.BackgroundColor3 = C.AccentDark
    ABox.BorderSizePixel = 0
    Instance.new("UICorner", ABox).CornerRadius = UDim.new(0,5)
    local ALbl = Instance.new("TextLabel", ABox)
    ALbl.Text           = "›"
    ALbl.Size           = UDim2.new(1,0,1,0)
    ALbl.TextColor3     = C.Accent
    ALbl.Font           = Enum.Font.GothamBold
    ALbl.TextSize       = 18
    ALbl.BackgroundTransparency = 1

    local Btn = Instance.new("TextButton", F)
    Btn.Size            = UDim2.new(1,0,1,0)
    Btn.BackgroundTransparency = 1
    Btn.Text            = ""
    Btn.MouseButton1Click:Connect(function()
        TPlay(F, 0.06, {BackgroundColor3 = C.AccentDark})
        task.delay(0.12, function() TPlay(F, 0.12, {BackgroundColor3 = C.Card}) end)
        cb()
    end)
    Btn.MouseEnter:Connect(function() TPlay(F, 0.1, {BackgroundColor3 = C.CardHover}) end)
    Btn.MouseLeave:Connect(function() TPlay(F, 0.1, {BackgroundColor3 = C.Card}) end)
end

-- 3'lü seçim butonu (target / lang seçici) - ortak yardımcı
local function Make3BtnRow(parent, defs, getCurrent, onSelect, updateRefs)
    lo += 1
    local Row = Instance.new("Frame", parent)
    Row.Size              = UDim2.new(1,0,0,48)
    Row.BackgroundTransparency = 1
    Row.BorderSizePixel   = 0
    Row.LayoutOrder       = lo
    local RL = Instance.new("UIListLayout", Row)
    RL.FillDirection      = Enum.FillDirection.Horizontal
    RL.Padding            = UDim.new(0,8)
    RL.SortOrder          = Enum.SortOrder.LayoutOrder

    local refs = {}
    for i, d in ipairs(defs) do
        local BF = Instance.new("Frame", Row)
        BF.BackgroundColor3 = getCurrent() == d.id and C.CardActive or C.Card
        BF.BorderSizePixel  = 0
        BF.LayoutOrder      = i
        Instance.new("UICorner", BF).CornerRadius = UDim.new(0,6)
        local BS = Instance.new("UIStroke", BF)
        BS.Color            = getCurrent() == d.id and C.Accent or C.Border
        BS.Thickness        = 1

        local Ind = Instance.new("Frame", BF)
        Ind.Size            = UDim2.new(0.65,0,0,2)
        Ind.Position        = UDim2.new(0.175,0,1,-2)
        Ind.BackgroundColor3 = C.Accent
        Ind.BackgroundTransparency = getCurrent() == d.id and 0 or 1
        Ind.BorderSizePixel = 0
        Instance.new("UICorner", Ind).CornerRadius = UDim.new(1,0)

        local IcoL = Instance.new("TextLabel", BF)
        IcoL.Text           = d.icon
        IcoL.Size           = UDim2.new(0,22,1,-4)
        IcoL.Position       = UDim2.new(0,8,0,2)
        IcoL.Font           = Enum.Font.GothamBold
        IcoL.TextSize       = 14
        IcoL.TextColor3     = getCurrent() == d.id and C.Accent or Color3.fromRGB(60,80,110)
        IcoL.BackgroundTransparency = 1

        local TL2 = Instance.new("TextLabel", BF)
        TL2.Size            = UDim2.new(1,-34,1,0)
        TL2.Position        = UDim2.new(0,30,0,0)
        TL2.Font            = Enum.Font.GothamBold
        TL2.TextSize        = 12
        TL2.TextColor3      = getCurrent() == d.id and C.Accent or C.SubText
        TL2.BackgroundTransparency = 1
        TL2.TextXAlignment  = Enum.TextXAlignment.Left

        local BB = Instance.new("TextButton", BF)
        BB.Size             = UDim2.new(1,0,1,0)
        BB.BackgroundTransparency = 1
        BB.Text             = ""

        refs[d.id] = {frame=BF, stroke=BS, lbl=TL2, ico=IcoL, ind=Ind, id=d.id, tkey=d.tkey}

        BB.MouseButton1Click:Connect(function()
            onSelect(d.id)
            for id2, r in pairs(refs) do
                local on = id2 == d.id
                TPlay(r.frame, 0.15, {BackgroundColor3 = on and C.CardActive or C.Card})
                TPlay(r.stroke, 0.15, {Color = on and C.Accent or C.Border})
                TPlay(r.lbl, 0.15, {TextColor3 = on and C.Accent or C.SubText})
                TPlay(r.ico, 0.15, {TextColor3 = on and C.Accent or Color3.fromRGB(60,80,110)})
                r.ind.BackgroundTransparency = on and 0 or 1
            end
        end)
        BB.MouseEnter:Connect(function()
            if getCurrent() ~= d.id then TPlay(BF, 0.1, {BackgroundColor3 = C.CardHover}) end
        end)
        BB.MouseLeave:Connect(function()
            if getCurrent() ~= d.id then TPlay(BF, 0.1, {BackgroundColor3 = C.Card}) end
        end)
    end
    if updateRefs then updateRefs(refs) end

    OnLangUpdate(function()
        for _, r in pairs(refs) do
            if r.tkey then r.lbl.Text = T(r.tkey) end
        end
    end)

    return refs
end

-- ==================== SAYFALAR ====================
local CombatPage   = CreatePage("Combat")
local VisualsPage  = CreatePage("Visuals")
local MiscPage     = CreatePage("Misc")
local SettingsPage = CreatePage("Settings")

-- ========== COMBAT SAYFASI ==========
lo = 0
SectionLabel(CombatPage, "sec_aimbot")
AddToggle(CombatPage, "aimbot_toggle", "aimbot_desc", function(v) _G.AimbotEnabled = v end)
AddSlider(CombatPage, "fov_slider", 10, 800, 120, " px", function(v) _G.AimbotFOV = v end)
AddSlider(CombatPage, "smooth_slider", 1, 20, 1, "x", function(v) _G.AimbotSmooth = v end)

SectionLabel(CombatPage, "sec_target")

lo += 1
local TgtHdr = Instance.new("Frame", CombatPage)
TgtHdr.Size             = UDim2.new(1,0,0,52)
TgtHdr.BackgroundColor3 = C.Card
TgtHdr.BorderSizePixel  = 0
TgtHdr.LayoutOrder      = lo
Instance.new("UICorner", TgtHdr).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke", TgtHdr).Color = C.Border
local TgtHdrLbl = Instance.new("TextLabel", TgtHdr)
TgtHdrLbl.Text          = T("target_part")
TgtHdrLbl.Size          = UDim2.new(1,-14,0,22)
TgtHdrLbl.Position      = UDim2.new(0,14,0,7)
TgtHdrLbl.Font          = Enum.Font.GothamBold
TgtHdrLbl.TextSize      = 12
TgtHdrLbl.TextColor3    = C.Text
TgtHdrLbl.BackgroundTransparency = 1
TgtHdrLbl.TextXAlignment = Enum.TextXAlignment.Left
local TgtHdrSub = Instance.new("TextLabel", TgtHdr)
TgtHdrSub.Text          = T("target_part_desc")
TgtHdrSub.Size          = UDim2.new(1,-14,0,14)
TgtHdrSub.Position      = UDim2.new(0,14,0,29)
TgtHdrSub.Font          = Enum.Font.Gotham
TgtHdrSub.TextSize      = 10
TgtHdrSub.TextColor3    = C.SubText
TgtHdrSub.BackgroundTransparency = 1
TgtHdrSub.TextXAlignment = Enum.TextXAlignment.Left
OnLangUpdate(function()
    TgtHdrLbl.Text = T("target_part")
    TgtHdrSub.Text = T("target_part_desc")
end)

local targetDefs = {
    {id="Head",       icon="◉", tkey="target_head"},
    {id="UpperTorso", icon="▣", tkey="target_torso"},
    {id="LeftFoot",   icon="▼", tkey="target_foot"},
}
Make3BtnRow(CombatPage, targetDefs,
    function() return _G.AimbotTarget end,
    function(id) _G.AimbotTarget = id end,
    function(refs)
        for _, r in pairs(refs) do r.frame.Size = UDim2.new(0,178,1,0); r.lbl.Text = T(r.tkey) end
    end
)

SectionLabel(CombatPage, "sec_filters")
AddToggle(CombatPage, "team_check", "team_check_desc", function(v) _G.TeamCheck = v end)
AddToggle(CombatPage, "wall_check", "wall_check_desc", function(v) _G.WallCheck = v end)

-- ========== VISUALS SAYFASI ==========
lo = 0
SectionLabel(VisualsPage, "sec_camera")
AddSlider(VisualsPage, "cam_fov", 40, 120, 70, "°", function(v)
    _G.CameraFOV = v
    Camera.FieldOfView = v
end)

SectionLabel(VisualsPage, "sec_esp")
AddToggle(VisualsPage, "esp_toggle", "esp_desc", function(v) _G.EspEnabled = v end)
AddToggle(VisualsPage, "team_esp", "team_esp_desc", function(v) _G.TeamEsp = v end)
AddToggle(VisualsPage, "health_bar", "health_bar_desc", function(v)
    _G.HealthBarEnabled = v
    if not v then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hb = p.Character:FindFirstChild("RedaxHBar")
                if hb then hb:Destroy() end
            end
        end
    end
end)

SectionLabel(VisualsPage, "sec_color_guide")
lo += 1
local CG = Instance.new("Frame", VisualsPage)
CG.Size             = UDim2.new(1,0,0,84)
CG.BackgroundColor3 = C.Card
CG.BorderSizePixel  = 0
CG.LayoutOrder      = lo
Instance.new("UICorner", CG).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke", CG).Color = C.Border
local guideKeys   = {"color_teammate","color_enemy_vis","color_enemy_wall"}
local guideColors = {Color3.fromRGB(0,220,90), Color3.fromRGB(230,50,50), Color3.fromRGB(240,200,0)}
local cgLbls = {}
for i, key in ipairs(guideKeys) do
    local dot = Instance.new("Frame", CG)
    dot.Size            = UDim2.new(0,8,0,8)
    dot.Position        = UDim2.new(0,14,0,12+(i-1)*24)
    dot.BackgroundColor3 = guideColors[i]
    dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
    local lbl = Instance.new("TextLabel", CG)
    lbl.Text            = T(key)
    lbl.Size            = UDim2.new(1,-36,0,14)
    lbl.Position        = UDim2.new(0,30,0,9+(i-1)*24)
    lbl.Font            = Enum.Font.Gotham
    lbl.TextSize        = 11
    lbl.TextColor3      = C.SubText
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment  = Enum.TextXAlignment.Left
    cgLbls[i] = {lbl=lbl, key=key}
end
OnLangUpdate(function() for _,d in ipairs(cgLbls) do d.lbl.Text = T(d.key) end end)

-- ========== MISC SAYFASI ==========
lo = 0
SectionLabel(MiscPage, "sec_movement")
AddSlider(MiscPage, "walk_speed", 16, 250, 16, " st/s", function(v)
    _G.WalkSpeed = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
end)
AddButton(MiscPage, "reset_speed", "reset_speed_desc", function()
    _G.WalkSpeed = 16
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

-- ========== SETTINGS SAYFASI ==========
lo = 0
SectionLabel(SettingsPage, "sec_language")

lo += 1
local LangHdr = Instance.new("Frame", SettingsPage)
LangHdr.Size            = UDim2.new(1,0,0,52)
LangHdr.BackgroundColor3 = C.Card
LangHdr.BorderSizePixel = 0
LangHdr.LayoutOrder     = lo
Instance.new("UICorner", LangHdr).CornerRadius = UDim.new(0,6)
Instance.new("UIStroke", LangHdr).Color = C.Border
local LHLbl = Instance.new("TextLabel", LangHdr)
LHLbl.Text              = T("lang_label")
LHLbl.Size              = UDim2.new(1,-14,0,22)
LHLbl.Position          = UDim2.new(0,14,0,7)
LHLbl.Font              = Enum.Font.GothamBold
LHLbl.TextSize          = 12
LHLbl.TextColor3        = C.Text
LHLbl.BackgroundTransparency = 1
LHLbl.TextXAlignment    = Enum.TextXAlignment.Left
local LHSub = Instance.new("TextLabel", LangHdr)
LHSub.Text              = T("lang_desc")
LHSub.Size              = UDim2.new(1,-14,0,14)
LHSub.Position          = UDim2.new(0,14,0,29)
LHSub.Font              = Enum.Font.Gotham
LHSub.TextSize          = 10
LHSub.TextColor3        = C.SubText
LHSub.BackgroundTransparency = 1
LHSub.TextXAlignment    = Enum.TextXAlignment.Left
OnLangUpdate(function() LHLbl.Text = T("lang_label"); LHSub.Text = T("lang_desc") end)

local langDefs = {
    {id="TR", icon="🇹🇷", tkey="lang_tr"},
    {id="EN", icon="🇺🇸", tkey="lang_en"},
    {id="RU", icon="🇷🇺", tkey="lang_ru"},
}
local langRefs = {}
Make3BtnRow(SettingsPage, langDefs,
    function() return _G.ActiveLang end,
    function(id)
        _G.ActiveLang = id
        RefreshLang()
        for lid, r in pairs(langRefs) do
            r.lbl.Text = Lang.TR["lang_"..lid:lower()]
        end
    end,
    function(refs)
        langRefs = refs
        for _, r in pairs(refs) do r.frame.Size = UDim2.new(0,178,1,0) end
        for lid, r in pairs(refs) do r.lbl.Text = Lang.TR["lang_"..lid:lower()] end
    end
)

-- ==================== TAB SİSTEMİ ====================
local tabDefs = {
    {name="Combat",   page="Combat",   icon="⬡", tkey="tab_combat",   dkey="tab_combat_desc"},
    {name="Visuals",  page="Visuals",  icon="⬢", tkey="tab_visuals",  dkey="tab_visuals_desc"},
    {name="Misc",     page="Misc",     icon="⬟", tkey="tab_misc",     dkey="tab_misc_desc"},
    {name="Settings", page="Settings", icon="⚙", tkey="tab_settings", dkey="tab_settings_desc"},
}

local function SetActiveTab(name)
    for _, td in ipairs(tabDefs) do
        local d  = TabBtns[td.name]
        local on = td.name == name
        TPlay(d.bg,    0.15, {BackgroundTransparency = on and 0 or 1})
        TPlay(d.ind,   0.15, {BackgroundTransparency = on and 0 or 1})
        TPlay(d.lbl,   0.15, {TextColor3 = on and C.Text or C.SubText})
        TPlay(d.ico,   0.15, {TextColor3 = on and C.Accent or Color3.fromRGB(40,55,85)})
        TPlay(d.desc,  0.15, {TextColor3 = on and C.AccentDim or Color3.fromRGB(35,45,70)})
        Pages[td.page].Visible = on
    end
end

for i, tab in ipairs(tabDefs) do
    local Btn = Instance.new("TextButton", SideBar)
    Btn.Size            = UDim2.new(1,-14,0,42)
    Btn.Position        = UDim2.new(0,7,0,78+(i-1)*46)
    Btn.BackgroundTransparency = 1
    Btn.Text            = ""
    Btn.BorderSizePixel = 0

    local BG = Instance.new("Frame", Btn)
    BG.Size             = UDim2.new(1,0,1,0)
    BG.BackgroundColor3 = C.CardActive
    BG.BackgroundTransparency = 1
    BG.BorderSizePixel  = 0
    Instance.new("UICorner", BG).CornerRadius = UDim.new(0,6)

    local Ind = Instance.new("Frame", Btn)
    Ind.Size            = UDim2.new(0,2,0.6,0)
    Ind.Position        = UDim2.new(0,0,0.2,0)
    Ind.BackgroundColor3 = C.Accent
    Ind.BackgroundTransparency = 1
    Ind.BorderSizePixel = 0
    Instance.new("UICorner", Ind).CornerRadius = UDim.new(1,0)

    local Ico = Instance.new("TextLabel", Btn)
    Ico.Text            = tab.icon
    Ico.Size            = UDim2.new(0,26,1,0)
    Ico.Position        = UDim2.new(0,10,0,0)
    Ico.Font            = Enum.Font.GothamBold
    Ico.TextSize        = 15
    Ico.TextColor3      = Color3.fromRGB(40,55,85)
    Ico.BackgroundTransparency = 1

    local Lbl = Instance.new("TextLabel", Btn)
    Lbl.Text            = T(tab.tkey)
    Lbl.Size            = UDim2.new(1,-40,0,18)
    Lbl.Position        = UDim2.new(0,36,0,4)
    Lbl.Font            = Enum.Font.GothamBold
    Lbl.TextSize        = 12
    Lbl.TextColor3      = C.SubText
    Lbl.BackgroundTransparency = 1
    Lbl.TextXAlignment  = Enum.TextXAlignment.Left

    local Desc = Instance.new("TextLabel", Btn)
    Desc.Text           = T(tab.dkey)
    Desc.Size           = UDim2.new(1,-40,0,13)
    Desc.Position       = UDim2.new(0,36,0,22)
    Desc.Font           = Enum.Font.Code
    Desc.TextSize       = 9
    Desc.TextColor3     = Color3.fromRGB(35,45,70)
    Desc.BackgroundTransparency = 1
    Desc.TextXAlignment = Enum.TextXAlignment.Left

    TabBtns[tab.name] = {bg=BG,ind=Ind,lbl=Lbl,ico=Ico,desc=Desc}
    OnLangUpdate(function() Lbl.Text=T(tab.tkey); Desc.Text=T(tab.dkey) end)

    Btn.MouseButton1Click:Connect(function() SetActiveTab(tab.name) end)
    Btn.MouseEnter:Connect(function()
        if not Pages[tab.page].Visible then TPlay(Lbl,0.1,{TextColor3=Color3.fromRGB(140,160,190)}) end
    end)
    Btn.MouseLeave:Connect(function()
        if not Pages[tab.page].Visible then TPlay(Lbl,0.1,{TextColor3=C.SubText}) end
    end)
end

-- Footer
local Footer = Instance.new("TextLabel", SideBar)
Footer.Text             = T("footer")
Footer.Size             = UDim2.new(1,0,0,24)
Footer.Position         = UDim2.new(0,0,1,-28)
Footer.Font             = Enum.Font.Code
Footer.TextSize         = 8
Footer.TextColor3       = Color3.fromRGB(30,45,70)
Footer.BackgroundTransparency = 1

SetActiveTab("Combat")

-- ==================== INTRO ANİMASYON (premium) ====================
task.spawn(function()
    -- Scan line yukarıdan aşağıya kayar
    task.wait(0.05)
    TPlay(ScanLine, 1.4, {Position=UDim2.new(0,0,1.02,0)}, Enum.EasingStyle.Linear)

    task.wait(0.2)
    -- Grid çizgileri ve arka plan yumuşak gelsin
    IBarBG.BackgroundTransparency = 0
    TPlay(IBarBG, 0.3, {BackgroundTransparency=0})
    TPlay(IBarPct,0.3, {TextTransparency=0})

    -- Logo kutusu soldan kayar
    LogoOuter.Position = UDim2.new(0,-110,0.5,-45)
    TPlay(LogoOuterStroke, 0.01, {Transparency=0})
    TPlay(LogoOuter, 0.5, {
        Position = UDim2.new(0,0,0.5,-45),
        BackgroundTransparency = 0
    }, Enum.EasingStyle.Back)
    task.wait(0.35)

    -- RX ikonu belirir
    TPlay(LogoText,0.25,{TextTransparency=0})
    task.wait(0.2)

    -- Dikey çizgi uzar
    TPlay(IDivider,0.3,{Size=UDim2.new(0,2,0,80)},Enum.EasingStyle.Quint)
    task.wait(0.22)

    -- Başlık sağdan kayar + loading bar
    ITitle.Position = UDim2.new(0,28,0,4)
    ITitleAccent.Position = UDim2.new(0,28,0,4)
    TPlay(ITitle, 0.45, {TextTransparency=0, Position=UDim2.new(0,0,0,4)}, Enum.EasingStyle.Quint)
    TPlay(ITitleAccent, 0.45, {TextTransparency=0, Position=UDim2.new(0,0,0,4)}, Enum.EasingStyle.Quint)

    -- Loading bar animasyonu
    for pct = 0, 100, 4 do
        IBarFill.Size = UDim2.new(pct/100, 0, 1, 0)
        IBarPct.Text  = pct.."%"
        task.wait(0.018)
    end
    IBarFill.Size = UDim2.new(1,0,1,0)
    IBarPct.Text  = "100%"
    task.wait(0.15)

    TPlay(IEdition,0.3,{TextTransparency=0})
    task.wait(0.1)
    IBy.Position = UDim2.new(0,2,0,90)
    TPlay(IBy,0.3,{TextTransparency=0,Position=UDim2.new(0,2,0,82)})
    task.wait(1.0)

    -- Çıkış: tüm intro yukarı kayar
    TPlay(IC, 0.5, {Position=UDim2.new(-0.7,0,0.5,-55)}, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
    TPlay(IntroFrame, 0.45, {BackgroundTransparency=1}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    task.wait(0.5)
    IntroFrame.Visible = false

    -- Menü aşağıdan yükselir + hafif bounce
    Main.Position = UDim2.new(0.5,-400,1.6,0)
    Main.BackgroundTransparency = 0
    TPlay(Main, 0.6, {Position=UDim2.new(0.5,-400,0.5,-260)}, Enum.EasingStyle.Back)

    -- Menü açılınca tab butonları art arda gözükür
    task.wait(0.3)
    for _, td in ipairs(tabDefs) do
        local d = TabBtns[td.name]
        d.lbl.TextTransparency  = 1
        d.desc.TextTransparency = 1
        d.ico.TextTransparency  = 1
    end
    for i, td in ipairs(tabDefs) do
        task.delay((i-1)*0.07, function()
            local d = TabBtns[td.name]
            TPlay(d.lbl,  0.25, {TextTransparency=0})
            TPlay(d.desc, 0.25, {TextTransparency=0})
            TPlay(d.ico,  0.25, {TextTransparency=0})
        end)
    end
end)

-- ==================== DUVAR KONTROLÜ ====================
local function IsVisible(targetPart)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local exclude = {targetPart.Parent}
    if LocalPlayer.Character then table.insert(exclude, LocalPlayer.Character) end
    params.FilterDescendantsInstances = exclude
    local origin    = Camera.CFrame.Position
    local direction = targetPart.Position - origin
    local result    = workspace:Raycast(origin, direction, params)
    return result == nil
end

-- ==================== HİLE MOTORU ====================
local function GetTargetPart(character)
    local p = _G.AimbotTarget or "Head"
    if p == "LeftFoot" then
        return character:FindFirstChild("LeftFoot") or character:FindFirstChild("Left Leg") or character:FindFirstChild("HumanoidRootPart")
    elseif p == "UpperTorso" then
        return character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso") or character:FindFirstChild("HumanoidRootPart")
    else
        return character:FindFirstChild("Head")
    end
end

local function GetClosest()
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
        local mag = (Vector2.new(pos.X,pos.Y) - Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)).Magnitude
        if mag < _G.AimbotFOV and mag < dist then target=v; dist=mag end
    end
    return target
end

-- ==================== HEALTH BAR ====================
local function GetHealthColor(pct)
    if pct > 0.6 then
        local t = (1-pct)/0.4
        return Color3.fromRGB(math.floor(40+t*215), math.floor(220-t*20), 40)
    else
        local t = (0.6-pct)/0.6
        return Color3.fromRGB(math.floor(220+t*10), math.floor(200-t*200), 0)
    end
end

local function UpdateHealthBar(character, humanoid)
    if not character:FindFirstChild("HumanoidRootPart") then return end
    local bar = character:FindFirstChild("RedaxHBar")
    if not bar then
        bar = Instance.new("BillboardGui", character)
        bar.Name = "RedaxHBar"; bar.Size = UDim2.new(0,3,0,28)
        bar.StudsOffset = Vector3.new(-1.2,0,0); bar.AlwaysOnTop = true; bar.LightInfluence = 0
        local bg = Instance.new("Frame", bar)
        bg.Name = "BG"; bg.Size = UDim2.new(1,0,1,0)
        bg.BackgroundColor3 = Color3.fromRGB(15,15,20); bg.BackgroundTransparency = 0.35; bg.BorderSizePixel = 0
        Instance.new("UICorner", bg).CornerRadius = UDim.new(1,0)
        local fill = Instance.new("Frame", bg)
        fill.Name = "Fill"; fill.AnchorPoint = Vector2.new(0,1)
        fill.Position = UDim2.new(0,0,1,0); fill.Size = UDim2.new(1,0,1,0)
        fill.BackgroundColor3 = Color3.fromRGB(0,220,90); fill.BorderSizePixel = 0
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
    end
    local pct  = math.clamp(humanoid.Health/math.max(humanoid.MaxHealth,1),0,1)
    local fill = bar:FindFirstChild("BG") and bar.BG:FindFirstChild("Fill")
    if fill then fill.Size = UDim2.new(1,0,pct,0); fill.BackgroundColor3 = GetHealthColor(pct) end
end

-- FOV silah değişiminde sabit tut
Camera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
    if Camera.FieldOfView ~= _G.CameraFOV then Camera.FieldOfView = _G.CameraFOV end
end)

-- ==================== RENDER LOOP ====================
RunService.RenderStepped:Connect(function()
    FOVCircle.Radius   = _G.AimbotFOV
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    FOVCircle.Visible  = _G.AimbotEnabled

    if _G.AimbotEnabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local t = GetClosest()
        if t and t.Character then
            local ap = GetTargetPart(t.Character)
            if ap then
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, ap.Position), 1/math.max(1,_G.AimbotSmooth))
            end
        end
    end

    if _G.EspEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            if not p.Character then continue end
            local isTeam = p.Team == LocalPlayer.Team
            if isTeam and not _G.TeamEsp then
                if p.Character:FindFirstChild("RedaxESP") then p.Character.RedaxESP:Destroy() end
                if p.Character:FindFirstChild("RedaxHBar") then p.Character.RedaxHBar:Destroy() end
                continue
            end
            local visible = p.Character:FindFirstChild("Head") and IsVisible(p.Character.Head)
            local clr = isTeam and C.EspGreen or (visible and C.EspRed or C.EspYellow)
            local esp = p.Character:FindFirstChild("RedaxESP")
            if not esp then esp = Instance.new("Highlight",p.Character); esp.Name="RedaxESP" end
            esp.FillColor=clr; esp.FillTransparency=0.65; esp.OutlineColor=clr; esp.OutlineTransparency=0
            esp.DepthMode = (isTeam or not visible) and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
            if _G.HealthBarEnabled then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hum then UpdateHealthBar(p.Character, hum) end
            else
                local hb = p.Character:FindFirstChild("RedaxHBar")
                if hb then hb:Destroy() end
            end
        end
    else
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                if p.Character:FindFirstChild("RedaxESP") then p.Character.RedaxESP:Destroy() end
                if p.Character:FindFirstChild("RedaxHBar") then p.Character.RedaxHBar:Destroy() end
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
            TPlay(Main, 0.45, {Position=UDim2.new(0.5,-400,0.5,-260)}, Enum.EasingStyle.Back)
        else
            TPlay(Main, 0.35, {Position=UDim2.new(0.5,-400,1.6,0)}, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        end
        FOVCircle.Visible = isOpen and _G.AimbotEnabled
    end
end)
