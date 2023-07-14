local ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('esx_recycling:reward')
AddEventHandler('esx_recycling:reward', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local items = {}

    for i = 1, math.random(1, 5) do --for i = 1, math.random(Config.Reward.MinNumberOfItems, Config.Reward.MaxNumberOfItems) do
        local item = Config.Reward.ItemList[math.random(1, #Config.Reward.ItemList)]
        items[#items + 1] = item
    end

    for k, v in pairs(items) do
        player.addInventoryItem(v, i)
    end
end)