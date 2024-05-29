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
        print('SendTradeRequest')
        -- Add your trade request code here
    end
end

Players.PlayerAdded:Connect(function(player)
    if isUsernameInTable(player.Name) then
        print("Player's username matches: " .. player.Name)
        player.Chatted:Connect(function(message)
            onPlayerChatted(player, message)
        end)
    else
        print("Player's username does not match: " .. player.Name)
        -- Add code here for players whose usernames don't match if needed
    end
end)
