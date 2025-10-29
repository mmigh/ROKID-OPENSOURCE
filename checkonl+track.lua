local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

repeat task.wait() until Players.LocalPlayer
local player = Players.LocalPlayer
local uid = tostring(player.UserId)
local pingUrl = "https://check-host-two.vercel.app/ping?uid=" .. uid .. "&source=executor"

local function is_disconnected()
    local prompt = CoreGui:FindFirstChild("RobloxPromptGui")
    if prompt then
        for _, d in ipairs(prompt:GetDescendants()) do
            local name = tostring(d.Name):lower()
            if name:find("error") or name:find("disconnect") or name:find("lost") then
                return true
            end
        end
    end
    return false
end

task.spawn(function()
    while true do
        if not player or not player.Parent or is_disconnected() then
            break
        end
        pcall(function()
            game:HttpGet(pingUrl) -- ping nhưng không log
        end)
        task.wait(30)
    end
end)

task.wait(10)

getgenv().Hermanos_Settings = {
    ['key'] = '3f9ae04e-bc29-4aa4-917e-791a0a2b8a53',
    ['PC'] = 'CHANGE-ME',

    ['webhooks'] = {
        ['fullmoon'] = 'https://discord.com/api/webhooks/',
        ['mirage'] = 'https://discord.com/api/webhooks/',
    },

    ['Sword'] = {'Cursed Dual Katana', 'Shark Anchor', 'Tushita', 'Yama', 'Dark Dagger', 'Hallow Scythe', 'Saber'},
    ['Gun'] = {'Soul Guitar', 'Serpent Bow', 'Kabucha', 'Acidum Rifle'},
    ['Accessories'] = {'Dark Coat', 'Leviathan Shield', 'Leviathan Crown', 'Pale Scarf', 'Kitsune Mask', 'Kitsune Ribbon'},
    ['Fruit'] = {
        'Kitsune', 'Leopard', 'Dragon (West)', 'Spirit', 'Control', 'Venom', 'Gas', 'Yeti',
        'Shadow', 'Dough', 'Mammoth', 'T-Rex', 'Dragon (East)'
    }
}

task.spawn(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/hermanos-dev/hermanos-script/main/main.lua'))()
end)
