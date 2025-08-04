local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local uid = tostring(player.UserId)

local function ping()
    local data = {
        uid = uid,
        place = game.PlaceId,
        tick = tick()
    }

    local success, err = pcall(function()
        HttpService:PostAsync("http://87.106.52.7:6041/api/ping", HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        print("[checkonl] Đã ping thành công")
    else
        warn("[checkonl] Ping thất bại: " .. tostring(err))
    end
end

ping()