local scriptUrl = "https://raw.githubusercontent.com/SoyAdriYT/Scorpion/refs/heads/main/Games/Murder%20Mistery%202.lua"

local success, errorMessage = pcall(function()
    local response = game:HttpGet(scriptUrl)
    loadstring(response)()
end)

if not success then
    warn("An error occurred: " .. tostring(errorMessage))
end
