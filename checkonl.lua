-- checkonl.lua - Final Stable Test Version
-- Ghi file vào workspace + /Download/, log rõ ràng, không spam

local Players = game:GetService("Players")
local player = Players.LocalPlayer
if not player then
    warn("[checkonl] ❌ Không tìm thấy người chơi.")
    return
end

local userId = tostring(player.UserId)
local fileName = userId .. ".main"
local content = "[checkonl] Executor ACTIVE - UID = " .. userId .. " | Time = " .. os.date()

-- Workspace paths tiêu chuẩn
local paths = {
    "/storage/emulated/0/Arceus X/Workspace/",
    "/storage/emulated/0/Codex/Workspace/",
    "/storage/emulated/0/Fluxus/Workspace/",
    "/storage/emulated/0/RonixExploit/Workspace/",
    "/storage/emulated/0/Delta/Workspace/",
    "/storage/emulated/0/Download/" -- Ghi vào đây để kiểm tra thủ công
}

-- Thêm clone
for i = 1, 20 do
    local id = string.format("%03d", i)
    table.insert(paths, "/storage/emulated/0/RobloxClone" .. id .. "/Arceus X/Workspace/")
    table.insert(paths, "/storage/emulated/0/RobloxClone" .. id .. "/Codex/Workspace/")
    table.insert(paths, "/storage/emulated/0/RobloxClone" .. id .. "/RonixExploit/Workspace/")
end

-- Ghi file và xác minh bằng isfile + readfile
local function writeAndCheck()
    for _, path in ipairs(paths) do
        local fullPath = path .. fileName
        local ok, err = pcall(function()
            writefile(fullPath, content)
        end)

        if ok and isfile(fullPath) then
            local readOk, readContent = pcall(function()
                return readfile(fullPath)
            end)
            if readOk then
                print("[checkonl] ✅ Ghi file thành công tại: " .. fullPath)
                print("[checkonl] 📄 Nội dung:\n" .. readContent)
            else
                warn("[checkonl] ⚠ Ghi thành công nhưng không đọc được: " .. fullPath)
            end
        else
            warn("[checkonl] ❌ Ghi thất bại tại: " .. fullPath)
            if err then warn("   Lý do: " .. tostring(err)) end
        end
    end
end

-- Ghi 3 lần cách nhau 5 giây (không spam)
writeAndCheck()
task.spawn(function()
    for i = 1, 2 do
        task.wait(5)
        print("[checkonl] 🔁 Ghi lại lần thứ " .. (i + 1))
        writeAndCheck()
    end
end)