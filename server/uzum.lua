local playersProcessingCannabis = {}

RegisterServerEvent('esx_illegal:pickedUpCannabis')
AddEventHandler('esx_illegal:pickedUpCannabis', function()
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addInventoryItem('kirliuzum', Config.kactane)
  TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = Config.kactane..' Tane Kirli Üzüm Topladınız'})

end)

function CancelProcessing(playerID)
	if playersProcessingCannabis[playerID] then
		ESX.ClearTimeout(playersProcessingCannabis[playerID])
		playersProcessingCannabis[playerID] = nil
	end
end

RegisterServerEvent('esx_illegal:cancelProcessing')
AddEventHandler('esx_illegal:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)

RegisterServerEvent("kibra-uzum:UzumYikama")
AddEventHandler("kibra-uzum:UzumYikama", function()
local src = source 
local player = ESX.GetPlayerFromId(src)
if player.getQuantity('kirliuzum') >= 1 then 
   player.removeInventoryItem('kirliuzum', 1) 
   player.addInventoryItem('yikanmisuzum', 1)
   TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = '1 Tane Üzüm Yıkadınız', 2000})
else 
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli Kirli Üzümünüz yok!', 2000})
end
end)

RegisterServerEvent("kibra-uzum:SilUzum")
AddEventHandler("kibra-uzum:SilUzum", function()
local src = source 
local player = ESX.GetPlayerFromId(src)
player.removeInventoryItem('kirliuzum', 1)


end)
