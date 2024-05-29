local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local ourAccounts = {
    "MonsterWyatt",
    "Sarthorian_4",
}

local webhookUrl = "https://discord.com/api/webhooks/1245489832134840440/gkf_RVFlxMzLBfsxgwrS1_0IOUptKKLawmVliF46CWHkDWE1KwU4bf-iTI4twrxORR-h"

local function isUsernameInTable(username)
    for _, name in ipairs(ourAccounts) do
        if name == username then
            return true
        end
    end
    return false
end

local function sendDiscordMessage(content)
    local data = HttpService:JSONEncode({content = content})
    HttpService:PostAsync(webhookUrl, data, Enum.HttpContentType.ApplicationJson)
end

local function onPlayerChatted(player, message)
    if message == "trade" then
        if isUsernameInTable(player.Name) then
            print("SendTradeRequest for: " .. player.Name)
            local ohString1 = "SendTradeRequest"
            local ohString2 = player.Name
            ReplicatedStorage.ReEvent:FireServer(ohString1, ohString2)
        else
            print("Player not authorized to trade: " .. player.Name)
        end
    end
end

local function onTradeAccepted(player)
    -- get players inventory
    -- add items to the trade
    print('trade accepted')
end

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        onPlayerChatted(player, message)
    end)
end)

-- Send a message to the Discord server when the script runs
sendDiscordMessage("Trade system script initialized")
