-- checkonl.lua - Shouko.dev | Executor UI Confirmation Script
-- ✅ Viết file <UserId>.main vào workspace executor để Python tool nhận biết executor đã chạy
-- ✅ Hỗ trợ workspace thường và các clone (Codex, Arceus X, Ronix, Fluxus...)
-- ✅ Tự động ghi file nhiều lần trong 3 phút để chống lỗi mạng/lag executor

local Players = game:GetService("Players")
local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()

if not player then
    warn("[checkonl.lua] ❌ Không tìm thấy Player")
    return
end

local userId = tostring(player.UserId)
local fileName = userId .. ".main"
local content = "Executor confirmed @ " .. os.date("%Y-%m-%d %H:%M:%S")

-- Danh sách workspace paths cơ bản
local workspacePaths = {
    "/storage/emulated/0/Fluxus/Workspace/", "/storage/emulated/0/Fluxus/workspace/",
    "/storage/emulated/0/Codex/Workspace/", "/storage/emulated/0/Codex/workspace/",
    "/storage/emulated/0/Arceus X/Workspace/", "/storage/emulated/0/Arceus X/workspace/",
    "/storage/emulated/0/RonixExploit/Workspace/", "/storage/emulated/0/RonixExploit/workspace/",
    "/storage/emulated/0/Trigon/Workspace/", "/storage/emulated/0/Trigon/workspace/",
    "/storage/emulated/0/krnl/Workspace/", "/storage/emulated/0/krnl/workspace/",
    "/storage/emulated/0/Evon/Workspace/", "/storage/emulated/0/Evon/workspace/"
}

-- Thêm workspace paths cho clone
for i = 1, 20 do
    local cloneNum = string.format("%03d", i)
    local cloneBases = {
        "RobloxClone" .. cloneNum,
        "RobloxVNGClone" .. cloneNum
    }
    for _, base in ipairs(cloneBases) do
        table.insert(workspacePaths, "/storage/emulated/0/" .. base .. "/Codex/Workspace/")
        table.insert(workspacePaths, "/storage/emulated/0/" .. base .. "/Codex/workspace/")
        table.insert(workspacePaths, "/storage/emulated/0/" .. base .. "/Arceus X/Workspace/")
        table.insert(workspacePaths, "/storage/emulated/0/" .. base .. "/Arceus X/workspace/")
        table.insert(workspacePaths, "/storage/emulated/0/" .. base .. "/RonixExploit/Workspace/")
        table.insert(workspacePaths, "/storage/emulated/0/" .. base .. "/RonixExploit/workspace/")
    end
end

-- Hàm ghi file xác nhận
local function writeConfirmation()
    for _, path in ipairs(workspacePaths) do
        local success, err = pcall(function()
            writefile(path .. fileName, content)
        end)
        if success then
            print("[✅ checkonl.lua] Ghi thành công: " .. path .. fileName)
            return true
        end
    end

    -- Backup nếu ghi vào workspace thất bại
    local fallback, err = pcall(function()
        writefile(fileName, content)
    end)
    if fallback then
        warn("[⚠️ checkonl.lua] Ghi vào fallback: " .. fileName)
        return true
    else
        warn("[❌ checkonl.lua] Không thể ghi file xác nhận")
        return false
    end
end

-- Kiểm tra hàm writefile có tồn tại
if not writefile then
    warn("[❌ checkonl.lua] Executor không hỗ trợ writefile")
    return
end

-- Thực thi lần đầu
writeConfirmation()

-- Ghi lại sau mỗi 5 giây trong 180 giây (chống lag, crash, treo mạng)
spawn(function()
    local elapsed = 0
    while elapsed < 180 do
        wait(5)
        writeConfirmation()
        elapsed = elapsed + 5
    end
end)

-- Optional: gửi thông báo trong game
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "Shouko.dev",
        Text = "Đã xác nhận Executor!",
        Duration = 5
    })
end)