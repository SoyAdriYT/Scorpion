local function ScorpionDisableAntiCheatScripts()
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Script") or obj:IsA("LocalScript") then
            if string.find(obj.Name:lower(), "anti") or string.find(obj.Name:lower(), "cheat") or string.find(obj.Name:lower(), "detect") then
                obj:Destroy()
            end
        end
    end
end

local function ScorpionBlockKickAndBan()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldNamecall = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "Ban" then
            return
        end
        return oldNamecall(self, ...)
    end)
end

local function ScorpionPreventRemotes()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldIndex = mt.__index
    mt.__index = newcclosure(function(self, key)
        if tostring(self) == "RemoteEvent" or tostring(self) == "RemoteFunction" then
            if key == "FireServer" or key == "InvokeServer" then
                return function() end
            end
        end
        return oldIndex(self, key)
    end)
end

local function ScorpionProtectHumanoid()
    local player = game.Players.LocalPlayer
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if humanoid.Health <= 0 then
                humanoid.Health = 100
            end
        end)
        humanoid.BreakJointsOnDeath = false
    end
end

local function ScorpionProtectGameObjects()
    game.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("Script") or descendant:IsA("LocalScript") then
            if string.find(descendant.Name:lower(), "anti") or string.find(descendant.Name:lower(), "cheat") then
                descendant:Destroy()
            end
        end
    end)

    game.DescendantRemoving:Connect(function(descendant)
        if descendant:IsA("Script") or descendant:IsA("LocalScript") then
            if string.find(descendant.Name:lower(), "anti") or string.find(descendant.Name:lower(), "cheat") then
                local clone = descendant:Clone()
                clone.Parent = game
            end
        end
    end)
end

local function ScorpionBypassByfron()
    for _, v in pairs(getgc(true)) do
        if type(v) == "function" and islclosure(v) then
            if not isexecutorclosure(v) then
                if debug.getinfo(v).name == "Byfron" then
                    hookfunction(v, function() return end)
                end
            end
        end
    end
end

local function ScorpionDisableDetectionServices()
    local services = {
        "ScriptContext", "LogService", "RunService", "Players", "HttpService", "TeleportService", "Stats"
    }
    
    for _, service in ipairs(services) do
        local s = game:GetService(service)
        if s then
            s.Error:Connect(function() return end)
            if s:IsA("BindableEvent") or s:IsA("BindableFunction") then
                s:Destroy()
            end
        end
    end
end

local function ScorpionBlockHttpRequests()
    local oldHttpGet = game.HttpGet
    game.HttpGet = function(self, url, ...)
        if string.find(url, "anti") or string.find(url, "cheat") then
            return ""
        end
        return oldHttpGet(self, url, ...)
    end
end

local function ScorpionBlockAntiCheatDetection()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldNamecall = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" or method == "InvokeServer" then
            local args = {...}
            if string.find(tostring(self), "Anti") or string.find(tostring(self), "Cheat") then
                return
            end
        end
        return oldNamecall(self, ...)
    end)
end

ScorpionBypassByfron()
ScorpionDisableAntiCheatScripts()
ScorpionBlockKickAndBan()
ScorpionPreventRemotes()
ScorpionProtectHumanoid()
ScorpionProtectGameObjects()
ScorpionDisableDetectionServices()
ScorpionBlockHttpRequests()
ScorpionBlockAntiCheatDetection()
