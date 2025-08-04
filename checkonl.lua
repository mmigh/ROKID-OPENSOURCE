-- checkonl.lua
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
local uid = tostring(player.UserId)

local pingURL = "https://your-server.com/api/ping" -- THAY bằng domain/server bạn deploy

local function ping()
    local payload = {
        uid = uid,
        place = game.PlaceId,
        tick = tick()
    }

    local success, result = pcall(function()
        HttpService:PostAsync(pingURL, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        print("[checkonl] Ping sent")
    else
        warn("[checkonl] Ping failed: " .. tostring(result))
    end
end

ping()
task.spawn(function()
    for _ = 1, 4 do
        wait(5)
        ping()
    end
end)