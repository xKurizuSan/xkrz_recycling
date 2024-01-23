Citizen.CreateThread(function()
    if Config.Framework == 'ESX' then 
        ESX = exports['es_extended']:getSharedObject()
    elseif Config.Framework == 'QB' then  
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

local carryPackage = false

Citizen.CreateThread(function()
	if Config.Target then
		exports.qtarget:AddBoxZone("Recycling", vector3(-350.71, -1553.79, 24.27), 6.2, 7.0, {
			name="Recycling",
			heading=359,
			debugPoly=false,
			minZ=25,
			maxZ=27,
			}, {
			options = {
				{
					event = "xkrz_recycling:skillCheck",
					icon = "fa-solid fa-recycle",
					label = "Einpacken",
				},
			},
		distance = 3.5
		})
	end	
	if Config.Target then
		exports.qtarget:AddBoxZone("Box", vector3(-340.02, -1568.12, 24.23), 0.6, 2.6, {
			name="Box",
			heading=66,
			debugPoly=false,
			minZ=25,
			maxZ=27,
			}, {
				options = {
					{
						event = "xkrz_recycling:einlagern",
						icon = "fa-solid fa-box-archive",
						label = "Einlagern",
					},
				},
				distance = 3.5
		})
	end		
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
		local pos = {x = -350.71, y = -1553.79, z = 24.27}
		local distance = Vdist(playerCoords, pos.x, pos.y, pos.z)
		local pos2 = {x = -340.02, y = -1568.12, z = 24.23}
		local distance2 = Vdist(playerCoords, pos2.x, pos2.y, pos2.z)
		if not Config.Target then
			if distance <= 5.0 then 		 	
				showInfobar("Drücke ~g~E~s~, um ein ~y~Paket~s~ einzupacken.")
				if IsControlJustReleased(0, 38) then
					if Config.UseSkillCheck and not carryPackage then
					local success = lib.skillCheck(Config.SkillCheckDifficulty, Config.SkillCheckKey)
						if success then
							TriggerEvent('xkrz_recycling:einpacken')
						else 
							lib.notify({
								title = 'Error',
								description = 'Probier es nochmal.',
								position = 'top',
								type = 'error'
							})
						end
					else
						TriggerEvent('xkrz_recycling:einpacken')
					end
				end
			elseif distance2 <= 2.0 then
				showInfobar("Drücke ~g~E~s~, um ein ~y~Paket~s~ auszupacken.")
				if IsControlJustReleased(0, 38) then
					TriggerEvent('xkrz_recycling:einlagern')
				end
			end
		end
		Citizen.Wait(1)
	end
end)

RegisterNetEvent('xkrz_recycling:einpacken')
AddEventHandler('xkrz_recycling:einpacken', function()
	if not carryPackage then
		einpacken()
	else 
		lib.notify({
			title = 'Error',
			description = 'Du kannst nichts mehr tragen.',
			position = 'top',
			type = 'error'
		})
	end
end)

RegisterNetEvent('xkrz_recycling:skillCheck')
AddEventHandler('xkrz_recycling:skillCheck', function()
	if not carryPackage then
		if Config.UseSkillCheck then
			local success = lib.skillCheck(Config.SkillCheckDifficulty, Config.SkillCheckKey)
			if success then
				TriggerEvent('xkrz_recycling:einpacken')
			end
		else
			TriggerEvent('xkrz_recycling:einpacken')
		end			
	else 
		lib.notify({
			title = 'Error',
			description = 'Du kannst nichts mehr tragen.',
			position = 'top',
			type = 'error'
		})
	end
end)

RegisterNetEvent('xkrz_recycling:marker')
AddEventHandler('xkrz_recycling:marker', function()
	local pos = {x = -340.72, y = -1567.75, z = 24.93, rot = 244.7}
	local scale = 1.0

	while carryPackage do
		DrawMarker(1, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, scale, scale, scale, 255, 0, 0, 100, true, true, 2, nil, nil, false)
		Citizen.Wait(1)
	end
end)

RegisterNetEvent('xkrz_recycling:einlagern')
AddEventHandler('xkrz_recycling:einlagern', function()
	if carryPackage then
		einraeumen()
	else
		lib.notify({
			title = 'Information',
			description = 'Du hast nichts bei dir.',
			position = 'top',
			type = 'inform'
		})
	end
end)

function einpacken()
	carryPackage = true
	local ped = PlayerPedId()
	TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, 1)
	if Config.ProgressBar == 'bar' then
		lib.progressBar({
	    	duration = Config.Duration,
	    	label = 'Müll einpacken',
	    	useWhileDead = false,
	    	canCancel = false,
		    disable = {
		        move = true,
		        car = true,
		        combat = true,
		        mouse = false
		    },
		})
	elseif Config.ProgressBar == 'circle' then
		lib.progressCircle({
		    duration = Config.Duration,
		    label = 'Müll einpacken',
		    useWhileDead = false,
		    canCancel = false,
			position = "bottom",
		    disable = {
		        move = true,
		        car = true,
		        combat = true,
		        mouse = false
		    },
		})
	end
	lib.notify({
		title = 'Information',
		description = 'Lege das Paket, hinter dir ab.',
		position = 'top',
		type = 'inform'
	})
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
	TriggerEvent('xkrz_recycling:marker')
end 	

function einraeumen()
	local ped = PlayerPedId()
	DetachEntity(carryPackage, true, true)
  	DeleteObject(carryPackage)
	ClearPedTasks(ped)
	carryPackage = false
	TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, 1)
	if Config.ProgressBar == 'bar' then
		lib.progressBar({
    	    duration = Config.Duration,
    	    label = 'Müll auspacken.',
    	    useWhileDead = false,
    	    canCancel = false,
    	    disable = {
    	        move = true,
    	        car = true,
    	        combat = true,
    	        mouse = false
    	    },
    	})
	elseif Config.ProgressBar == 'circle' then
		lib.progressCircle({
    	    duration = Config.Duration,
    	    label = 'Müll auspacken.',
    	    useWhileDead = false,
    	    canCancel = false,
    	    position = "bottom",
    	    disable = {
    	        move = true,
    	        car = true,
    	        combat = true,
    	        mouse = false
    	    },
    	})
	end 
    ClearPedTasks(ped)
	if Config.Framework == 'ESX' then
		TriggerServerEvent('xkrz_recycling:reward')
	elseif Config.Framework == 'QB' then
		TriggerServerEvent('xkrz_recycling:reward:qb')
	end
	lib.notify({
		title = 'Success',
		description = 'Du hast das Paket erfolgreich abgeliefert.',
		position = 'top',
		type = 'success'
	})
end

function showInfobar(msg)
	CurrentActionMsg  = msg
	SetTextComponentFormat('STRING')
	AddTextComponentString(CurrentActionMsg)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

CreateThread(function()
	if Config.Blip then
		local blip = AddBlipForCoord(-350.71, -1553.79, 24.27)

		SetBlipSprite (blip, 467)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.2)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName('Recycling')
		EndTextCommandSetBlipName(blip)
	end
end)