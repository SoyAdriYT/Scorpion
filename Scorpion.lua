local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Line = Instance.new("Frame")
local BladeBallButton = Instance.new("TextButton")
local PiggyButton = Instance.new("TextButton")
local UICornerFrame = Instance.new("UICorner")
local UICornerBladeBall = Instance.new("UICorner")
local UICornerPiggy = Instance.new("UICorner")

ScreenGui.Name = "ScreenGui"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, 0, 1.5, 0)
Frame.Size = UDim2.new(0, 320, 0, 250)
Frame.ClipsDescendants = true
Frame.Active = true
Frame.Draggable = true

UICornerFrame.CornerRadius = UDim.new(0, 8)
UICornerFrame.Parent = Frame

Title.Parent = Frame
Title.AnchorPoint = Vector2.new(0.5, 0)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.5, 0, 0, 0)
Title.Size = UDim2.new(0, 320, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Scorpion Game"
Title.TextColor3 = Color3.fromRGB(255,0,0)
Title.TextSize = 30

Line.Parent = Title
Line.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Line.Size = UDim2.new(1, 0, 0, 5)
Line.Position = UDim2.new(0, 0, 1.1, 0)

BladeBallButton.Parent = Frame
BladeBallButton.AnchorPoint = Vector2.new(0.5, 0)
BladeBallButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
BladeBallButton.Position = UDim2.new(0.5, 0, 0, 95)
BladeBallButton.Size = UDim2.new(0, 190, 0, 40)
BladeBallButton.Font = Enum.Font.SourceSans
BladeBallButton.Text = "Blade Ball"
BladeBallButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BladeBallButton.TextSize = 25

UICornerBladeBall.CornerRadius = UDim.new(0, 8)
UICornerBladeBall.Parent = BladeBallButton

PiggyButton.Parent = Frame
PiggyButton.AnchorPoint = Vector2.new(0.5, 0)
PiggyButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
PiggyButton.Position = UDim2.new(0.5, 0, 0, 145)
PiggyButton.Size = UDim2.new(0, 190, 0, 40)
PiggyButton.Font = Enum.Font.SourceSans
PiggyButton.Text = "Piggy"
PiggyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PiggyButton.TextSize = 25

UICornerPiggy.CornerRadius = UDim.new(0, 8)
UICornerPiggy.Parent = PiggyButton

local tweenService = game:GetService("TweenService")
local curve = Enum.EasingStyle.Sine
local direction = Enum.EasingDirection.Out

local frameIn = {
    Position = UDim2.new(0.5, 0, 0.5, 0),
}

local frameOut = {
    Position = UDim2.new(0.5, 0, 1.5, 0),
}

function animateIn()
    local frameTween = tweenService:Create(Frame, TweenInfo.new(2, curve, direction), frameIn)
    frameTween:Play()
end

function animateOut()
    local frameTween = tweenService:Create(Frame, TweenInfo.new(2, curve, direction), frameOut)
    frameTween:Play()
    frameTween.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end

animateIn()

BladeBallButton.MouseButton1Click:Connect(function()
    animateOut()
    wait(0.1)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SoyAdriYT/Scorpion/refs/heads/main/Games/Blade%20Ball.lua"))()
end)

PiggyButton.MouseButton1Click:Connect(function()
    animateOut()
    wait(0.1)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SoyAdriYT/Scorpion/refs/heads/main/Games/Piggy.lua"))()
end)
