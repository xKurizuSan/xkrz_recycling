local ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('xkrz_recycling:reward')
AddEventHandler('xkrz_recycling:reward', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local items = {}
    local count = math.random(Config.MinMoney, Config.MaxMoney)                     

    for _ = 1, math.random(1, 5), 1 do
        local randItem = Config.Reward.ItemList[math.random(1, #Config.Reward.ItemList)]
        local amount = math.random(Config.MinItem, Config.MaxItem)
        player.addInventoryItem(randItem, amount)
    end

    if Config.getMoney then
        player.addInventoryItem('money', count) 
    end
end)