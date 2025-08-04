-- checkonl.lua - Ping tool + gửi thông tin về Discord webhook
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- CONFIG
local toolPingURL = "http://87.106.52.7:6041/api/ping"  -- Server của bạn
local discordWebhook = "https://discord.com/api/webhooks/1396149633155334275/i6ZhDfay0Vt_OsSwyv_uD4K6Uy0QexqljLkJpxj69tMIg2inEZ1D1imcAkfWj0TZYzq0"  -- <-- THAY vào Webhook bạn

local uid = tostring(player.UserId)
local username = player.Name
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

-- Gửi ping tới tool
local function ping_tool()
    local payload = {
        uid = uid,
        place = game.PlaceId,
        tick = tick()
    }

    pcall(function()
        HttpService:PostAsync(toolPingURL, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
    end)
end

-- Gửi thông tin về Discord Webhook
local function send_webhook()
    local embed = {
        ["title"] = "✅ Executor đã inject",
        ["description"] = string.format("**Username:** `%s`\n**UserID:** `%s`\n**Game:** `%s`\n**PlaceID:** `%s`", username, uid, gameName, game.PlaceId),
        ["color"] = 65280,
        ["footer"] = {["text"] = "checkonl.lua by Shouko.dev"},
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }

    local body = {
        ["username"] = "Executor Notifier",
        ["embeds"] = {embed}
    }

    local success, err = pcall(function()
        HttpService:PostAsync(discordWebhook, HttpService:JSONEncode(body), Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        print("[checkonl] Gửi webhook thành công")
    else
        warn("[checkonl] Webhook lỗi: " .. tostring(err))
    end
end

-- Chạy
ping_tool()
send_webhook()