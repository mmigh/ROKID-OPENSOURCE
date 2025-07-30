-- checkonl.lua (Final Stable)
-- ✔ Không spam loop
-- ✔ Ghi file đúng 3 lần, mỗi 5s
-- ✔ Log rõ tiến trình
-- ✔ Không cần executor check / HTTP

local Players = game:GetService("Players")
local player = Players.LocalPlayer
if not player then
    warn("[checkonl] Không tìm thấy người chơi.")
    return
end

local userId = tostring(player.UserId)
local fileName = userId .. ".main"
local content = "[checkonl] Executor ACTIVE - UID = " .. userId .. " | Time = " .. os.date()

local paths = {
    "/storage/emulated/0/Arceus X/Workspace/",
    "/storage/emulated/0/Codex/Workspace/",
    "/storage/emulated/0/Fluxus/Workspace/",
    "/storage/emulated/0/RonixExploit/Workspace/",
    "/storage/emulated/0/Delta/Workspace/"
}

-- Hỗ trợ clone 001–020
for i = 1, 20 do
    local id = string.format("%03d", i)
    table.insert(paths, "/storage/emulated/0/RobloxClone" .. id .. "/Arceus X/Workspace/")
    table.insert(paths, "/storage/emulated/0/RobloxClone" .. id .. "/Codex/Workspace/")
    table.insert(paths, "/storage/emulated/0/RobloxClone" .. id .. "/RonixExploit/Workspace/")
end

local function writeConfirm()
    local wrote = 0
    for _, path in ipairs(paths) do
        local success, err = pcall(function()
            writefile(path .. fileName, content)
        end)
        if success then
            wrote += 1
            print("[checkonl] ✔ Ghi file tại: " .. path)
        end
    end
    if wrote == 0 then
        warn("[checkonl] ❌ Không thể ghi vào bất kỳ thư mục nào.")
    else
        print("[checkonl] ✅ Ghi file xong (" .. wrote .. " nơi)")
    end
end

-- Ghi lần đầu
writeConfirm()

-- Ghi thêm 2 lần nữa, cách nhau 5s để đảm bảo executor đã load
task.spawn(function()
    for i = 1, 2 do
        task.wait(5)
        print("[checkonl] ⏳ Đang ghi lại lần thứ " .. (i+1))
        writeConfirm()
    end
end)