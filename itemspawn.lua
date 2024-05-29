local Players = game:GetService('Players')

local ourAccounts = {
    "MonsterWyatt",
    "Sarthorian_4",
}

local function isUsernameInTable(username)
    for _, name in ipairs(ourAccounts) do
        if name == username then
            return true
        end
    end
    return false
end

local function onPlayerChatted(player, message)
    if message == "trade" then
        if isUsernameInTable(player.Name) then
            print("SendTradeRequest for: " .. player.Name)
            -- Add your trade request code here
        else
            print("Player not authorized to trade: " .. player.Name)
            -- Add code here for unauthorized trade attempts
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        onPlayerChatted(player, message)
    end)
end)
