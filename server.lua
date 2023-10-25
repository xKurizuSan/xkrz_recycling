local ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('esx_recycling:reward')
AddEventHandler('esx_recycling:reward', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local items = {}
    local count = math.random(1, 3)                     -- HIER KÖNNT IHR DAS GELD EINSTELLEN. STANDARD BEKOMMT IHR ZWISCHEN 1-3 DOLLAR...

    for i = 1, math.random(1, 5) do                     -- HIER KÖNNT IHR DIE ANZAHL DER BEKOMMENDEN ITEMS ÄNDERN. STANDARD IST 1-5...
        local item = Config.Reward.ItemList[math.random(1, #Config.Reward.ItemList)]
        items[#items + 1] = item
    end

    for k, v in pairs(items) do
        player.addInventoryItem(v, i)
    end

    player.addInventoryItem('money', count)  -- SOLLTE EURE WÄHRUNG ANDERS HEIßEN, DANN ÄNDERT "money" EINFACH ZU DEN NAMEN EURER WÄHRUNG.. MÖCHTET IHR DAS EURE SPIELER KEIN GELD BEKOMMEN DANN LÖSCHT EINFACH DIE ZEILEN 8 und 19.
end)