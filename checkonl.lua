-- checkonl.lua - Hoạt động đúng theo tool main.py
-- ✔ Ghi file UserID.main
-- ✔ Ghi lặp mỗi 5s trong 30s (đủ thời gian tool phát hiện)
-- ❌ Không cần mạng, HTTP, executor check

local Players = game:GetService("Players")
local player = Players.LocalPlayer
if not player then return end

local userId = tostring(player.UserId)
local fileName = userId .. ".main"
local content = "[executor: ok] UID = " .. userId .. " | Time = " .. os.date()

-- Các workspace mà tool của bạn kiểm tra (phải khớp)
local paths = {
    "/storage/emulated/0/Arceus X/Workspace/",
    "/storage/emulated/0/Codex/Workspace/",
    "/storage/emulated/0/Fluxus/Workspace/",
    "/storage/emulated/0/RonixExploit/Workspace/",
    "/storage/emulated/0/Delta/Workspace/"
}

-- Clone support
for i = 1, 20 do
    local id = string.format("%03d", i)
    table.insert(paths, "/storage/emulated/0/RobloxClone" .. id .. "/Arceus X/Workspace/")
    table.insert(paths, "/storage/emulated/0/RobloxClone" .. id .. "/Codex/Workspace/")
    table.insert(paths, "/storage/emulated/0/RobloxClone" .. id .. "/RonixExploit/Workspace/")
end

-- Ghi file xác nhận executor đang chạy
local function writeConfirm()
    for _, path in ipairs(paths) do
        pcall(function()
            writefile(path .. fileName, content)
        end)
    end
end

-- Ghi ngay lập tức
writeConfirm()

-- Lặp lại 5s x 6 = 30s để đảm bảo tool có thời gian phát hiện
task.spawn(function()
    for _ = 1, 6 do
        task.wait(5)
        writeConfirm()
    end
end)