-- Roblox GUI Injector Script
-- Player Crash Menu with smooth movable GUI

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- Создаем основной ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CrashMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Создаем основной фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Selectable = true

-- Добавляем скругленные углы
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Добавляем тень/эффект глубины
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(60, 60, 60)
UIStroke.Parent = MainFrame

-- Заголовок для перемещения
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Text = "CRASH MENU"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Добавляем кнопку закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 15)
CloseCorner.Parent = CloseButton

-- Кнопка PLAYER CRASH
local CrashButton = Instance.new("TextButton")
CrashButton.Name = "CrashButton"
CrashButton.Size = UDim2.new(0, 200, 0, 50)
CrashButton.Position = UDim2.new(0.5, -100, 0.5, -25)
CrashButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CrashButton.Text = "PLAYER CRASH"
CrashButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CrashButton.TextSize = 16
CrashButton.Font = Enum.Font.GothamBold
CrashButton.BorderSizePixel = 0
CrashButton.AutoButtonColor = false -- Отключаем стандартную анимацию

local CrashCorner = Instance.new("UICorner")
CrashCorner.CornerRadius = UDim.new(0, 8)
CrashCorner.Parent = CrashButton

-- Плавные эффекты при наведении на кнопку
CrashButton.MouseEnter:Connect(function()
    local tween = TweenService:Create(
        CrashButton,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {
            BackgroundColor3 = Color3.fromRGB(220, 70, 70),
            Size = UDim2.new(0, 205, 0, 52)
        }
    )
    tween:Play()
end)

CrashButton.MouseLeave:Connect(function()
    local tween = TweenService:Create(
        CrashButton,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {
            BackgroundColor3 = Color3.fromRGB(200, 50, 50),
            Size = UDim2.new(0, 200, 0, 50)
        }
    )
    tween:Play()
end)

-- Плавная анимация нажатия без дерганий
local isButtonAnimating = false

CrashButton.MouseButton1Down:Connect(function()
    if isButtonAnimating then return end
    isButtonAnimating = true
    
    local tweenDown = TweenService:Create(
        CrashButton,
        TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0),
        {
            Size = UDim2.new(0, 195, 0, 48),
            BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        }
    )
    tweenDown:Play()
end)

CrashButton.MouseButton1Up:Connect(function()
    if not isButtonAnimating then return end
    
    local tweenUp = TweenService:Create(
        CrashButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0),
        {
            Size = UDim2.new(0, 200, 0, 50),
            BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        }
    )
    tweenUp:Play()
    
    wait(0.2)
    isButtonAnimating = false
end)

-- Функция для кнопки PLAYER CRASH (ничего не делает)
CrashButton.MouseButton1Click:Connect(function()
    -- Здесь ничего не происходит, как и требовалось
    print("Player Crash button pressed - no action taken")
end)

-- Функция закрытия GUI с анимацией
CloseButton.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(
        MainFrame,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }
    )
    tween:Play()
    
    wait(0.3)
    ScreenGui:Destroy()
end)

-- Плавная система перемещения GUI
local dragging = false
local dragStartPos
local frameStartPos

local function startDrag()
    dragging = true
    dragStartPos = UserInputService:GetMouseLocation()
    frameStartPos = MainFrame.Position
end

local function endDrag()
    dragging = false
end

local function updateDrag()
    if not dragging then return end
    
    local currentMousePos = UserInputService:GetMouseLocation()
    local delta = currentMousePos - dragStartPos
    
    MainFrame.Position = UDim2.new(
        frameStartPos.X.Scale, 
        frameStartPos.X.Offset + delta.X,
        frameStartPos.Y.Scale, 
        frameStartPos.Y.Offset + delta.Y
    )
end

-- Обработчики для перемещения за заголовок
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        startDrag()
    end
end)

Title.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        endDrag()
    end
end)

-- Обработчики для перемещения за основную область (если нужно)
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        startDrag()
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        endDrag()
    end
end)

-- Обновление позиции при движении мыши
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        updateDrag()
    end
end)

-- Собираем все элементы
Title.Parent = MainFrame
CloseButton.Parent = Title
CrashButton.Parent = MainFrame
MainFrame.Parent = ScreenGui
ScreenGui.Parent = CoreGui

-- Анимация появления
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

local openTween = TweenService:Create(
    MainFrame,
    TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {
        Size = UDim2.new(0, 300, 0, 200),
        Position = UDim2.new(0.5, -150, 0.5, -100)
    }
)
openTween:Play()

print("Crash Menu GUI loaded successfully!")
print("Move the GUI by dragging the top area")
print("Player Crash button is clickable but does nothing")