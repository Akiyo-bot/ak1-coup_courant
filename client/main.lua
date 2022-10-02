-- Version du fichier 1.0

open = false
local ESX = nil
local IsInAnyCourant = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

local coupCourant = RageUI.CreateMenu("coupCourant", "~b~Courant WanhAki")
coupCourant:DisplayHeader(true)
coupCourant.Closed = function()
    open = false
end

Citizen.CreateThread(function()
	while true do
		local interval = 1
		for k, v in pairs(Config.Pos) do
			local playerPos = GetEntityCoords(PlayerPedId())
			local distance = #(playerPos - v)
			if distance <= 9 then
				interval = 0
				DrawMarker(22, v.x, v.y, v.z + 0.98, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 0, 0, 0, 150, 55555, false, true, 2, false, false, false, false)
				if distance <= 2 then
					Visual.Subtitle("Il vous faut quelques chose pour couper le courant...", 1)
				end
			end
		end
		Wait(interval)
    end
end)

RegisterNetEvent('ak1:PinceCup')
AddEventHandler('ak1:PinceCup', function()
    for k, v in pairs(Config.Pos) do
        local playerPos = GetEntityCoords(PlayerPedId())
        local distance = #(playerPos - v)

        if distance > 2 then
            ESX.ShowAdvancedNotification('Pince Coupe-Câble', "Pince Coupe-Câble", "Il vous faut quelques chose a couper non ?", playerPed, 110)
            return
        end
    end
    
    OpencoupCourantMenu()
end)


function OpencoupCourantMenu()
    if open then
        open = false
        return
    else
        RageUI.Visible(coupCourant, true)
        open = true
        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(coupCourant, function()
                    if not IsInAnyCourant then
                        RageUI.Button('Couper le courant', nil, {}, true, {
                            onSelected = function()
                                IsInAnyCourant = true
                                ExecuteCommand('blackout')
                                Notification(true, "cup")
                            end
                        })
                    else
                        RageUI.Separator("↓ retablire couper ↓")
                        RageUI.Button('Reactiver le courant', nil, {}, true, {
                            onSelected = function()

                                ExecuteCommand('blackout')
                                IsInAnyCourant = false
                                Notification(true, "reset")
                            end
                        })
                    end
                end)
                Wait(1)
            end
        end)
    end
end

function Notification(info, status)

    if(info == true) then
        CHAR = "CHAR_MP_FM_CONTACT"
    elseif(info == false) then
        CHAR = "CHAR_BLOCKED" 
    end

    if(status == "cup") then
        messageNottif = "Vous venez de couper le courant"
    elseif(status == "reset") then
        messageNottif = "Vous venez de redémarrer le courant"
    end

    SetNotificationTextEntry("STRING");
    AddTextComponentString(message);
    SetNotificationMessage(CHAR, CHAR, true, 1,"¦ Courant", messageNottif, 3000);
    DrawNotification(false, true);
end