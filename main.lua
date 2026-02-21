-- [[ REDAXHACK v12.0 - FULL & STABLE ]] --
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Eski GUI'yi Temizle
if CoreGui:FindFirstChild("RedaxUltimate") then CoreGui.RedaxUltimate:Destroy() end

-- [ AYARLAR ]
_G.AimbotEnabled = false
_G.AimbotFOV = 100
_G.EspEnabled = false
_G.TeamCheck = false

-- [ FOV ÇİZİMİ ]
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.fromRGB(255, 0, 0)
FOVCircle.Visible = false

-- [ ANA EKRAN ]
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "RedaxUltimate"
ScreenGui.ResetOnSpawn = false

-- [1] INTRO ANIMASYONU KATMANI
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundTransparency = 1

local Logo = Instance.new("ImageLabel", IntroFrame)
Logo.Size = UDim2.new(0, 100, 0, 100)
Logo.Position = UDim2.new(0.5, -50, 0.5, -50)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://6034289557" -- Seçtiğim Kırmızı Premium Logo
Logo.ImageColor3 = Color3.fromRGB(255, 0, 0)
Logo.ImageTransparency = 1

local IntroText = Instance.new("TextLabel", IntroFrame)
IntroText.Text = "RedaxHack"
IntroText.Font = Enum.Font.GothamBold
IntroText.TextSize = 80
IntroText.TextColor3 = Color3.fromRGB(255, 0, 0)
IntroText.Size = UDim2.new(0, 400, 0, 100)
IntroText.Position = UDim2.new(0.5, 20, 0.5, -55)
IntroText.BackgroundTransparency = 1
IntroText.TextTransparency = 1
IntroText.TextXAlignment = Enum.TextXAlignment.Left

local IntroSub = Instance.new("TextLabel", IntroFrame)
IntroSub.Text = "by HzFewarr"
IntroSub.Font = Enum.Font.Gotham
IntroSub.TextSize = 30
IntroSub.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroSub.Size = UDim2.new(0, 400, 0, 30)
IntroSub.Position = UDim2.new(0.5, 25, 0.5, 20)
IntroSub.BackgroundTransparency = 1
IntroSub.TextTransparency = 1
IntroSub.TextXAlignment = Enum.TextXAlignment.Left

-- [2] ANA MENÜ YAPISI
local Main = Instance.new("Frame", ScreenGui)
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 680, 0, 480)
Main.Position = UDim2.new(0.5, -340, 1.5, 0) -- Başta ekranın altında
Main.BackgroundColor3 = Color3.fromRGB(13, 13, 15)
Main.BorderSizePixel = 0
Main.Visible = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local SideBar = Instance.new("Frame", Main)
SideBar.Size = UDim2.new(0, 170, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Instance.new("UICorner", SideBar).CornerRadius = UDim.new(0, 10)

local MainTitle = Instance.new("TextLabel", SideBar)
MainTitle.Size = UDim2.new(1, 0, 0, 80)
MainTitle.Text = "REDAXHACK"
MainTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 24
MainTitle.BackgroundTransparency = 1

local ContentArea = Instance.new("Frame", Main)
ContentArea.Position = UDim2.new(0, 185, 0, 20)
ContentArea.Size = UDim2.new(1, -205, 1, -40)
ContentArea.BackgroundTransparency = 1

-- [3] SAYFA & BİLEŞEN SİSTEMİ
local Pages = {}
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame", ContentArea)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 0
    Page.CanvasSize = UDim2.new(0, 0, 2, 0)
    local List = Instance.new("UIListLayout", Page)
    List.Padding = UDim.new(0, 10)
    Pages[name] = Page
    return Page
end

local function AddToggle(parent, text, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, -10, 0, 45)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel", Frame)
    Label.Text = "  " .. text
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local ToggleBtn = Instance.new("TextButton", Frame)
    ToggleBtn.Size = UDim2.new(0, 45, 0, 22)
    ToggleBtn.Position = UDim2.new(1, -55, 0.5, -11)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    ToggleBtn.Text = ""
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

    local Ball = Instance.new("Frame", ToggleBtn)
    Ball.Size = UDim2.new(0, 18, 0, 18)
    Ball.Position = UDim2.new(0, 2, 0.5, -9)
    Ball.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Ball).CornerRadius = UDim.new(1, 0)

    local state = false
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(Ball, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}):Play()
        TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(40, 40, 45)}):Play()
        callback(state)
    end)
end

local function AddSlider(parent, text, min, max, default, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.Size = UDim2.new(1, -10, 0, 65)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel", Frame)
    Label.Text = "  " .. text .. ": " .. default
    Label.Size = UDim2.new(1, 0, 0, 35)
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1

    local Bar = Instance.new("Frame", Frame)
    Bar.Size = UDim2.new(1, -40, 0, 4)
    Bar.Position = UDim2.new(0, 20, 0, 48)
    Bar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)

    local Fill = Instance.new("Frame", Bar)
    Fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

    local Btn = Instance.new("TextButton", Bar)
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""

    Btn.MouseButton1Down:Connect(function()
        local MoveConn
        MoveConn = RunService.RenderStepped:Connect(function()
            local RelativePos = math.clamp((UserInputService:GetMouseLocation().X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
            local Value = math.floor(min + (max - min) * RelativePos)
            Fill.Size = UDim2.new(RelativePos, 0, 1, 0)
            Label.Text = "  " .. text .. ": " .. Value
            callback(Value)
        end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then MoveConn:Disconnect() end end)
    end)
end

-- Sayfa İçeriklerini Ekle
local CombatPage = CreatePage("Combat")
local VisualsPage = CreatePage("Visuals")

AddToggle(CombatPage, "Aimbot Enable", function(v) _G.AimbotEnabled = v end)
AddSlider(CombatPage, "Aimbot FOV", 0, 800, 100, function(v) _G.AimbotFOV = v end)
AddToggle(CombatPage, "Team Check", function(v) _G.TeamCheck = v end)
AddToggle(VisualsPage, "ESP (Highlight) Enable", function(v) _G.EspEnabled = v end)

-- Kategori Butonları
local function AddTab(name, order)
    local Btn = Instance.new("TextButton", SideBar)
    Btn.Size = UDim2.new(1, -20, 0, 40)
    Btn.Position = UDim2.new(0, 10, 0, 100 + (order * 45))
    Btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextSize = 15
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(SideBar:GetChildren()) do if b:IsA("TextButton") then b.BackgroundTransparency = 1 b.TextColor3 = Color3.fromRGB(150,150,150) end end
        Pages[name].Visible = true
        Btn.BackgroundTransparency = 0.9
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
end

AddTab("Combat", 0)
AddTab("Visuals", 1)
Pages.Combat.Visible = true

-- [4] GÜÇLENDİRİLMİŞ INTRO VE MENÜ AKIŞI
task.spawn(function()
    -- Logo Belirme
    TweenService:Create(Logo, TweenInfo.new(1), {ImageTransparency = 0}):Play()
    task.wait(1.2)
    
    -- Logo Sola, Yazı Sağa
    TweenService:Create(Logo, TweenInfo.new(0.8, Enum.EasingStyle.Quart), {Position = UDim2.new(0.5, -220, 0.5, -50)}):Play()
    task.wait(0.2)
    TweenService:Create(IntroText, TweenInfo.new(0.8), {TextTransparency = 0, Position = UDim2.new(0.5, -80, 0.5, -55)}):Play()
    task.wait(0.4)
    TweenService:Create(IntroSub, TweenInfo.new(0.8), {TextTransparency = 0, Position = UDim2.new(0.5, -75, 0.5, 20)}):Play()
    
    task.wait(3) -- Ekranda kalma süresi
    
    -- Intro Kapanış
    TweenService:Create(Logo, TweenInfo.new(0.6), {ImageTransparency = 1}):Play()
    TweenService:Create(IntroText, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TweenService:Create(IntroSub, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    task.wait(0.7)
    
    -- MENÜ GELİŞİ
    Main:TweenPosition(UDim2.new(0.5, -340, 0.5, -240), "Out", "Quart", 1, true)
end)

-- [5] HİLE MOTORU (Aimbot & ESP)
local function GetClosest()
    local target, dist = nil, math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Character.Humanoid.Health > 0 then
            if _G.TeamCheck and v.Team == LocalPlayer.Team then continue end
            local pos, screen = Camera:WorldToViewportPoint(v.Character.Head.Position)
            if screen then
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if mag < _G.AimbotFOV and mag < dist then target = v dist = mag end
            end
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
        if t then Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Character.Head.Position) end
    end
    
    if _G.EspEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                if not p.Character:FindFirstChild("RedaxESP") then
                    local h = Instance.new("Highlight", p.Character)
                    h.Name = "RedaxESP"
                    h.FillColor = Color3.fromRGB(255, 0, 0)
                end
            end
        end
    else
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("RedaxESP") then p.Character.RedaxESP:Destroy() end
        end
    end
end)

-- INSERT Aç/Kapat
local isOpen = true
UserInputService.InputBegan:Connect(function(i) 
    if i.KeyCode == Enum.KeyCode.Insert then 
        isOpen = not isOpen
        Main:TweenPosition(isOpen and UDim2.new(0.5, -340, 0.5, -240) or UDim2.new(0.5, -340, 1.5, 0), "Out", "Quart", 0.6, true)
    end 
end)
