local scriptUrl = "https://raw.githubusercontent.com/SoyAdriYT/Scorpion/refs/heads/main/Games/Murderes%20VS%20Sheriff%20Duels.lua"

local success, errorMessage = pcall(function()
    local response = game:HttpGet(scriptUrl)
    loadstring(response)()
end)

if not success then
    warn("An error occurred: " .. tostring(errorMessage))
end
