local ESX = exports['es_extended']:getSharedObject()
local carryPackage = nil

exports.qtarget:AddBoxZone("Recycling", vector3(-350.71, -1553.79, 24.27), 6.2, 7.0, {
	name="Recycling",
	heading=359,
	debugPoly=false,
	minZ=25,
	maxZ=27,
	}, {
		options = {
			{
				event = "esx_recycling:test",
				icon = "fas fa-sign-in-alt",
				label = "Einpacken",
			},
		},
		distance = 3.5
})

RegisterNetEvent('esx_recycling:test')
AddEventHandler('esx_recycling:test', function()
	if not carryPackage then
		local ped = PlayerPedId()
		exports['an_progBar']:run(7,'Müll einpacken','#E14127') --exports['progressBars']:startUI(7000, "Müll einpacken")
    	TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, 1)
    	Citizen.Wait(7000)
    	ClearPedTasks(ped)
		local pos = GetEntityCoords(PlayerPedId(), true)
		RequestAnimDict('anim@heists@box_carry@')
			while (not HasAnimDictLoaded('anim@heists@box_carry@')) do
		  	Wait(7)
			end
		TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 5.0, -1, -1, 50, 0, false, false, false)
		RequestModel('prop_cs_cardbox_01')
			while not HasModelLoaded('prop_cs_cardbox_01') do
		  	Wait(0)
			end
		local object = CreateObject('prop_cs_cardbox_01', pos.x, pos.y, pos.z, true, true, true)
		AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
		carryPackage = object
		TriggerEvent('esx_recycling:box')
	else 
		exports["skeexsNotify"]:TriggerNotification({
			['type'] = "info",
			['message'] = 'Bringe zuerst den Müll weg.'
		})
	end
end)

RegisterNetEvent('esx_recycling:box')
AddEventHandler('esx_recycling:box', function()
	local pos = {x = -340.72, y = -1567.75, z = 24.93, rot = 244.7} -- rot = heading
	local scale = 1.0

	while carryPackage do  
		DrawMarker(1, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, scale, scale, scale, 255, 0, 0, 100, true, true, 2, nil, nil, false) -- Bei pos.z evt anpassen.  0, 128, 255
		Citizen.Wait(1)
		exports.qtarget:AddBoxZone("Box", vector3(-340.02, -1568.12, 24.23), 0.6, 2.6, {
			name="Box",
			heading=66,
			debugPoly=false,
			minZ=25,
			maxZ=27,
			}, {
				options = {
					{
						event = "esx_recycling:einlagern",
						icon = "fas fa-sign-in-alt",
						label = "Einlagern",
					},
				},
				distance = 3.5
		})
	end
end)

RegisterNetEvent('esx_recycling:einlagern')
AddEventHandler('esx_recycling:einlagern', function()
	if not carryPackage then
		exports["skeexsNotify"]:TriggerNotification({
			['type'] = "info",
			['message'] = 'Du brauchst erst Müll.'
		  })
	else
		local ped = PlayerPedId()
		exports['an_progBar']:run(7,'Müll auspacken.','#E14127') --exports['progressBars']:startUI(7000, "Müll auspacken.")
		DetachEntity(carryPackage, true, true)
  		DeleteObject(carryPackage)
		ClearPedTasks(ped)
		TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, 1)
    	Citizen.Wait(7000)
    	ClearPedTasks(ped)
  		carryPackage = nil
		TriggerServerEvent('esx_recycling:reward')
		exports["skeexsNotify"]:TriggerNotification({
			['type'] = "success",
			['message'] = 'Du hast alles ausgepackt.'
		})
	end
end)

CreateThread(function()
	local blip = AddBlipForCoord(-350.71, -1553.79, 24.27)

	SetBlipSprite (blip, 467)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.2)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName('Recycling')
	EndTextCommandSetBlipName(blip)
end)