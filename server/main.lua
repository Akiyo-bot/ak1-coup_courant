-- Version du fichier 1.0

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  ESX.RegisterUsableItem('PinceCup', function(source)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)

    TriggerClientEvent('ak1:PinceCup', _source)
  end)

CreateThread(function()
    print('^5[ak1-coup_courant] ^1Information: Vérification des mises à jours...')
	local current = GetResourceMetadata(GetCurrentResourceName(), 'version')
	PerformHttpRequest('https://raw.githubusercontent.com/Akiyo-bot/ak1-coup_courant/main/json/version.json', function(code, res, headers)
		if code == 200 then
			local rv = json.decode(res)
			SetConvarServerInfo("ak1-coup_courant", "V"..current)
			if rv.version ~= current then
				
                print('^5[ak1-coup_courant] ^1Error: ^6ak1-coup_courant ^1est obsolète et vous n\'obtiendrez plus de support pour cette version.')
            end
		end
	end, 'GET')
	Wait(10 * 1000)
	SetResourceKvp("ak1-coup_courant:LastVersion", current)
end)

-- Vérification des versions
CreateThread(function()
	local version = GetResourceMetadata(GetCurrentResourceName(), 'version')
	SetConvarServerInfo("ak1-coup_courant", "V"..version)
	PerformHttpRequest('https://raw.githubusercontent.com/Akiyo-bot/ak1-coup_courant/main/json/version.json', function(code, res, headers)
		if code == 200 then
			local rv = json.decode(res)
			if rv.version ~= version then
					print((
[[^1-------------------------------------------------------
				       ak1-coup_courant
UPDATE: %s AVAILABLE
DATE: %s
MODIFICATIONS: %s
Téléchargez la dernière mise à jour de ak1-coup_courant ici : ^6https://github.com/Akiyo-bot/ak1-coup_courant ^1
    -------------------------------------------------------^0]]):format(rv.version, rv.date, rv.changelog))
            else
                Wait(60)
                print('^5[ak1-coup_courant] ^1Information: ^6ak1-coup_courant ^1est à jours !')
            end
		end
	end, 'GET')
end)