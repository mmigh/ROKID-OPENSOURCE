local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

repeat task.wait() until Players.LocalPlayer
local player = Players.LocalPlayer
local uid = tostring(player.UserId)
local pingUrl = "https://dummy-r3m8.onrender.com/ping?uid=" .. uid .. "&source=executor"

print("[Checkonl] Start ping for UID:", uid)

while true do
    if not player or not player.Parent or not game:IsLoaded() then
        warn("[Checkonl] Player lost → stop ping")
        break -- ✅ dừng hẳn, để tool ngoài rejoin
    end

    pcall(function()
        game:HttpGet(pingUrl)
    end)
    task.wait(30)
end

print("[Checkonl] Stopped ping loop")
