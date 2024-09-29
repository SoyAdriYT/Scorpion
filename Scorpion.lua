local url = "https://raw.githubusercontent.com/SoyAdriYT/Scorpion/refs/heads/main/Games/Blade%20Ball.lua"
local success, result = pcall(function()
    return game:HttpGet(url)
end)

if success then
    local successScript, err = pcall(function()
        loadstring(result)()
    end)
    if not successScript then
        warn("Error executing the script: "..err)
    end
else
    warn("Error fetching the content from the URL.")
end
