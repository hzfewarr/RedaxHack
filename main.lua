--[[
██████╗ ███████╗██████╗  █████╗ ██╗  ██╗██╗  ██╗ █████╗  ██████╗██╗  ██╗
██╔══██╗██╔════╝██╔══██╗██╔══██╗╚██╗██╔╝██║  ██║██╔══██╗██╔════╝██║ ██╔╝
██████╔╝█████╗  ██║  ██║███████║ ╚███╔╝ ███████║███████║██║     █████╔╝
██╔══██╗██╔══╝  ██║  ██║██╔══██║ ██╔██╗ ██╔══██║██╔══██║██║     ██╔═██╗
██║  ██║███████╗██████╔╝██║  ██║██╔╝ ██╗██║  ██║██║  ██║╚██████╗██║  ██╗
╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
                    RedaxHACK v1.0 BETA — Universal
           Delta / Solara / Fluxus / Synapse X / KRNL Compatible
--]]

local ExecutorName = "Unknown"
pcall(function()
    if syn then ExecutorName = "Synapse X"
    elseif KRNL_LOADED then ExecutorName = "KRNL"
    elseif fluxus then ExecutorName = "Fluxus"
    elseif Delta then ExecutorName = "Delta"
    elseif solara then ExecutorName = "Solara"
    elseif getexecutorname then
        local ok, n = pcall(getexecutorname); if ok then ExecutorName = n end
    end
end)

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService      = game:GetService("HttpService")
local Lighting         = game:GetService("Lighting")
local Workspace        = game:GetService("Workspace")
local VirtualUser      = game:GetService("VirtualUser")
local TeleportSvc      = game:GetService("TeleportService")

local LP    = Players.LocalPlayer
local Mouse = LP:GetMouse()

local function CAM() return Workspace.CurrentCamera end

local GameID   = game.PlaceId
local GameName = ({
    [292439477]   = "Jailbreak",      [6872265039]  = "Blox Fruits",
    [3233893879]  = "Tower of Hell",  [13822889]    = "Arsenal",
    [189700877]   = "Phantom Forces", [2788229376]  = "Bad Business",
    [3260590327]  = "Murder Mystery 2",[1962086868]  = "Brookhaven",
    [606849621]   = "MeepCity",       [17017769292] = "Rivals",
})[GameID] or "Universal"

local CFG_FOLDER = "RedaxHACK"
local CFG_FILE   = CFG_FOLDER.."/config.json"

local function EnsureDir()
    if isfolder and not isfolder(CFG_FOLDER) then
        if makefolder then makefolder(CFG_FOLDER) end
    end
end

local DEFAULT = {
    Aimbot=false, AimbotFOV=120, AimbotShowFOV=true,
    AimbotPart="Head", AimbotSmooth=5, AimbotKey="RMB",
    Prediction=false, PredictionMs=120,
    TeamCheck=true, WallCheck=false,
    Triggerbot=false, TrigDelay=80, HitChance=100,
    HitboxExpander=false, HitboxSize=8,
    NameESP=false, HealthESP=false, DistESP=false,
    WeaponESP=false,
    TracerESP=false, TracerOrigin="Bottom",
    HeadDot=false,
    SkeletonESP=false,
    Chams=false, ChamsAlpha=60,
    ChamsTeamMode=true,
    ChamsR=255, ChamsG=50, ChamsB=50,
    ChamsAllyAlpha=70,
    Speed=false, WalkSpeed=16,
    Fly=false, FlySpeed=60,
    Noclip=false, InfJump=false,
    BHop=false, HighJump=false, JumpPow=80, LongJump=false,
    GodMode=false, AntiVoid=false, AntiAFK=false, AntiRagdoll=false,
    Fullbright=false, NoFog=false, NoShadows=false,
    Gravity=196.2, ClockTime=12, TimeFreeze=false, NoWeather=false,
    ChatSpam=false, ChatMsg="Hello!", ChatDelay=3,
    FPSBoost=false, ShowFPS=false,
}

local C = {}
for k,v in pairs(DEFAULT) do C[k]=v end

local function SaveConfig()
    EnsureDir()
    if writefile then pcall(function() writefile(CFG_FILE, HttpService:JSONEncode(C)) end) end
end
local function LoadConfig()
    EnsureDir()
    if readfile and isfile and isfile(CFG_FILE) then
        local ok,d = pcall(function() return HttpService:JSONDecode(readfile(CFG_FILE)) end)
        if ok and type(d)=="table" then
            for k,v in pairs(d) do if DEFAULT[k]~=nil then C[k]=v end end
        end
    end
end
LoadConfig()

local function CHAR()  return LP.Character end
local function HRPF()
    local c=CHAR(); return c and c:FindFirstChild("HumanoidRootPart")
end
local function HUMF()
    local c=CHAR(); return c and c:FindFirstChildOfClass("Humanoid")
end

local function W2S(pos)
    local ok, sp = pcall(function() return CAM():WorldToViewportPoint(pos) end)
    if not ok then return Vector2.zero, false, -1 end
    return Vector2.new(sp.X, sp.Y), sp.Z > 0, sp.Z
end

local function SCRCTR()
    local vp = CAM().ViewportSize
    return Vector2.new(vp.X/2, vp.Y/2)
end

local function SameTeam(p)
    if not C.TeamCheck then return false end
    return p.Team ~= nil and p.Team == LP.Team
end

local function HasLoS(from, to)
    local dir = to - from
    local rp  = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude
    rp.FilterDescendantsInstances = {CHAR() or Instance.new("Folder")}
    local res = Workspace:Raycast(from, dir, rp)
    if not res then return true end
    for _, pl in ipairs(Players:GetPlayers()) do
        if pl ~= LP and pl.Character and res.Instance:IsDescendantOf(pl.Character) then
            return true
        end
    end
    return false
end

local function ValidTarget(p)
    if p == LP then return false end
    if SameTeam(p) then return false end
    local ch  = p.Character; if not ch then return false end
    local hrp = ch:FindFirstChild("HumanoidRootPart")
    local hum = ch:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return false end
    if hum.Health <= 0 then return false end
    local state = hum:GetState()
    if state == Enum.HumanoidStateType.Dead then return false end
    return true, ch, hrp, hum
end

local function Closest(fovR, useLoS)
    local ctr   = SCRCTR()
    local best, bDist, bCh, bHRP, bHum = nil, fovR
    for _, p in ipairs(Players:GetPlayers()) do
        local ok, ch, hrp, hum = ValidTarget(p)
        if not ok then continue end
        if useLoS and not C.WallCheck then
            if not HasLoS(CAM().CFrame.Position, hrp.Position) then continue end
        end
        local sp, vis = W2S(hrp.Position)
        if not vis then continue end
        local d = (sp - ctr).Magnitude
        if d < bDist then
            bDist=d; best=p; bCh=ch; bHRP=hrp; bHum=hum
        end
    end
    return best, bCh, bHRP, bHum
end

local function AimPart(ch, name)
    if not ch then return nil end
    local map = {
        Head="Head",UpperTorso={"UpperTorso","Torso"},
        HumanoidRootPart="HumanoidRootPart",LowerTorso={"LowerTorso","Torso"},
    }
    local v = map[name]
    if type(v)=="table" then
        for _,n in ipairs(v) do local p=ch:FindFirstChild(n); if p then return p end end
    elseif type(v)=="string" then
        local p=ch:FindFirstChild(v); if p then return p end
    end
    return ch:FindFirstChild("Head") or ch:FindFirstChild("HumanoidRootPart")
end

local function GetWeapon(p)
    local ch = p.Character
    if not ch then return "" end
    for _, obj in ipairs(ch:GetChildren()) do
        if obj:IsA("Tool") then return "🔫 "..obj.Name end
    end
    local bp = p:FindFirstChild("Backpack")
    if bp then
        for _, obj in ipairs(bp:GetChildren()) do
            if obj:IsA("Tool") then return "🎒 "..obj.Name end
        end
    end
    local hrp = ch:FindFirstChild("HumanoidRootPart")
    if hrp then
        local cw = hrp:FindFirstChild("CurrentWeapon") or hrp:FindFirstChild("Weapon")
        if cw and (cw:IsA("StringValue") or cw:IsA("ObjectValue")) then
            local val = cw.Value
            if type(val) == "string" and val ~= "" then return "🔫 "..val end
            if type(val) == "userdata" and val and val.Name then return "🔫 "..val.Name end
        end
    end
    return ""
end

local ABCirc = Drawing.new("Circle")
ABCirc.Filled=false; ABCirc.Thickness=1.5
ABCirc.Color=Color3.fromRGB(0,200,255); ABCirc.Visible=false

RunService.RenderStepped:Connect(function()
    local c = SCRCTR()
    ABCirc.Position=c; ABCirc.Radius=C.AimbotFOV
    ABCirc.Visible = C.Aimbot and C.AimbotShowFOV
end)


-- ══════════════════════════════════════════════════════
--  AIMBOT
-- ══════════════════════════════════════════════════════
RunService.RenderStepped:Connect(function()
    if not C.Aimbot then return end
    local holding = C.AimbotKey=="RMB" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
        or C.AimbotKey=="LMB" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
        or C.AimbotKey=="E"   and UserInputService:IsKeyDown(Enum.KeyCode.E)
    if not holding then return end

    local _, ch, hrp = Closest(C.AimbotFOV, true)
    if not ch or not hrp then return end
    local part = AimPart(ch, C.AimbotPart)
    if not part then return end

    local tPos = part.Position
    if C.Prediction then
        local ok, vel = pcall(function() return hrp.AssemblyLinearVelocity end)
        if ok and vel then
            local ping=0; pcall(function()
                ping=game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
            end)
            tPos = tPos + vel * ((C.PredictionMs + ping)/1000)
        end
    end
    local alpha = 1 - (C.AimbotSmooth-1)/10
    alpha = math.clamp(alpha, 0.05, 1)
    local cam = CAM()
    cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, tPos), alpha)
end)

-- ══════════════════════════════════════════════════════
--  TRIGGERBOT
-- ══════════════════════════════════════════════════════
local lastTrig = 0
RunService.Heartbeat:Connect(function()
    if not C.Triggerbot then return end
    if tick()-lastTrig < C.TrigDelay/1000 then return end
    local cam = CAM()
    local rp  = RaycastParams.new()
    rp.FilterType = Enum.RaycastFilterType.Exclude
    rp.FilterDescendantsInstances = {CHAR() or Instance.new("Folder")}
    local res = Workspace:Raycast(cam.CFrame.Position, cam.CFrame.LookVector*2000, rp)
    if not res then return end
    local hp = Players:GetPlayerFromCharacter(res.Instance.Parent)
    if not hp or hp==LP then return end
    if SameTeam(hp) then return end
    local hum = hp.Character and hp.Character:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health<=0 then return end
    if math.random(1,100) > C.HitChance then return end
    lastTrig = tick()
    local chr=CHAR(); if not chr then return end
    for _,tool in ipairs(chr:GetChildren()) do
        if tool:IsA("Tool") then
            pcall(function()
                local re = tool:FindFirstChildOfClass("RemoteEvent")
                if re then re:FireServer() end
            end)
        end
    end
end)

-- ══════════════════════════════════════════════════════
--  HITBOX EXPANDER
-- ══════════════════════════════════════════════════════
local OrigSizes   = {}
local HBConnections = {}

local HB_PARTS = {
    "Head","UpperTorso","LowerTorso","HumanoidRootPart",
    "LeftUpperArm","RightUpperArm","LeftLowerArm","RightLowerArm",
    "LeftHand","RightHand",
    "LeftUpperLeg","RightUpperLeg","LeftLowerLeg","RightLowerLeg",
    "LeftFoot","RightFoot",
    "Torso","Left Arm","Right Arm","Left Leg","Right Leg",
}

local function ExpandChar(ch)
    if not ch then return end
    for _, pname in ipairs(HB_PARTS) do
        local part = ch:FindFirstChild(pname)
        if part and part:IsA("BasePart") and not part:IsA("UnionOperation") then
            if not OrigSizes[part] then
                OrigSizes[part] = part.Size
            end
            part.Size = Vector3.new(C.HitboxSize, C.HitboxSize, C.HitboxSize)
        end
    end
end

local function RestoreChar(ch)
    if not ch then return end
    for _, pname in ipairs(HB_PARTS) do
        local part = ch:FindFirstChild(pname)
        if part and OrigSizes[part] then
            pcall(function() part.Size = OrigSizes[part] end)
            OrigSizes[part] = nil
        end
    end
end

local function SetupHitboxForPlayer(p)
    if p == LP then return end
    if HBConnections[p] then
        for _, conn in ipairs(HBConnections[p]) do conn:Disconnect() end
    end
    HBConnections[p] = {}
    if p.Character then
        if C.HitboxExpander then ExpandChar(p.Character) end
    end
    local conn1 = p.CharacterAdded:Connect(function(ch)
        task.wait(0.1)
        if C.HitboxExpander then ExpandChar(ch) end
    end)
    local conn2 = p.CharacterRemoving:Connect(function(ch)
        RestoreChar(ch)
    end)
    table.insert(HBConnections[p], conn1)
    table.insert(HBConnections[p], conn2)
end

local function SetupAllHitboxes()
    for _, p in ipairs(Players:GetPlayers()) do SetupHitboxForPlayer(p) end
end

Players.PlayerAdded:Connect(SetupHitboxForPlayer)
Players.PlayerRemoving:Connect(function(p)
    if HBConnections[p] then
        for _, conn in ipairs(HBConnections[p]) do conn:Disconnect() end
        HBConnections[p] = nil
    end
end)

RunService.Heartbeat:Connect(function()
    if not C.HitboxExpander then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            ExpandChar(p.Character)
        end
    end
end)

local function RestoreAllHitboxes()
    for part, sz in pairs(OrigSizes) do
        pcall(function() if part and part.Parent then part.Size = sz end end)
    end
    OrigSizes = {}
end

-- ══════════════════════════════════════════════════════
--  ESP — FRESH DRAW
-- ══════════════════════════════════════════════════════
local _frameDrawings = {}

local function FD(t, props)
    local d = Drawing.new(t)
    for k, v in pairs(props) do d[k] = v end
    d.Visible = true
    table.insert(_frameDrawings, d)
    return d
end

local function ClearFrame()
    for i = #_frameDrawings, 1, -1 do
        pcall(function() _frameDrawings[i]:Remove() end)
        _frameDrawings[i] = nil
    end
end

-- ══════════════════════════════════════════════════════
--  CHAMS
-- ══════════════════════════════════════════════════════
local ChamsHL = {}

local function IsAlly(p)
    return p.Team ~= nil and p.Team == LP.Team
end

local function GetOrCreateHL(ch, name, depthMode)
    local hl = ch:FindFirstChild(name)
    if not hl or not hl:IsA("Highlight") then
        if hl then pcall(function() hl:Destroy() end) end
        hl = Instance.new("Highlight")
        hl.Name = name
        hl.Adornee = ch
        hl.DepthMode = depthMode
        hl.Parent = ch
    end
    return hl
end

local function ApplyChams(p)
    if not C.Chams then return end
    local ch = p.Character
    if not ch or not ch.Parent then return end

    if C.ChamsTeamMode then
        local ally = IsAlly(p)
        if ally then
            local hlW = GetOrCreateHL(ch, "_RDXHl_W", Enum.HighlightDepthMode.AlwaysOnTop)
            hlW.FillColor           = Color3.fromRGB(0, 255, 80)
            hlW.FillTransparency    = math.clamp(C.ChamsAllyAlpha / 100, 0, 1)
            hlW.OutlineColor        = Color3.fromRGB(0, 255, 80)
            hlW.OutlineTransparency = 0.3
            hlW.Enabled             = true
            local old = ch:FindFirstChild("_RDXHl_N")
            if old then pcall(function() old.Enabled = false end) end
        else
            local hlW = GetOrCreateHL(ch, "_RDXHl_W", Enum.HighlightDepthMode.AlwaysOnTop)
            hlW.FillColor           = Color3.fromRGB(255, 210, 0)
            hlW.FillTransparency    = math.clamp(C.ChamsAlpha / 100, 0, 1)
            hlW.OutlineColor        = Color3.fromRGB(255, 210, 0)
            hlW.OutlineTransparency = 0
            hlW.Enabled             = true
            local hlN = GetOrCreateHL(ch, "_RDXHl_N", Enum.HighlightDepthMode.Occluded)
            hlN.FillColor           = Color3.fromRGB(255, 40, 40)
            hlN.FillTransparency    = math.clamp(C.ChamsAlpha / 100, 0, 1)
            hlN.OutlineColor        = Color3.fromRGB(255, 40, 40)
            hlN.OutlineTransparency = 0
            hlN.Enabled             = true
        end
    else
        local hlW = GetOrCreateHL(ch, "_RDXHl_W", Enum.HighlightDepthMode.AlwaysOnTop)
        local r,g,b = C.ChamsR/255, C.ChamsG/255, C.ChamsB/255
        hlW.FillColor           = Color3.new(r,g,b)
        hlW.FillTransparency    = math.clamp(C.ChamsAlpha / 100, 0, 1)
        hlW.OutlineColor        = Color3.new(r,g,b)
        hlW.OutlineTransparency = 0
        hlW.Enabled             = true
        local old = ch:FindFirstChild("_RDXHl_N")
        if old then pcall(function() old.Enabled = false end) end
    end
end

local function RemoveChams(p)
    local cache = ChamsHL[p]
    if cache then
        pcall(function() if cache.W then cache.W:Destroy() end end)
        pcall(function() if cache.N then cache.N:Destroy() end end)
        ChamsHL[p] = nil
    end
    if p.Character then
        for _, obj in ipairs(p.Character:GetChildren()) do
            if obj:IsA("Highlight") and (obj.Name=="_RDXHl_W" or obj.Name=="_RDXHl_N") then
                pcall(function() obj:Destroy() end)
            end
        end
    end
end

local function OnCharacterAdded_Chams(p)
    ChamsHL[p] = nil
end

-- ══════════════════════════════════════════════════════
--  OYUNCU SETUP
-- ══════════════════════════════════════════════════════
local function SetupPlayer(p)
    if p == LP then return end
    p.CharacterAdded:Connect(function(ch)
        OnCharacterAdded_Chams(p)
        task.wait(0.15)
        if C.HitboxExpander then
            task.wait(0.1)
            ExpandChar(ch)
        end
    end)
    p.CharacterRemoving:Connect(function(ch)
        RemoveChams(p)
        RestoreChar(ch)
    end)
end

Players.PlayerAdded:Connect(SetupPlayer)
Players.PlayerRemoving:Connect(function(p)
    RemoveChams(p)
    if HBConnections[p] then
        for _, conn in ipairs(HBConnections[p]) do conn:Disconnect() end
        HBConnections[p] = nil
    end
end)
for _, p in ipairs(Players:GetPlayers()) do
    SetupPlayer(p)
    SetupHitboxForPlayer(p)
end

-- ══════════════════════════════════════════════════════
--  ANA ESP RENDER DÖNGÜSÜ
-- ══════════════════════════════════════════════════════
local SK_JOINTS = {
    {"Head","UpperTorso"},{"Head","Torso"},
    {"UpperTorso","LowerTorso"},
    {"UpperTorso","LeftUpperArm"},{"Torso","Left Arm"},
    {"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},
    {"UpperTorso","RightUpperArm"},{"Torso","Right Arm"},
    {"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},
    {"LowerTorso","LeftUpperLeg"},{"Torso","Left Leg"},
    {"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},
    {"LowerTorso","RightUpperLeg"},{"Torso","Right Leg"},
    {"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"},
}

RunService.RenderStepped:Connect(function()
    ClearFrame()

    local anyOn = C.NameESP or C.HealthESP or C.DistESP
        or C.TracerESP or C.HeadDot or C.WeaponESP or C.SkeletonESP

    for _, pl in ipairs(Players:GetPlayers()) do
        if pl == LP then continue end
        local ch  = pl.Character
        if not ch or not ch.Parent then RemoveChams(pl); continue end
        local hrp = ch:FindFirstChild("HumanoidRootPart")
        local hum = ch:FindFirstChildOfClass("Humanoid")
        if not hrp or hrp.Parent ~= ch then RemoveChams(pl); continue end
        if not hum or hum.Health <= 0  then RemoveChams(pl); continue end
        if hum:GetState() == Enum.HumanoidStateType.Dead then RemoveChams(pl); continue end
        if C.Chams then ApplyChams(pl) else RemoveChams(pl) end
    end

    if not anyOn then return end

    local vp    = CAM().ViewportSize
    local myHRP = HRPF()
    local col   = Color3.fromRGB(255, 50, 50)

    for _, pl in ipairs(Players:GetPlayers()) do
        if pl == LP then continue end
        local ch = pl.Character
        if not ch or not ch.Parent then continue end
        local hrp = ch:FindFirstChild("HumanoidRootPart")
        if not hrp or hrp.Parent ~= ch then continue end
        local hum = ch:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        if hum:GetState() == Enum.HumanoidStateType.Dead then continue end

        local head    = ch:FindFirstChild("Head")
        local headPos = head and (head.Position + Vector3.new(0, 0.6, 0))
                        or (hrp.Position + Vector3.new(0, 2.8, 0))
        local feetPos = hrp.Position - Vector3.new(0, 3.1, 0)

        local hSP, _, hZ = W2S(headPos)
        local fSP, _, fZ = W2S(feetPos)

        if hZ <= 0 and fZ <= 0 then continue end

        local M = 400
        local onScr = (hSP.X > -M and hSP.X < vp.X+M and hSP.Y > -M and hSP.Y < vp.Y+M)
                   or (fSP.X > -M and fSP.X < vp.X+M and fSP.Y > -M and fSP.Y < vp.Y+M)
        if not onScr then continue end

        local bH = math.max(math.abs(hSP.Y - fSP.Y), 8)
        local bW = bH * 0.56
        local cx = fSP.X

        if C.WeaponESP then
            local wpn = GetWeapon(pl)
            if wpn ~= "" then
                FD("Text", {Text=wpn, Size=11, Center=true, Outline=true,
                    Color=Color3.fromRGB(255,220,50), OutlineColor=Color3.fromRGB(0,0,0),
                    Font=Drawing.Fonts.UI, Position=Vector2.new(cx, hSP.Y - 30)})
            end
        end

        if C.NameESP then
            FD("Text", {Text=pl.Name, Size=13, Center=true, Outline=true,
                Color=Color3.fromRGB(255,255,255), OutlineColor=Color3.fromRGB(0,0,0),
                Font=Drawing.Fonts.UI, Position=Vector2.new(cx, hSP.Y - 17)})
        end

        if C.HealthESP then
            local hp  = math.clamp(hum.Health / math.max(hum.MaxHealth,1), 0, 1)
            local hpR = math.floor((1-hp)*255)
            local hpG = math.floor(hp*255)
            local bx2  = cx - bW/2 - 7
            local byTop = hSP.Y
            local byBot = hSP.Y + bH
            FD("Line", {From=Vector2.new(bx2, byTop), To=Vector2.new(bx2, byBot),
                Thickness=5, Color=Color3.fromRGB(20,20,20)})
            FD("Line", {From=Vector2.new(bx2, byTop + bH*(1-hp)), To=Vector2.new(bx2, byBot),
                Thickness=3, Color=Color3.fromRGB(hpR, hpG, 0)})
            FD("Text", {Text=math.floor(hp*100).."%", Size=10, Center=true, Outline=true,
                Color=Color3.fromRGB(hpR, hpG, 0), OutlineColor=Color3.fromRGB(0,0,0),
                Font=Drawing.Fonts.Monospace, Position=Vector2.new(bx2-8, byTop + bH/2 - 6)})
        end

        if C.DistESP and myHRP then
            local d = math.floor((myHRP.Position - hrp.Position).Magnitude)
            FD("Text", {Text=d.." studs", Size=11, Center=true, Outline=true,
                Color=Color3.fromRGB(180,180,180), OutlineColor=Color3.fromRGB(0,0,0),
                Font=Drawing.Fonts.Monospace, Position=Vector2.new(cx, hSP.Y + bH + 4)})
        end

        if C.TracerESP then
            local ty = C.TracerOrigin=="Bottom" and vp.Y or C.TracerOrigin=="Middle" and vp.Y/2 or 0
            FD("Line", {From=Vector2.new(vp.X/2, ty), To=Vector2.new(fSP.X, fSP.Y),
                Thickness=1, Color=col})
        end

        if C.HeadDot then
            local hsp2, _, hz2 = W2S(headPos)
            if hz2 > 0 then
                FD("Circle", {Position=hsp2, Radius=math.max(bW*0.09, 2.5),
                    Filled=true, Color=col, Thickness=1})
            end
        end

        if C.SkeletonESP then
            local skColor = C.ChamsTeamMode
                and ((pl.Team ~= nil and pl.Team == LP.Team) and Color3.fromRGB(0,255,80) or Color3.fromRGB(255,210,0))
                or Color3.fromRGB(255,200,50)
            for _, jt in ipairs(SK_JOINTS) do
                local pA = ch:FindFirstChild(jt[1])
                local pB = ch:FindFirstChild(jt[2])
                if pA and pB then
                    local sA, _, zA = W2S(pA.Position)
                    local sB, _, zB = W2S(pB.Position)
                    if zA > 0 or zB > 0 then
                        FD("Line", {From=sA, To=sB, Thickness=1, Color=skColor})
                    end
                end
            end
        end
    end
end)

-- ══════════════════════════════════════════════════════
--  MOVEMENT
-- ══════════════════════════════════════════════════════
RunService.Heartbeat:Connect(function()
    local hum=HUMF(); if not hum then return end
    if C.Speed    then hum.WalkSpeed = C.WalkSpeed end
    if C.HighJump then hum.JumpPower = C.JumpPow   end
end)

UserInputService.JumpRequest:Connect(function()
    if not C.InfJump then return end
    local hum=HUMF(); if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

RunService.Heartbeat:Connect(function()
    if not C.BHop then return end
    local hum=HUMF()
    if hum and hum:GetState()==Enum.HumanoidStateType.Landed then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

RunService.Stepped:Connect(function()
    if not C.Noclip then return end
    local ch=CHAR(); if not ch then return end
    for _,p in ipairs(ch:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide=false end
    end
end)

UserInputService.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if C.LongJump and inp.KeyCode==Enum.KeyCode.Space then
        local hrp=HRPF(); if not hrp then return end
        local look=CAM().CFrame.LookVector
        hrp.Velocity = Vector3.new(look.X*80, 35, look.Z*80)
    end
end)

local FlyBV, FlyBG, FlyConn
local function KillFly()
    if FlyConn then FlyConn:Disconnect(); FlyConn=nil end
    if FlyBV and FlyBV.Parent then FlyBV:Destroy() end
    if FlyBG and FlyBG.Parent then FlyBG:Destroy() end
    FlyBV=nil; FlyBG=nil
    local hum=HUMF(); if hum then hum.PlatformStand=false end
end
local function StartFly()
    KillFly()
    local hrp=HRPF(); if not hrp then return end
    FlyBV=Instance.new("BodyVelocity"); FlyBV.MaxForce=Vector3.new(1e6,1e6,1e6)
    FlyBV.Velocity=Vector3.zero; FlyBV.Parent=hrp
    FlyBG=Instance.new("BodyGyro"); FlyBG.MaxTorque=Vector3.new(1e6,1e6,1e6)
    FlyBG.P=9e4; FlyBG.Parent=hrp
    local hum=HUMF(); if hum then hum.PlatformStand=true end
    FlyConn=RunService.Heartbeat:Connect(function()
        if not C.Fly then KillFly(); return end
        local hrp2=HRPF(); if not hrp2 then KillFly(); return end
        local d=Vector3.zero; local uis=UserInputService; local cam=CAM()
        if uis:IsKeyDown(Enum.KeyCode.W)         then d+=cam.CFrame.LookVector  end
        if uis:IsKeyDown(Enum.KeyCode.S)         then d-=cam.CFrame.LookVector  end
        if uis:IsKeyDown(Enum.KeyCode.A)         then d-=cam.CFrame.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.D)         then d+=cam.CFrame.RightVector end
        if uis:IsKeyDown(Enum.KeyCode.Space)     then d+=Vector3.new(0,1,0)     end
        if uis:IsKeyDown(Enum.KeyCode.LeftShift) then d-=Vector3.new(0,1,0)     end
        FlyBV.Velocity = d.Magnitude>0 and d.Unit*C.FlySpeed or Vector3.zero
        FlyBG.CFrame   = cam.CFrame
    end)
end

LP.CharacterAdded:Connect(function()
    task.wait(0.6)
    if C.Speed    then local h=HUMF(); if h then h.WalkSpeed=C.WalkSpeed end end
    if C.HighJump then local h=HUMF(); if h then h.JumpPower=C.JumpPow   end end
    if C.Fly      then task.wait(0.3); StartFly() end
    if C.AntiRagdoll then
        local ch=CHAR(); if ch then
            for _,v in ipairs(ch:GetDescendants()) do
                if v:IsA("BallSocketConstraint") or v:IsA("HingeConstraint") then v.Enabled=false end
            end
        end
    end
end)

-- ══════════════════════════════════════════════════════
--  PLAYER FEATURES
-- ══════════════════════════════════════════════════════
local GodConn
local function SetGodMode(v)
    C.GodMode=v
    if GodConn then GodConn:Disconnect(); GodConn=nil end
    if v then
        GodConn = RunService.Heartbeat:Connect(function()
            local hum=HUMF()
            if hum and hum.Health<hum.MaxHealth then hum.Health=hum.MaxHealth end
        end)
    end
end

RunService.Heartbeat:Connect(function()
    if not C.AntiVoid then return end
    local hrp=HRPF()
    if hrp and hrp.Position.Y < -350 then
        hrp.CFrame = CFrame.new(hrp.Position.X, 100, hrp.Position.Z)
    end
end)

LP.Idled:Connect(function()
    if C.AntiAFK then VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end
end)

RunService.Heartbeat:Connect(function()
    if not C.AntiRagdoll then return end
    local ch=CHAR(); if not ch then return end
    for _,v in ipairs(ch:GetDescendants()) do
        if v:IsA("BallSocketConstraint") or v:IsA("HingeConstraint") then v.Enabled=false end
    end
end)

-- ══════════════════════════════════════════════════════
--  WORLD
-- ══════════════════════════════════════════════════════
local OrigFE, OrigFS, OrigAmb, OrigBri, OrigOut

local function SetFullbright(v)
    C.Fullbright=v
    if v then
        OrigAmb=OrigAmb or Lighting.Ambient
        OrigBri=OrigBri or Lighting.Brightness
        OrigOut=OrigOut or Lighting.OutdoorAmbient
        Lighting.Ambient=Color3.fromRGB(255,255,255)
        Lighting.OutdoorAmbient=Color3.fromRGB(255,255,255)
        Lighting.Brightness=2
    else
        if OrigAmb then Lighting.Ambient=OrigAmb end
        if OrigBri then Lighting.Brightness=OrigBri end
        if OrigOut then Lighting.OutdoorAmbient=OrigOut end
    end
end

local function SetNoFog(v)
    C.NoFog=v
    if v then
        OrigFE=OrigFE or Lighting.FogEnd
        OrigFS=OrigFS or Lighting.FogStart
        Lighting.FogEnd=9e8; Lighting.FogStart=9e8
    else
        if OrigFE then Lighting.FogEnd=OrigFE end
        if OrigFS then Lighting.FogStart=OrigFS end
    end
end

local function SetNoShadows(v) C.NoShadows=v; Lighting.GlobalShadows=not v end
local function ApplyGravity()  Workspace.Gravity=C.Gravity end

local function SetNoWeather(v)
    C.NoWeather=v
    for _,o in ipairs(Lighting:GetChildren()) do
        if o:IsA("Atmosphere") then o.Density=v and 0 or 0.3 end
        if o:IsA("Sky") then pcall(function() o.Enabled=not v end) end
    end
end

-- ══════════════════════════════════════════════════════
--  TELEPORT
-- ══════════════════════════════════════════════════════
local Waypoints = {}
local function TpToPlayer(p)
    local hrp=HRPF(); local t=p.Character and p.Character:FindFirstChild("HumanoidRootPart")
    if hrp and t then hrp.CFrame=t.CFrame+Vector3.new(2,0,0) end
end
local function AddWP(name) local hrp=HRPF(); if hrp then
    Waypoints[name]={hrp.Position.X,hrp.Position.Y,hrp.Position.Z} end end
local function TpWP(name) local w=Waypoints[name]; local hrp=HRPF()
    if w and hrp then hrp.CFrame=CFrame.new(w[1],w[2],w[3]) end end
local function ServerHop()
    local ok,r=pcall(function() return HttpService:JSONDecode(game:HttpGet(
        "https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")) end)
    if ok and r and r.data then for _,s in ipairs(r.data) do
        if s.id~=game.JobId and s.playing<s.maxPlayers then
            TeleportSvc:TeleportToPlaceInstance(game.PlaceId,s.id); return true end end end
    return false
end

-- ══════════════════════════════════════════════════════
--  MISC
-- ══════════════════════════════════════════════════════
local SpamThread
local function StartSpam()
    if SpamThread then task.cancel(SpamThread) end
    SpamThread=task.spawn(function()
        while C.ChatSpam do
            pcall(function()
                game:GetService("ReplicatedStorage")
                    :WaitForChild("DefaultChatSystemChatEvents",2)
                    :WaitForChild("SayMessageRequest",2)
                    :FireServer(C.ChatMsg,"All")
            end)
            task.wait(math.max(C.ChatDelay,1))
        end
    end)
end
local function ApplyFPSBoost()
    pcall(function() settings().Rendering.QualityLevel=1 end)
    for _,v in ipairs(Lighting:GetChildren()) do
        if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect")
            or v:IsA("ColorCorrectionEffect") or v:IsA("DepthOfFieldEffect") then v.Enabled=false end
    end
end

local FPSLbl=Drawing.new("Text"); FPSLbl.Size=15; FPSLbl.Color=Color3.fromRGB(80,255,120)
FPSLbl.Outline=true; FPSLbl.Font=Drawing.Fonts.Monospace
FPSLbl.Position=Vector2.new(10,10); FPSLbl.Visible=false

local fpsQ={}
RunService.RenderStepped:Connect(function(dt)
    table.insert(fpsQ,dt); if #fpsQ>60 then table.remove(fpsQ,1) end
    if C.ShowFPS then
        local s=0; for _,v in ipairs(fpsQ) do s+=v end
        local fps=math.floor(#fpsQ/s)
        local ping=0; pcall(function()
            ping=math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) end)
        FPSLbl.Text=("FPS: %d  PING: %dms"):format(fps,ping); FPSLbl.Visible=true
    else FPSLbl.Visible=false end
end)

-- ══════════════════════════════════════════════════════
--  RAYFIELD
-- ══════════════════════════════════════════════════════
local Rayfield
local rfOK=pcall(function() Rayfield=loadstring(game:HttpGet("https://sirius.menu/rayfield"))() end)
if not rfOK or not Rayfield then
    pcall(function()
        Rayfield=loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/SiriusAsh/Rayfield/main/source.lua"))()
    end)
end
if not Rayfield then warn("[RedaxHACK] Rayfield yuklenemedi!"); return end

-- ══════════════════════════════════════════════════════
--  GUI
-- ══════════════════════════════════════════════════════
local Win = Rayfield:CreateWindow({
    Name            = "RedaxHACK  v1.0 BETA",
    LoadingTitle    = "RedaxHACK  v1.0 BETA",
    LoadingSubtitle = "⚠️ Beta Sürüm  |  "..GameName.."  |  "..ExecutorName,
    ConfigurationSaving = {Enabled=false},
    KeySystem = false,
})

-- ─────────────────────
--  TAB: COMBAT
--  ❌ Silent Aim seksiyon ve butonları KALDIRILDI
-- ─────────────────────
local CT = Win:CreateTab("⚔️ Combat", 4483362458)

CT:CreateSection("── Aimbot ──")
CT:CreateToggle({Name="Aimbot",CurrentValue=C.Aimbot,Flag="AB",
    Callback=function(v) C.Aimbot=v; SaveConfig() end})
CT:CreateToggle({Name="AB  ·  FOV Dairesi",CurrentValue=C.AimbotShowFOV,Flag="ABF",
    Callback=function(v) C.AimbotShowFOV=v; SaveConfig() end})
CT:CreateSlider({Name="AB  ·  FOV",Range={10,800},Increment=5,Suffix="px",
    CurrentValue=C.AimbotFOV,Flag="ABFOV",
    Callback=function(v) C.AimbotFOV=v; SaveConfig() end})
CT:CreateDropdown({Name="AB  ·  Hedef Kısım",
    Options={"Head","UpperTorso","HumanoidRootPart","LowerTorso"},
    CurrentOption={C.AimbotPart},Flag="ABP",
    Callback=function(v) C.AimbotPart=v[1]; SaveConfig() end})
CT:CreateDropdown({Name="AB  ·  Tuş",Options={"RMB","LMB","E"},
    CurrentOption={C.AimbotKey},Flag="ABK",
    Callback=function(v) C.AimbotKey=v[1]; SaveConfig() end})
CT:CreateSlider({Name="AB  ·  Smoothness  (1=anlık)",Range={1,10},Increment=1,
    CurrentValue=C.AimbotSmooth,Flag="ABS",
    Callback=function(v) C.AimbotSmooth=v; SaveConfig() end})
CT:CreateToggle({Name="Prediction",CurrentValue=C.Prediction,Flag="Prd",
    Callback=function(v) C.Prediction=v; SaveConfig() end})
CT:CreateSlider({Name="Prediction ms",Range={50,600},Increment=10,Suffix="ms",
    CurrentValue=C.PredictionMs,Flag="PrdMs",
    Callback=function(v) C.PredictionMs=v; SaveConfig() end})

CT:CreateDivider()
CT:CreateSection("── Genel ──")
CT:CreateToggle({Name="Takım Kontrolü",CurrentValue=C.TeamCheck,Flag="TC",
    Callback=function(v) C.TeamCheck=v; SaveConfig() end})
CT:CreateToggle({Name="Duvar Arkası Hedef",CurrentValue=C.WallCheck,Flag="WC",
    Callback=function(v) C.WallCheck=v; SaveConfig() end})

CT:CreateDivider()
CT:CreateSection("── Triggerbot ──")
CT:CreateToggle({Name="Triggerbot",CurrentValue=C.Triggerbot,Flag="Trig",
    Callback=function(v) C.Triggerbot=v; SaveConfig() end})
CT:CreateSlider({Name="Gecikme",Range={0,500},Increment=5,Suffix="ms",
    CurrentValue=C.TrigDelay,Flag="TD",
    Callback=function(v) C.TrigDelay=v; SaveConfig() end})
CT:CreateSlider({Name="İsabet Şansı",Range={1,100},Increment=1,Suffix="%",
    CurrentValue=C.HitChance,Flag="HC",
    Callback=function(v) C.HitChance=v; SaveConfig() end})

CT:CreateDivider()
CT:CreateSection("── Hitbox Expander ──")
CT:CreateToggle({Name="Hitbox Expander",CurrentValue=C.HitboxExpander,Flag="HBE",
    Callback=function(v)
        C.HitboxExpander=v
        if v then SetupAllHitboxes()
        else RestoreAllHitboxes() end
        SaveConfig()
    end})
CT:CreateSlider({Name="Boyut",Range={2,30},Increment=0.5,
    CurrentValue=C.HitboxSize,Flag="HBS",
    Callback=function(v) C.HitboxSize=v; SaveConfig() end})

-- ─────────────────────
--  TAB: ESP
-- ─────────────────────
local ET = Win:CreateTab("👁️ ESP", 4483362458)

ET:CreateSection("── Etiketler ──")
ET:CreateToggle({Name="İsim",CurrentValue=C.NameESP,Flag="NE",
    Callback=function(v) C.NameESP=v; SaveConfig() end})
ET:CreateToggle({Name="Sağlık Barı + %",CurrentValue=C.HealthESP,Flag="HE",
    Callback=function(v) C.HealthESP=v; SaveConfig() end})
ET:CreateToggle({Name="Mesafe",CurrentValue=C.DistESP,Flag="DE",
    Callback=function(v) C.DistESP=v; SaveConfig() end})
ET:CreateToggle({Name="Silah Gösterimi",CurrentValue=C.WeaponESP,Flag="WpnE",
    Callback=function(v) C.WeaponESP=v; SaveConfig() end})
ET:CreateToggle({Name="Head Dot",CurrentValue=C.HeadDot,Flag="HD",
    Callback=function(v) C.HeadDot=v; SaveConfig() end})

ET:CreateSection("── Çizgiler ──")
ET:CreateToggle({Name="Tracer",CurrentValue=C.TracerESP,Flag="TE",
    Callback=function(v) C.TracerESP=v; SaveConfig() end})
ET:CreateDropdown({Name="Tracer Noktası",Options={"Bottom","Middle","Top"},
    CurrentOption={C.TracerOrigin},Flag="TO",
    Callback=function(v) C.TracerOrigin=v[1]; SaveConfig() end})
ET:CreateToggle({Name="Skeleton (İskelet)",CurrentValue=C.SkeletonESP,Flag="SKE",
    Callback=function(v) C.SkeletonESP=v; SaveConfig() end})

ET:CreateSection("── Chams (Highlight) ──")
ET:CreateToggle({Name="Chams — Aktif",CurrentValue=C.Chams,Flag="Ch",
    Callback=function(v)
        C.Chams=v
        if not v then
            for _,p in ipairs(Players:GetPlayers()) do RemoveChams(p) end
        end
        SaveConfig()
    end})
ET:CreateToggle({Name="Takım Renk Modu  🟢🔴🟡",CurrentValue=C.ChamsTeamMode,Flag="CTM",
    Callback=function(v)
        C.ChamsTeamMode=v
        for _,p in ipairs(Players:GetPlayers()) do
            if p ~= LP then RemoveChams(p) end
        end
        SaveConfig()
        Rayfield:Notify({Title="Chams",
            Content=v and "Takım Modu: Yeşil=Takım | Kırmızı=Düşman | Sarı=Duvar Arkası"
                      or "Manuel Renk Moduna geçildi.",Duration=4})
    end})
ET:CreateLabel("  🟢 Takım arkadaşı   🔴 Görünür düşman   🟡 Duvar arkası düşman")
ET:CreateSlider({Name="Saydamlık (Düşman/Manuel)",Range={0,95},Increment=5,Suffix="%",
    CurrentValue=C.ChamsAlpha,Flag="ChA",
    Callback=function(v) C.ChamsAlpha=v; SaveConfig() end})
ET:CreateSlider({Name="Saydamlık (Takım Arkadaşı)",Range={0,95},Increment=5,Suffix="%",
    CurrentValue=C.ChamsAllyAlpha,Flag="ChAA",
    Callback=function(v) C.ChamsAllyAlpha=v; SaveConfig() end})
ET:CreateSection("── Chams Manuel Renk ──")
ET:CreateLabel("  (Takım Modu kapalıyken geçerli)")
ET:CreateSlider({Name="Renk R",Range={0,255},Increment=5,CurrentValue=C.ChamsR,Flag="ChR",
    Callback=function(v) C.ChamsR=v; SaveConfig() end})
ET:CreateSlider({Name="Renk G",Range={0,255},Increment=5,CurrentValue=C.ChamsG,Flag="ChG",
    Callback=function(v) C.ChamsG=v; SaveConfig() end})
ET:CreateSlider({Name="Renk B",Range={0,255},Increment=5,CurrentValue=C.ChamsB,Flag="ChB",
    Callback=function(v) C.ChamsB=v; SaveConfig() end})

-- ─────────────────────
--  TAB: MOVEMENT
-- ─────────────────────
local MV = Win:CreateTab("🏃 Movement", 4483362458)
MV:CreateSection("── Speed ──")
MV:CreateToggle({Name="Speed Hack",CurrentValue=C.Speed,Flag="SH",
    Callback=function(v) C.Speed=v; SaveConfig() end})
MV:CreateSlider({Name="WalkSpeed",Range={16,500},Increment=1,CurrentValue=C.WalkSpeed,Flag="WS",
    Callback=function(v) C.WalkSpeed=v; SaveConfig() end})
MV:CreateSection("── Fly ──")
MV:CreateToggle({Name="Fly  (WASD+Space/Shift)",CurrentValue=C.Fly,Flag="Fly",
    Callback=function(v) C.Fly=v; if v then StartFly() else KillFly() end; SaveConfig() end})
MV:CreateSlider({Name="Fly Hız",Range={5,500},Increment=5,CurrentValue=C.FlySpeed,Flag="FS",
    Callback=function(v) C.FlySpeed=v; SaveConfig() end})
MV:CreateSection("── Diğer ──")
MV:CreateToggle({Name="Noclip",CurrentValue=C.Noclip,Flag="NC",
    Callback=function(v) C.Noclip=v; SaveConfig() end})
MV:CreateToggle({Name="Infinite Jump",CurrentValue=C.InfJump,Flag="IJ",
    Callback=function(v) C.InfJump=v; SaveConfig() end})
MV:CreateToggle({Name="Bunny Hop",CurrentValue=C.BHop,Flag="BH",
    Callback=function(v) C.BHop=v; SaveConfig() end})
MV:CreateToggle({Name="High Jump",CurrentValue=C.HighJump,Flag="HJ",
    Callback=function(v) C.HighJump=v; SaveConfig() end})
MV:CreateSlider({Name="Jump Power",Range={50,1000},Increment=10,CurrentValue=C.JumpPow,Flag="JP",
    Callback=function(v) C.JumpPow=v; SaveConfig() end})
MV:CreateToggle({Name="Long Jump  (Space)",CurrentValue=C.LongJump,Flag="LJ",
    Callback=function(v) C.LongJump=v; SaveConfig() end})

-- ─────────────────────
--  TAB: PLAYER
-- ─────────────────────
local PL = Win:CreateTab("👤 Player", 4483362458)
PL:CreateSection("── Hayatta Kalma ──")
PL:CreateToggle({Name="God Mode",CurrentValue=C.GodMode,Flag="GM",
    Callback=function(v) SetGodMode(v); SaveConfig() end})
PL:CreateToggle({Name="Anti-Void",CurrentValue=C.AntiVoid,Flag="AV",
    Callback=function(v) C.AntiVoid=v; SaveConfig() end})
PL:CreateToggle({Name="Anti-AFK",CurrentValue=C.AntiAFK,Flag="AAK",
    Callback=function(v) C.AntiAFK=v; SaveConfig() end})
PL:CreateToggle({Name="Anti-Ragdoll",CurrentValue=C.AntiRagdoll,Flag="AR",
    Callback=function(v) C.AntiRagdoll=v; SaveConfig() end})
PL:CreateSection("── Görsel ──")
PL:CreateToggle({Name="Fullbright",CurrentValue=C.Fullbright,Flag="FB",
    Callback=function(v) SetFullbright(v); SaveConfig() end})
PL:CreateToggle({Name="No Fog",CurrentValue=C.NoFog,Flag="NF",
    Callback=function(v) SetNoFog(v); SaveConfig() end})
PL:CreateToggle({Name="No Shadows",CurrentValue=C.NoShadows,Flag="NS",
    Callback=function(v) SetNoShadows(v); SaveConfig() end})

-- ─────────────────────
--  TAB: WORLD
-- ─────────────────────
local WD = Win:CreateTab("🌍 World", 4483362458)
WD:CreateSection("── Fizik ──")
WD:CreateSlider({Name="Yerçekimi",Range={0,600},Increment=1,Suffix="G",
    CurrentValue=C.Gravity,Flag="Gv",
    Callback=function(v) C.Gravity=v; ApplyGravity(); SaveConfig() end})
WD:CreateButton({Name="Sıfırla (196.2)",
    Callback=function() C.Gravity=196.2; ApplyGravity()
        Rayfield:Notify({Title="World",Content="Sıfırlandı.",Duration=2}) end})
WD:CreateSection("── Zaman ──")
WD:CreateSlider({Name="ClockTime",Range={0,24},Increment=0.25,CurrentValue=C.ClockTime,Flag="CT",
    Callback=function(v) C.ClockTime=v; if not C.TimeFreeze then Lighting.ClockTime=v end; SaveConfig() end})
WD:CreateToggle({Name="Zamanı Dondur",CurrentValue=C.TimeFreeze,Flag="TF",
    Callback=function(v) C.TimeFreeze=v; SaveConfig() end})
WD:CreateToggle({Name="No Weather",CurrentValue=C.NoWeather,Flag="NW",
    Callback=function(v) SetNoWeather(v); SaveConfig() end})
WD:CreateSection("── Map ──")
WD:CreateButton({Name="⚠️ Haritayı Temizle",
    Callback=function()
        local n=0
        for _,v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name~="HumanoidRootPart"
                and not v:IsDescendantOf(LP.Character or Instance.new("Folder")) then
                pcall(function() v:Destroy(); n=n+1 end)
            end
        end
        Rayfield:Notify({Title="Map",Content=n.." parça silindi!",Duration=3})
    end})

-- ─────────────────────
--  TAB: TELEPORT
-- ─────────────────────
local TP = Win:CreateTab("🌀 Teleport", 4483362458)
TP:CreateSection("── Oyunculara Işınlan ──")
for _, p in ipairs(Players:GetPlayers()) do
    if p~=LP then local pp=p
        TP:CreateButton({Name="→  "..pp.Name,
            Callback=function() TpToPlayer(pp)
                Rayfield:Notify({Title="TP",Content=pp.Name.." konumuna ışınlandın.",Duration=2}) end})
    end
end
TP:CreateSection("── Waypoints ──")
local wpIn="WP1"
TP:CreateInput({Name="Waypoint Adı",PlaceholderText="WP1",RemoveTextAfterFocusLost=false,
    Callback=function(v) if v~="" then wpIn=v end end})
TP:CreateButton({Name="📍 Konumu Kaydet",
    Callback=function() AddWP(wpIn)
        local h=HRPF()
        Rayfield:Notify({Title="WP",Content=wpIn.." kaydedildi!"
            ..(h and ("\n"..math.floor(h.Position.X)..","..math.floor(h.Position.Y)..","..math.floor(h.Position.Z)) or ""),Duration=3}) end})
TP:CreateButton({Name="🚀 Waypointle Işınlan",
    Callback=function()
        if Waypoints[wpIn] then TpWP(wpIn)
            Rayfield:Notify({Title="TP",Content=wpIn.." konumuna ışınlandın.",Duration=2})
        else Rayfield:Notify({Title="Hata",Content=wpIn.." bulunamadı!",Duration=3}) end end})
TP:CreateButton({Name="🗑️ Waypointu Sil",
    Callback=function() Waypoints[wpIn]=nil
        Rayfield:Notify({Title="WP",Content=wpIn.." silindi.",Duration=2}) end})
TP:CreateSection("── Sunucu ──")
TP:CreateButton({Name="🔀 Server Hop",
    Callback=function()
        Rayfield:Notify({Title="Server Hop",Content="Aranıyor...",Duration=2})
        if not ServerHop() then Rayfield:Notify({Title="Hata",Content="Sunucu bulunamadı.",Duration=3}) end end})
TP:CreateButton({Name="🔄 Rejoin",
    Callback=function() TeleportSvc:Teleport(game.PlaceId) end})

-- ─────────────────────
--  TAB: MISC
-- ─────────────────────
local MC = Win:CreateTab("⚙️ Misc", 4483362458)
MC:CreateSection("── Chat Spammer ──")
MC:CreateInput({Name="Mesaj",PlaceholderText="Mesaj...",RemoveTextAfterFocusLost=false,
    Callback=function(v) if v~="" then C.ChatMsg=v; SaveConfig() end end})
MC:CreateSlider({Name="Gecikme",Range={1,60},Increment=1,Suffix="sn",CurrentValue=C.ChatDelay,Flag="CD",
    Callback=function(v) C.ChatDelay=v; SaveConfig() end})
MC:CreateToggle({Name="Chat Spammer",CurrentValue=C.ChatSpam,Flag="CS",
    Callback=function(v)
        C.ChatSpam=v
        if v then StartSpam()
        else if SpamThread then task.cancel(SpamThread); SpamThread=nil end end
        SaveConfig()
    end})
MC:CreateSection("── Performans ──")
MC:CreateToggle({Name="FPS Boost",CurrentValue=C.FPSBoost,Flag="FPB",
    Callback=function(v) C.FPSBoost=v; if v then ApplyFPSBoost() end; SaveConfig() end})
MC:CreateToggle({Name="FPS + Ping Göstergesi",CurrentValue=C.ShowFPS,Flag="SFP",
    Callback=function(v) C.ShowFPS=v; SaveConfig() end})
MC:CreateSection("── Bilgi ──")
MC:CreateLabel("⚠️  Bu hile BETA sürümündedir. Hatalar oluşabilir.")
MC:CreateLabel("🖥️  Executor : "..ExecutorName)
MC:CreateLabel("🎮  Oyun     : "..GameName)
MC:CreateLabel("🆔  PlaceID  : "..GameID)
MC:CreateLabel("👤  Oyuncu  : "..LP.Name)
MC:CreateLabel("🔧  Sürüm   : RedaxHACK v1.0 BETA")
MC:CreateSection("── Script Hub ──")
local SCRIPTS={
    {n="Infinite Yield",u="https://raw.githubusercontent.com/EdgeIY/infinite-yield/master/script.lua"},
    {n="Dex Explorer",  u="https://raw.githubusercontent.com/LorekeeperZinnia/Dex/master/DexNew.lua"},
    {n="Remote Spy",    u="https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"},
    {n="Dark Dex v3",   u="https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/DarkDex.lua"},
}
for _,s in ipairs(SCRIPTS) do local ss=s
    MC:CreateButton({Name="📥 "..ss.n,
        Callback=function()
            local ok,err=pcall(function() loadstring(game:HttpGet(ss.u))() end)
            Rayfield:Notify({Title=ok and "✅ Tamam" or "❌ Hata",
                Content=ok and (ss.n.." yüklendi!") or tostring(err):sub(1,80),Duration=4})
        end})
end
MC:CreateSection("── Config ──")
MC:CreateButton({Name="💾 Kaydet",Callback=function() SaveConfig()
    Rayfield:Notify({Title="Config",Content="Kaydedildi!",Duration=2}) end})
MC:CreateButton({Name="📂 Yükle",Callback=function() LoadConfig()
    Rayfield:Notify({Title="Config",Content="Yüklendi!",Duration=2}) end})
MC:CreateButton({Name="🔄 Sıfırla",Callback=function()
    for k,v in pairs(DEFAULT) do C[k]=v end; SaveConfig()
    Rayfield:Notify({Title="Config",Content="Sıfırlandı!",Duration=2}) end})

-- ══════════════════════════════════════════════════════
--  KEYBIND
-- ══════════════════════════════════════════════════════
UserInputService.InputBegan:Connect(function(inp,gp)
    if gp then return end
    if inp.KeyCode==Enum.KeyCode.RightControl then Rayfield:Toggle() end
end)

-- ══════════════════════════════════════════════════════
--  BAŞLANGIÇ
-- ══════════════════════════════════════════════════════
task.spawn(function()
    task.wait(1.5)
    if C.Fullbright then SetFullbright(true) end
    if C.NoFog      then SetNoFog(true)      end
    if C.NoShadows  then SetNoShadows(true)  end
    if C.NoWeather  then SetNoWeather(true)  end
    if C.FPSBoost   then ApplyFPSBoost()     end
    if C.GodMode    then SetGodMode(true)    end
    if C.Fly        then StartFly()          end
    ApplyGravity()
    if not C.TimeFreeze then Lighting.ClockTime=C.ClockTime end
    if C.HitboxExpander then SetupAllHitboxes() end

    task.wait(0.5)
    Rayfield:Notify({
        Title   = "⚠️ RedaxHACK v1.0 BETA Aktif",
        Content = "Beta sürüm — Hatalar oluşabilir.\n"
            ..GameName.."  |  "..ExecutorName
            .."\n[RightControl] → Menü",
        Duration = 7,
    })
end)
