-- This code is open source because it doesn't work well 

local function bypassByfron()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldNamecall = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if tostring(self) == "Kick" or tostring(self) == "Ban" then
            return nil
        end
        return oldNamecall(self, ...)
    end)
end

bypassByfron()

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SoyAdriYT/Scorpion/refs/heads/main/ScorpionUI/ScorpionUI.lua"))()

local Window = Library:MakeWindow({
    Title = "Scorpion - Piggy Hub",
    SaveFolder = "Piggy_Hub"
})

Window:AddMinimizeButton({
    Button = {Image = "rbxassetid://99406005425356"},
    Corner = {CornerRadius = UDim.new(0, 5)}
})

local Home = Window:MakeTab({"Player", "Player Settings"})

Home:AddSlider({
    Name = "Set WalkSpeed",
    Min = 16,
    Max = 500,
    Default = 16,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

Home:AddSlider({
    Name = "Set JumpPower",
    Min = 50,
    Max = 500,
    Default = 50,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
})

Home:AddToggle({
    Name = "God Mode",
    Default = false,
    Callback = function(state)
        if state then
            local char = game.Players.LocalPlayer.Character
            char.Humanoid.Name = "1"
            local clone = char.Humanoid:Clone()
            clone.Parent = char
            clone.Name = "Humanoid"
            char["1"]:Destroy()
            workspace.CurrentCamera.CameraSubject = char.Humanoid
        end
    end
})

Home:AddToggle({
    Name = "Invisibility",
    Default = false,
    Callback = function(state)
        if state then
            local char = game.Players.LocalPlayer.Character
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                    part.CanCollide = false
                end
            end
        else
            local char = game.Players.LocalPlayer.Character
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                    part.CanCollide = true
                end
            end
        end
    end
})

local Main = Window:MakeTab({"Main", "Main Features"})

Main:AddButton({
    Name = "Auto Collect Keys",
    Callback = function()
        for _, item in pairs(workspace:GetChildren()) do
            if item:IsA("Tool") and item:FindFirstChild("Handle") and item.Name:match("Key") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = item.Handle.CFrame
            end
        end
    end
})

Main:AddButton({
    Name = "Teleport to Piggy",
    Callback = function()
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.TeamColor == BrickColor.new("Really red") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
            end
        end
    end
})

Main:AddToggle({
    Name = "Auto Escape",
    Default = false,
    Callback = function(state)
        while state do
            for _, door in pairs(workspace:GetChildren()) do
                if door.Name == "ExitDoor" and door:FindFirstChild("Handle") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = door.Handle.CFrame
                    break
                end
            end
            wait(0.5)
        end
    end
})

Main:AddToggle({
    Name = "Kill All Piggies",
    Default = false,
    Callback = function(state)
        while state do
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.TeamColor == BrickColor.new("Really red") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                    player.Character.Humanoid:TakeDamage(player.Character.Humanoid.MaxHealth)
                end
            end
            wait(1)
        end
    end
})

Main:AddButton({
    Name = "Teleport to Safe Zone",
    Callback = function()
        for _, zone in pairs(workspace:GetChildren()) do
            if zone:IsA("Part") and zone.Name == "SafeZone" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = zone.CFrame
            end
        end
    end
})

local Shop = Window:MakeTab({"Shop", "Shop Features"})

Shop:AddButton({
    Name = "Unlock All Skins",
    Callback = function()
        for _, v in pairs(game.Players.LocalPlayer.PlayerGui.Shop.Skins:GetChildren()) do
            if v:IsA("Frame") and v:FindFirstChild("BuyButton") then
                fireclickdetector(v.BuyButton.ClickDetector)
            end
        end
    end
})

local Settings = Window:MakeTab({"Settings", "Settings"})

Settings:AddToggle({
    Name = "Anti-Kick",
    Default = false,
    Callback = function(state)
        if state then
            local mt = getrawmetatable(game)
            setreadonly(mt, false)
            local old = mt.__namecall
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                if method == "Kick" then
                    return
                end
                return old(self, ...)
            end)
        end
    end
})

Settings:AddButton({
    Name = "Server Hop",
    Callback = function()
        local servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for _, server in pairs(servers.data) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id)
                break
            end
        end
    end
})

Settings:AddButton({
    Name = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end
})
