local Players = game:GetService('Players')

local ourAccounts = {
    "MonsterWyatt",
    "Sarthorian_4",
}

local function isUsernameInTable(username)
    for _, name in ipairs(usernames) do
        if name == username then
            return true
        end
    end
    return false
end

local function onPlayerChatted(player, message)
    if message == "nwpnwp" then
        if isUsernameInTable(player.Name) then
            --
            print("Player's username matches: " .. player.Name)
        else
            --
            print("Player's username does not match: " .. player.Name)
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        onPlayerChatted(player, message)
    end)
end)
