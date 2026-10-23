local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LOADER_URL = "https://vampauth.com/v1/loaders/9ba58c52454c91552008a5941ef192e5.lua"
local GET_KEY_URL = "https://vampauth.com/FY9ALS4VDGFZY3HF/flow"
local SAVE_FILE = "CrystalHub_key.txt"

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local YELLOW = Color3.fromRGB(255, 212, 0)
local YELLOW_DARK = Color3.fromRGB(220, 182, 0)
local CARD_BG = Color3.fromRGB(16, 16, 16)
local CARD_BG_TOP = Color3.fromRGB(26, 26, 26)
local FIELD = Color3.fromRGB(24, 24, 24)
local FIELD_HOVER = Color3.fromRGB(32, 32, 32)
local TEXT = Color3.fromRGB(245, 245, 245)
local MUTED = Color3.fromRGB(140, 140, 140)
local DANGER = Color3.fromRGB(255, 90, 90)
local DIVIDER = Color3.fromRGB(40, 40, 40)
local INACTIVE_BORDER = Color3.fromRGB(50, 50, 50)

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local function make(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props) do inst[k] = v end
    return inst
end

local function saveKey(key)
    pcall(function()
        if writefile then writefile(SAVE_FILE, key) end
    end)
end

local function loadKey()
    local key = ""
    pcall(function()
        if isfile and readfile and isfile(SAVE_FILE) then
            key = readfile(SAVE_FILE) or ""
        end
    end)
    return key
end

local old = playerGui:FindFirstChild("CrystalHub")
if old then old:Destroy() end

local screenGui = make("ScreenGui", {
    Name = "CrystalHub",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = playerGui,
})

local cardW, cardH = 400, 460
if isMobile then cardW, cardH = 330, 460 end

local card = make("Frame", {
    Size = UDim2.fromOffset(cardW, cardH),
    Position = UDim2.new(0.5, 0, 0.55, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = CARD_BG,
    BorderSizePixel = 0,
    Parent = screenGui,
})
make("UICorner", { CornerRadius = UDim.new(0, 20), Parent = card })
make("UIStroke", { Color = YELLOW, Thickness = 1.5, Transparency = 0.7, Parent = card })
make("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, CARD_BG_TOP),
        ColorSequenceKeypoint.new(1, CARD_BG),
    }),
    Rotation = 90,
    Parent = card,
})

local accent = make("Frame", {
    Size = UDim2.new(1, -100, 0, 2),
    Position = UDim2.new(0.5, 0, 0, 0),
    AnchorPoint = Vector2.new(0.5, 0),
    BackgroundColor3 = YELLOW,
    BorderSizePixel = 0,
    Parent = card,
})
make("UIGradient", {
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 1),
    }),
    Parent = accent,
})

local logoBox = make("Frame", {
    Size = UDim2.fromOffset(52, 52),
    Position = UDim2.new(0.5, 0, 0, 30),
    AnchorPoint = Vector2.new(0.5, 0),
    BackgroundColor3 = YELLOW,
    BorderSizePixel = 0,
    Parent = card,
})
make("UICorner", { CornerRadius = UDim.new(0, 15), Parent = logoBox })
make("TextLabel", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Text = "C",
    TextColor3 = Color3.new(0, 0, 0),
    TextSize = 28,
    Font = Enum.Font.GothamBlack,
    Parent = logoBox,
})

make("TextLabel", {
    Size = UDim2.new(1, 0, 0, 26),
    Position = UDim2.new(0, 0, 0, 94),
    BackgroundTransparency = 1,
    Text = "Crystal Hub",
    TextColor3 = TEXT,
    TextSize = 22,
    Font = Enum.Font.GothamBold,
    Parent = card,
})

make("TextLabel", {
    Size = UDim2.new(1, 0, 0, 16),
    Position = UDim2.new(0, 0, 0, 122),
    BackgroundTransparency = 1,
    Text = "Enter your license key to continue",
    TextColor3 = MUTED,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    Parent = card,
})

make("Frame", {
    Size = UDim2.new(1, -56, 0, 1),
    Position = UDim2.new(0, 28, 0, 156),
    BackgroundColor3 = DIVIDER,
    BorderSizePixel = 0,
    Parent = card,
})

make("TextLabel", {
    Size = UDim2.new(1, -56, 0, 14),
    Position = UDim2.new(0, 28, 0, 172),
    BackgroundTransparency = 1,
    Text = "LICENSE KEY",
    TextColor3 = YELLOW,
    TextSize = 10,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = card,
})

local keyBox = make("TextBox", {
    Size = UDim2.new(1, -56, 0, 46),
    Position = UDim2.new(0, 28, 0, 190),
    BackgroundColor3 = FIELD,
    BorderSizePixel = 0,
    PlaceholderText = "XXXX-XXXX-XXXX-XXXX",
    PlaceholderColor3 = Color3.fromRGB(90, 90, 90),
    Text = loadKey(),
    TextColor3 = TEXT,
    TextSize = 14,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClearTextOnFocus = false,
    Parent = card,
})
make("UICorner", { CornerRadius = UDim.new(0, 11), Parent = keyBox })
local keyStroke = make("UIStroke", {
    Color = INACTIVE_BORDER, Thickness = 1, Parent = keyBox,
})
make("UIPadding", {
    PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14),
    Parent = keyBox,
})

local validateBtn = make("TextButton", {
    Size = UDim2.new(1, -56, 0, 46),
    Position = UDim2.new(0, 28, 0, 250),
    BackgroundColor3 = YELLOW,
    BorderSizePixel = 0,
    Text = "Validate & Load",
    TextColor3 = Color3.new(0, 0, 0),
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false,
    Parent = card,
})
make("UICorner", { CornerRadius = UDim.new(0, 11), Parent = validateBtn })

local getKeyBtn = make("TextButton", {
    Size = UDim2.new(1, -56, 0, 42),
    Position = UDim2.new(0, 28, 0, 306),
    BackgroundColor3 = FIELD,
    BorderSizePixel = 0,
    Text = "Get Key",
    TextColor3 = YELLOW,
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false,
    Parent = card,
})
make("UICorner", { CornerRadius = UDim.new(0, 11), Parent = getKeyBtn })
make("UIStroke", { Color = YELLOW, Thickness = 1, Transparency = 0.8, Parent = getKeyBtn })

local statusBox = make("Frame", {
    Size = UDim2.new(1, -56, 0, 50),
    Position = UDim2.new(0, 28, 0, 360),
    BackgroundColor3 = FIELD,
    BorderSizePixel = 0,
    Visible = false,
    Parent = card,
})
make("UICorner", { CornerRadius = UDim.new(0, 11), Parent = statusBox })
local statusStroke = make("UIStroke", {
    Color = YELLOW, Thickness = 1, Transparency = 0.6, Parent = statusBox,
})
local statusText = make("TextLabel", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Text = "",
    TextColor3 = TEXT,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = statusBox,
})
make("UIPadding", {
    PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12),
    PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8),
    Parent = statusBox,
})

make("TextLabel", {
    Size = UDim2.new(1, 0, 0, 14),
    Position = UDim2.new(0, 0, 1, -22),
    BackgroundTransparency = 1,
    Text = "Powered by VAMP Auth",
    TextColor3 = Color3.fromRGB(70, 70, 70),
    TextSize = 10,
    Font = Enum.Font.Gotham,
    Parent = card,
})

local function setStatus(isSuccess, message)
    statusBox.Visible = true
    statusText.Text = message
    if isSuccess then
        statusStroke.Color = YELLOW
        statusText.TextColor3 = YELLOW
    else
        statusStroke.Color = DANGER
        statusText.TextColor3 = DANGER
    end
end

local function copyToClipboard(text)
    pcall(function() if setclipboard then setclipboard(text) end end)
    pcall(function() if syn and syn.setclipboard then syn.setclipboard(text) end end)
end

local function openBrowser(url)
    local opened = false
    pcall(function() if openbrowser then openbrowser(url); opened = true end end)
    if not opened then
        pcall(function() if syn and syn.openbrowser then syn.openbrowser(url); opened = true end end)
    end
    if not opened then
        copyToClipboard(url)
        setStatus(true, "Link copied — open it in your browser to get a key.")
    else
        setStatus(true, "Browser opened — complete the flow to get your key.")
    end
end

local function fetchLoader()
    local ok, res = pcall(function() return game:HttpGet(LOADER_URL) end)
    if ok and type(res) == "string" and #res > 0 then return res end
    ok, res = pcall(function()
        if syn and syn.request then
            return syn.request({ Url = LOADER_URL, Method = "GET" }).Body
        end
    end)
    if ok and type(res) == "string" and #res > 0 then return res end
    ok, res = pcall(function()
        if http and http.request then
            return http.request({ Url = LOADER_URL, Method = "GET" }).Body
        end
    end)
    if ok and type(res) == "string" and #res > 0 then return res end
    ok, res = pcall(function()
        if request then
            return request({ Url = LOADER_URL, Method = "GET" }).Body
        end
    end)
    if ok and type(res) == "string" and #res > 0 then return res end
    return nil
end

local function addHover(btn, baseColor, hoverColor)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = hoverColor }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = baseColor }):Play()
    end)
end

addHover(validateBtn, YELLOW, YELLOW_DARK)
addHover(getKeyBtn, FIELD, FIELD_HOVER)

local function addPress(btn)
    local orig = btn.Size
    btn.MouseButton1Down:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.08), {
            Size = UDim2.new(orig.X.Scale, orig.X.Offset - 4, orig.Y.Scale, orig.Y.Offset - 2),
        }):Play()
    end)
    btn.MouseButton1Up:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.08), { Size = orig }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.08), { Size = orig }):Play()
    end)
end

addPress(validateBtn)
addPress(getKeyBtn)

local busy = false
local function onValidate()
    if busy then return end
    local key = keyBox.Text:match("^%s*(.-)%s*$")
    if key == "" then
        setStatus(false, "Please enter a key first.")
        return
    end

    busy = true
    validateBtn.Text = "Loading…"
    validateBtn.Active = false
    statusBox.Visible = false
    saveKey(key)

    local src = fetchLoader()
    if not src then
        busy = false
        validateBtn.Text = "Validate & Load"
        validateBtn.Active = true
        setStatus(false, "Failed to download loader. Check your connection.")
        return
    end

    local fn, compileErr = loadstring(src)
    if not fn then
        busy = false
        validateBtn.Text = "Validate & Load"
        validateBtn.Active = true
        setStatus(false, "Loader compile error: " .. tostring(compileErr))
        return
    end

    screenGui.Enabled = false

    local errored = false
    task.spawn(function()
        script_key = key
        getgenv().script_key = key
        _G.script_key = key
        if shared then shared.script_key = key end

        local ok, err = pcall(fn)
        if not ok then
            errored = true
            screenGui.Enabled = true
            busy = false
            validateBtn.Text = "Validate & Load"
            validateBtn.Active = true
            setStatus(false, "Error: " .. tostring(err))
        end
    end)

    task.delay(4, function()
        if not errored and screenGui and screenGui.Parent then
            screenGui:Destroy()
        end
    end)
end

validateBtn.MouseButton1Click:Connect(onValidate)

getKeyBtn.MouseButton1Click:Connect(function()
    openBrowser(GET_KEY_URL)
end)

keyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then onValidate() end
end)

keyBox.Focused:Connect(function()
    TweenService:Create(keyStroke, TweenInfo.new(0.2), { Color = YELLOW }):Play()
end)
keyBox.FocusLost:Connect(function()
    TweenService:Create(keyStroke, TweenInfo.new(0.2), { Color = INACTIVE_BORDER }):Play()
end)

TweenService:Create(card, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, 0, 0.5, 0),
}):Play()
