-- checkonl.lua
local HttpService = game:GetService("HttpService")
local Players     = game:GetService("Players")

-- Chờ đến khi LocalPlayer sẵn sàng
repeat task.wait() until Players.LocalPlayer
local uid = tostring(Players.LocalPlayer.UserId)
local pingUrl = "https://dummy-r3m8.onrender.com/ping?uid=" .. uid .. "&source=executor"

while true do
    local ok, res = pcall(function()
        return game:HttpGet(pingUrl)
    end)
    if ok then
        -- in nhẹ ra console, không spam quá nhiều
        print("[Checkonl] ping ok")
    else
        warn("[Checkonl] ping failed:", res)
    end
    task.wait(30)  -- ping mỗi 30s
end
