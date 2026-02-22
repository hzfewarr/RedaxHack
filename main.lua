-- [[ REDAXHACK v3.0 - MIDNIGHT ELITE ]] --
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

if CoreGui:FindFirstChild("RedaxUltimate") then CoreGui.RedaxUltimate:Destroy() end

-- ==================== DİL SİSTEMİ ====================
_G.ActiveLang = "TR"

local Lang = {
    TR = {
        -- Genel
        hide_key        = "[INSERT] Gizle",
        game_name       = "Counter Blox",
        footer          = "✕  REDAXHACK  v3.0",
        -- Sekmeler
        tab_combat      = "Combat",
        tab_combat_desc = "Aimbot & ESP",
        tab_visuals     = "Visuals",
        tab_visuals_desc= "Görsel",
        tab_misc        = "Misc",
        tab_misc_desc   = "Ekstra",
        tab_skins       = "Skins",
        tab_skins_desc  = "Skin Changer",
        tab_settings    = "Settings",
        tab_settings_desc = "Ayarlar",
        -- Combat
        sec_aimbot      = "Aimbot",
        aimbot_toggle   = "Aimbot",
        aimbot_desc     = "Sağ tık basılıyken otomatik nişan",
        fov_slider      = "FOV Radius",
        smooth_slider   = "Smoothness",
        sec_target      = "Hedef",
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
        -- Visuals
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
        -- Misc
        sec_movement    = "Hareket",
        walk_speed      = "Yürüme Hızı",
        reset_speed     = "Hızı Sıfırla",
        reset_speed_desc= "Normal hıza geri dön (16)",
        -- Settings
        sec_language    = "Dil / Language / Язык",
        lang_label      = "Dil Seçimi",
        lang_desc       = "Arayüz dilini değiştir",
        lang_tr         = "🇹🇷  Türkçe",
        lang_en         = "🇺🇸  English",
        lang_ru         = "🇷🇺  Русский",
        -- Skins
        skin_select_weapon = "← Silah seç",
        skin_applied    = "✓ %s uygulandı",
        skin_next_round = "⚠ Bir sonraki raunda geçince aktif olur",
        skin_apply_btn  = "Uygula",
        skin_active_btn = "✓ Aktif",
        -- Skin Kategorileri
        skin_cat1       = "T Silahları",
        skin_cat2       = "CT Silahları",
        skin_cat3       = "Ortak",
        skin_cat4       = "Bıçaklar",
    },
    EN = {
        hide_key        = "[INSERT] Hide",
        game_name       = "Counter Blox",
        footer          = "✕  REDAXHACK  v3.0",
        tab_combat      = "Combat",
        tab_combat_desc = "Aimbot & ESP",
        tab_visuals     = "Visuals",
        tab_visuals_desc= "Visual",
        tab_misc        = "Misc",
        tab_misc_desc   = "Extra",
        tab_skins       = "Skins",
        tab_skins_desc  = "Skin Changer",
        tab_settings    = "Settings",
        tab_settings_desc = "Options",
        sec_aimbot      = "Aimbot",
        aimbot_toggle   = "Aimbot",
        aimbot_desc     = "Auto-aim while right mouse held",
        fov_slider      = "FOV Radius",
        smooth_slider   = "Smoothness",
        sec_target      = "Target",
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
        skin_select_weapon = "← Select a weapon",
        skin_applied    = "✓ %s applied",
        skin_next_round = "⚠ Will activate next round",
        skin_apply_btn  = "Apply",
        skin_active_btn = "✓ Active",
        skin_cat1       = "T Weapons",
        skin_cat2       = "CT Weapons",
        skin_cat3       = "Shared",
        skin_cat4       = "Knives",
    },
    RU = {
        hide_key        = "[INSERT] Скрыть",
        game_name       = "Counter Blox",
        footer          = "✕  REDAXHACK  v3.0",
        tab_combat      = "Бой",
        tab_combat_desc = "Аимбот & ESP",
        tab_visuals     = "Визуал",
        tab_visuals_desc= "Оформление",
        tab_misc        = "Разное",
        tab_misc_desc   = "Прочее",
        tab_skins       = "Скины",
        tab_skins_desc  = "Скин Чейнджер",
        tab_settings    = "Настройки",
        tab_settings_desc = "Параметры",
        sec_aimbot      = "Аимбот",
        aimbot_toggle   = "Аимбот",
        aimbot_desc     = "Автоприцел при зажатой ПКМ",
        fov_slider      = "Радиус FOV",
        smooth_slider   = "Плавность",
        sec_target      = "Цель",
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
        cam_fov_desc    = "Настроить угол обзора игры",
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
        skin_select_weapon = "← Выберите оружие",
        skin_applied    = "✓ %s применён",
        skin_next_round = "⚠ Активируется в следующем раунде",
        skin_apply_btn  = "Применить",
        skin_active_btn = "✓ Активен",
        skin_cat1       = "Оружие T",
        skin_cat2       = "Оружие CT",
        skin_cat3       = "Общее",
        skin_cat4       = "Ножи",
    },
}

local function T(key) return Lang[_G.ActiveLang][key] or key end

-- ==================== AYARLAR ====================
_G.AimbotEnabled  = false
_G.AimbotFOV      = 120
_G.AimbotSmooth   = 1
_G.AimbotTarget   = "Head"
_G.TeamCheck      = false
_G.EspEnabled     = false
_G.TeamEsp        = true
_G.WallCheck      = true
_G.HealthBarEnabled = true
_G.CameraFOV      = 70
_G.WalkSpeed      = 16

local SkinCategories = {"T Silahları", "CT Silahları", "Ortak"}
local activeSkinCat  = "T Silahları"
local appliedSkins   = {}
local activeSkinWeapon = nil

-- ==================== RENKLER ====================
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

-- ==================== INTRO ====================
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(6, 6, 8)
IntroFrame.ZIndex = 200
IntroFrame.BorderSizePixel = 0

for i = 1, 12 do
    local line = Instance.new("Frame", IntroFrame)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, i / 12, 0)
    line.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
    line.BackgroundTransparency = 0.96
    line.BorderSizePixel = 0
    line.ZIndex = 200
end

local IntroCenterFrame = Instance.new("Frame", IntroFrame)
IntroCenterFrame.Size = UDim2.new(0, 480, 0, 90)
IntroCenterFrame.Position = UDim2.new(0.5, -240, 0.5, -45)
IntroCenterFrame.BackgroundTransparency = 1
IntroCenterFrame.ZIndex = 205

local LogoBox = Instance.new("Frame", IntroCenterFrame)
LogoBox.Size = UDim2.new(0, 80, 0, 80)
LogoBox.Position = UDim2.new(0, 0, 0.5, -40)
LogoBox.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
LogoBox.BorderSizePixel = 0
LogoBox.ZIndex = 206
LogoBox.BackgroundTransparency = 1
Instance.new("UICorner", LogoBox).CornerRadius = UDim.new(0, 6)

local LogoBoxInner = Instance.new("Frame", LogoBox)
LogoBoxInner.Size = UDim2.new(1, -4, 1, -4)
LogoBoxInner.Position = UDim2.new(0, 2, 0, 2)
LogoBoxInner.BackgroundColor3 = Color3.fromRGB(12, 10, 14)
LogoBoxInner.BorderSizePixel = 0
LogoBoxInner.ZIndex = 207
Instance.new("UICorner", LogoBoxInner).CornerRadius = UDim.new(0, 4)

local LogoX = Instance.new("TextLabel", LogoBox)
LogoX.Text = "✕"
LogoX.Size = UDim2.new(1, 0, 1, 0)
LogoX.Font = Enum.Font.GothamBlack
LogoX.TextSize = 42
LogoX.TextColor3 = Color3.fromRGB(220, 40, 40)
LogoX.BackgroundTransparency = 1
LogoX.ZIndex = 208
LogoX.TextTransparency = 1

local IntroDivider = Instance.new("Frame", IntroCenterFrame)
IntroDivider.Size = UDim2.new(0, 2, 0, 0)
IntroDivider.Position = UDim2.new(0, 96, 0.5, 0)
IntroDivider.AnchorPoint = Vector2.new(0, 0.5)
IntroDivider.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
IntroDivider.BorderSizePixel = 0
IntroDivider.ZIndex = 206

local IntroTextGroup = Instance.new("Frame", IntroCenterFrame)
IntroTextGroup.Size = UDim2.new(0, 370, 1, 0)
IntroTextGroup.Position = UDim2.new(0, 108, 0, 0)
IntroTextGroup.BackgroundTransparency = 1
IntroTextGroup.ZIndex = 206

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
IntroTitle.TextTransparency = 1

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

local IntroUnderline = Instance.new("Frame", IntroTextGroup)
IntroUnderline.Size = UDim2.new(0, 0, 0, 2)
IntroUnderline.Position = UDim2.new(0, 0, 0, 54)
IntroUnderline.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
IntroUnderline.BorderSizePixel = 0
IntroUnderline.ZIndex = 207

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

-- ========== HEADER ==========
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 44)
Header.BackgroundColor3 = Color3.fromRGB(8, 7, 9)
Header.BorderSizePixel = 0

local HeaderBottomLine = Instance.new("Frame", Header)
HeaderBottomLine.Size = UDim2.new(1, 0, 0, 2)
HeaderBottomLine.Position = UDim2.new(0, 0, 1, -2)
HeaderBottomLine.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
HeaderBottomLine.BorderSizePixel = 0

local HLogo = Instance.new("TextLabel", Header)
HLogo.Text = "✕"
HLogo.Size = UDim2.new(0, 36, 1, 0)
HLogo.Position = UDim2.new(0, 10, 0, 0)
HLogo.Font = Enum.Font.GothamBlack
HLogo.TextSize = 20
HLogo.TextColor3 = Color3.fromRGB(220, 40, 40)
HLogo.BackgroundTransparency = 1

local HeaderTitle = Instance.new("TextLabel", Header)
HeaderTitle.Text = "REDAXHACK"
HeaderTitle.Font = Enum.Font.GothamBlack
HeaderTitle.TextSize = 15
HeaderTitle.TextColor3 = Color3.fromRGB(225, 220, 220)
HeaderTitle.Size = UDim2.new(0, 180, 1, 0)
HeaderTitle.Position = UDim2.new(0, 46, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

local HeaderMid = Instance.new("TextLabel", Header)
HeaderMid.Text = T("game_name")
HeaderMid.Font = Enum.Font.GothamMedium
HeaderMid.TextSize = 10
HeaderMid.TextColor3 = Color3.fromRGB(100, 90, 90)
HeaderMid.Size = UDim2.new(0, 160, 1, 0)
HeaderMid.Position = UDim2.new(0.5, -80, 0, 0)
HeaderMid.BackgroundTransparency = 1

local HeaderRight = Instance.new("TextLabel", Header)
HeaderRight.Text = T("hide_key")
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

-- ========== SIDEBAR ==========
local SideBar = Instance.new("Frame", Main)
SideBar.Size = UDim2.new(0, 160, 1, -44)
SideBar.Position = UDim2.new(0, 0, 0, 44)
SideBar.BackgroundColor3 = Color3.fromRGB(11, 10, 13)
SideBar.BorderSizePixel = 0

local SBLine = Instance.new("Frame", SideBar)
SBLine.Size = UDim2.new(0, 1, 1, 0)
SBLine.Position = UDim2.new(1, -1, 0, 0)
SBLine.BackgroundColor3 = Color3.fromRGB(40, 30, 30)
SBLine.BorderSizePixel = 0

local SBDeco = Instance.new("Frame", SideBar)
SBDeco.Size = UDim2.new(1, 0, 0, 2)
SBDeco.Position = UDim2.new(0, 0, 0, 0)
SBDeco.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
SBDeco.BorderSizePixel = 0

local PlayerBox = Instance.new("Frame", SideBar)
PlayerBox.Size = UDim2.new(1, -16, 0, 42)
PlayerBox.Position = UDim2.new(0, 8, 0, 10)
PlayerBox.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
PlayerBox.BorderSizePixel = 0
Instance.new("UICorner", PlayerBox).CornerRadius = UDim.new(0, 4)
local PBStroke = Instance.new("UIStroke", PlayerBox)
PBStroke.Color = Color3.fromRGB(40, 30, 30)
PBStroke.Thickness = 1

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

-- ==================== DİL GÜNCELLEYİCİ KAYIT SİSTEMİ ====================
local _langUpdaters = {}
local function OnLangUpdate(fn) table.insert(_langUpdaters, fn) end
local function RefreshLang()
    for _, fn in ipairs(_langUpdaters) do pcall(fn) end
end

-- ==================== BİLEŞENLER ====================
local layoutOrder = 0
local function NextOrder() layoutOrder += 1 return layoutOrder end

local function SectionLabel(parent, textKey)
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
    lbl.Text = T(textKey):upper()
    lbl.Size = UDim2.new(1, -12, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.Font = Enum.Font.Code
    lbl.TextSize = 10
    lbl.TextColor3 = C.Accent
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    OnLangUpdate(function() lbl.Text = T(textKey):upper() end)
end

local function AddToggle(parent, textKey, descKey, callback)
    layoutOrder += 1
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, 0, 0, descKey and 54 or 44)
    Frame.BackgroundColor3 = C.Card
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = layoutOrder
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 5)

    local Stroke = Instance.new("UIStroke", Frame)
    Stroke.Color = C.Border
    Stroke.Thickness = 1

    local Label = Instance.new("TextLabel", Frame)
    Label.Text = T(textKey)
    Label.Size = UDim2.new(1, -68, 0, 22)
    Label.Position = UDim2.new(0, 14, 0, descKey and 8 or 0)
    Label.TextColor3 = C.Text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local Sub
    if descKey then
        Sub = Instance.new("TextLabel", Frame)
        Sub.Text = T(descKey)
        Sub.Size = UDim2.new(1, -68, 0, 16)
        Sub.Position = UDim2.new(0, 14, 0, 28)
        Sub.TextColor3 = C.SubText
        Sub.Font = Enum.Font.Gotham
        Sub.TextSize = 10
        Sub.TextXAlignment = Enum.TextXAlignment.Left
        Sub.BackgroundTransparency = 1
    end

    OnLangUpdate(function()
        Label.Text = T(textKey)
        if Sub then Sub.Text = T(descKey) end
    end)

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
        TweenService:Create(Switch, TweenInfo.new(0.15), {BackgroundColor3 = state and C.Accent or C.Off}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.15), {Color = state and C.AccentDim or C.Border}):Play()
        callback(state)
    end)
    Btn.MouseEnter:Connect(function() TweenService:Create(Frame, TweenInfo.new(0.1), {BackgroundColor3 = C.CardHover}):Play() end)
    Btn.MouseLeave:Connect(function() TweenService:Create(Frame, TweenInfo.new(0.1), {BackgroundColor3 = C.Card}):Play() end)
end

local function AddSlider(parent, textKey, min, max, default, suffix, callback)
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
    Label.Text = T(textKey)
    Label.TextColor3 = C.Text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    OnLangUpdate(function() Label.Text = T(textKey) end)

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

local function AddButton(parent, textKey, descKey, callback)
    layoutOrder += 1
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, 0, 0, descKey and 54 or 44)
    Frame.BackgroundColor3 = C.Card
    Frame.BorderSizePixel = 0
    Frame.LayoutOrder = layoutOrder
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 5)
    Instance.new("UIStroke", Frame).Color = C.Border

    local Label = Instance.new("TextLabel", Frame)
    Label.Text = T(textKey)
    Label.Size = UDim2.new(1, -50, 0, 22)
    Label.Position = UDim2.new(0, 14, 0, descKey and 8 or 0)
    Label.TextColor3 = C.Text
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local Sub
    if descKey then
        Sub = Instance.new("TextLabel", Frame)
        Sub.Text = T(descKey)
        Sub.Size = UDim2.new(1, -50, 0, 16)
        Sub.Position = UDim2.new(0, 14, 0, 28)
        Sub.TextColor3 = C.SubText
        Sub.Font = Enum.Font.Gotham
        Sub.TextSize = 10
        Sub.TextXAlignment = Enum.TextXAlignment.Left
        Sub.BackgroundTransparency = 1
    end

    OnLangUpdate(function()
        Label.Text = T(textKey)
        if Sub then Sub.Text = T(descKey) end
    end)

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
        task.delay(0.14, function() TweenService:Create(Frame, TweenInfo.new(0.12), {BackgroundColor3 = C.Card}):Play() end)
        callback()
    end)
    Btn.MouseEnter:Connect(function() TweenService:Create(Frame, TweenInfo.new(0.1), {BackgroundColor3 = C.CardHover}):Play() end)
    Btn.MouseLeave:Connect(function() TweenService:Create(Frame, TweenInfo.new(0.1), {BackgroundColor3 = C.Card}):Play() end)
end

-- ==================== SAYFALAR ====================
local CombatPage  = CreatePage("Combat")
local VisualsPage = CreatePage("Visuals")
local MiscPage    = CreatePage("Misc")
local SettingsPage = CreatePage("Settings")

local SkinsPage = Instance.new("Frame", ContentArea)
SkinsPage.Size = UDim2.new(1, 0, 1, 0)
SkinsPage.BackgroundTransparency = 1
SkinsPage.Visible = false
Pages["Skins"] = SkinsPage

-- ========== COMBAT SAYFA ==========
layoutOrder = 0
SectionLabel(CombatPage, "sec_aimbot")
AddToggle(CombatPage, "aimbot_toggle", "aimbot_desc", function(v) _G.AimbotEnabled = v end)
AddSlider(CombatPage, "fov_slider", 10, 800, 120, " px", function(v) _G.AimbotFOV = v end)
AddSlider(CombatPage, "smooth_slider", 1, 20, 1, "x", function(v) _G.AimbotSmooth = v end)

-- -------- Hedef Seçici --------
SectionLabel(CombatPage, "sec_target")

layoutOrder += 1
local TargetFrame = Instance.new("Frame", CombatPage)
TargetFrame.Size = UDim2.new(1, 0, 0, 54)
TargetFrame.BackgroundColor3 = C.Card
TargetFrame.BorderSizePixel = 0
TargetFrame.LayoutOrder = layoutOrder
Instance.new("UICorner", TargetFrame).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", TargetFrame).Color = C.Border

local TargetTitleLbl = Instance.new("TextLabel", TargetFrame)
TargetTitleLbl.Text = T("target_part")
TargetTitleLbl.Size = UDim2.new(1, -14, 0, 20)
TargetTitleLbl.Position = UDim2.new(0, 14, 0, 8)
TargetTitleLbl.Font = Enum.Font.GothamMedium
TargetTitleLbl.TextSize = 13
TargetTitleLbl.TextColor3 = C.Text
TargetTitleLbl.BackgroundTransparency = 1
TargetTitleLbl.TextXAlignment = Enum.TextXAlignment.Left

local TargetDescLbl = Instance.new("TextLabel", TargetFrame)
TargetDescLbl.Text = T("target_part_desc")
TargetDescLbl.Size = UDim2.new(1, -14, 0, 14)
TargetDescLbl.Position = UDim2.new(0, 14, 0, 28)
TargetDescLbl.Font = Enum.Font.Gotham
TargetDescLbl.TextSize = 10
TargetDescLbl.TextColor3 = C.SubText
TargetDescLbl.BackgroundTransparency = 1
TargetDescLbl.TextXAlignment = Enum.TextXAlignment.Left

OnLangUpdate(function()
    TargetTitleLbl.Text = T("target_part")
    TargetDescLbl.Text = T("target_part_desc")
end)

layoutOrder += 1
local TargetBtnRow = Instance.new("Frame", CombatPage)
TargetBtnRow.Size = UDim2.new(1, 0, 0, 46)
TargetBtnRow.BackgroundTransparency = 1
TargetBtnRow.BorderSizePixel = 0
TargetBtnRow.LayoutOrder = layoutOrder

local TargetRowList = Instance.new("UIListLayout", TargetBtnRow)
TargetRowList.FillDirection = Enum.FillDirection.Horizontal
TargetRowList.Padding = UDim.new(0, 8)
TargetRowList.SortOrder = Enum.SortOrder.LayoutOrder

-- {partKey, partName (Roblox), langKey}
local targetDefs = {
    {part="Head",       icon="◉", tkey="target_head"},
    {part="UpperTorso", icon="▣", tkey="target_torso"},
    {part="LeftFoot",   icon="▼", tkey="target_foot"},
}

local targetBtnRefs = {}

local function UpdateTargetButtons()
    for _, r in pairs(targetBtnRefs) do
        local on = r.part == _G.AimbotTarget
        TweenService:Create(r.frame, TweenInfo.new(0.15), {BackgroundColor3 = on and C.CardActive or C.Card}):Play()
        TweenService:Create(r.stroke, TweenInfo.new(0.15), {Color = on and C.Accent or C.Border}):Play()
        TweenService:Create(r.lbl, TweenInfo.new(0.15), {TextColor3 = on and C.Accent or C.SubText}):Play()
        r.indicator.BackgroundTransparency = on and 0 or 1
    end
end

for i, td in ipairs(targetDefs) do
    local BtnFrame = Instance.new("Frame", TargetBtnRow)
    BtnFrame.Size = UDim2.new(0, 174, 1, 0)
    BtnFrame.BackgroundColor3 = td.part == _G.AimbotTarget and C.CardActive or C.Card
    BtnFrame.BorderSizePixel = 0
    BtnFrame.LayoutOrder = i
    Instance.new("UICorner", BtnFrame).CornerRadius = UDim.new(0, 5)
    local BStroke = Instance.new("UIStroke", BtnFrame)
    BStroke.Color = td.part == _G.AimbotTarget and C.Accent or C.Border
    BStroke.Thickness = 1

    local Indicator = Instance.new("Frame", BtnFrame)
    Indicator.Size = UDim2.new(0.6, 0, 0, 2)
    Indicator.Position = UDim2.new(0.2, 0, 1, -2)
    Indicator.BackgroundColor3 = C.Accent
    Indicator.BackgroundTransparency = td.part == _G.AimbotTarget and 0 or 1
    Indicator.BorderSizePixel = 0
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

    local IconLbl = Instance.new("TextLabel", BtnFrame)
    IconLbl.Text = td.icon
    IconLbl.Size = UDim2.new(0, 22, 1, -4)
    IconLbl.Position = UDim2.new(0, 10, 0, 2)
    IconLbl.Font = Enum.Font.GothamBold
    IconLbl.TextSize = 14
    IconLbl.TextColor3 = td.part == _G.AimbotTarget and C.Accent or Color3.fromRGB(70,60,60)
    IconLbl.BackgroundTransparency = 1

    local BLbl = Instance.new("TextLabel", BtnFrame)
    BLbl.Text = T(td.tkey)
    BLbl.Size = UDim2.new(1, -36, 1, 0)
    BLbl.Position = UDim2.new(0, 32, 0, 0)
    BLbl.Font = Enum.Font.GothamMedium
    BLbl.TextSize = 13
    BLbl.TextColor3 = td.part == _G.AimbotTarget and C.Accent or C.SubText
    BLbl.BackgroundTransparency = 1
    BLbl.TextXAlignment = Enum.TextXAlignment.Left

    local BBtn = Instance.new("TextButton", BtnFrame)
    BBtn.Size = UDim2.new(1, 0, 1, 0)
    BBtn.BackgroundTransparency = 1
    BBtn.Text = ""

    targetBtnRefs[td.part] = {frame=BtnFrame, stroke=BStroke, lbl=BLbl, icon=IconLbl, indicator=Indicator, part=td.part, tkey=td.tkey}

    BBtn.MouseButton1Click:Connect(function()
        _G.AimbotTarget = td.part
        UpdateTargetButtons()
    end)
    BBtn.MouseEnter:Connect(function()
        if _G.AimbotTarget ~= td.part then
            TweenService:Create(BtnFrame, TweenInfo.new(0.1), {BackgroundColor3 = C.CardHover}):Play()
        end
    end)
    BBtn.MouseLeave:Connect(function()
        if _G.AimbotTarget ~= td.part then
            TweenService:Create(BtnFrame, TweenInfo.new(0.1), {BackgroundColor3 = C.Card}):Play()
        end
    end)
end

OnLangUpdate(function()
    for _, r in pairs(targetBtnRefs) do
        r.lbl.Text = T(r.tkey)
    end
end)
SectionLabel(CombatPage, "sec_filters")
AddToggle(CombatPage, "team_check", "team_check_desc", function(v) _G.TeamCheck = v end)
AddToggle(CombatPage, "wall_check", "wall_check_desc", function(v) _G.WallCheck = v end)

-- ========== VISUALS SAYFA ==========
layoutOrder = 0
SectionLabel(VisualsPage, "sec_camera")
AddSlider(VisualsPage, "cam_fov", 40, 120, 70, "°", function(v)
    _G.CameraFOV = v
    Camera.FieldOfView = v
end)

SectionLabel(VisualsPage, "sec_esp")
AddToggle(VisualsPage, "esp_toggle", "esp_desc", function(v) _G.EspEnabled = v end)
AddToggle(VisualsPage, "team_esp", "team_esp_desc", function(v) _G.TeamEsp = v end)
AddToggle(VisualsPage, "health_bar", "health_bar_desc", function(v) _G.HealthBarEnabled = v
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

layoutOrder += 1
local ColorGuide = Instance.new("Frame", VisualsPage)
ColorGuide.Size = UDim2.new(1, 0, 0, 80)
ColorGuide.BackgroundColor3 = C.Card
ColorGuide.BorderSizePixel = 0
ColorGuide.LayoutOrder = layoutOrder
Instance.new("UICorner", ColorGuide).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", ColorGuide).Color = C.Border

local guideKeys = {"color_teammate", "color_enemy_vis", "color_enemy_wall"}
local guideColors = {Color3.fromRGB(0,220,90), Color3.fromRGB(230,50,50), Color3.fromRGB(240,200,0)}
local guideLbls = {}
for i, key in ipairs(guideKeys) do
    local dot = Instance.new("Frame", ColorGuide)
    dot.Size = UDim2.new(0, 10, 0, 10)
    dot.Position = UDim2.new(0, 14, 0, 10 + (i-1)*22)
    dot.BackgroundColor3 = guideColors[i]
    dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)

    local lbl = Instance.new("TextLabel", ColorGuide)
    lbl.Text = T(key)
    lbl.Size = UDim2.new(1, -36, 0, 16)
    lbl.Position = UDim2.new(0, 32, 0, 7 + (i-1)*22)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 11
    lbl.TextColor3 = C.SubText
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    guideLbls[i] = {lbl = lbl, key = key}
end
OnLangUpdate(function()
    for _, d in ipairs(guideLbls) do d.lbl.Text = T(d.key) end
end)

-- ========== MISC SAYFA ==========
layoutOrder = 0
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

-- ========== SETTINGS SAYFA ==========
layoutOrder = 0
SectionLabel(SettingsPage, "sec_language")

-- Dil seçim butonları
layoutOrder += 1
local LangFrame = Instance.new("Frame", SettingsPage)
LangFrame.Size = UDim2.new(1, 0, 0, 54)
LangFrame.BackgroundColor3 = C.Card
LangFrame.BorderSizePixel = 0
LangFrame.LayoutOrder = layoutOrder
Instance.new("UICorner", LangFrame).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", LangFrame).Color = C.Border

local LangTitleLbl = Instance.new("TextLabel", LangFrame)
LangTitleLbl.Text = T("lang_label")
LangTitleLbl.Size = UDim2.new(1, -14, 0, 20)
LangTitleLbl.Position = UDim2.new(0, 14, 0, 8)
LangTitleLbl.Font = Enum.Font.GothamMedium
LangTitleLbl.TextSize = 13
LangTitleLbl.TextColor3 = C.Text
LangTitleLbl.BackgroundTransparency = 1
LangTitleLbl.TextXAlignment = Enum.TextXAlignment.Left

local LangDescLbl = Instance.new("TextLabel", LangFrame)
LangDescLbl.Text = T("lang_desc")
LangDescLbl.Size = UDim2.new(1, -14, 0, 14)
LangDescLbl.Position = UDim2.new(0, 14, 0, 28)
LangDescLbl.Font = Enum.Font.Gotham
LangDescLbl.TextSize = 10
LangDescLbl.TextColor3 = C.SubText
LangDescLbl.BackgroundTransparency = 1
LangDescLbl.TextXAlignment = Enum.TextXAlignment.Left

OnLangUpdate(function()
    LangTitleLbl.Text = T("lang_label")
    LangDescLbl.Text = T("lang_desc")
end)

-- 3 dil butonu yan yana
layoutOrder += 1
local LangBtnRow = Instance.new("Frame", SettingsPage)
LangBtnRow.Size = UDim2.new(1, 0, 0, 50)
LangBtnRow.BackgroundTransparency = 1
LangBtnRow.BorderSizePixel = 0
LangBtnRow.LayoutOrder = layoutOrder

local LangRowList = Instance.new("UIListLayout", LangBtnRow)
LangRowList.FillDirection = Enum.FillDirection.Horizontal
LangRowList.Padding = UDim.new(0, 8)
LangRowList.SortOrder = Enum.SortOrder.LayoutOrder

local langDefs = {
    {code="TR", key="lang_tr"},
    {code="EN", key="lang_en"},
    {code="RU", key="lang_ru"},
}

local langBtnRefs = {}

local function UpdateLangButtons()
    for _, r in pairs(langBtnRefs) do
        local on = r.code == _G.ActiveLang
        TweenService:Create(r.frame, TweenInfo.new(0.15), {BackgroundColor3 = on and C.CardActive or C.Card}):Play()
        TweenService:Create(r.stroke, TweenInfo.new(0.15), {Color = on and C.Accent or C.Border}):Play()
        TweenService:Create(r.lbl, TweenInfo.new(0.15), {TextColor3 = on and C.Accent or C.SubText}):Play()
        r.indicator.BackgroundTransparency = on and 0 or 1
    end
end

for i, ld in ipairs(langDefs) do
    local BtnFrame = Instance.new("Frame", LangBtnRow)
    BtnFrame.Size = UDim2.new(0, 174, 1, 0)
    BtnFrame.BackgroundColor3 = ld.code == _G.ActiveLang and C.CardActive or C.Card
    BtnFrame.BorderSizePixel = 0
    BtnFrame.LayoutOrder = i
    Instance.new("UICorner", BtnFrame).CornerRadius = UDim.new(0, 5)
    local BStroke = Instance.new("UIStroke", BtnFrame)
    BStroke.Color = ld.code == _G.ActiveLang and C.Accent or C.Border
    BStroke.Thickness = 1

    -- Alt aktif çizgi
    local Indicator = Instance.new("Frame", BtnFrame)
    Indicator.Size = UDim2.new(0.6, 0, 0, 2)
    Indicator.Position = UDim2.new(0.2, 0, 1, -2)
    Indicator.BackgroundColor3 = C.Accent
    Indicator.BackgroundTransparency = ld.code == _G.ActiveLang and 0 or 1
    Indicator.BorderSizePixel = 0
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

    local BLbl = Instance.new("TextLabel", BtnFrame)
    BLbl.Text = Lang.TR[ld.key]  -- Dil ismi her zaman sabit göster
    BLbl.Size = UDim2.new(1, 0, 1, 0)
    BLbl.Font = Enum.Font.GothamMedium
    BLbl.TextSize = 13
    BLbl.TextColor3 = ld.code == _G.ActiveLang and C.Accent or C.SubText
    BLbl.BackgroundTransparency = 1

    local BBtn = Instance.new("TextButton", BtnFrame)
    BBtn.Size = UDim2.new(1, 0, 1, 0)
    BBtn.BackgroundTransparency = 1
    BBtn.Text = ""

    langBtnRefs[ld.code] = {frame=BtnFrame, stroke=BStroke, lbl=BLbl, indicator=Indicator, code=ld.code}

    BBtn.MouseButton1Click:Connect(function()
        if _G.ActiveLang == ld.code then return end
        _G.ActiveLang = ld.code
        UpdateLangButtons()
        RefreshLang()
        -- Header güncelle
        HeaderRight.Text = T("hide_key")
    end)
    BBtn.MouseEnter:Connect(function()
        if _G.ActiveLang ~= ld.code then
            TweenService:Create(BtnFrame, TweenInfo.new(0.1), {BackgroundColor3 = C.CardHover}):Play()
        end
    end)
    BBtn.MouseLeave:Connect(function()
        if _G.ActiveLang ~= ld.code then
            TweenService:Create(BtnFrame, TweenInfo.new(0.1), {BackgroundColor3 = C.Card}):Play()
        end
    end)
end

-- ==================== SKİN CHANGER VERİSİ ====================
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
                    if not doSkip then table.insert(args[1], v) end
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
            if val then val.Value = skinValue; wrote = true end
        end
    end
    return wrote
end

task.spawn(function() task.wait(3); _SetupHook() end)

-- ========== SKINS SAYFA LAYOUT ==========
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
SkinRightTitle.Text = T("skin_select_weapon")
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

OnLangUpdate(function()
    if not activeSkinWeapon then
        SkinRightTitle.Text = T("skin_select_weapon")
    end
end)

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

local skinCardRefs = {}

local function LoadSkinCards(weapon)
    for _, v in pairs(SkinRightScroll:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    skinCardRefs = {}
    activeSkinWeapon = weapon
    SkinRightTitle.Text = weapon.name .. " — " .. (
        _G.ActiveLang == "TR" and "Skin Seç" or
        _G.ActiveLang == "EN" and "Select Skin" or
        "Выбрать скин"
    )

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
        ApplyBtn.Size = UDim2.new(0, 72, 0, 26)
        ApplyBtn.Position = UDim2.new(1, -82, 0.5, -13)
        ApplyBtn.BackgroundColor3 = isActive and C.Accent or C.Off
        ApplyBtn.BorderSizePixel = 0
        ApplyBtn.Text = isActive and T("skin_active_btn") or T("skin_apply_btn")
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
                refs.btn.Text = on and T("skin_active_btn") or T("skin_apply_btn")
                refs.btn.TextColor3 = on and Color3.fromRGB(0,0,0) or C.Text
            end

            if weaponBtnRefs[weapon.name] then
                weaponBtnRefs[weapon.name].dot.BackgroundTransparency = 0
            end

            if ok then
                SkinStatusLbl.Text = string.format(T("skin_applied"), skinName)
                SkinStatusLbl.TextColor3 = C.Accent
            else
                SkinStatusLbl.Text = T("skin_next_round")
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

weaponBtnRefs = {}

local function BuildWeaponList(cat)
    for _, v in pairs(SkinLeftScroll:GetChildren()) do
        if v:IsA("TextButton") or v:IsA("Frame") then v:Destroy() end
    end
    weaponBtnRefs = {}
    for _, v in pairs(SkinRightScroll:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    skinCardRefs = {}
    SkinRightTitle.Text = T("skin_select_weapon")
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

-- Skin kategori butonları (sabit iç veri ismiyle çalışır, görünen isim dile göre değişir)
local skinCatMap = {
    ["T Silahları"]  = "skin_cat1",
    ["CT Silahları"] = "skin_cat2",
    ["Ortak"]        = "skin_cat3",
}
local skinCatBtnRefs = {}
for i, cat in ipairs(SkinCategories) do
    local Btn = Instance.new("TextButton", SkinCatBar)
    Btn.Size = UDim2.new(0, 196, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.BorderSizePixel = 0
    Btn.Text = T(skinCatMap[cat])
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

    skinCatBtnRefs[cat] = {btn=Btn, line=Line, key=skinCatMap[cat]}

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

OnLangUpdate(function()
    for cat, refs in pairs(skinCatBtnRefs) do
        refs.btn.Text = T(refs.key)
    end
end)

BuildWeaponList(activeSkinCat)

-- ==================== TAB BUTONLARI ====================
local tabDefs = {
    {name="Combat",   pageKey="Combat",   icon="◈", tkey="tab_combat",   dkey="tab_combat_desc"},
    {name="Visuals",  pageKey="Visuals",  icon="◉", tkey="tab_visuals",  dkey="tab_visuals_desc"},
    {name="Misc",     pageKey="Misc",     icon="◧", tkey="tab_misc",     dkey="tab_misc_desc"},
    {name="Skins",    pageKey="Skins",    icon="◇", tkey="tab_skins",    dkey="tab_skins_desc"},
    {name="Settings", pageKey="Settings", icon="⚙", tkey="tab_settings", dkey="tab_settings_desc"},
}

local function SetActiveTab(activeName)
    for _, td in ipairs(tabDefs) do
        local d = TabButtons[td.name]
        local on = td.name == activeName
        TweenService:Create(d.BG, TweenInfo.new(0.12), {BackgroundTransparency = on and 0 or 1}):Play()
        TweenService:Create(d.Indicator, TweenInfo.new(0.12), {BackgroundTransparency = on and 0 or 1}):Play()
        TweenService:Create(d.Label, TweenInfo.new(0.12), {TextColor3 = on and Color3.fromRGB(230,225,225) or Color3.fromRGB(100,90,90)}):Play()
        TweenService:Create(d.Icon, TweenInfo.new(0.12), {TextColor3 = on and Color3.fromRGB(220,40,40) or Color3.fromRGB(70,60,60)}):Play()
        Pages[td.pageKey].Visible = on
    end
end

for i, tab in ipairs(tabDefs) do
    local Btn = Instance.new("TextButton", SideBar)
    Btn.Size = UDim2.new(1, -16, 0, 40)
    Btn.Position = UDim2.new(0, 8, 0, 64 + (i-1)*44)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.BorderSizePixel = 0

    local BG = Instance.new("Frame", Btn)
    BG.Size = UDim2.new(1, 0, 1, 0)
    BG.BackgroundColor3 = Color3.fromRGB(28, 14, 14)
    BG.BackgroundTransparency = 1
    BG.BorderSizePixel = 0
    Instance.new("UICorner", BG).CornerRadius = UDim.new(0, 4)

    local Indicator = Instance.new("Frame", Btn)
    Indicator.Size = UDim2.new(0, 3, 0.55, 0)
    Indicator.Position = UDim2.new(0, 0, 0.225, 0)
    Indicator.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
    Indicator.BackgroundTransparency = 1
    Indicator.BorderSizePixel = 0
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

    local Icon = Instance.new("TextLabel", Btn)
    Icon.Text = tab.icon
    Icon.Size = UDim2.new(0, 28, 1, 0)
    Icon.Position = UDim2.new(0, 10, 0, 0)
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 16
    Icon.TextColor3 = Color3.fromRGB(70, 60, 60)
    Icon.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel", Btn)
    Label.Text = T(tab.tkey)
    Label.Size = UDim2.new(1, -42, 0, 18)
    Label.Position = UDim2.new(0, 38, 0, 4)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 12
    Label.TextColor3 = Color3.fromRGB(100, 90, 90)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Desc = Instance.new("TextLabel", Btn)
    Desc.Text = T(tab.dkey)
    Desc.Size = UDim2.new(1, -42, 0, 13)
    Desc.Position = UDim2.new(0, 38, 0, 22)
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 9
    Desc.TextColor3 = Color3.fromRGB(65, 55, 55)
    Desc.BackgroundTransparency = 1
    Desc.TextXAlignment = Enum.TextXAlignment.Left

    TabButtons[tab.name] = {BG=BG, Indicator=Indicator, Label=Label, Icon=Icon, Desc=Desc}

    OnLangUpdate(function()
        Label.Text = T(tab.tkey)
        Desc.Text = T(tab.dkey)
    end)

    Btn.MouseButton1Click:Connect(function() SetActiveTab(tab.name) end)
    Btn.MouseEnter:Connect(function()
        if not Pages[tab.pageKey].Visible then
            TweenService:Create(Label, TweenInfo.new(0.1), {TextColor3 = Color3.fromRGB(160,150,150)}):Play()
        end
    end)
    Btn.MouseLeave:Connect(function()
        if not Pages[tab.pageKey].Visible then
            TweenService:Create(Label, TweenInfo.new(0.1), {TextColor3 = Color3.fromRGB(100,90,90)}):Play()
        end
    end)
end

local Footer = Instance.new("TextLabel", SideBar)
Footer.Text = T("footer")
Footer.Size = UDim2.new(1, 0, 0, 28)
Footer.Position = UDim2.new(0, 0, 1, -32)
Footer.Font = Enum.Font.GothamMedium
Footer.TextSize = 9
Footer.TextColor3 = Color3.fromRGB(50, 40, 40)
Footer.BackgroundTransparency = 1

SetActiveTab("Combat")

-- ==================== INTRO ANİMASYON ====================
task.spawn(function()
    task.wait(0.1)
    LogoBox.Position = UDim2.new(0, -100, 0.5, -40)
    LogoBox.BackgroundTransparency = 0
    TweenService:Create(LogoBox, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0.5, -40)
    }):Play()
    task.wait(0.3)
    TweenService:Create(LogoX, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
    task.wait(0.2)
    TweenService:Create(IntroDivider, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 2, 0, 70)}):Play()
    task.wait(0.25)
    IntroTitle.Position = UDim2.new(0, 30, 0, 6)
    IntroTitleRed.Position = UDim2.new(0, 30, 0, 6)
    TweenService:Create(IntroTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0, Position = UDim2.new(0, 0, 0, 6)}):Play()
    TweenService:Create(IntroTitleRed, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0, Position = UDim2.new(0, 0, 0, 6)}):Play()
    task.wait(0.3)
    TweenService:Create(IntroUnderline, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 200, 0, 2)}):Play()
    task.wait(0.2)
    IntroBy.Position = UDim2.new(0, 2, 0, 66)
    TweenService:Create(IntroBy, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {TextTransparency = 0, Position = UDim2.new(0, 2, 0, 58)}):Play()
    task.wait(1.2)
    TweenService:Create(IntroCenterFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(-0.6, 0, 0.5, -45)}):Play()
    TweenService:Create(IntroFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.15), {BackgroundTransparency = 1}):Play()
    task.wait(0.55)
    IntroFrame.Visible = false
    Main.Position = UDim2.new(0.5, -380, 1.5, 0)
    TweenService:Create(Main, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -380, 0.5, -250)}):Play()
end)

-- ==================== DUVAR KONTROLÜ ====================
local function IsVisible(targetPart)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local exclude = {targetPart.Parent}
    if LocalPlayer.Character then table.insert(exclude, LocalPlayer.Character) end
    params.FilterDescendantsInstances = exclude
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin)
    local result = workspace:Raycast(origin, direction, params)
    return result == nil
end

-- ==================== HİLE MOTORU ====================
-- Hedef parta göre doğru bone'u döndürür
local function GetTargetPart(character)
    local partName = _G.AimbotTarget or "Head"
    -- Ayak için LeftFoot veya HumanoidRootPart alt kısım
    if partName == "LeftFoot" then
        return character:FindFirstChild("LeftFoot")
            or character:FindFirstChild("Left Leg")
            or character:FindFirstChild("HumanoidRootPart")
    elseif partName == "UpperTorso" then
        return character:FindFirstChild("UpperTorso")
            or character:FindFirstChild("Torso")
            or character:FindFirstChild("HumanoidRootPart")
    else
        return character:FindFirstChild("Head")
    end
end

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
        if mag < fov and mag < dist then target = v; dist = mag end
    end
    return target
end

-- ==================== HEALTH BAR ====================
local function GetHealthColor(pct)
    if pct > 0.6 then
        local t = (1 - pct) / 0.4
        return Color3.fromRGB(math.floor(40 + t*215), math.floor(220 - t*20), 40)
    else
        local t = (0.6 - pct) / 0.6
        return Color3.fromRGB(math.floor(220 + t*10), math.floor(200 - t*200), 0)
    end
end

local function UpdateHealthBar(character, humanoid)
    if not character:FindFirstChild("HumanoidRootPart") then return end
    local bar = character:FindFirstChild("RedaxHBar")
    if not bar then
        bar = Instance.new("BillboardGui", character)
        bar.Name          = "RedaxHBar"
        bar.Size          = UDim2.new(0, 3, 0, 28)   -- çok ince & kısa çubuk
        bar.StudsOffset   = Vector3.new(-1.2, 0, 0)  -- karakterin hemen yanı
        bar.AlwaysOnTop   = true
        bar.LightInfluence= 0

        local bg = Instance.new("Frame", bar)
        bg.Name                 = "BG"
        bg.Size                 = UDim2.new(1, 0, 1, 0)
        bg.BackgroundColor3     = Color3.fromRGB(15, 15, 15)
        bg.BackgroundTransparency = 0.35
        bg.BorderSizePixel      = 0
        Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)

        local fill = Instance.new("Frame", bg)
        fill.Name           = "Fill"
        fill.AnchorPoint    = Vector2.new(0, 1)
        fill.Position       = UDim2.new(0, 0, 1, 0)
        fill.Size           = UDim2.new(1, 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(0, 220, 90)
        fill.BorderSizePixel  = 0
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    end

    local pct  = math.clamp(humanoid.Health / math.max(humanoid.MaxHealth, 1), 0, 1)
    local fill = bar:FindFirstChild("BG") and bar.BG:FindFirstChild("Fill")
    if fill then
        fill.Size             = UDim2.new(1, 0, pct, 0)
        fill.BackgroundColor3 = GetHealthColor(pct)
    end
end

-- ==================== FOV — SİLAH DEĞİŞİMİNDE SABİT TUT ====================
-- CB silah değiştiğinde kamera FOV'unu sıfırlayabilir; bunu önlemek için
-- kamera özellik değişimini dinleyip anında geri yazıyoruz.
Camera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
    if Camera.FieldOfView ~= _G.CameraFOV then
        Camera.FieldOfView = _G.CameraFOV
    end
end)

RunService.RenderStepped:Connect(function()
    -- FOV DAİRESİ
    FOVCircle.Radius   = _G.AimbotFOV
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    FOVCircle.Visible  = _G.AimbotEnabled

    -- AIMBOT
    if _G.AimbotEnabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local t = GetClosest()
        if t and t.Character then
            local aimPart = GetTargetPart(t.Character)
            if aimPart then
                local targetCF = CFrame.new(Camera.CFrame.Position, aimPart.Position)
                Camera.CFrame  = Camera.CFrame:Lerp(targetCF, 1 / math.max(1, _G.AimbotSmooth))
            end
        end
    end

    -- ESP
    if _G.EspEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p == LocalPlayer then continue end
            if not p.Character then continue end
            local isTeammate = p.Team == LocalPlayer.Team
            if isTeammate and not _G.TeamEsp then
                if p.Character:FindFirstChild("RedaxESP") then p.Character.RedaxESP:Destroy() end
                if p.Character:FindFirstChild("RedaxHBar") then p.Character.RedaxHBar:Destroy() end
                continue
            end
            local visible = p.Character:FindFirstChild("Head") and IsVisible(p.Character.Head)
            local clr
            if isTeammate then clr = C.EspGreen
            elseif visible then clr = C.EspRed
            else clr = C.EspYellow end

            -- Highlight
            local esp = p.Character:FindFirstChild("RedaxESP")
            if not esp then esp = Instance.new("Highlight", p.Character); esp.Name = "RedaxESP" end
            esp.FillColor         = clr
            esp.FillTransparency  = 0.65
            esp.OutlineColor      = clr
            esp.OutlineTransparency = 0
            if isTeammate then
                esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            elseif visible then
                esp.DepthMode = Enum.HighlightDepthMode.Occluded
            else
                esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end

            -- Can barı
            if _G.HealthBarEnabled then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hum then UpdateHealthBar(p.Character, hum) end
            else
                local hb = p.Character:FindFirstChild("RedaxHBar")
                if hb then hb:Destroy() end
            end
        end
    else
        -- ESP kapalı — temizle
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                if p.Character:FindFirstChild("RedaxESP") then p.Character.RedaxESP:Destroy() end
                if p.Character:FindFirstChild("RedaxHBar") then p.Character.RedaxHBar:Destroy() end
            end
        end
    end

    -- WALK SPEED
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
            TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -380, 0.5, -250)}):Play()
        else
            TweenService:Create(Main, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -380, 1.6, 0)}):Play()
        end
        FOVCircle.Visible = isOpen and _G.AimbotEnabled
    end
end)
