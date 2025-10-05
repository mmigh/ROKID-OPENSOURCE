-- checkonl.lua (fix disconnect chính xác)
local Players = game:GetService("Players")

repeat task.wait() until Players.LocalPlayer
local uid = tostring(Players.LocalPlayer.UserId)
local pingUrl = "https://dummy-r3m8.onrender.com/ping?uid=" .. uid .. "&source=executor"

while true do
    local player = Players.LocalPlayer
    -- Kiểm tra xem LocalPlayer còn tồn tại & game có load không
    if player and player.Parent ~= nil and game:IsLoaded() then
        local ok, res = pcall(function()
            return game:HttpGet(pingUrl)
        end)
        if ok then
            print("[Checkonl] ping ok")
        else
            warn("[Checkonl] ping failed:", res)
        end
    else
        warn("[Checkonl] LocalPlayer không tồn tại -> stop ping (disconnect)")
        break
    end
    task.wait(30) -- ping mỗi 30 giây
end
