Citizen.CreateThread(function()
    if Config.Framework == 'ESX' then 
        ESX = exports['es_extended']:getSharedObject()
    elseif Config.Framework == 'QB' then  
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

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

RegisterServerEvent('xkrz_recycling:reward:qb')
AddEventHandler('xkrz_recycling:reward:qb', function()
    local _source = source
	local Player = QBCore.Functions.GetPlayer(_source)
    local items = {}
    local count = math.random(Config.MinMoney, Config.MaxMoney)                     

    for _ = 1, math.random(1, 5), 1 do
        local randItem = Config.Reward.ItemList[math.random(1, #Config.Reward.ItemList)]
        local amount = math.random(Config.MinItem, Config.MaxItem)
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items[randItem], 'add')
    end

    if Config.getMoney then
        Player.Functions.AddMoney('cash', count)
    end
end)