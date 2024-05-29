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

local function sendDiscordMessage(embed)
    print('Sending Message?')
    local http = game:GetService("HttpService")
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local data = {
        ["embeds"] = {
            {
                ["title"] = embed.title,
                ["description"] = embed.description,
                ["color"] = embed.color,
                ["fields"] = embed.fields,
                ["footer"] = {
                    ["text"] = embed.footer.text
                }
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
local embed = {
    ["title"] = "This is an embedded message",
    ["description"] = "This message has an embed with fields and a footer",
    ["color"] = 65280,
    ["fields"] = {
        {
            ["name"] = "Field 1",
            ["value"] = "This is the first field"
        },
        {
            ["name"] = "Field 2",
            ["value"] = "This is the second field"
        }
    },
    ["footer"] = {
        ["text"] = "This is the footer text"
    }
}

sendDiscordMessage(embed)
